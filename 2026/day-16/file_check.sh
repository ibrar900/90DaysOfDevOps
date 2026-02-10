#!/bin/bash

# Prompt user for file name
read -p "Please enter any file name: " fname

# Check if input is empty
if [[ -z "$fname" ]]; then
    echo "Error: No file name entered."
    exit 1
fi

# Check if file exists
if [[ -f "$fname" ]]; then
    echo "The file exists."
else
    echo "The file doesn't exist."
fi
