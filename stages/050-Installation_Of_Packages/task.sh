#!/bin/bash

source $(dirname $0)/local_env.sh

# This function ensures all prerequisites needed for the task pass.
function pre () {
	print_role_banner ${task_name}
	verify_packagemanger
}

# This function executes the main task of the stage.
function task () {
	if $install_fast; then
		install_packages $pkgs
	else
		for pkg in ${pkgs[@]}; do
			install_package ${pkg}
		done
	fi
}

# This function cleans up any loose ends after the task executes.
function post () {
	:
}

# This function verifies the task executed as it was supposed to.
function verify () {
	for pkg in ${pkgs[@]}; do
		verify_package_installed ${pkg}
	done
}
