#!/bin/bash

source $(dirname $0)/local_env.sh

# This function ensures all prerequisites needed for the task pass.
function pre () {
	print_role_banner ${task_name}
}

# This function executes the main task of the stage.
function task () {
	touch "/DELETE.ME"

	copy "${test_file}" \
		"${test_file_move}" \
		"600" \
		"bubba:users"

	move "${test_file}" \
		"${test_file_move}" \
		"600" \
		"bubba:users"

	delete "${test_file}"
	delete "${test_file_move}"
}

# This function cleans up any loose ends after the task executes.
function post () {
	:
}

# This function verifies the task executed as it was supposed to.
function verify () {

	verify_copy "${test_file_move}" \
		"600" \
		"bubba:users"

	verify_move "${test_file_move}" \
		"600" \
		"bubba:users"

	verify_delete "${test_file}"
	verify_delete "${test_file_move}"
}
