
## 1. Create an empty file

**Command:**
```bash
touch notes.txt
Explanation: Creates an empty file named notes.txt in the current directory if it does not already exist.

2. Write first line using >
Command:

# 📚 Linux File I/O Practice Guide

A comprehensive guide to mastering file input/output operations and text processing in Linux.

---

## 🎯 Overview

This guide covers essential Linux commands for:
- Creating and managing files
- Writing and appending data
- Reading file contents
- Searching within files
- Real-world DevOps applications

---

## 📝 Part 1: File Creation and Writing

### ✅ 1. Create an Empty File

**Command:**
```bash
touch notes.txt
```

**Explanation:**  
Creates an empty file named `notes.txt` in the current directory. If the file already exists, it updates the timestamp without modifying the content.

**Use Cases:**
- Initialize configuration files
- Create placeholder files
- Update file timestamps

---

### ✅ 2. Write First Line (Overwrite Mode)

**Command:**
```bash
echo "Line 1: This is the first line" > notes.txt
```

**Explanation:**  
The `>` operator writes text to `notes.txt`, **overwriting** any existing content. Use with caution!

**Key Point:** `>` = Create or Overwrite

**Example:**
```bash
echo "Linux practice line 1 - file created" > notes.txt
```

---

### ✅ 3. Append a Second Line

**Command:**
```bash
echo "Line 2: This line is appended" >> notes.txt
```

**Explanation:**  
The `>>` operator **appends** text to the end of `notes.txt` without removing existing content. This is the safe way to add data.

**Key Point:** `>>` = Append (safe, preserves existing data)

**Example:**
```bash
echo "Linux practice line 2 - append mode" >> notes.txt
```

---

### ✅ 4. Write and Display Using `tee`

**Command:**
```bash
echo "Line 3: Added using tee -a" | tee -a notes.txt
```

**Explanation:**  
The `tee` command with `-a` flag appends input to the file **and** displays it on the terminal simultaneously.

**Key Point:** `tee -a` = Append + Display

**Use Cases:**
- Log command output while viewing it
- Save script output to file and screen
- Monitor data being written

**Example:**
```bash
echo "Linux practice line 3 - tee write and show" | tee -a notes.txt
```

---

### ✅ 5. Add Multiple Lines Efficiently

**Command:**
```bash
echo "Linux practice line 4 - logs are text" >> notes.txt
echo "Linux practice line 5 - configs are text" >> notes.txt
echo "Linux practice line 6 - scripts are text" >> notes.txt
echo "Linux practice line 7 - automation uses files" >> notes.txt
echo "Linux practice line 8 - learning is practice" >> notes.txt
```

**Alternative (Multi-line):**
```bash
cat >> notes.txt << EOF
Line 4: Additional content
Line 5: More information
Line 6: Keep adding lines
EOF
```

---

## 📖 Part 2: Reading File Contents

### ✅ 6. Read Entire File

**Command:**
```bash
cat notes.txt
```

**Explanation:**  
Displays the complete contents of `notes.txt` to the terminal.

**Use Cases:**
- View configuration files
- Check file contents quickly
- Verify file data

**Alternative Commands:**
```bash
less notes.txt    # View with pagination
more notes.txt    # View page by page
```

---

### ✅ 7. Read First N Lines

**Command:**
```bash
head -n 2 notes.txt
```

**Explanation:**  
Shows only the **first 2 lines** of `notes.txt`.

**Use Cases:**
- Check file headers
- View configuration file beginning
- Quick preview of large files

**Examples:**
```bash
head -n 5 notes.txt     # First 5 lines
head -n 10 /etc/passwd  # First 10 users
head notes.txt          # Default: first 10 lines
```

---

### ✅ 8. Read Last N Lines

**Command:**
```bash
tail -n 2 notes.txt
```

**Explanation:**  
Shows only the **last 2 lines** of `notes.txt`.

**Use Cases:**
- View recent log entries
- Check file endings
- Monitor file updates

**Real-World DevOps Example:**
```bash
tail -n 50 /var/log/syslog              # Last 50 log entries
tail -n 100 /var/log/apache2/error.log  # Recent errors
```

---

### ✅ 9. Real-Time Log Monitoring

**Command:**
```bash
tail -f /var/log/syslog
```

**Explanation:**  
The `-f` (follow) flag shows new lines as they're added to the file in real-time.

**⭐ Most Important DevOps Command!**

**Use Cases:**
- Monitor application logs live
- Watch server activity
- Debug issues in real-time

**Examples:**
```bash
tail -f /var/log/app.log
tail -f /var/log/nginx/access.log
tail -f -n 100 /var/log/auth.log  # Last 100 lines + follow
```

---

## 🔍 Part 3: Searching Within Files

### ✅ 10. Basic Search with `grep`

**Command:**
```bash
grep "Linux" notes.txt
```

**Explanation:**  
Searches for the word "Linux" in `notes.txt` and displays all matching lines.

**Use Cases:**
- Find specific configuration entries
- Search for errors in logs
- Locate keywords in files

---

### ✅ 11. Case-Insensitive Search

**Command:**
```bash
grep -i "linux" notes.txt
```

**Explanation:**  
The `-i` flag makes the search case-insensitive. Matches: Linux, linux, LINUX, LiNuX, etc.

**Example:**
```bash
grep -i "error" /var/log/syslog  # Find all error variations
```

---

### ✅ 12. Show Line Numbers

**Command:**
```bash
grep -n "line" notes.txt
```

**Explanation:**  
The `-n` flag displays line numbers alongside matching lines. Very useful for debugging and editing.

**Example Output:**
```
3:Linux practice line 3
5:Linux practice line 5
7:Linux practice line 7
```

---

### ✅ 13. Count Matching Lines

**Command:**
```bash
grep -c "Linux" notes.txt
```

**Explanation:**  
Counts how many lines contain the search term.

**Use Cases:**
- Count errors in logs
- Track occurrences of events
- Monitor specific patterns

---

### ✅ 14. Invert Match (Exclude Lines)

**Command:**
```bash
grep -v "Linux" notes.txt
```

**Explanation:**  
Shows all lines that **do NOT** contain "Linux".

**Use Cases:**
- Filter out known entries
- Remove noise from logs
- Exclude specific patterns

---

### ✅ 15. Search Multiple Files

**Command:**
```bash
grep "error" *.log
```

**Explanation:**  
Searches for "error" in all `.log` files in the current directory.

**Examples:**
```bash
grep -r "TODO" .          # Recursive search in current directory
grep "pattern" file1 file2 file3
```

---

### ✅ 16. Search with Pipes (DevOps Style)

**Command:**
```bash
cat notes.txt | grep "text"
```

**Explanation:**  
Pipes the output of `cat` to `grep` for filtering.

**Better Examples:**
```bash
tail -n 100 notes.txt | grep "Linux"
cat /var/log/syslog | grep -i error
ps aux | grep nginx
```

---

### ✅ 17. Combine Commands (Advanced)

**Command:**
```bash
tail -n 5 notes.txt | grep "Linux"
```

**Explanation:**  
Shows the last 5 lines, then filters for "Linux". Very common in log analysis.

**Real DevOps Examples:**
```bash
# Find recent errors
tail -n 1000 /var/log/app.log | grep -i error

