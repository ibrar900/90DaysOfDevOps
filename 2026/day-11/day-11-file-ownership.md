# Day 11 – File Ownership Challenge (chown & chgrp)  
**Simple Guide for Beginners – 2026 Edition**

### Goal of the Day
Learn how to control **who owns** files and folders in Linux.  
This is very important in DevOps because:

- Different users should only access what they need
- Applications run as specific users (nginx, docker, jenkins…)
- Shared folders need correct group ownership

Ownership = **user** + **group**

Format you will see in `ls -l`:  
`-rw-r--r-- 1 user group size date filename`

### Overall Workflow Blueprint (Easy to Follow)

Start
├── Task 1: Understand current ownership (ls -l)
├── Task 2: Change file owner (chown)
├── Task 3: Change file group (chgrp)
├── Task 4: Change both owner + group in one command
├── Task 5: Recursive change on whole folder (-R)
├── Task 6: Practice Challenge (bank-heist scenario)
└── End: Create day-11-file-ownership.md + screenshots

### Task 1: Understanding Ownership (10 minutes)

**Commands to run:**
Terminal ---- bash

cd ~
ls -l

**What you will see:**

-rw-r--r-- 1 ibrar ibrar  1234 Feb  3 17:00 notes.txt
drwxr-xr-x 2 ibrar ibrar  4096 Feb  3 17:00 project

**Explanation:**
- First column after number: **owner** (ibrar)
- Second column: **group** (ibrar)
- Owner = person who created file (usually you)
- Group = team/category file belongs to

**Question to answer in notes:**
> What is the difference between owner and group?  
Answer: Owner is the single user who has full control. Group is a team — multiple users can share access through group permissions.

**Screenshot suggestion** (typical ls -l output):

### Task 2: Basic chown Operations (20 minutes)

**Steps:**

1. Create a file
Terminal ---- bash
touch devops-file.txt
ls -l devops-file.txt

2. Change owner to tokyo (create user if not exists)
Terminal ---- bash
sudo useradd -m tokyo          # if tokyo doesn't exist
sudo chown tokyo devops-file.txt
ls -l devops-file.txt

3. Change owner to berlin
Terminal ---- bash
sudo useradd -m berlin
sudo chown berlin devops-file.txt
ls -l devops-file.txt

**Before / After example:**

Before: -rw-r--r-- 1 ibrar ibrar ...
After:  -rw-r--r-- 1 berlin ibrar ...

### Task 3: Basic chgrp Operations (15 minutes)

**Steps:**

1. Create file
Terminal ---- bash
touch team-notes.txt
ls -l team-notes.txt

2. Create group
Terminal ---- bash
sudo groupadd heist-team
ls -l team-notes.txt

3. Change group
Terminal ---- bash
sudo chgrp heist-team team-notes.txt
ls -l team-notes.txt

**Before / After:**

Before: -rw-r--r-- 1 ibrar ibrar ...
After:  -rw-r--r-- 1 ibrar heist-team ...


### Task 4: Combined Owner & Group Change (15 minutes)

**Syntax:** `sudo chown user:group file`

**Steps:**

1. Create file
Terminal ---- bash
touch project-config.yaml
ls -l project-config.yaml

2. Change both
Terminal ---- bash
sudo chown professor:heist-team project-config.yaml
ls -l project-config.yaml

3. Create directory and change
Terminal ---- bash
mkdir app-logs
sudo chown berlin:heist-team app-logs

**Verify:**
Terminal ---- bash
ls -l project-config.yaml
ls -ld app-logs

### Task 5: Recursive Ownership (20 minutes)

**Goal:** Change owner & group for a whole folder + all files inside

**Steps:**

Terminal ---- bash
# Create structure
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

# Create group
sudo groupadd planners

# Change everything recursively
sudo chown -R professor:planners heist-project/

# Verify
ls -lR heist-project/

**Result:** Every file and subfolder now belongs to professor:planners

**Recursive Diagram (Blueprint)**

heist-project/
├── vault/
│   └── gold.txt          → professor:planners
└── plans/
    └── strategy.conf     → professor:planners

One command changes ALL ↓
sudo chown -R professor:planners heist-project/

### Task 6: Practice Challenge – Bank Heist Scenario (20 minutes)

**Steps:**

1. Create users & groups (if not already)
Terminal ---- bash
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m nairobi

sudo groupadd vault-team
sudo groupadd tech-team

