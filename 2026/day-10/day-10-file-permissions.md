# Day 10 – File Permissions & File Operations Challenge  
**Super Simple Guide for Beginners (2026 Edition)**

Hello Ibrar (@ibrarahmad900)!  
It's 01:56 PM IST on February 02, 2026, in Bengaluru — good time for a quick 1-hour practice before afternoon tea.  

Today we master **file permissions** (like locks on doors) and **basic operations** (create/read/modify). README instructions followed exactly, but made **extra simple**: short steps, everyday examples, text-based structure & blueprint diagrams (easy to visualize), pictures from internet, and the **best troubleshooting guide** at the end.

Think of permissions like: `rwx` = read (open book), write (edit book), execute (run as program). Numbers: 4(r) + 2(w) + 1(x) = 7 (full access).

### Overall Workflow Blueprint (Step-by-Step Flow)
```
Start
├── Task 1: Create 3 Files (touch, cat/echo, vim)
├── Task 2: Read Files (cat, vim read-only, head, tail)
├── Task 3: Understand Permissions (ls -l, explain rwx/640)
├── Task 4: Modify Permissions (chmod +x, -w, 640, 755)
├── Task 5: Test Permissions (try write/execute, note errors)
└── End: Document in day-10-file-permissions.md + Screenshots + Submit
```

This blueprint is a linear path — do one task, then next.

### Challenge Tasks (Hands-On – Do in Terminal)

#### Task 1: Create Files (10 minutes)
**Goal**: Make 3 files with different tools.

1. Empty file:  
   Command: `touch devops.txt`  
   (Creates empty file like a blank page.)

2. File with content:  
   Command: `echo "This is notes content" > notes.txt` (or use cat: `cat > notes.txt` then type lines, Ctrl+D to save).  
   (Writes simple text.)

3. Script file:  
   Command: `vim script.sh` (in vim: i to insert, type `echo "Hello DevOps"`, Esc, :wq to save).  
   (Creates executable-like file.)

**Verification**: `ls -l` (shows files with default permissions like -rw-r--r--).  

**Structure Diagram for Task 1**:
```
touch devops.txt      → Empty file created
     ↓
echo "text" > notes.txt → File with 1 line
     ↓
vim script.sh         → Edit and add echo line
     ↓
ls -l                 → See all 3 files
```

*(Picture: touch command in terminal – creating file with ls output after.)*

#### Task 2: Read Files (10 minutes)
**Goal**: View content in different ways.

1. Full read: `cat notes.txt` (shows all lines).  

2. Vim read-only: `vim -R script.sh` (view without edit; :q to quit).  

3. First 5 lines of /etc/passwd: `head -n 5 /etc/passwd`.  

4. Last 5 lines: `tail -n 5 /etc/passwd`.  

*(Picture: cat command output – showing file content in terminal.)*

#### Task 3: Understand Permissions (10 minutes)
Permissions format: `rwxrwxrwx` = owner-group-others.  
Numbers: r=4, w=2, x=1 (e.g., 755 = rwxr-xr-x).  

**Check**: `ls -l devops.txt notes.txt script.sh`  
(Example output: -rw-r--r-- for notes.txt = owner rw, group/others r).  

Who can: Owner read/write, group/others read only. No execute for anyone yet.

*(Picture: ls -l permissions example – colored terminal showing rwx details.)*

#### Task 4: Modify Permissions (20 minutes)
**Goal**: Change access levels.

1. Make executable: `chmod +x script.sh` → Now run `./script.sh` (output: "Hello DevOps").  

2. Read-only: `chmod -w devops.txt` (remove write for all).  

3. Set 640: `chmod 640 notes.txt` (owner rw, group r, others none).  

4. Directory: `mkdir project/ && chmod 755 project/` (rwxr-xr-x).  

**Verification**: `ls -l` after each (see changes).  

**Blueprint Diagram for Task 4**:

ls -l script.sh       → Check before (-rw-r--r--)
     ↓
chmod +x script.sh    → Add execute
     ↓
./script.sh           → Test run
     ↓
ls -l                 → Now -rwxr-xr-x

*(Picture: chmod +x example – before/after ls -l for script.)*

#### Task 5: Test Permissions (10 minutes)
1. Write to read-only: `echo "test" >> devops.txt` → Error: "Permission denied".  

2. Execute without x: Remove x from script.sh (`chmod -x script.sh`), then `./script.sh` → "Permission denied".  

3. Document errors: Note messages in your MD.

### Documentation Template (day-10-file-permissions.md)
Copy and fill:

```markdown
# Day 10 – File Permissions Challenge

## Files Created
- devops.txt (empty)
- notes.txt (with "This is notes content")
- script.sh (with echo "Hello DevOps")

## Permission Changes
- Before: -rw-r--r-- (all files)
- script.sh after: -rwxr-xr-x (executable)
- devops.txt after: -r--r--r-- (read-only)
- notes.txt after: -rw-r----- (640)
- project/ after: drwxr-xr-x (755)

## Commands Used
touch devops.txt  
echo "content" > notes.txt  
vim script.sh  
cat notes.txt  
vim -R script.sh  
head -n 5 /etc/passwd  
tail -n 5 /etc/passwd  
ls -l  
chmod +x script.sh && ./script.sh  
chmod -w devops.txt  
chmod 640 notes.txt  
mkdir project/ && chmod 755 project/  

## What I Learned
1. rwx means read/write/execute; numbers like 7= rwx
2. +x makes scripts run; -w makes read-only
3. Always check ls -l before/after changes

## Screenshots Attached
- ls -l before/after
- Error messages from tests

### Submission (Quick Steps)
1. Fork 90DaysOfDevOps repo.
2. Add to 2026/day-10/: day-10-file-permissions.md + screenshots (e.g., permissions-before.png, error-denied.png).
3. Commit/push.

### Learn in Public (LinkedIn Post Idea)
"Day 10 done! Mastered Linux permissions – turned script.sh into executable with chmod +x. No more 'denied'! #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham" + screenshot of ls -l.

### Why This Matters for DevOps
Permissions keep servers secure (e.g., only devs edit configs). Operations like create/read are for logs/scripts – daily DevOps tasks!

### Best Troubleshooting Guide (Top Issues & Fixes)
| Issue | Cause | Fix |
|-------|-------|-----|
| touch: command not found | Rare, minimal system | sudo apt install coreutils |
| Permission denied (write) | Not owner/no write perm | sudo chown $USER file; chmod +w file |
| vim not installed | Default missing on some | sudo apt install vim |
| ./script.sh denied | No execute perm | chmod +x script.sh |
| ls -l wrong format | Not in dir | cd to folder first |
| head/tail no output | File empty | Add content with echo |
| chmod fails | Not owner | sudo chmod |
| Error on /etc/passwd | Read-only system file | Normal – don't modify, just read |

This guide is complete, simple, visual – just run the commands in order! If error, match to troubleshooting.  

Ready for Task 1? Type `touch devops.txt` now. Let me know how it goes! 🚀