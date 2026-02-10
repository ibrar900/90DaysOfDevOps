Day-17 Shell Scripting: Loops, Arguments & Error Handling
''''
Task 1: For loop
''''
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one

Here is the script forfor_loop.sh
![alt text](<Screenshot 2026-02-10 174032.png>)

2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop
Here is the script for count.sh
![alt text](image.png)

Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end
Here is the script for countdown.sh
![alt text](image-1.png)

Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"
Here is the script for greet.sh
![alt text](image-2.png)

2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)
Here is the script for args_demo.sh
![alt text](image-3.png)

Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package

> Run as root: `sudo -i` or `sudo su`
Here is the script for install_packages.sh
![alt text](image-4.png)

Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails

Example:

mkdir /tmp/devops-test || echo "Directory already exists"

Here is the script for safe_script.sh
![alt text](image-5.png)

```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.
Here is the script for safe_script.sh
![alt text](image-6.png)

''''
What i learned
''''
1.Using for loop
2.Using while loop
3.Using command-line arguments
4.Using error handling 