# Day 18 - Scripting : Functions & Slightly Advanced Topics

write and call functions
Use set -euo pipefail for safer scripts
work with return values and local variables
Build a slightly advanced script

## Challenge Tasks

Task 1: Basic functions---- [functions.sh](scripts/functions.sh)

 A function greet that takes a name as argument and prints Hello, <name>!
 A function add that takes two arguments and returns their sum.
 call both functions from the script

[View Script](scripts/functions.sh)
<img width="1463" height="240" alt="Screenshot 2026-02-10 195153" src="https://github.com/user-attachments/assets/809e6667-2fa7-4a0b-a6cd-aecd59290887" />

Task 2: Strict mode---- [strict_demo.sh](scripts/strict_demo.sh)

    Create strict_demo.sh with set -euo pipefail at the top
    Try using an undefined variable — what happens with set -u?
    Try a command that fails — what happens with set -e?
    Try a piped command where one part fails — what happens with set -o pipefail?
Document: What does each flag do?

    set -e → If a commands fails it exits the script.
    set -u → It throws unbound variable error and exits the script.
    set -o pipefail → Makes pipeline fail if any command fails.

[View Script](scripts/strict_demo.sh)

Task 3: Local variables---- [local_demo.sh](scripts/local_demo.sh)

    A function that uses local keyword for variables
    Show that local variables don't leak outside the function
    Compare with a function that uses regular variables

[View Script](scripts/local_demo.sh)
<img width="1464" height="198" alt="Screenshot 2026-02-10 201933" src="https://github.com/user-attachments/assets/3b0732a3-fdb1-48b7-b595-d78efc8f0d8c" />


Task 4: System info---- [system_info.sh](scripts/system_info.sh)

[View Script](scripts/system_info.sh)

    A function to print hostname and OS info
    A function to print uptime
    A function to print disk usage (top 5 by size)
    A function to print memory usage
    A function to print top 5 CPU-consuming processes
    A main function that calls all of the above with section headers

Use set -euo pipefail at the top.
 1.  Create Strict_demo.sh with set -euo pipefail at the top
 2.  Try using an undefined variable -- what happens with set -u ?
 3.  Try a command that fails -- what happens set -e ?
 4.  Try a piped command where one part fails -- what happens with set -o pipefail ?
    
Document: What does each flag do ?
 . set -e ---> if a command fails it exits the script.
 . set -u ---> it throws unbound variable error and exits the script
 . set -o pipefail ---> Makes pipeline fail if any command fails

 Great question — let’s break down your Bash script in a few different ways so you can really see what’s happening.  

---

## 🔍 **Line-by-Line Explanation**

```bash
#!/bin/bash
set -euo pipefail
```
- `#!/bin/bash` → Shebang, tells the system to run this script with Bash.  
- `set -euo pipefail` → Enables strict error handling:
  - `-e`: Exit immediately if a command fails.  
  - `-u`: Treat unset variables as errors.  
  - `-o pipefail`: If any command in a pipeline fails, the whole pipeline fails.  

---

```bash
echo "Check set -o pipefail"
cat count.txt | grep "total"
```
- Prints a message.  
- Runs a pipeline: `cat count.txt | grep "total"`.  
  - If `grep` fails (e.g., no match), with `pipefail` enabled, the script exits.  
  - Without `pipefail`, the script would continue even if `grep` failed.  

---

```bash
echo "After failing script running without set -o"
echo -e "\n"
```
- Shows what happens if `pipefail` isn’t set: the script continues after a failed pipeline.  
- `echo -e "\n"` → Prints a newline.  

---

```bash
echo "Undefined variable -u"
echo $a
```
- Prints a message.  
- Tries to print variable `$a`.  
  - With `-u` enabled, this causes an error because `$a` is undefined.  
  - Without `-u`, it would just print an empty line.  

---

```bash
echo "After using undefined variable script running without set -u"
echo -e "\n"
```
- Demonstrates that without `-u`, the script continues even after referencing an undefined variable.  

---

```bash
echo "Failed command -e"
mkdir ../scripts
```
- Prints a message.  
- Tries to create a directory `../scripts`.  
  - If it already exists or fails for another reason, with `-e` enabled, the script exits immediately.  
  - Without `-e`, the script continues.  

---

```bash
echo "After failing command script running without using -e"
```
- Shows that without `-e`, the script would keep running even after a failed command.  

---

## 🧩 **Conceptual Explanation**

This script is essentially a **demo of Bash safety flags**:
- **`-e`** → Stop on errors.  
- **`-u`** → Stop on undefined variables.  
- **`pipefail`** → Stop if any command in a pipeline fails.  

It’s teaching you how scripts behave differently **with vs. without strict error handling**.

---

## 📚 **Analogy**

Think of `set -euo pipefail` as **seatbelts for your script**:
- `-e` → If something crashes, stop immediately (like airbags deploying).  
- `-u` → Don’t drive with missing parts (undefined variables).  
- `pipefail` → If one part of the chain breaks, the whole machine stops (pipeline safety).  

Without these, the script keeps going even when things are broken — which can cause bigger problems later.

---

## ✅ **Best Practice Takeaway**

Always start your Bash scripts with:

```bash
set -euo pipefail
```

This ensures:
- You catch errors early.  
- You don’t accidentally use undefined variables.  
- Pipelines don’t silently fail.  

---

Would you like me to **rewrite this script into a safer, modern version** that demonstrates the same concepts but avoids pitfalls like `cat file | grep` (which is considered a *useless use of cat*)?
 
<img width="1462" height="841" alt="Screenshot 2026-02-10 202616" src="https://github.com/user-attachments/assets/3ae4a9bf-0202-4906-ae48-3e97ea62a359" />

Task 5: Disk check---- [disk_check.sh](scripts/disk_check.sh)

[View Script](scripts/disk_check.sh)

    A function check_disk that checks disk usage of / using df -h
    A function check_memory that checks free memory using free -h
    A main section that calls both and prints the results

<img width="1487" height="679" alt="Screenshot 2026-02-10 200645" src="https://github.com/user-attachments/assets/d80651b3-feec-439f-9bb1-778be36740a2" />

