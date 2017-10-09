function wait_for_scale {
  for i in {0..100}; do
    sleep 5
    if [ $(oc get dc "${1}" -o jsonpath="{.status.availableReplicas}") == "${2}" ]; then
      return
    fi
    echo "Waiting for ${1} to scale to ${2}, currently $(oc get dc ${1} -o jsonpath='{.status.availableReplicas}')"
  done
}

echo "Waiting for Jenkins to be available"

wait_for_scale "jenkins" 1

readonly jenkins_pod=$(oc get pods | grep jenkins- | awk '{ print $1 }')

echo "Copying Jenkins plugins from /jenkins-plugins/"

oc cp /tmp/jenkins-plugins/android-signing ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp /tmp/jenkins-plugins/android-signing.jpi ${jenkins_pod}:/var/lib/jenkins/plugins/

echo "Scaling down Jenkins"

oc scale dc jenkins --replicas=0
wait_for_scale "jenkins" 0

echo "Scaling up Jenkins"

oc scale dc jenkins --replicas=1
wait_for_scale "jenkins" 1