# Monitor new errors live
tail -f /var/log/syslog | grep error

# Search specific time range
grep "2026-01-29" /var/log/auth.log | grep -i failed
```

---

## 🧠 Part 4: Real-World DevOps Applications

### Common Use Cases

#### 1. **Log Debugging**
```bash
# Find all errors in the last hour
tail -n 10000 /var/log/app.log | grep -i error

# Monitor live errors
tail -f /var/log/app.log | grep -i "error\|warning\|critical"

# Count error occurrences
grep -c "ERROR" /var/log/app.log
```

#### 2. **Configuration Management**
```bash
# Check specific config values
grep "Port" /etc/ssh/sshd_config

# Find all commented lines
grep "^#" /etc/nginx/nginx.conf

# Search for configuration errors
grep -n "error" /etc/nginx/nginx.conf
```

#### 3. **Security Monitoring**
```bash
# Failed login attempts
grep "Failed password" /var/log/auth.log

# Recent authentication events
tail -n 100 /var/log/auth.log | grep -i "authentication"

# Monitor live auth attempts
tail -f /var/log/auth.log | grep "sshd"
```

#### 4. **Application Monitoring**
```bash
# Watch application startup
tail -f /var/log/app.log | grep "Started"

# Find crashes
grep -i "crash\|exception\|fatal" /var/log/app.log

