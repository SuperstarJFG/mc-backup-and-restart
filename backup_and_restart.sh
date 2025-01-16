#!/bin/bash

tmux_session="0"  # Name of the tmux session running your server
world_folder="world"  # Name of the folder containing the world data
date=$(date +%Y-%m-%d)  # Current date for backup file
old_date=$(date -d "2 days ago" +%Y-%m-%d)  # Date for deleting old backup

echo
echo $date

if tmux has-session -t "$tmux_session" 2>/dev/null; then
  echo "Found tmux session '$tmux_session'"

  echo "Announcing to server"
  tmux send-keys -t "$tmux_session" "say Stopping server for backup" C-m
  sleep 5
  
  echo "Stopping server"
  tmux send-keys -t "$tmux_session" "stop" C-m
  sleep 10
  
  echo "Backing up $world_folder to world-$date.zip"
  tmux send-keys -t "$tmux_session" "sudo zip -r world-$date.zip $world_folder" C-m
  sleep 60

  echo "Deleting backup from $old_date"
  tmux send-keys -t "$tmux_session" "sudo rm world-$old_date.zip" C-m
  sleep 5

  echo "Starting server"
  tmux send-keys -t "$tmux_session" "sudo ./run.sh" C-m
else
  echo "Error: tmux session '$tmux_session' not found. Is the server running?"
  exit 1
fi