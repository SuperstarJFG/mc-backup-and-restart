#!/bin/bash

# Add +x permission to the script
chmod +x backup_and_restart.sh
# Add a cron job to run the backup_and_restart.sh script every day at 10:00 AM
(crontab -l 2>/dev/null; echo "0 10 * * * ~/mc-backup-and-restart/backup_and_restart.sh >> ~/mc-backup-and-restart/backup_and_restart.log 2>&1") | crontab -