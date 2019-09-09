#!/bin/bash

# Source this to determine which package manager to use.
source $(dirname $0)/set_packager.sh

# Verifies that we have the ability to "see" the packagmanager.
# Usage:
# 	verify_packagemanager
function verify_packagemanger () {
	hash ${pkg_utility} > /dev/null 2>&1
	print_ret_res "$?" "Package utility found."
}

# Installs a package.
# Usage:
# 	install_package "package"
function install_package () {
	if ! eval "$query_pkg_cmd $1" > /dev/null 2>&1; then
		eval "$install_pkg_cmd $1" > /dev/null 2>&1
		print_ret_res "$?" "Installed package: ${pkg}"
	else
		print_ret_res "0" "Installed package: ${pkg}"
	fi
}

# Installs packages.
# Usage:
# 	install_packages "A list of packages. Space deliminated."
function install_packages () {
	eval "$install_pkg_cmd $@" > /dev/null 2>&1
	print_ret_res "$?" "Installed packages."
}

# Removes a package
# Usage:
# 	remove_package "package"
function remove_package () {
	if eval "$query_pkg_cmd $1" > /dev/null 2>&1; then
		eval "$remove_pkg_cmd $1" > /dev/null 2>&1
		print_ret_res "$?" "Removed package: ${pkg}"
	else
		print_ret_res "0" "Removed package: ${pkg}"
	fi
}

# Removes packages.
# Usage:
# 	remove_packages "A list of packages. Space deliminated."
function remove_packages () {
	eval "$remove_pkg_cmd $@" > /dev/null 2>&1
	print_ret_res "$?" "Installed packages."
}

# Verifies that a package was installed
# Usage:
# 	verify_package_installed "package"
function verify_package_installed () {
	eval ${query_pkg_cmd} $1 > /dev/null 2>&1
	print_ret_res "$?" "Verified package installed: $1"
}

# Verifies that a package was removed.
# Usage:
# 	verify_package_removed "package"
function verify_package_removed () {
	! eval ${query_pkg_cmd} $1 > /dev/null 2>&1
	print_ret_res "$?" "Verified package removed: $1"
}
