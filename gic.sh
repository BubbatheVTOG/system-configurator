#!/bin/bash


# Source these scripts for dependencies.
source $(dirname $0)/conf/set_environment.sh
source $(dirname $0)/libs/pretty_print_funcs.sh
source $(dirname $0)/modules/module_loader.sh

########################
#      FUNCTIONS       #
########################

# Parse arguments.
function parse_args () {
	while (( "$#" )); do
		case $1 in
			-y|--no-confirm)
				skip_confirm=true
				shift
				;;
			-F|--no-format)
				FORMAT=false
				shift
				;;
			-va|--verify_all)
				VERIFY_ALL=true
				shift
				;;
			--)
				shift
				;;
			-h|--help)
				print_help
				exit 0
				;;
			*)
				print_help
				exit 1
				;;
		esac
	done
}


#######################
#        MAIN         #
#######################

skip_confirm=false
go=false

# Need to run this as root. Evaluate our privileges here.
if [[ ${UID} != "0" ]]; then
	echo ""
	echo -e "YOU NEED TO RUN THIS SCRIPT AS ROOT!!!"
	print_help
	exit 1
fi

parse_args "$@"

# Clear the screen.
clear

echo -e ""
print_banner
echo -e ""
print_commit_info
echo -e ""

# Print confimration screen.
if ! $skip_confirm; then
	print_confirm
	pad=""
	if $FORMAT; then
		for (( i = 1; i <= $((($TERMINAL_WIDTH-15)/2)); i++)); do
			pad+=" "
		done
	fi
	read -p "${pad}Continue? " -n 1 -r
	echo #remove whitespace in buffer.
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		go=true
	else
		exit 1
	fi
else
	go=true
fi

# Clear the screen of banners
clear

# GO!!!!
stages=$(ls -d $roles_dir*/)
for stage in $stages; do
	cd ${stage}
	source task.sh
	pre
	task
	post
	if $VERIFY_ALL; then
		verify
	fi
	cd ${MY_DIR}
done
