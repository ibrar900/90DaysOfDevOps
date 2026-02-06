# Linux Commands Cheat Sheet

## 🐧 Linux System Architecture
```text
USER SPACE           |  Applications, Shell (bash, zsh), GUIs
---------------------|---------------------------------------
KERNEL               |  CPU/Memory Manager, File System, Drivers
---------------------|---------------------------------------
HARDWARE             |  CPU, RAM, Disk, NICs
```
![File system](https://github.com/user-attachments/assets/a3f48dbb-2df2-4aaf-b378-34aaab2c7bb3)


## 📂 Linux File System Hierarchy (FSH)
- `/bin`: Essential user command binaries (ls, cp, mv)
- `/sbin`: System binaries for administration (fdisk, ip)
- `/etc`: Configuration files
- `/home`: User home directories
- `/var`: Variable data (Logs, spool files)
- `/tmp`: Temporary files
- `/dev`: Device files

---

## 🚀 Core Commands

### 📁 File & Directory Operations
- `ls`: List directory contents. `ls -lh` shows human-readable sizes.
- `pwd`: Print name of current/working directory.
- `cd`: Change directory. `cd ..` moves up one level.
- `mkdir`: Create a new directory. `mkdir -p` creates nested directories.
- `touch`: Create an empty file or update timestamps.
- `cp`: Copy files or directories. `cp -r` for recursive copying.
- `mv`: Move or rename files/directories.
- `rm`: Remove files or directories. `rm -r` for recursive deletion.
- `shred`: Overwrite a file to hide its contents, and optionally delete it.

### 📝 Viewing & Text Processing
- `cat`: Concatenate and display file content.
- `less`: View file content one page at a time (scrollable).
- `head`: Output the first part of files (default 10 lines).
- `tail`: Output the last part of files. `tail -f` follows logs in real-time.
- `grep`: Search for patterns in files. `grep -i` for case-insensitive search.
- `awk`: Pattern scanning and processing language.
- `sort`: Sort lines of text files.
- `diff`: Compare files line by line.

### 🔐 Users & Permissions
- `sudo`: Execute a command as another user (usually root).
- `chmod`: Change file mode bits (permissions). `chmod 755 script.sh`.
- `chown`: Change file owner and group.
- `whoami`: Print effective userid.
- `useradd` / `adduser`: Create a new user.
- `passwd`: Change user password.

### ⚙️ Process Management
- `ps`: Report a snapshot of current processes. `ps aux` lists all.
- `top`: Display Linux processes in real-time.
- `htop`: Interactive process viewer (enhanced version of top).
- `kill`: Send a signal to a process (usually to stop it). `kill -9` forces termination.

### 🌐 Networking Troubleshooting
- `ip address`: Show/manipulate routing, devices, policy routing, and tunnels.
- 'ifconfig / ip addr': shows networks
- 'ip r': Gateway of network
- `ping`: Send ICMP ECHO_REQUEST to network hosts.
- `curl`: Transfer data from or to a server (supports HTTP, FTP, etc.).
- `netstat` / `ss`: Print network connections, routing tables, and interface statistics.
- `dig` / `nslookup`: DNS lookup utility.

### 📊 System Information
- `df -h`: Report file system disk space usage in human-readable format.
- `free -h`: Display amount of free and used memory in the system.
- `uname -a`: Print all system information (kernel version, etc.).
- `neofetch`: A fast, highly customizable system info script.
- `history`: Display the command history list.

---

*Generated for #90DaysOfDevOps*
