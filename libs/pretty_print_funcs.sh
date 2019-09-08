#!/bin/bash

# Print help arguments.
# Usage:
#	print_help
function print_help () {
	echo -e "\nGIC (Golden Image Creator) was designed to create a golden"
	echo -e "image based on CentOS 7 minimal"
	echo -e "Arguments:"
	echo -e "\t-y" "\t\tSkip confirmation messages."
	echo -e "\t--no-confirm"
	echo -e "\t-F" "\t\tDisable centering of output."
	echo -e "\t--no-format"
	echo -e "\t-t" "\t\tRun task tests."
	echo -e "\t--run-tests"
}

# Prints char array arugment as centered text.
# Usage:
# 	print_center
function print_center () {
	if $FORMAT; then
		# Get first arg and the length of the arg.
		local raw_string=$*
		local str_len=${#raw_string}

		# Print the arg centered in term.
		local loc_pad=""
		for (( i = 1; i <= $((($TERMINAL_WIDTH-$str_len-4)/2)); i++)); do
			loc_pad+=" "
		done
		echo -e "$loc_pad$raw_string"
	else
		echo -e "$*"
	fi
}

# Print our welcome banner.
# Usage:
#	print_banner
function print_banner () {

	if $FORMAT; then
		local msg_pad=""

		for (( i = 1; i <= $((($TERMINAL_WIDTH-51)/2)); i++)); do
			msg_pad+=" "
		done

		echo -e "$msg_pad*************************************************"
		echo -e "$msg_pad**                                             **"
		echo -e "$msg_pad**         🍆 \e[4m\e[43mGOLDEN IMAGE CREATOR\e[0m\e[49m 🍆          **"
		echo -e "$msg_pad**                   (GIC)                     **"
		echo -e "$msg_pad**                                             **"
		echo -e "$msg_pad*************************************************"
	else
		echo -e "*************************************************"
		echo -e "**                                             **"
		echo -e "**         🍆 \e[4m\e[43mGOLDEN IMAGE CREATOR\e[0m\e[49m 🍆          **"
		echo -e "**                   (GIC)                     **"
		echo -e "**                                             **"
		echo -e "*************************************************"

	fi
}

# Print a confirmation screen.
# Usage:
#	print_confirm
function print_confirm () {

	if $FORMAT; then
		local msg_pad=""

		for (( i = 1; i <= $((($TERMINAL_WIDTH-26)/2)); i++)); do
			msg_pad+=" "
		done

		echo -e "$msg_pad*********************"
		echo -e "$msg_pad**                 **"
		echo -e "$msg_pad**   \e[41;5mCONTINUE???\e[0m   **"
		echo -e "$msg_pad**      (Y/n)      **"
		echo -e "$msg_pad**                 **"
		echo -e "$msg_pad*********************"
	else
		echo -e "*********************"
		echo -e "**                 **"
		echo -e "**   \e[41;5mCONTINUE???\e[0m   **"
		echo -e "**      (Y/n)      **"
		echo -e "**                 **"
		echo -e "*********************"

	fi
}

# Prints the latest commit information to the screen.
# Usage:
# 	print_commit_info
function print_commit_info () {
	print_center "Last Commit Information"
	#print_center "Author: ${commit_author}"
	print_center "Commit:" "${commit_abrev}"
	print_center "Date:" "${commit_date}"
	print_center "Time:" "${commit_time}"
}

# Prints a banner with text centered in it.
# Usage:
#	print_role_banner
function print_role_banner () {
	echo ""

	# Print `#` in green for term len
	printf "\e[42m%`tput cols`s\e[0m"|tr ' ' '#'
	print_center "$@"
	# Print `#` in green for term len
	printf "\e[42m%`tput cols`s\e[0m"|tr ' ' '#'
	echo ""
}

# Print success or fail
# Usage:
# 	print_ret_res "<return code>" "<message>"
function print_ret_res () {
	if [ $1 == 0 ] ; then
		echo -e "[  \e[32mOK\e[0m  ] -- $2"
	else
		echo -e "[ \e[31mFAIL\e[0m ] -- $2"
	fi
}

