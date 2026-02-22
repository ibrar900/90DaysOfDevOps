Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference GuideTask 1: Basics1. Shebang (#!/bin/bash)
What it does: Tells the system which interpreter to use to execute the script.
Why it matters: Ensures the script runs with the correct shell regardless of default settings.
bash#!/bin/bash
#!/bin/bash
2. Running a script
chmod +x script.sh: Makes the script executable.
./script.sh: Runs the script from current directory.
bash script.sh: Runs the script using bash explicitly.
bashchmod +x script.sh
./script.sh
bash script.sh
chmod +x script.sh
./script.sh
bash script.sh
3. Comments
Single-line comment: # This is a comment
Inline comment: echo "Hello" # This is inline
bash# This is a comment
echo "Hello" # This is inline
# This is a comment
echo "Hello" # This is inline
4. Variables
Declaring: VAR="value"
Using: $VAR
Quoting: "$VAR" (allows expansion), '$VAR' (literal), $VAR (no quotes)
bashNAME="DevOps"
echo $NAME
echo "$NAME"
echo '$NAME'
NAME="DevOps"
echo $NAME
echo "$NAME"
echo '$NAME'
5. Reading user input
read VAR: Reads user input into a variable.
bashread name
echo "Hello, $name"
read name
echo "Hello, $name"
6. Command-line arguments
$0: Script name
$1, $2: First and second arguments
$#: Number of arguments
$@: All arguments
$?: Exit status of last command
bashecho "Script: $0"
echo "First arg: $1"
echo "Number of args: $#"
echo "All args: $@"
echo "Exit status: $?"
echo "Script: $0"
echo "First arg: $1"
echo "Number of args: $#"
echo "All args: $@"
echo "Exit status: $?"
Task 2: Operators and Conditionals1. String comparisons
=: Equal
!=: Not equal
-z: Empty string
-n: Non-empty string
bashif [ "$var" = "test" ]; then echo "Equal"; fi
if [ "$var" = "test" ]; then echo "Equal"; fi
2. Integer comparisons
-eq, -ne, -lt, -gt, -le, -ge
bashif [ $num -gt 5 ]; then echo "Greater than 5"; fi
if [ $num -gt 5 ]; then echo "Greater than 5"; fi
3. File test operators
-f: File exists and is regular
-d: Directory exists
-e: File or directory exists
-r: Readable
-w: Writable
-x: Executable
-s: Size > 0
bashif [ -f file.txt ]; then echo "File exists"; fi
if [ -f file.txt ]; then echo "File exists"; fi
4. if, elif, elsebashif [ condition ]; then
  action1
elif [ another_condition ]; then
  action2
else
  action3
fi
if [ condition ]; then
  action1
elif [ another_condition ]; then
  action2
else
  action3
fi
5. Logical operators
&&: AND
||: OR
!: NOT
bash[ condition ] && echo "Success"
[ ! condition ] || echo "Failed"
[ condition ] && echo "Success"
[ ! condition ] || echo "Failed"
6. Case statementsbashcase $var in
  "option1") echo "Selected option1" ;;
  "option2") echo "Selected option2" ;;
  *) echo "Default" ;;
esac
case $var in
  "option1") echo "Selected option1" ;;
  "option2") echo "Selected option2" ;;
  *) echo "Default" ;;
esac
Task 3: Loops1. for loop
List-based: for i in 1 2 3; do echo $i; done
C-style: for ((i=0; i<3; i++)); do echo $i; done
bashfor i in {1..3}; do echo $i; done
for i in {1..3}; do echo $i; done
2. while loopbashwhile [ condition ]; do
  action
done
while [ condition ]; do
  action
done
3. until loopbashuntil [ condition ]; do
  action
done
until [ condition ]; do
  action
done
4. Loop control
break: Exit loop
continue: Skip iteration
bashfor i in 1 2 3; do
  if [ $i -eq 2 ]; then continue; fi
  echo $i
done
for i in 1 2 3; do
  if [ $i -eq 2 ]; then continue; fi
  echo $i
done
5. Looping over filesbashfor file in *.log; do
  echo "Processing $file"
done
for file in *.log; do
  echo "Processing $file"
done
6. Looping over command outputbashwhile read line; do
  echo "$line"
done < file.txt
while read line; do
  echo "$line"
