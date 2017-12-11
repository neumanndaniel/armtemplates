#!/bin/bash

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

#Install Apache and configure it for auto start
echo 'Installing Apache web server...'
yum install -y httpd

echo 'Starting httpd.service and enable auto start...'
systemctl start httpd.service
systemctl enable httpd.service
