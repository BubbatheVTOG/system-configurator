#!/bin/bash

# The current absolute directory of the script.
export MY_DIR="$( cd -P "$(dirname "$0")" && pwd)"
export PROJ_ROOT=${MY_DIR}../

# Setting this to true will format output.
export FORMAT=true

# Setting this to true will run verification tests.
export VERIFY_ALL=false

# Find our term width. Used for centerting text.
export TERMINAL_WIDTH=$(tput cols)

# Roles Directory
export roles_dir=${MY_DIR}/stages/

# Modules Directory
export mods_dir=${MY_DIR}/modules/

# Git Commit Information
export commit_abrev=$(git log -n1 --pretty=format:"%h")
export commit_author=$(git log -n1 --pretty=format:"%an")
export commit_date=$(git log -n1 --date=format:"%m/%d/%y" --pretty=format:"%ad")
export commit_time=$(git log -n1 --date=format:"%H:%M:%S" --pretty=format:"%ad")
export commit_summary=$(git log -n1 --pretty=format:"%s")

# If we are on Arch. This is for Bubba.
if [[ -e /etc/arch-release ]]; then
    export IS_ARCH=true
else
    export IS_ARCH=false
fi
