#!/usr/bin/env bash
function wait_for_scale {
  local dc="${1:?"[ERROR]You must provide a deployment configuration."}"
  local rc="${2:?"[ERROR]You must provide a number of replicas"}"
  local ns="${3:?"[ERROR]You must provide a namespace."}"

  local var=$(oc get dc "${dc}" -n "${ns}" -o jsonpath="{.status.availableReplicas}")
  while [ "${var}" -lt "${rc}" ]
  do
    echo "Waiting for ${dc} to scale to ${rc}, currently ${var}"; sleep 5
    var=$(oc get dc "${dc}" -n "${ns}" -o jsonpath="{.status.availableReplicas}")
  done
}

echo "Waiting for Jenkins to be available"

readonly namespace="${1:?"[ERROR]You must provide a namespace."}"
readonly jenkins_name="${2:?"[ERROR]You must provide an jenkins deployment name."}"

wait_for_scale ${jenkins_name} 1 ${namespace}

readonly jenkins_pod=$(oc get pods -n ${namespace} | grep ${jenkins_name}- | awk '{ print $1 }')

echo "Copying Jenkins plugins from /jenkins-plugins/"

oc cp -n ${namespace} /tmp/jenkins-plugins/android-signing ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/android-signing.jpi ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/openshift-sync ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/openshift-sync.hpi ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/xcode-plugin ${jenkins_pod}:/var/lib/jenkins/plugins/
oc cp -n ${namespace} /tmp/jenkins-plugins/xcode-plugin.hpi ${jenkins_pod}:/var/lib/jenkins/plugins/

echo "Scaling down Jenkins"

oc scale dc/${jenkins_name} --replicas=0 -n ${namespace}
wait_for_scale ${jenkins_name} 0 ${namespace}

echo "Scaling up Jenkins"

oc scale dc/${jenkins_name} --replicas=1 -n ${namespace}
wait_for_scale ${jenkins_name} 1 ${namespace}
