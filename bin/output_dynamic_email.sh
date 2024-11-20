#!/bin/bash

# Generate a UUID
uuid=$(uuidgen)

# Define your email components
username="mothore"
domain="gmail.com"

# Combine to create the email with UUID
email="${username}+${uuid}@${domain}"

# Use osascript to simulate typing the variable's value
osascript <<EOF
tell application "System Events"
  keystroke "$email"
end tell
EOF
