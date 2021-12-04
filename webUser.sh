#!/bin/bash
#This script is used to write all contents in the /home/webUser to a text file
#Array created to store everything in /home/webUser
array=($(ls /home/webUser))
#Empties the text target text file
> /var/www/html/example.txt
#Below loops through the array
for user in "${array[@]}"
do
#Below writes everything in /webUser
printf "$user\n" >> /var/www/html/example.txt
done
logger "Moved everything in /home/webUser to a text file to be read by web interface from script [$0]"
