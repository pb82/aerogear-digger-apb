# AeroGear Digger APB

[![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/aerogearcatalog/aerogear-digger-apb/)
[![Docker Stars](https://img.shields.io/docker/stars/aerogearcatalog/aerogear-digger-apb.svg)](https://registry.hub.docker.com/v2/repositories/aerogearcatalog/aerogear-digger-apb/stars/count/)
[![Docker pulls](https://img.shields.io/docker/pulls/aerogearcatalog/aerogear-digger-apb.svg)](https://registry.hub.docker.com/v2/repositories/aerogearcatalog/aerogear-digger-apb/)
[![License](https://img.shields.io/:license-Apache2-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

## What does it do?
* Installs Android SDK pod into the project
* Creates an OpenShift Jenkins if it does not exist in a project
* Adds the android-signing plugin into the OpenShift Jenkins pod
* Creates the ConfigMap to configure the Jenkins Kubernetes Plugin

## Developing

### Requirements

- Setup OpenShift Origin [development environment](https://github.com/ansibleplaybookbundle/ansible-playbook-bundle/blob/master/docs/getting_started.md#development-environment) for APB development.
- Install [apb tool](https://github.com/ansibleplaybookbundle/ansible-playbook-bundle/blob/master/docs/apb_cli.md)

### Process

```bash
apb push
```

For more extensive documentation on APB development and apb command line options, please read the ansible playbook bundle [docs](https://github.com/ansibleplaybookbundle/ansible-playbook-bundle/tree/master/docs).

## TODO
* Creates an OpenShift Jenkins if it does not exist in a project
* Adds the android-signing plugin into the OpenShift Jenkins pod (https://github.com/aidenkeating/mobile-next-jenkins)
* Creates the ConfigMap to configure the Jenkins Kubernetes Plugin (https://gist.github.com/aidenkeating/66e4ac393a81407b809fe993a7b2e1e3)
