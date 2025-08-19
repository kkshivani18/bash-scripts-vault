#!/bin/bash

echo "Execution of Script: $0"
echo "Please enter the name of the user: $1"

#Adding the user
sudo adduser --home /$1 $1

