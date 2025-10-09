#!/bin/bash
# GEtting user input to replace assignment
read -p "Enter the Assignment_name: " Assignment 

#Input sanitization to ensure a name has been entered.
while [[ -z "$Assignment" ]]; do
        echo "you have to enter assignment_name!"
        read -p "please enter your assignment_name:" Assignment
done

#checking for any directory that has submission_reminder..., and locating the config.env file
#The if statement block replaces the current assignment in row two with the user's input

for i in submission_reminder_*/config; do
	if [ -f "$i/config.env" ]; then
		sed -i "2s/.*/ASSIGNMENT=\"$assName\"/" "$i/config.env"    
		echo "ASSIGNMENT in $i/config.env has been updated to $assName"
	fi
done


#Running the startup.sh file in the directory that has submission_reminder_...

for i in submission_reminder_*/; do
	if [ -f "$i/startup.sh" ]; then
		./$i/startup.sh
	fi
done
