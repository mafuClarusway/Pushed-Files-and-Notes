#!/bin/bash # need to go to folder with the files
cd ~
cd Desktop/Clarusway/AWS/Projects/Pushed-Files/Pushed-Files-and-Notes/Projects/Project-101/Forth_Part/Task_1/
cat info.json | grep private -i # allows you to find exact wording of private ip, not needed for automation
cat info.json | grep private -i | awk '/PrivateIpAddress/ {print $2}' | head -1 | cut -d'"' -f2 | tee priv.txt
cat terraform.tf # again to find wording
cat terraform.tf | sed "s/ec2-private_ip/$(cat priv.txt)/" | tee terraform.tf # done!