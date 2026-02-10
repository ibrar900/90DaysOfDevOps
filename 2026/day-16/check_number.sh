#!/bin/bash

# Prompt the user for input
read -p "Please enter a number of your choice: " num

# Validate input using regex for integer check
if [[ "$num" =~ ^-?[0-9]+$ ]]; then
# Classification using arithmetic evaluation
    if (( num > 0 )); then
        echo "Number is Positive."
    elif (( num < 0 )); then
        echo "Number is Negative."
    else
        echo "Number is Zero."
    fi
else
# Error handling for invalid input
    echo "Entered value is invalid"
    exit 1
fi
