#!/bin/bash

# Get the active output (screen) name where the currently focused window is
output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')

# Get the workspace number from the argument passed to the script
workspace_number=$1

# Switch to the workspace with the corresponding number on the focused output
i3-msg "workspace $workspace_number:$output"