2. Create folder & files
Terminal ---- bash
mkdir bank-heist
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

3. Set ownership
Terminal ---- bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt

4. Verify
Terminal ---- bash
ls -l bank-heist/

**Expected output:**
-rw-r--r-- 1 tokyo    vault-team ... access-codes.txt
-rw-r--r-- 1 berlin   tech-team  ... blueprints.pdf
-rw-r--r-- 1 nairobi  vault-team ... escape-plan.txt

### Documentation Template – day-11-file-ownership.md

# Day 11 – File Ownership Challenge

## Files & Directories Created
- devops-file.txt
- team-notes.txt
- project-config.yaml
- app-logs/
- heist-project/ (with subfolders & files)
- bank-heist/ (with 3 files)

## Ownership Changes (Examples)
- devops-file.txt: ibrar:ibrar → berlin:ibrar
- team-notes.txt: ibrar:ibrar → ibrar:heist-team
- project-config.yaml: ibrar:ibrar → professor:heist-team
- heist-project/ (recursive): ibrar:ibrar → professor:planners
- bank-heist/access-codes.txt: ibrar:ibrar → tokyo:vault-team

## Commands Used
touch, ls -l, sudo useradd, sudo groupadd,
sudo chown user file,
sudo chgrp group file,
sudo chown user:group file,
sudo chown -R user:group folder/

## What I Learned (3 key points)
1. chown changes owner, chgrp changes group, or use chown user:group for both
2. -R flag is very important for directories — changes everything inside
3. Ownership controls who can read/write/execute files — critical for security

## Screenshots Attached
- ls -l before & after chown
- ls -lR heist-project/
- ls -l bank-heist/

### Best Troubleshooting Guide

| Problem                               | Cause                                  | Solution                                                                 |
|---------------------------------------|----------------------------------------|--------------------------------------------------------------------------|
| chown: invalid user                   | User doesn't exist                     | Create first: `sudo useradd -m username`                                 |
| chgrp: invalid group                  | Group doesn't exist                    | `sudo groupadd groupname`                                                |
| Operation not permitted               | Not using sudo                         | Always use `sudo chown` / `sudo chgrp`                                   |
| Can't change ownership of file        | You are not the owner or root          | Use sudo                                                                 |
| Recursive change didn't work          | Forgot -R flag                         | Use `-R`: `sudo chown -R user:group folder/`                             |
| ls -l shows wrong owner after change  | Changed in wrong directory             | Check `pwd` and run again in correct folder                              |
| Permission denied when running script | No execute permission                  | `chmod +x script.sh` (ownership is separate from permissions)           |
| User can't access shared folder       | Not in the group                       | Add user: `sudo usermod -aG group user` then log out/in                  |


Here is a **clear, beginner-friendly, and structured explanation** of **chmod numeric modes** in Linux — exactly what you need to master file permissions.

### What is chmod numeric mode?

`chmod` changes file/directory permissions.

There are two ways to use chmod:

1. **Symbolic mode** (e.g. `chmod u+x file`) → easy to read, good for small changes  
2. **Numeric (octal) mode** (e.g. `chmod 755 file`) → very fast, most used by professionals

Today we focus only on **numeric mode** — the one you see everywhere in DevOps scripts and tutorials.

### Numeric Mode Explained – The 3-Digit Magic

Permissions are divided into **3 parts**:

- Owner (user who owns the file)  
- Group (users in the same group)  
- Others (everyone else)

Each part can have 3 permissions:

- **r** = read (4 points)  
- **w** = write (2 points)  
- **x** = execute (1 point)

You **add** the numbers for each part.

| Permission | Meaning               | Number |
|------------|-----------------------|--------|
| rwx        | read + write + execute | 7      |
| rw-        | read + write          | 6      |
| r-x        | read + execute        | 5      |
| r--        | read only             | 4      |
| -wx        | write + execute       | 3      |
| -w-        | write only            | 2      |
| --x        | execute only          | 1      |
| ---        | no permissions        | 0      |

So the full permission is always **3 digits**:

chmod ABC file

- **A** = owner permissions (0–7)  
- **B** = group permissions (0–7)  
- **C** = others permissions (0–7)

### Most Common & Important Numeric Modes

