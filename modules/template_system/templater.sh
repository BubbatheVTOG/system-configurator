#!/bin/bash

# Used to substitute text into a template file, the put said file
# into a designated location.
# Usage:
# 	template_file "source" "destination"
# Optional:
# 	template_file "source" "destination" "permissions in octal"
# 	template_file "source" "destination" "permissions in octal" "user and group"
function template_file () {
	envsubst < $1 > $2
	print_ret_res "$?" "Templated file $1 to $2"
	if [ ! -z $3 ]; then
		chmod $3 $2
		print_ret_res "$?" "Permissions to \"$3\" on file: $2"
	fi

	if [ ! -z $4 ]; then
		chown $4 $2
		print_ret_res "$?" "Owner and group to \"$4\" on file: $2"
	fi
}


# Verifies the contents of a templated file.
# Usage:
# 	verify_template "regex of contents" "file"
# Optional:
# 	verify_template "regex of contents" "file" "permissions in octal"
# 	verify_template "regex of contents" "file" "permissions in octal" "user and group"
function verify_template () {
	grep -E ${1} ${2} > /dev/null 2>&1
	print_ret_res "$?" "Verified contents of templated file: $2"

	if [ ! -z $3 ]; then
		if (( $(stat -c %a $2) == $3 )); then
			print_ret_res "0" "Verified templated file permissions \"$3\" on file: $2"
		else
			print_ret_res "1" "Verified templated file permissions \"$3\" on file: $2"
		fi
	fi

	if [ ! -z $4 ]; then
		if [ "$(stat -c %U:%G $2)" == "$4" ]; then
			print_ret_res "0" "Verified templated file owner and group \"$4\" on file: $2"
		else
			print_ret_res "1" "Verified templated file owner and group \"$4\" on file: $2"
		fi
	fi
}