done < file.txt
Task 4: Functions1. Defining a functionbashfunction_name() {
  action
}
function_name() {
  action
}
2. Calling a functionbashfunction_name
function_name
3. Passing arguments to functionsbashgreet() {
  echo "Hello, $1"
}
greet "DevOps"
greet() {
  echo "Hello, $1"
}
greet "DevOps"
4. Return values
Use return for exit codes (0–255)
Use echo to return strings
bashcheck() {
  return 0
}
result=$(check)
echo $?
check() {
  return 0
}
result=$(check)
echo $?
5. Local variablesbashmy_func() {
  local var="local_value"
}
my_func() {
  local var="local_value"
}
Task 5: Text Processing Commands1. grep
Search patterns: grep "pattern" file
-i: Case insensitive
-r: Recursive search
-c: Count matches
-n: Show line numbers
-v: Invert match
-E: Extended regex
bashgrep -i "error" log.txt
grep -r "pattern" .
grep -i "error" log.txt
grep -r "pattern" .
2. awk
Print columns: awk '{print $1}' file
Field separator: awk -F: '{print $1}' /etc/passwd
Patterns: awk '/pattern/ {print}' file
BEGIN/END: Run before/after processing
bashawk '{print $1}' file.txt
awk -F: '{print $1}' /etc/passwd
awk '{print $1}' file.txt
awk -F: '{print $1}' /etc/passwd
3. sed
Substitution: sed 's/old/new/g' file
Delete lines: sed '/pattern/d' file
In-place edit: sed -i 's/foo/bar/g' file
bashsed 's/old/new/g' file.txt
sed -i 's/foo/bar/g' config.txt
sed 's/old/new/g' file.txt
sed -i 's/foo/bar/g' config.txt
4. cut
Extract columns by delimiter: cut -d':' -f1 /etc/passwd
bashcut -d':' -f1 /etc/passwd
cut -d':' -f1 /etc/passwd
5. sort
Alphabetical: sort file.txt
Numerical: sort -n file.txt
Reverse: sort -r file.txt
Unique: sort -u file.txt
bashsort -n file.txt
sort -n file.txt
6. uniq
Deduplicate: uniq file.txt
Count duplicates: uniq -c file.txt
bashuniq -c file.txt
uniq -c file.txt
7. tr
Translate characters: tr 'a-z' 'A-Z' < file.txt
Delete characters: tr -d '\n' < file.txt
bashtr 'a-z' 'A-Z' < file.txt
tr 'a-z' 'A-Z' < file.txt
8. wc
Count lines/words/chars: wc file.txt
bashwc file.txt
wc file.txt
9. head / tail
First N lines: head -n 10 file.txt
Last N lines: tail -n 10 file.txt
Follow mode: tail -f file.txt
bashhead -n 5 file.txt
tail -f log.txt
head -n 5 file.txt
tail -f log.txt
Task 6: Useful Patterns and One-Liners
Find and delete files older than N days:
bashfind . -type f -mtime +7 -delete
find . -type f -mtime +7 -delete

Count lines in all .log files:
bashfind . -name "*.log" -exec wc -l {} +
find . -name "*.log" -exec wc -l {} +

Replace a string across multiple files:
bashsed -i 's/old/new/g' *.txt
sed -i 's/old/new/g' *.txt

Check if a service is running:
bashsystemctl is-active nginx
systemctl is-active nginx

Monitor disk usage with alerts:
bashdf -h | awk '$5 > 80 {print "Warning: Disk usage high"}'
df -h | awk '$5 > 80 {print "Warning: Disk usage high"}'

Tail a log and filter for errors in real time:
bashtail -f app.log | grep ERROR
tail -f app.log | grep ERROR

Parse CSV using awk:
bashawk -F',' '{print $1}' data.csv
awk -F',' '{print $1}' data.csv
Task 7: Error Handling and Debugging1. Exit codes
$?: Exit status of last command
exit 0: Success
exit 1: Failure
bashls /nonexistent
echo $? # Should print 2
ls /nonexistent
echo $? # Should print 2
2. set -e
Exit immediately if a command fails
bashset -e
set -e
3. set -u
Treat unset variables as errors
bashset -u
set -u
4. set -o pipefail
Catch errors in pipes
bashset -o pipefail
set -o pipefail
5. set -x
Enable trace mode (debug)
bashset -x
set -x
6. Trap
Run cleanup code on exit
bashtrap 'rm temp_file' EXIT
trap 'rm temp_file' EXIT
Task 8: Bonus — Quick Reference Table



TopicKey SyntaxExampleVariableVAR="value"NAME="DevOps"Argument$1, $2./script.sh arg1Ifif [ condition ]; thenif [ -f file ]; thenFor loopfor i in list; dofor i in 1 2 3; doFunctionname() { ... }greet() { echo "Hi"; }Grepgrep pattern filegrep -i "error" log.txtAwkawk '{print $1}' fileawk -F: '{print $1}' /etc/passwdSedsed 's/old/new/g' filesed -i 's/foo/bar/g' config.txt✅ End of Shell Scripting Cheat Sheet
