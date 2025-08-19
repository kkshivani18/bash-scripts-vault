#name=$1
#username=$2
#passwd=$3

#echo "Hi $name!!"
#sleep 1
#echo "Your $username and $passwd is exposed"
#sleep 1
#echo "Beware next time"

#!/bin/bash
echo "WHat is your name and age?"
read name
read age
echo "Name is $name and age is $age"

#echo $twit
echo "Calculating..."
sleep 1
echo "*"
echo "**"
echo "****"

getrich=$(((8962 % 15)+$age))
echo "You will get rich at $getrich years"
