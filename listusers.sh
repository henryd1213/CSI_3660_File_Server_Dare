#!/bin/bash
#henryd1213 12/04/21
#This script is responsible for creating user .txt and .php files. It sets group ownerships and permissions. It also creates each user's .php file.
#This script references "Ls Arrays" and "HTML Page Within Bash" but was written entirely by me.
array=($(ls /home)) #creates an array of all users in /home
> /var/www/html/users.txt #empties the users.txt file so it can be populated with users to be made into links for the user.php page.
#Below loops through array
for user in "${array[@]}"
do
#Below writes each user it finds into the users.txt file so the user.php page can create a link from each one.
printf "$user\n" >> /var/www/html/users.txt
#Below creates two text files and a php file for each user. the $user'"size"'.txt is because when I was reading the filename in php I couldn't get it to username
#And not literally include and exclusion characters. So I included "" in the filename.
#Below also sets permissions and group ownership of the files created.
sudo touch /var/www/html/$user.txt
sudo touch /var/www/html/$user.php
sudo touch /var/www/html/$user'"size"'.txt
sudo chmod 755 /var/www/html/$user.txt
sudo chmod 755 /var/www/html/$user.php
sudo chmod 755 /var/www/html/$user'"size"'.txt
sudo chgrp CSI3660 /var/www/html/$user.txt
sudo chgrp CSI3660 /var/www/html/$user.php
sudo chgrp CSI3660 /var/www/html/$user'"size"'.txt
#Below creates the php file and populates it with a template to match the rest of the website. The design was pulled from the "HTML Page Inspiration" source but all the 
#Content was written by me. The two divisions of left and rigth are from "Side by Side Elements in HTML" and resized for this webpage by me.
#The SVG content was manually edited to have a class and viewbox value by me. I learned how to interact with SVG files from "SVG Basics" and "SVG Styling."
#The php to read the file is from "Read Text FIles PHP" and adjusted by me to the user's two text files.
cat > /var/www/html/$user.php << EOF
<html><head>
<title>Linux File Server</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/fontawesome.min.css">
</head>
<body>
<div class="container">
        <div class="menu">
        <ul class="top">
                <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="gem" class="svg-inline--fafa-gem" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#fff" d="M507.9 196.4l-104-153.8C399.4 35.95 391.1 32 384 32H127.1C120 32 112.6 35.95 108.1 42.56l-103.1 153.8c-6.312 9.297-5.281 21.72 2.406 29.89l231.1 246.2C243.1 477.3 249.4 480 256 480s12.94-2.734 17.47-7.547l232-246.2C513.2 218.1 514.2 205.7 507.9 196.4zM382.5 96.59L446.1 192h-140.1L382.5 96.59zM256 178.9L177.6 80h156.7L256 178.9zM129.5 96.59L205.1 192H65.04L129.5 96.59zM256 421L85.42 240h341.2L256 421z"></path></svg>
                <li class="logo"></li>
                <li><a href="index.php">Home</a></li>
                <li class="active"><a href="user.php">Users</a></li>
                <li><a href="externalUser.php">Upload/Download</a></li>
                <li><a href="about.php">About</a></li>
                <li><a href="references.php">References</a></li>
                <li><a href="https://youtu.be/KLX7-5ffmVM" class="crud-btn"><span>Learn More</span></a></li>
        </ul>
        </div>
                <div class="banner">
                <div class="app-text">
                                <h1>
                                        $user's System Overview:
                                </h1>
                                <div class="splitscreen">
                                    <div class="left">
                                        $user's directory structure:  <br>
                                                                        <?php
                                                                        echo nl2br (file_get_contents('/var/www/html/$user"size".txt'));
                                                                        ?>
                                    </div>
                                
                                    <div class="right">
                                        <?php
                                        echo nl2br (file_get_contents('/var/www/html/$user.txt'));
                                        ?>
                                     </div>
                                </div>
                               
                        </div>
                        <div class="app-picture">
                                <img src="https://image.freepik.com/free-vector/ultraviolet-banner-server-room-abstract-technology-objects-cloud-storage_39422-562.jpg">
                        </div>
                </div>
                <div class="quick-links">
                        <ul class="bottom">
                                <li><a href="mailto:hdare@oakland.edu?subject=Your CSI 3660 File Server"><svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="envelope" class="svg-inline--fafa-envelope" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#fff" d="M448 64H64C28.65 64 0 92.65 0 128v256c0 35.35 28.65 64 64 64h384c35.35 0 64-28.65 64-64V128C512 92.65 483.3 64 448 64zM64 112h384c8.822 0 16 7.178 16 16v22.16l-166.8 138.1c-23.19 19.28-59.34 19.27-82.47 .0156L48 150.2V128C48 119.2 55.18 112 64 112zM448 400H64c-8.822 0-16-7.178-16-16V212.7l136.1 113.4C204.3 342.8 229.8 352 256 352s51.75-9.188 71.97-25.98L464 212.7V384C464 392.8 456.8 400 448 400z"></path></svg><p>EMAIL</p></a> </li>
                                <li><a href="https://github.com/henryd1213/CSI_3660_File_Server_Dare"><svg aria-hidden="true" focusable="false" data-prefix="fab" data-icon="github" class="svg-inline--fafa-github" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#fff" d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3 .3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5 .3-6.2 2.3zm44.2-1.7c-2.9 .7-4.9 2.6-4.6 4.9 .3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3 .7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3 .3 2.9 2.3 3.9 1.6 1 3.6 .7 4.3-.7 .7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3 .7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3 .7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"></path></svg><p>GITHUB</p></a></li>
                             <li><a href="https://www.instagram.com/henry_dare/"><svg aria-hidden="true" focusable="false" data-prefix="fab" data-icon="instagram" class="svg-inline--fafa-github" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500"><path fill="#fff" d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"></path></svg><p>INSTAGRAM</p></a> </li>
                             <li><a href="https://www.snapchat.com/add/henwardo"><svg aria-hidden="true" focusable="false" data-prefix="fab" data-icon="snapchat" class="svg-inline--fafa-github" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#fff" d="M496.9 366.6c-3.373-9.176-9.8-14.09-17.11-18.15-1.376-.806-2.641-1.451-3.72-1.947-2.182-1.128-4.414-2.22-6.634-3.373-22.8-12.09-40.61-27.34-52.96-45.42a102.9 102.9 0 0 1 -9.089-16.12c-1.054-3.013-1-4.724-.248-6.287a10.22 10.22 0 0 1 2.914-3.038c3.918-2.591 7.96-5.22 10.7-6.993 4.885-3.162 8.754-5.667 11.25-7.44 9.362-6.547 15.91-13.5 20-21.28a42.37 42.37 0 0 0 2.1-35.19c-6.2-16.32-21.61-26.45-40.29-26.45a55.54 55.54 0 0 0 -11.72 1.24c-1.029 .224-2.059 .459-3.063 .72 .174-11.16-.074-22.94-1.066-34.53-3.522-40.76-17.79-62.12-32.67-79.16A130.2 130.2 0 0 0 332.1 36.44C309.5 23.55 283.9 17 256 17S202.6 23.55 180 36.44a129.7 129.7 0 0 0 -33.28 26.78c-14.88 17.04-29.15 38.44-32.67 79.16-.992 11.59-1.24 23.43-1.079 34.53-1-.26-2.021-.5-3.051-.719a55.46 55.46 0 0 0 -11.72-1.24c-18.69 0-34.13 10.13-40.3 26.45a42.42 42.42 0 0 0 2.046 35.23c4.105 7.774 10.65 14.73 20.01 21.28 2.48 1.736 6.361 4.24 11.25 7.44 2.641 1.711 6.5 4.216 10.28 6.72a11.05 11.05 0 0 1 3.3 3.311c.794 1.624 .818 3.373-.36 6.6a102 102 0 0 1 -8.94 15.78c-12.08 17.67-29.36 32.65-51.43 44.64C32.35 348.6 20.2 352.8 15.07 366.7c-3.868 10.53-1.339 22.51 8.494 32.6a49.14 49.14 0 0 0 12.4 9.387 134.3 134.3 0 0 0 30.34 12.14 20.02 20.02 0 0 1 6.126 2.741c3.583 3.137 3.075 7.861 7.849 14.78a34.47 34.47 0 0 0 8.977 9.127c10.02 6.919 21.28 7.353 33.21 7.811 10.78 .41 22.99 .881 36.94 5.481 5.778 1.91 11.78 5.605 18.74 9.92C194.8 480.1 217.7 495 255.1 495s61.29-14.12 78.12-24.43c6.907-4.24 12.87-7.9 18.49-9.758 13.95-4.613 26.16-5.072 36.94-5.481 11.93-.459 23.19-.893 33.21-7.812a34.58 34.58 0 0 0 10.22-11.16c3.434-5.84 3.348-9.919 6.572-12.77a18.97 18.97 0 0 1 5.753-2.629A134.9 134.9 0 0 0 476 408.7a48.34 48.34 0 0 0 13.02-10.19l.124-.149C498.4 388.5 500.7 376.9 496.9 366.6zm-34.01 18.28c-20.75 11.46-34.53 10.23-45.26 17.14-9.114 5.865-3.72 18.51-10.34 23.08-8.134 5.617-32.18-.4-63.24 9.858-25.62 8.469-41.96 32.82-88.04 32.82s-62.04-24.3-88.08-32.88c-31-10.26-55.09-4.241-63.24-9.858-6.609-4.563-1.24-17.21-10.34-23.08-10.74-6.907-24.53-5.679-45.26-17.08-13.21-7.291-5.716-11.8-1.314-13.94 75.14-36.38 87.13-92.55 87.67-96.72 .645-5.046 1.364-9.014-4.191-14.15-5.369-4.96-29.19-19.7-35.8-24.32-10.94-7.638-15.75-15.26-12.2-24.64 2.48-6.485 8.531-8.928 14.88-8.928a27.64 27.64 0 0 1 5.965 .67c12 2.6 23.66 8.617 30.39 10.24a10.75 10.75 0 0 0 2.48 .335c3.6 0 4.86-1.811 4.612-5.927-.768-13.13-2.628-38.72-.558-62.64 2.84-32.91 13.44-49.22 26.04-63.64 6.051-6.932 34.48-36.98 88.86-36.98s82.88 29.92 88.93 36.83c12.61 14.42 23.23 30.73 26.04 63.64 2.071 23.92 .285 49.53-.558 62.64-.285 4.327 1.017 5.927 4.613 5.927a10.65 10.65 0 0 0 2.48-.335c6.745-1.624 18.4-7.638 30.4-10.24a27.64 27.64 0 0 1 5.964-.67c6.386 0 12.4 2.48 14.88 8.928 3.546 9.374-1.24 17-12.19 24.64-6.609 4.612-30.43 19.34-35.8 24.32-5.568 5.134-4.836 9.1-4.191 14.15 .533 4.228 12.51 60.4 87.67 96.72C468.6 373 476.1 377.5 462.9 384.9z"></path></svg><p>SNAPCHAT</p></a></li>
                              </ul>
                </div>
</div>
</body></html>
EOF
done
#Below logs success of script 
logger "Successfully created text files and php files for each user from script [$0]"
