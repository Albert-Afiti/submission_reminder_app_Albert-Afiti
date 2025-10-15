                                   ** Submission Reminder Automation**
 This project automates the creation of personalized shell environments for tracking student assignment submissions. It includes dynamic directory setup, configuration management, and a reminder system that identifies students who haven't submitted their work. 
 Features - Prompts users for their first name and creates a personalized project directory. - Generates modular subfolders: `app`, `modules`, `assets`, `config`. - Populates each folder with relevant scripts and data files. - Uses environment variables and reusable functions to process submission data. - Allows dynamic assignment updates and re-runs the reminder system.
  **Directory Structure**
submission_reminder_albert/
├── app
│   └── reminder.sh
├── assets
│   └── submissions.txt
├── config
│   └── config.env
├── modules
│   └── functions.sh
└── startup.sh


 **Setup Instructions 1.**  Run the environment creation script: bash bash create_environment.sh
You'll be prompted to enter your first name.
This creates a folder like submission_reminder_Albert with all necessary files.
Run the reminder system:
cd submission_reminder_Albert bash startup.sh
This loads the config, parses the submissions file, and prints reminders.
Update the assignment name (optional):
bash update_assignment.sh
Prompts for a new assignment name.
Updates all config.env files across submission_reminder_* directories.
Automatically re-runs each startup.sh to reflect the change.
**How It Works**
create_environment.sh
Prompts for a name and creates a personalized folder.
Builds subdirectories and populates them with:
config.env: stores assignment name and deadline.
reminder.sh: main script that prints reminders.
functions.sh: defines check_submissions function.
submissions.txt: sample data of student submissions.
startup.sh: launches the reminder script from the correct directory.
update_assignment.sh
Prompts for a new assignment name.
Uses sed to replace the second line of each config.env file.
Re-runs each startup.sh to apply the updated assignment.
 **Notes**
All scripts are made executable automatically.
reminder.sh assumes it's run from the root of the project directory.
The reminder system skips the header row and checks for "not submitted" status.
Author
Created by Albert Afiti, a reflective, mission-driven developer focused on reproducible automation and collaborative scripting.
