#!/bin/bash

# Generate a UUID
uuid=$(uuidgen)

# Define your email components
username="mothore"
domain="gmail.com"

# Combine to create the email with UUID
email="${username}+${uuid}@${domain}"

# Output the email
echo "$email" | pbcopy
