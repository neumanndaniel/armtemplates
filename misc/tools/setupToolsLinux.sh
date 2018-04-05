#!/bin/bash

#Ubuntu
if [ $(cat /etc/*_version|grep -c 'Ubuntu') -ge 1 ]
then
    #Azure CLI
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
    sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
    sudo apt-get install apt-transport-https
    sudo apt-get update && sudo apt-get install azure-cli

    #PowerShell Core
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    if [ $(cat /etc/*_version|grep -c 'Ubuntu 16.04') -ge 1 ]
    then
        sudo curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
    else
        sudo curl https://packages.microsoft.com/config/ubuntu/17.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
    fi
    sudo apt-get update
    sudo apt-get install -y powershell
fi

#CentOS
if [ $(cat /etc/*-release|grep -c 'CentOS') -ge 1 ]
then
    #Azure CLI
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
    yum check-update
    sudo yum install azure-cli

    #PowerShell Core
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
    sudo yum install -y powershell
fi
