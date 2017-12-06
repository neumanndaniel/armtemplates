lsblk > disk.conf
if [ $(grep -c 'sdc' disk.conf) -eq 1 ]
then
    echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdc
fi
