#!/bin/bash

echo "Welcome tarnished. Select your starting class:
1 - Samurai
2 - Prisoner
3 - Prophet"

read class 

case $class in

	1)

		type="Samurai"
		hp=10
		attack=11
		;;
	2)

        	type="Prisoner"
        	hp=13
        	attack=4
		;;
	3)
		type="Prophet"
		hp=30
		attack=4
		;;
esac

echo "You have chosen the $type class. Your HP is $hp and your attack is $attack." 
