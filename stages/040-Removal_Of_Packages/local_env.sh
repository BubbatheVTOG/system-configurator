#!/bin/bash

# Get the name of the stage.
task_name=${PWD##*/}

# If true remove packages in one shot. This is faster, but we cannot
# programatically verify it.
install_fast=false

# Figure out what iptables is called per distibution.
if $IS_ARCH; then
    iptables="iptables"
else
    iptables="iptables-services"
fi

# The packages that will be removed.
pkgs=(vim htop ${iptables})

