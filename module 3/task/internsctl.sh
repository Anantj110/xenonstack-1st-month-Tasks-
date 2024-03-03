#!/usr/bin/bash

Command_name="internsctl"
Command_version="v0.1.0"

get_help(){
	echo "$Command_name: $Command_name [Options]"
	echo "[Description]"
	echo "options:"
	echo "--help	Display usage and guidelinse."
	echo "--version	Display the version of the command"
}
display_version(){
	echo "Command version	$Command_version"
}

case "$1" in
	--help) get_help ;;
       	--version) display_version ;;
esac

get_CPU_info(){
	lscpu
}

get_memory_info(){
	free
}

case "$2" in
	get_info)
		if [ "$1" == "cpu" ]
		then
			get_CPU_info 
		elif [ "$1" == "memory" ]
		then
			get_memory_info
		fi
		;;
esac

add_user() {
	local USER=$1
	local PASS=$2
	
	sudo useradd -m -p "$PASS" "$USER" && echo "User '$USER' successfully added."
}

delete_user() {
	local USER=$1
	sudo userdel -r $USER && echo "User $USER successfully deleted"
}

display_user_list(){
	cat /etc/passwd
}

display_sudo_user_only(){
:wq	getent group sudo | cut -d: -f4 | tr ',' '\n'
}

case "$1" in
	create)
		if [ "$2" == "user" ]
		then
			read -p "Enter username: " USER
			read -s -p "Enter password: " PASS
			echo
			add_user "$USER" "$PASS"
		fi
		;;
	user)
		if [ "$2" == "list"  ]
		then
			if [ "$3" == "--sudo-only"]
			then
				display_sudo_user_only
			else
				display_user_list
			fi
		elif [ "$2" == "delete" ] 
		then
		       read -p "Enter the username: " USER	
			delete_user "$USER"
		fi
		;;
esac

get_file_info() {
	local fileName=$1
	local size=$(stat -c %s "$fileName")
	local access=$(stat -c %A "$fileName")
	local user=$(stat -c %U "$fileName")
	local modify=$(stat -c %y "$fileName")

	case "$2" in 
		--size | -s)
			echo "Size(B):  $size"
			;;
		--permissions | -p)
			echo "Access:   $access"
			;;
		--owner | -o)
			echo "Owner:    $user"
			;;
		--last-modified | -m)
			echo "Modify:   $modify"
			;;
		*)
			echo "File:     $fileName"
			echo "Access:   $access"
			echo "Size(B):  $size"
			echo "Owner:    $user"
			echo "Modify:   $modify"
			;;
																						esac
																					}

case "$1" in
	file)
		case "$2" in
			getinfo)
				get_file_info "$3" "$4"
				;;
		esac
esac
