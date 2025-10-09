#!/bin/bash

#Taking the user's name for directory creation
read -p "Enter your first name: " Username

#ensuring that users enters their name and also handling error message
while [[ -z "$Username" ]]; do         
        echo "You have to enter a name!"
        read -p "Please enter your name: " Username
done

#Creating personalized directories for each user
Dir_name=submission_reminder_$Username

#Creating  subfolders in the main project folder
mkdir $Dir_name
echo "main directory sucessfully created"
mkdir $Dir_name/app
echo "app directory sucessfully created"
mkdir $Dir_name/modules
echo "modules directory sucessfully created"
mkdir $Dir_name/assets
echo "assets directory sucessfully created"
mkdir $Dir_name/config
echo "config directory sucessfully created"

#Adding the content of the config.env given 
cat <<'EOF' >> $Dir_name/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "config.env sucessfully created and populated"

#Adding the content of the reminer.sh 
cat <<'EOF' >> $Dir_name/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
echo "reminder.sh sucessfully created and populated"

#Adding the content of the functions .sh  
cat <<'EOF' >> $Dir_name/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
echo "functions.sh sucessfully created and populated"

#adding the content of submissions.txt and also providing other names that also check if they submitted their assingnment or not  
cat <<'EOF' >> $Dir_name/assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Eric, Bash, not submitted
Kwame, Regex, submitted
Sika, HTML Basics, not submitted
Blessing, Python Programming, submitted
Albert, CSS Queries, not submitted
EOF
echo "submissions.txt sucessfully created and populated"

#ensuring the  startup.sh script is created correctly and will reliably execute reminder.sh with the right working directory context.
cat <<'EOF' >> $Dir_name/startup.sh
#!/bin/bash

cd "$(dirname "$0")"
bash ./app/reminder.sh
EOF
echo "startup.sh file sucessfully created and populated"

#ensuring if all the script update the permissions off all files with .sh
chmod u+x $Dir_name/app/reminder.sh
chmod u+x $Dir_name/modules/functions.sh
chmod u+x $Dir_name/startup.sh
echo "done with all the permissions"
