#!/bin/bash
# Check if the User ran this with sudo permissions

if [$UID -ne 0]
then 
echo "Please run this Script with sudo"
exit
fi

# Defining Variables
output=$HOME/research3/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777 2> /dev/null)
cpu=$(lscpu | grep CPU)
disk=$(df -H | head -2)

# Define Lists to use later
files=(
'/etc/passwd'
'/etc/shadow'
)

commands=(
	'date'
	'uname -a'
	'hostname -s'
)


# Check if there is a research3 directory

if [!-d $HOME/research3]
then
mkdir $HOME/research3
fi

# Check if there is an output file

if [-f $output]
then
rm $output
fi

echo "A Quick System Audit Script" > $output 
# Check the Date
date >> $output
echo "" >> $output
# Check Machine Type
echo "Machine Type Info:" >> $output
echo $MACHTYPE >> $output
# Check Username
echo -e "Uname info: $(uname -a) \n" >> $output
# Check IP info
echo -e "IP info:"
echo -e "$ip \n" >> $output
# Check the Hostname
echo "Hostname: $(hostname -s) " >> $output
# Check the DNS servers
echo "DNS servers: " >> $output
cat /etc/resolv.conf >> $output
# Check the permissions and change if needed
echo -e "\nexec Files:" >> $output
$execs >> $output
# Check the PC's Top 10 Processes
echo -e "\nTop 10 Processes" >> $output
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output
# Display login information for current user
echo -e "\nCurrent user login information: \n $(who -a) \n" >> $output
# Check PC Memory Info
echo "Memory Info:" >> $output
free >> $output
# Check CPU usage
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output
# Check Disk Usage
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output
# Check Who is logged in to this PC
echo -e "\nWho is logged in: \n $(who) \n" >> $output
fi
# Check Permissions on Files in your File list
echo -e "\nThe permissions for sensitive /etc files: \n" >> $output
for file in ${files[@]}
do
ls -l $file >> $output
done

# Check the sudo abilities of Each user in the /home directory

for user in $(ls /home)
do
sudo -lu $user
done

# Create a list that displays username, hostname, and the date

for x in {0..2}
do
results=$(${commands[x]})
echo $results
echo ""
done 
