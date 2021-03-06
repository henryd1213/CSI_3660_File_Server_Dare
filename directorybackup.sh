#!/bin/bash
#henryd1213 12/04/21
#This script is responsible for backing up all directories and subdirectories in /home
#This base script was pulled from the source "TAR Backups" and put into an array from "ls Arrays." It was modified by me to look in the /home directory 
#And the date format was modified, as well as modifying the backup structure to create a date folder, the make the backup for each user in that folder.
DATE=$(date +%m-%d-%Y) #Sets the date format to month day year
#Below sets the backup directory to the required project backup location.
BACKUP_DIR="/usr/local/CSI3660ProjectBackup"
#Below creates an array of all users in /home
array=($(ls /home))
#Below loops through array
for user in "${array[@]}"
do
mkdir -p $BACKUP_DIR/$DATE #makes a date directory if it doesn't exist. Made by me.
#Below makes the backup for everything within that user's /home directory and places it in the backup location and appends the file with the name and date. modified by me.
tar -zcvpf $BACKUP_DIR/$DATE/$user-$DATE.tar.gz /home/$user
#Below deletes backups older than 10 days. Taken from source.
find $BACKUP_DIR/* -mtime +10 -exec rm {} \;
done
#Below logs success of script execution 
logger "Backed up all /home directories to /usr/loca/CSI3660 from script [$0]"
