# Day 07 – Linux File System & Scenarios

This note has two sections as required: **File System Hierarchy** and **Scenario Practice**

## Part 1: Linux File System Hierarchy

Below are the key Linux directories, what they store, a quick `ls -l` example, and when I would use them.

### 1. `/` – Root

**What it contains (1–2 lines)**  
The top of the Linux directory tree. Every other directory (like `/home`, `/etc`, `/var`) starts from here.

**Example command and sample output**

Terminal ---- bash

ls -l /

Example entries you might see:

- `bin`, `boot`, `etc`, `home`, `root`, `var`  

**I would use this when…**  
I want to see the overall structure of the system and jump into important directories like `/etc` or `/var/log`.

### 2. `/home` – User Homes

**What it contains (1–2 lines)**  
Stores personal files, configs, and directories for normal users (for example `/home/ubuntu`, `/home/devops`).

**Example command and sample output**

Terminal ---- bash

ls -l /home

Example entries you might see:

- `ubuntu`, `devops`, `student`  

**I would use this when…**  
I want to work with my own files, SSH keys, or project folders as a normal user.

### 3. `/root` – Root User Home

**What it contains (1–2 lines)**  
Home directory of the `root` (superuser) account. Similar to `/home/<user>` but for the administrator.

**Example command and sample output**

Terminal ---- bash

sudo ls -l /root

Example entries you might see:

- `scripts`, `.ssh`, `backups`  

**I would use this when…**  
I am logged in as root and need to access admin-only scripts, keys, or configuration files.

### 4. `/etc` – Configuration Files

**What it contains (1–2 lines)**  
System-wide configuration files for services and applications, such as network, SSH, hostname, and more.

**Example command and sample output**

Terminal ---- bash

ls -l /etc

Example entries you might see:

- `hostname`, `ssh/`, `nginx/`, `systemd/`  

**I would use this when…**  
I need to edit or inspect configuration files, for example changing the hostname, SSH settings, or web server configs.

### 5. `/var/log` – Log Files

**What it contains (1–2 lines)**  
System and application log files, such as `syslog`, `auth.log`, and service-specific logs.

**Example command and sample output**

Terminal ---- bash

ls -l /var/log

Example entries you might see:

- `syslog`, `auth.log`, `kern.log`, `nginx/`  

**Hands-on: Find largest log files**

Terminal ---- bash

