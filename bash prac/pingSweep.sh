#!/bin/bash

#Simple Ping Script
# (-c used for count)
echo "Enter the subnet: "
read SUBNET

for IP in $(seq 1 254); do
	ping -c 1 $SUBNET.$IP
done 