# Monitor specific user activity
grep "user123" /var/log/app.log
```

#### 5. **Script Output Validation**
```bash
# Save and display script output
./deploy.sh | tee deployment.log

# Append to existing log
./backup.sh | tee -a backup-history.log
```

---

## 📄 Expected Practice Output

After running all commands, your `notes.txt` should contain:

```
Linux practice line 1 - file created
Linux practice line 2 - append mode
Linux practice line 3 - tee write and show
Linux practice line 4 - logs are text
Linux practice line 5 - configs are text
Linux practice line 6 - scripts are text
Linux practice line 7 - automation uses files
Linux practice line 8 - learning is practice
```

**Total lines:** 8

---

## ⭐ Most Important Commands for DevOps

### Top 5 Daily Commands:

1. **`tail -f /var/log/app.log`** - Real-time log monitoring
2. **`grep -i error /var/log/syslog`** - Error searching
3. **`cat config.yaml`** - View configurations
4. **`echo "data" >> log.txt`** - Append to files
5. **`tail -n 100 file | grep pattern`** - Combined analysis

---

## 🎓 Quick Reference

### Writing Operations:
- `>` - Overwrite file
- `>>` - Append to file
- `tee -a` - Append and display

### Reading Operations:
- `cat` - Display entire file
- `head -n X` - First X lines
- `tail -n X` - Last X lines
- `tail -f` - Follow file in real-time

### Searching Operations:
- `grep "pattern"` - Basic search
- `grep -i` - Case-insensitive
- `grep -n` - Show line numbers
- `grep -c` - Count matches
- `grep -v` - Invert match (exclude)
- `grep -r` - Recursive search

---

## 💡 Best Practices

1. **Always test with `cat` before using `>`** to avoid accidental overwrites
2. **Use `>>` for appending** - it's safer than `>`
3. **Combine commands with pipes** for powerful analysis
4. **Use `tail -f` for live monitoring** instead of repeatedly checking files
5. **Use `grep -i` for flexible searching** when case doesn't matter
6. **Add line numbers with `-n`** when debugging configurations

---

## 🚀 Next Steps

Practice these commands daily by:
- Monitoring system logs
- Analyzing application logs
- Editing configuration files
- Creating automation scripts
- Debugging issues in real-time

**Remember:** These commands form the foundation of DevOps operations. Master them, and you'll be much more efficient in your daily work!

---

## 📚 Additional Resources

- `man grep` - Full grep documentation
- `man tail` - Tail command manual
- `man head` - Head command manual
- `man cat` - Cat command manual

---

**Happy Learning! 🎉**echo "Line 1: This is the first line" > notes.txt
Explanation: Writes the given text to notes.txt,
overwriting any existing content in the file.

3. Append a second line using >>
Command:

bash
echo "Line 2: This line is appended" >> notes.txt
Explanation: Appends the text to the end of notes.txt without removing the existing content.

4. Append a third line using tee -a
Command:

bash
echo "Line 3: Added using tee -a" | tee -a notes.txt
Explanation: tee -a appends the input to notes.txt
and displays it on the terminal at the same time.

5. Read the full file with cat
Command:

bash
cat notes.txt
Explanation: Displays the entire contents of notes.txt to the terminal.

6. Read first 2 lines with head
Command:

bash
head -n 2 notes.txt
Explanation: Shows only the first 2 lines of notes.txt.
7. Read last 2 lines with tail
Command:

bash
tail -n 2 notes.txt
Explanation: Shows only the last 2 lines of notes.txt.

text

These commands and flow follow the instructions from the README for Day 06 (create `notes.txt`, use `>`, `>>`, `cat`, `head`, `tail`, `tee`, keep it short).[1]

## 2. Run commands locally (optional but recommended)
In your cloned fork, from inside `2026/day-06/`:

```bash
touch notes.txt
echo "Line 1: This is the first line" > notes.txt
echo "Line 2: This line is appended" >> notes.txt
echo "Line 3: Added using tee -a" | tee -a notes.txt
cat notes.txt
head -n 2 notes.txt
tail -n 2 notes.txt


## 📌 Step-by-Step Commands (With Inline Explanation)