du -sh /var/log/* 2>/dev/null | sort -h | tail -5

This shows the largest log directories/files in `/var/log` (very useful when disk is filling up).

**I would use this when…**  
I am troubleshooting errors, performance issues, or checking what happened on the system or service.

### 6. `/tmp` – Temporary Files

**What it contains (1–2 lines)**  
Temporary files created by users and applications. Contents can be cleared automatically on reboot.

**Example command and sample output**

Terminal ---- bash

ls -l /tmp

Example entries you might see:

- Random files and folders created by applications and users  

**I would use this when…**  
I need a quick place to store temporary test files or debug output that does not need to be permanent.

### 7. `/bin` – Essential Binaries

**What it contains (1–2 lines)**  
Essential command binaries needed for basic system operation, like `ls`, `cp`, `mv`, `cat`.

**Example command and sample output**

Terminal ---- bash

ls -l /bin

Example entries you might see:

- `ls`, `cp`, `mv`, `bash`, `cat`  

**I would use this when…**  
I want to know where core commands live or to check if a basic command exists on the system.

### 8. `/usr/bin` – User Binaries

**What it contains (1–2 lines)**  
Most user-level commands and applications installed on the system (editors, utilities, tools).

**Example command and sample output**

Terminal ---- bash

ls -l /usr/bin | head

Example entries you might see:

- `vim`, `python3`, `ssh`, `git`  

**I would use this when…**  
I am checking where a user command is installed, or debugging PATH and binary availability issues.

### 9. `/opt` – Optional Software

**What it contains (1–2 lines)**  
Optional or third-party applications installed outside the default package manager (often vendor apps).

**Example command and sample output**

Terminal ---- bash

ls -l /opt

Example entries you might see:

- `some-app/`, `company-tool/` (may be empty on fresh systems)  

**I would use this when…**  
I install or manage third-party software that should not mix with system packages.

### Quick check of home directory

Terminal ---- bash

ls -la ~

Shows hidden files (like `.ssh`, `.bashrc`) and normal files in your home directory.

## Part 2: Scenario-Based Practice

Focus on the **troubleshooting flow**: what you check first, next, and why.[page:1]

### Example (from README): Check if `nginx` service is running

**Step 1 – Check service status**

Terminal ---- bash

systemctl status nginx

Why: Shows if `nginx` is active, inactive, or failed, and gives a quick log snippet.

**Step 2 – List services if not found**

Terminal ---- bash

systemctl list-units --type=service

Why: Confirms whether the `nginx` service exists and how it is named.

**Step 3 – Check if enabled on boot**

Terminal ---- bash

systemctl is-enabled nginx

Why: Tells if `nginx` will automatically start after a reboot.

**What I learned:** Always start with `systemctl status`, then explore further based on what you see (logs, enablement, dependencies).

### Scenario 1: Service Not Starting (`myapp`)

> A web application service called `myapp` failed to start after a server reboot. What commands would you run to diagnose the issue? Write at least 4 commands in order.

**Step 1**

Terminal ---- bash

systemctl status myapp

Why: Check if the service is active, failed, or not found, and see the latest error message.

**Step 2**

Terminal ---- bash

journalctl -u myapp -n 50

Why: View the last 50 log lines for `myapp` to understand why it failed.

**Step 3**

Terminal ---- bash

systemctl is-enabled myapp

Why: Confirm if `myapp` is configured to start automatically on boot.

**Step 4**

Terminal ---- bash

journalctl -u myapp -f

Why: Follow logs in real time while trying to restart, to see new errors as they happen.

### Scenario 2: High CPU Usage

> Your manager reports that the application server is slow. You SSH into the server. What commands would you run to identify which process is using high CPU?

**Step 1**

Terminal ---- bash

top

Why: See live CPU usage and identify which processes are consuming the most CPU (press `q` to quit).

**Step 2**

Terminal ---- bash

ps aux --sort=-%cpu | head -10

Why: Show a sorted list of processes by CPU usage with the top 10 highest consumers.

**Step 3**

Terminal ---- bash

htop

Why: Provides an interactive, color view of CPU, memory, and processes (if installed), easier for beginners to read.

**Step 4**

Terminal ---- bash

pidof <process-name>

Why: Get the PID of a specific process (for example `pidof nginx`) if I need to focus on one service.

### Scenario 3: Finding Service Logs (`docker`)

> A developer asks: “Where are the logs for the `docker` service?” The service is managed by systemd. What commands would you use?

**Step 1**

Terminal ---- bash

systemctl status docker

Why: Confirm that `docker` is a systemd service and see a short log snippet.

**Step 2**

Terminal ---- bash

journalctl -u docker -n 50

Why: Show the last 50 log lines for the `docker` service from journald.

**Step 3**

Terminal ---- bash

journalctl -u docker -f

Why: Follow `docker` logs in real time, similar to `tail -f`.

**Step 4 (optional)**

Terminal ---- bash

journalctl -u docker --since "1 hour ago"

Why: See logs only from the last hour to narrow down to the problem time window.

### Scenario 4: File Permissions Issue (`backup.sh`)

> A script at `/home/user/backup.sh` is not executing. When you run it: `./backup.sh` you get: “Permission denied”. What commands would you use to fix this?

**Step 1 – Check current permissions**

Terminal ---- bash

ls -l /home/user/backup.sh

Why: See if the script has execute (`x`) permission. For example `-rw-r--r--` means it is not executable.

**Step 2 – Add execute permission**

Terminal ---- bash

chmod +x /home/user/backup.sh

Why: Add execute permission so the script can be run.

**Step 3 – Verify permissions**

Terminal ---- bash

ls -l /home/user/backup.sh

Why: Confirm that the file now shows `x`, for example `-rwxr-xr-x`.

**Step 4 – Run the script**

Terminal ---- bash

./backup.sh

Why: Test that the script now executes without the "Permission denied" error.

## Why this matters for DevOps

Knowing the file system hierarchy helps you quickly find logs, configs, and binaries when something breaks.

Practicing scenario-based troubleshooting builds the habit of checking status, logs, and permissions in a structured way.

HAPPY LEARNING
