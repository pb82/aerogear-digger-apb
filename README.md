# Buildfarm APB

## What does it do?
* Installs Android SDK pod into the project
* Creates an OpenShift Jenkins if it does not exist in a project
* Adds the android-signing plugin into the OpenShift Jenkins pod
* Creates the ConfigMap to configure the Jenkins Kubernetes Plugin

## Developing
* Make your changes
* `apb prepare` - Create the Dockerfile
* `apb build` - Build the Dockerfile
* `docker push ...` - Push the image to an image repository

## TODO
* Creates an OpenShift Jenkins if it does not exist in a project
* Adds the android-signing plugin into the OpenShift Jenkins pod (https://github.com/aidenkeating/mobile-next-jenkins)
* Creates the ConfigMap to configure the Jenkins Kubernetes Plugin (https://gist.github.com/aidenkeating/66e4ac393a81407b809fe993a7b2e1e3)
