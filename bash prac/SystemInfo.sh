#!/bin/bash

while true; do
	clear

	echo "System Info Menu"
	echo "Select the options according to your need: "
	echo "1. List logged-in users"
	echo "2. List system information"
	echo "3. List 5 largest files in the directory"
	echo "4. List basic CPU Information"
	echo "5. Display system time"
	echo "6. Exit program"
	echo "-------------------------------------------"

	read option
	echo "You have selected option - $option"

	case $option in
	    1)
		echo -e "\n Logged in users: "
		who
		;;
	    2)
		echo -e "\nSystem Information: "
		uname 
		;;
	    3)
		echo -e "\nLargest 5 files in the directory: "
		ls -lS | head -n 6
		;;
	    4)
		echo -e "\nBasic CPU Information: "
		lscpu | head
		;;
	    5)
		echo -e "\nCurrent system time: "
		date
		;;
	    6)
		echo "Exiting program"
		exit 0
		;;
	    *)
		echo "Invalid option"
		;;
	esac

	echo -e "\nPress Enter to continue..."
	read
done
