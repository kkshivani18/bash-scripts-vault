#!/bin/bash

if [ "$1" == "" ]
then 
echo "You forgot an ip address"
echo "Syntax: ./tcm.sh 192.168.1"

else
for ip in `seq 1 254`; do
ping -c $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" & 
done
fi 

# $ip is used for seq in ip 1 to 254 and $1 is the first command after the tcm.sh