| Number | Symbolic Equivalent | Meaning (who can do what)                          | Typical Use Case                                  |
|--------|----------------------|-----------------------------------------------------|---------------------------------------------------|
| 777    | rwxrwxrwx           | Everyone can read, write, execute                   | Very open – dangerous on servers                  |
| 755    | rwxr-xr-x           | Owner full, group & others: read + execute          | Scripts, binaries, public directories (most common) |
| 644    | rw-r--r--           | Owner read+write, group & others: read only         | Normal files (configs, scripts without execute)   |
| 700    | rwx------           | Only owner has full access                          | Private keys (~/.ssh/id_rsa)                      |
| 600    | rw-------           | Only owner can read/write                           | Private files (SSH keys, .env files)              |
| 775    | rwxrwxr-x           | Owner & group full, others read+execute             | Shared team folders (like /opt/project)           |
| 640    | rw-r-----           | Owner read+write, group read only                   | Config files shared with a group                  |

### Real Examples (Run These)

Terminal ---- bash
# 1. Make a script executable by everyone (most common in DevOps)
chmod 755 deploy.sh
# Result: -rwxr-xr-x

# 2. Make a normal config file read-only for others
chmod 644 config.yaml
# Result: -rw-r--r--

# 3. Make private SSH key super secure
chmod 600 ~/.ssh/id_rsa
# Result: -rw-------

# 4. Team shared folder (group members can edit)
sudo mkdir /opt/team-project
sudo chmod 775 /opt/team-project
# Result: drwxrwxr-x

# 5. Very restricted private file
touch secret.txt
chmod 600 secret.txt
# Result: -rw-------

### Quick Visual Cheat Sheet (Memorize This)

7 = rwx   → full access
6 = rw-   → read + write
5 = r-x   → read + execute
4 = r--   → read only

**Common combinations you will use 90% of the time:**

- Scripts & programs → **755**  
- Normal files (txt, yaml, conf) → **644**  
- Private files/keys → **600** or **644**  
- Shared folders → **775**  
- Very private folders → **700**

### How to Check Permissions (Always Verify)

Terminal ---- bash
ls -l filename          # shows current permissions
ls -ld directory-name   # important for folders (d at start)

### Best Troubleshooting Guide for chmod Numeric

| Problem                              | Why it happens                              | Fix / Solution                                                                 |
|--------------------------------------|---------------------------------------------|---------------------------------------------------------------------------------|
| chmod: cannot access 'file'          | File doesn't exist or wrong path            | Check `ls` first, use correct path                                              |
| Operation not permitted              | You are not owner and not root              | Use `sudo chmod` or become owner with `sudo chown $USER file`                   |
| Script still says "Permission denied" | Forgot execute bit (x)                      | Add x: `chmod +x script.sh` or `chmod 755 script.sh`                            |
| Directory not accessible             | Directory needs execute bit (x)             | Directories need x to enter: `chmod 755 dir/` or at least 5 for read-only access |
| Group permissions not working        | User not in group                           | Check `groups username`, add with `sudo usermod -aG group user` (log out/in)    |
| Changed permissions but no effect    | Changed wrong file / cached view            | Run `ls -l` again, clear terminal cache (`reset`), or use full path             |
| Accidentally made file 000           | Removed all permissions                     | Fix as root: `sudo chmod 644 file` (or whatever needed)                         |
| Folder inside not changed            | Forgot -R recursive flag                    | Use `-R`: `sudo chmod -R 755 folder/`                                           |

### Quick Reference Table (Save this!)

| Use Case                        | Recommended Mode | Command Example                        |
|---------------------------------|------------------|----------------------------------------|
| Public script/binary            | 755              | chmod 755 script.sh                    |
| Normal config / text file       | 644              | chmod 644 config.yaml                  |
| Private key / .env              | 600              | chmod 600 .env                         |
| Shared team folder              | 775              | chmod 775 /opt/team-project            |
| Private personal folder         | 700              | chmod 700 ~/secrets                    |
| Read-only for group             | 640              | chmod 640 shared-config.conf           |

Now you know **numeric chmod** perfectly!

Practice these 5 commands right now in your terminal:

Terminal ---- bash
touch test-755.sh
chmod 755 test-755.sh
ls -l test-755.sh

touch test-644.txt
chmod 644 test-644.txt
ls -l test-644.txt

touch secret.txt
chmod 600 secret.txt
ls -l secret.txt

Happy learning!  
You’ve got this! 🚀
  
+ screenshot of `ls -lR` output

You're now ready to start Task 1!

Just open terminal and type:  
`touch devops-file.txt`  

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham"

Happy learning! 💪