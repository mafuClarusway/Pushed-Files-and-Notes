#!/bin/bash

# Check if we are root privilage or not

# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file

# Where do we backup to. Please crete this file before execute this script

# Create archive filename based on time

# Print start status message.

# Backup the files using tar.

# Print end status message.

# Long listing of files in $dest to check file sizes.

#!/bin/bash 
# NOT AUTOMATED YET BUT FINISHED?
sudo -i
cd /
mkdir /mnt/lala
mkdir /home/ec2-user/data
# /home/ec2-user/, /etc, /boot, /usr -> /mnt/backup
# enter the following into crontab -e
5 * * * * cp -R /home/ec2-user/data /mnt/backup # remove -R command after cp cause files were too big
5 * * * * cp -R /etc /mnt/backup 
5 * * * * cp -R /boot /mnt/backup 
5 * * * * cp -R /usr /mnt/backup
5 * * * * tirtle=$(date +"%d-%m-%y_%T")
5 * * * * echo $tirtle | sed '\s\/\:\/\-\/\g' | tee turtle.txt
5 * * * * sudo tar -c -f $(cat $turtle.txt)_$(hostname).tar.Z /mnt/backup/data /mnt/backup/etc /mnt/backup/boot /mnt/backup/usr