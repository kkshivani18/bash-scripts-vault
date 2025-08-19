#!/bin/bash

function shadow(){
if [ -e /etc/shadow ];
then
	echo "It exists"
else
	echo "Doesn't exist"
fi
}
function password(){
if [ -e /etc/passwd ];
then 
	echo "It also exists"
else
	echo "It doesn't exist"
fi
}

shadow
password
