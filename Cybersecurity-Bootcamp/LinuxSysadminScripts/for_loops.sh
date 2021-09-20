#!/bin/bash

# List of Created Variables
states=('Illinois' 'Florida' 'New York' 'Hawaii' 'Colorado')
num=(seq 0 9)
ls_out=$(ls)
execs=$(find /home -type f -perm 777 2> /dev/null)

# For Loops Created

# For loop for states

for state in ${states[@]}
do
if [$state == 'Hawaii'];
then
echo "Hawaii is the best!"
else
echo "I'm not a fan of Hawaii."
fi
done

# For loop for numbers

for num in ${nums[@]}
do
if [$num = 3] || [$num = 5] || [$num = 7]
then
echo $num
fi
done

# For loop for LS that holds the output of the ls command
for x in ${ls_out[@]}
do
echo $x
done

# For loop to print out execs on one line for each entry
for exec in ${execs[@]}
do
echo $execs
done
