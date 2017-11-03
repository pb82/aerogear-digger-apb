# $1 - Name of the Deployment Config
# $2 - Number of availableReplicas to wait for
# $3 - Namespace
function wait_for_scale {
  for i in {0..100}; do
    sleep 5
    echo "oc get dc ${1} -n ${3} -o jsonpath='{.status.availableReplicas}'"
    if [ $(oc get dc "${1}" -n "${3}" -o jsonpath="{.status.availableReplicas}") == "${2}" ]; then
      return
    fi
    echo "Waiting for ${1} to scale to ${2}, currently $(oc get dc ${1} -n ${3} -o jsonpath='{.status.availableReplicas}')"
  done
}

echo "Waiting for Jenkins to be available"

readonly namespace="${1}"

wait_for_scale "jenkins" 1 "${namespace}"

readonly jenkins_pod=$(oc get pods -n ${1} | grep jenkins- | awk '{ print $1 }')

echo "Copying Jenkins plugins from /jenkins-plugins/"

oc cp -n ${namespace} /tmp/jenkins-plugins/android-signing ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/android-signing.jpi ${jenkins_pod}:/var/lib/jenkins/plugins/

echo "Scaling down Jenkins"

oc scale dc jenkins --replicas=0 -n ${namespace}
wait_for_scale "jenkins" 0 ${namespace}

echo "Scaling up Jenkins"

oc scale dc jenkins --replicas=1 -n ${namespace}
wait_for_scale "jenkins" 1 ${namespace}
