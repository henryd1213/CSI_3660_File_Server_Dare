#!/bin/bash
#This script is responsible for populating the rext files created by listusers.sh. The directory command was taken from "Tree Directory Structure in Bash"
#And modified to look in the home directories of each user by me. The file extension commands were taken from "Search for File Extensions"
#The Commands to search for file sizes came from "Size of Directories." Each command was modified to look in each user's /home directory
#Below creates an array of all directories in /home
array=($(ls /home))
#Below loops through the array
for user in "${array[@]}"
do
#Below empties the two user's text files to ensure it doesn't write twice.
> /var/www/html/$user.txt
> /var/www/html/$user'"size"'.txt
#Below maps out the directory structure. taken from "Tree Directory Structure in Bash" and modified by me to look in the /home directory
echo -e "$(ls -aR /home/$user | grep ":$" | perl -pe 's/:$//;s/[^-][^\/]*\//    /g;s/^    (\S)/└── \1/;s/(^    |    (?= ))/│   /g;s/    (\S)/└── \1/')" >> /var/www/html/$user'"size"'.t
xt
#Below finds the size of each user's /home directory and stores it in a variable. Command to find size taken from "Size of Directories" Modified by me to look in /home and store in var
iable
vara=$(du -sh /home/$user)
#Below takes the size command and takes off the /home/$user so it just reads the size. Command to remove was taken from "Remove Text After Character in Bash"
varb=${vara%%/*}
#Below writes size of directory attached with variable
echo "Size of all items in $user's directories in Bytes: $varb" >> /var/www/html/$user.txt
#All commands below look for file extensions and add them together to get number of specific files.
#Command to find extensions taken from "Search for File Extenions" and added together using "Addition in Bash." Modified by me to looks in each user's /home directory
echo "Audio files: $(($(find /home/$user -iname '*.mp3' | wc -l) + $(find /home/$user -iname '*.wav' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Video files: $(($(find /home/$user -iname '*.mp4' | wc -l) + $(find /home/$user -iname '*.mov' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Compressed files: $(($(find /home/$user -iname '*.7z' | wc -l) + $(find /home/$user -iname '*.zip' | wc -l) + $(find /home/$user -iname '*.rar' | wc -l) + $(find /home/$user -ina
me '*.tar.gz' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Executable files: $(($(find /home/$user -iname '*.exe' | wc -l) + $(find /home/$user -iname '*.jar' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Images: $(($(find /home/$user -iname '*.jpg' | wc -l) + $(find /home/$user -iname '*.png' | wc -l) + $(find /home/$user -iname '*.gif' | wc -l) | bc -l))" >> /var/www/html/$user.
txt
echo "Internet files: $(($(find /home/$user -iname '*.css' | wc -l) + $(find /home/$user -iname '*.html' | wc -l) + $(find /home/$user -iname '*.js' | wc -l) + $(find /home/$user -inam
e '*.php' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Text files: $(find /home/$user -iname '*.txt' -printf '1\n' | wc -l)" >> /var/www/html/$user.txt
echo "PDF files: $(($(find /home/$user -iname '*.pdf' | wc -l) + $(find /home/$user -iname '*.pdfx' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Word files: $(($(find /home/$user -iname '*.doc' | wc -l) + $(find /home/$user -iname '*.docx' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Spreadsheet files: $(($(find /home/$user -iname '*.xls' | wc -l) + $(find /home/$user -iname '*.xlsx' | wc -l) + $(find /home/$user -iname '.xlsm' | wc -l) | bc -l))" >> /var/www
/html/$user.txt
echo "PowerPoint presentations: $(($(find /home/$user -iname '*.ppt' | wc -l) + $(find /home/$user -iname '*.pptx' | wc -l) | bc -l))" >> /var/www/html/$user.txt
echo "Programming files: $(($(find /home/$user -iname '*.c' | wc -l) + $(find /home/$user -iname '*.class' | wc -l) + $(find /home/$user -iname '*.cpp' | wc -l) + $(find /home/$user -i
name '*.java' | wc -l) + $(find /home/$user -iname '*.php' | wc -l) + $(find /home/$user -iname '*.py' | wc -l) + $(find /home/$user -iname '*.sh' | wc -l) | bc -l))" >> /var/www/html/
$user.txt
done
#Below logs success of script execution.
logger "Populated user text files with their data from script [$0]"
