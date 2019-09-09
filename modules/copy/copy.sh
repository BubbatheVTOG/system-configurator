#!/bin/bash

# Copies a file from one location to another.
# Usage:
#	copy "source" "destination"
# Optional:
#	copy "source" "destination" "destination permissions in octal"
#	copy "source" "destination" "destination permissions in octal" "destination user and group"
function copy () {
    cp -rf $1 $2
    print_ret_res "$?" "Copied $1 to $2"

	if [ ! -z $3 ]; then
        chmod -R $3 $2
	    print_ret_res "$?" "Permissions \"$3\" on file: $2"
	fi

	if [ ! -z $4 ]; then
        chown -R $4 $2
	    print_ret_res "$?" "Owner and group \"$4\" on file: $2"
	fi
}

# Verifies a copied a file.
# Usage:
#	copy "source"
# Optional:
#	copy "source"  "destination permissions in octal"
#	copy "source"  "destination permissions in octal" "destination user and group"
function verify_copy () {

    if [ -e "$1" ]; then
        print_ret_res "0" "Verified file exists at: $1"
    else
        print_ret_res "1" "Verified file exists at: $1"
	return
    fi

	if [ ! -z $2 ]; then
		if (( $(stat -c %a $1 2> /dev/null) == $2 )); then
			print_ret_res "0" "Verified copied file permissions \"$2\" on file: $1"
		else
			print_ret_res "1" "Verified copied file permissions \"$2\" on file: $1"
		fi
	fi

	if [ ! -z $4 ]; then
		if [ "$(stat -c %U:%G $1 2> /dev/null)" == "$3" ]; then
			print_ret_res "0" "Verified copied file owner and group \"$3\" on file: $1"
		else
			print_ret_res "1" "Verified copied file owner and group \"$3\" on file: $1"
		fi
	fi
}
