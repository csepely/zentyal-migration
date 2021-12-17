#!/bin/bash

# default: ansible
# anyway any ansible-command that exists on given location
# 
# default_location
default_location=/usr/bin

[[ -e ${default_location}/ansible-${1} ]] && \
(module=${1}; \
shift; \
exec ${default_location}/ansible-${module} $@ ) || \
exec ${default_location}/ansible $@
