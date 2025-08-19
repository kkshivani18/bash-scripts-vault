#!/bin/bash

echo "Enter the number : "
read number

if [[ $number =~ ^[0-9]+$ ]]; then
	echo "Number is positive and whole number"
elif [[ $number =~ ^-[0-9]+$ ]]; then
	echo "Number is negative"
else
	echo "Not valid"
fi
