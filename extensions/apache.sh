#!/bin/bash

#Install updates
sudo yum update -y

#Configure automated updates
sudo yum install -y yum-cron

if[$(grep -c 'update_messages = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^update_messages = no/update_messages = yes/g' /etc/yum/yum-cron.conf
    echo 'update_messages value changed from no to yes!'
else
    echo 'update_messages value is already set to yes!'
fi

if[$(grep -c 'download_updates = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^download_updates = no/download_updates = yes/g' /etc/yum/yum-cron.conf
    echo 'download_updates value changed from no to yes!'
else
    echo 'download_updates value is already set to yes!'
fi

if[$(grep -c 'apply_updates = no' /etc/yum/yum-cron.conf) -eq 1 ]
then
	sed -i 's/^apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
    echo 'apply_updates value changed from no to yes!'
else
    echo 'apply_updates value is already set to yes!'
fi

systemctl start yum-cron.service
systemctl enable yum-cron.service

#Install Apache and configure it for auto start
sudo yum install -y httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
