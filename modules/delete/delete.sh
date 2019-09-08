#!/bin/sh

# Delets a file or directory.
# Usage:
#   delete "file"
function delete () {
    rm -rf $1
    print_ret_res "$?" "Deleted: $1"
}

# Verifies that a file or directory is non-existant.
# Usage:
#   verify_delete "destination"
function verify_delete () {
    if [ ! -e $1 ]; then
        print_ret_res "0" "Verify deleted: $1"
    else
        print_ret_res "1" "Verify deleted: $1"
    fi
}
