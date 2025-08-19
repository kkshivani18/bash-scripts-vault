#!/bin/bash

echo "What do you wantto check?"
read target

while true
do
  if ping -q -c 2 -w 1 $target > /dev/null; then
    echo "Hey, you are up!!"
    break
  else
    echo "$target is currently down"
  fi
sleep 2
done 
