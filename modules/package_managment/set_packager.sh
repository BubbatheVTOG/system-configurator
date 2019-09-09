#!/bin/bash

# Determines which package manager to use.
if $IS_ARCH; then
	export pkg_utility="pacman"
	export install_pkg_cmd="${pkg_utility} -S --noconfirm"
	export remove_pkg_cmd="${pkg_utility} -Rns --noconfirm"
	export update_os_cmd="${pkg_utility} -Syu --noconfirm"
	export query_pkg_cmd="${pkg_utility} -Q"
else
	export pkg_utility="yum"
	export install_pkg_cmd="${pkg_utility} install -y"
	export remove_pkg_cmd="${pkg_utility} remove -y"
	export update_os_cmd="${pkg_utility} update -y"
	export query_pkg_cmd="rpm -qa"
fi

