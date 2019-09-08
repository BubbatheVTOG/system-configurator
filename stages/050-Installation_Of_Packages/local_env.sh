#!/bin/bash

# Get the name of the stage.
task_name=${PWD##*/}

# If true install packages in one shot. This is faster, but we cannot
# programatically verify it.
INSTALL_FAST=false

# Figure out what iptables is called per distibution.
if $IS_ARCH; then
    iptables="iptables"
else
    iptables="iptables-services"
fi

# The packages that will be installed.
pkgs=(vim htop ${iptables})

