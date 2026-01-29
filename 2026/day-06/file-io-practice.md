
## 1. Create an empty file

**Command:**
```bash
touch notes.txt
Explanation: Creates an empty file named notes.txt in the current directory if it does not already exist.

2. Write first line using >
Command:

bash
echo "Line 1: This is the first line" > notes.txt
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