### ✅ 1️⃣ Create an empty file

```bash
touch notes.txt
```

👉 Creates an empty file (safe if file exists).

---

### ✅ 2️⃣ Write first line (Overwrite Mode `>`)

```bash
echo "Linux practice line 1 - file created" > notes.txt
```

👉 `>` = create OR overwrite file.

---

### ✅ 3️⃣ Append second line (`>>`)

```bash
echo "Linux practice line 2 - append mode" >> notes.txt
```

👉 `>>` = append (safe, does not erase existing data).

---

### ✅ 4️⃣ Write + Display using tee

```bash
echo "Linux practice line 3 - tee write and show" | tee -a notes.txt
```

👉 `tee -a` = append + display on screen.

---

### ✅ 5️⃣ Add more lines (Reach 8–12 total lines)

```bash
echo "Linux practice line 4 - logs are text" >> notes.txt
echo "Linux practice line 5 - configs are text" >> notes.txt
echo "Linux practice line 6 - scripts are text" >> notes.txt
echo "Linux practice line 7 - automation uses files" >> notes.txt
echo "Linux practice line 8 - learning is practice" >> notes.txt
```

---

## 📖 Read the File (Full)

### ✅ 6️⃣ Read entire file

```bash
cat notes.txt
```

👉 Shows all lines.

---

## 📖 Read File (Partial)

### ✅ 7️⃣ First 2 lines

```bash
head -n 2 notes.txt
```

👉 Useful for configs / headers.

---

### ✅ 8️⃣ Last 2 lines

```bash
tail -n 2 notes.txt
```

👉 Useful for logs (very common in DevOps).

---

# 📄 Final File Content (Should Look Like This)

```
Linux practice line 1 - file created
Linux practice line 2 - append mode
Linux practice line 3 - tee write and show
Linux practice line 4 - logs are text
Linux practice line 5 - configs are text
Linux practice line 6 - scripts are text
Linux practice line 7 - automation uses files
Linux practice line 8 - learning is practice
```

✅ Total lines = 8 (within your rule)

---

# 🧠 Why This Matters (DevOps Reality)

You will use this daily for:

* Log debugging
* Config editing
* Script output validation
* CI/CD troubleshooting
* Server monitoring

Example Real DevOps Pattern:

```bash
tail -f /var/log/app.log
```

---

# ⭐ One Command I Will Use Often

👉 **`tail -f`**

Example:

```bash
tail -f /var/log/syslog
`------

## 📌 Step-by-Step Commands (Inline Explanation)

### ✅ 1️⃣ Make sure file exists (reuse previous file)

```bash
cat notes.txt
```

👉 Confirms file exists and shows content.

---

### ✅ 2️⃣ Search for a word inside file

```bash
grep "Linux" notes.txt
```

👉 Shows all lines containing **Linux**

---

### ✅ 3️⃣ Case-insensitive search

```bash
grep -i "linux" notes.txt
```

👉 Matches **Linux / linux / LINUX**

---

### ✅ 4️⃣ Show line numbers

```bash
grep -n "line" notes.txt
```

👉 Very useful when debugging configs.

---

### ✅ 5️⃣ Search + Pipe (Real DevOps Style)

```bash
cat notes.txt | grep "text"
```

👉 Pipe sends output of `cat` → `grep`

---

### ✅ 6️⃣ Search only last lines (Log style)

```bash
tail -n 5 notes.txt | grep "Linux"
```

👉 Very common for log debugging.

---

## 📖 Real DevOps Example (Logs)

```bash
grep -i error /var/log/syslog
```

OR real-time:

```bash
tail -f /var/log/syslog | grep error
```

👉 Shows new errors live.

---

# 📄 Expected Practice Output Example

If file contains:

```
Linux practice line 1
Linux practice line 2
Linux practice line 3
```

Then:

```
grep Linux notes.txt
```

Output:

```
Linux practice line 1
Linux practice line 2
Linux practice line 3
```

---

# 🧠 Why This Matters

In real life you will search:

* Errors
* Warnings
* Failed logins
* Application crashes
* Deployment failures

Example:

```bash
grep -i failed auth.log
```

---

# ⭐ One Command From This Lesson I’ll Use Often

👉 **`grep -i error logfile`**








