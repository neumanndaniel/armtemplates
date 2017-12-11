#!/bin/bash
mysqlPassword=$1

#Install updates
echo 'Updating operating system...'
yum update -y

#Configure automated updates
echo 'Configuring operating system for automatic updates...'
yum install -y yum-cron

echo 'Checking /etc/yum/yum-cron.conf for correct configuration...'
if [ $(grep -c 'update_messages = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^update_messages = no/update_messages = yes/g' /etc/yum/yum-cron.conf
    echo 'update_messages value changed from no to yes!'
else
    echo 'update_messages value is already set to yes!'
fi

if [ $(grep -c 'download_updates = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^download_updates = no/download_updates = yes/g' /etc/yum/yum-cron.conf
    echo 'download_updates value changed from no to yes!'
else
    echo 'download_updates value is already set to yes!'
fi

if [ $(grep -c 'apply_updates = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
    echo 'apply_updates value changed from no to yes!'
else
    echo 'apply_updates value is already set to yes!'
fi

echo 'Starting yum-cron.service and enable auto start...'
systemctl start yum-cron.service
systemctl enable yum-cron.service

#Partitioning data disk, formatting it with ext4 and mount it
echo 'Getting empty data disk and create primary partition...'
lsblk > disk.conf
if [ $(grep -c 'sdc' disk.conf) -eq 1 ]
then
    echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdc

    sleep 10

    echo 'Formatting new primary partition with ext4 file system...'
    mkfs.ext4 -L mysqldb /dev/sdc1

    echo 'Creating mount point and mount the new primary partition...'
    mkdir /mnt/mysqldb
    mount /dev/sdc1 /mnt/mysqldb

    echo 'Creating entry in /etc/fstab for the new primary partition...'
    echo "LABEL=mysqldb /mnt/mysqldb ext4 defaults,nofail 1 2" | tee -a /etc/fstab
fi

#Install MySQL server
echo 'Installing MySQL database server...'
wget http://repo.mysql.com/mysql57-community-release-el7-11.noarch.rpm
rpm -ivh mysql57-community-release-el7-11.noarch.rpm

yum install -y mysql-server

echo 'Starting mysqld.service and enable auto start...'
systemctl start mysqld.service
systemctl enable mysqld.service

echo 'Changing the root password...'
temppassword=$(grep 'temporary password' /var/log/mysqld.log|cut -d ':' -f4|cut -d ' ' -f2)
mysqladmin -u root -p"$temppassword" password "$mysqlPassword"
