#!/usr/bin/env bash

# Check for root access
if [ "$EUID" -ne 0 ]
then
    echo "Please run this script with sudo"
    exit
fi

#Replace Student files
cp /home/instructor/Documents/research/user.hashes /
cp /home/instructor/Documents/research/str.sh /tmp
echo "copied str.sh and user.hashes into place"

#Remove teacher demo files
rm /tmp/rev_shell.sh /tmp/listen.sh /tmp/a9xk.sh
echo "removed scripts from /tmp directory"

# Change ownership and permissions of these scripts to the `jack` user
chown -R jack:jack /user.hashes /tmp/str.sh
chmod 0744 /tmp/str.sh
chmod 0644 /user.hashes
echo "set owner and permissions for str.sh and user.hashes"