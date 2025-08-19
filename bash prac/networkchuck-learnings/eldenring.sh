#!/bin/bash

echo "You died"

# First beast battle 
beast = $(( $RANDOM % 2 ))

echo "Your first beast approaches. Prepare the number from 0 to 1 (0/1)"

read tarnished

if [[ $beast == $tarnished ]]; then

	echo "Beast VANQUISED. Congrats!!"

elif [[ $USER == "kali" ]]; then 

	echo "Kali wins"

else 

	echo "You Died"

fi

sleep 2

echo "Boss battle. Get scared. It's Margit. Pick a number from 0 to 9 (0-9)"

read tarnished

beast = $(( $RANDOM % 10 )) 

if [[ $beast == $tarnished || $tarnished == "coffee" ]]; then
	if [[ $USER == "root" ]]; then
		echo "Beast vanquished"
	fi
else
	echo "You Died"
fi

