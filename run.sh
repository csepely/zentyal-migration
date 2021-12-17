#!/bin/bash
[[ -z "$NO_SUDO" ]] && C="sudo docker" || C=docker
${C} run -ti -v $PWD:/tmp/playbook:Z --name ansible --rm csp/ansiblecm "$@"
