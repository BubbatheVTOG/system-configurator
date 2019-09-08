#!/bin/bash

source $(dirname $0)/local_env.sh

# This function ensures all prerequisites needed for the task pass.
function pre () {
	print_role_banner ${task_name}
}

# This function executes the main task of the stage.
function task () {
	:
}

# This function cleans up any loose ends after the task executes.
function post () {
	:
}

# This function verifies the task executed as it was supposed to.
function verify () {
	:
}
