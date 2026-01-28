# Linux Troubleshooting Runbook: SSH Service Health Check

## Target Service/Process
SSH (sshd) - OpenSSH server daemon
Priority: CRITICAL (authentication & remote access service)

---

## 1. ENVIRONMENT BASICS

### Command 1: uname -a
```bash
$ uname -a
Linux devops-server 5.10.0-18-generic #1 SMP Debian 5.10.140-1 x86_64 GNU/Linux
```
**Explanation**: Displays system information including kernel name, hostname, kernel release, kernel version, hardware platform, and OS.
- **Linux**: Operating system
- **devops-server**: System hostname
- **5.10.0-18-generic**: Kernel release version
- **x86_64**: 64-bit processor architecture
- **GNU/Linux**: System type

**Observation**: Running on Debian-based Linux with 5.10 kernel. This is compatible with modern DevOps tools.

---

### Command 2: lsb_release -a / cat /etc/os-release
```bash
$ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Release:        11
Codename:       bullseye

$ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian"
VERSION_ID="11"
```
**Explanation**: Shows Linux distribution details for OS identification and package management compatibility.
- **Distributor ID**: Debian
- **Release**: Version 11 (bullseye)
- **PRETTY_NAME**: Human-readable distribution name

**Observation**: Debian 11 bullseye - stable release with security support. Package managers use 'apt' for this distro.

---

## 2. FILESYSTEM SANITY CHECK

### Command 3: mkdir & ls -l (Create test directory)
```bash
$ mkdir /tmp/runbook-demo
$ ls -l /tmp/runbook-demo
total 0
drwxr-xr-x 2 root root 4096 Jan 28 19:00 /tmp/runbook-demo
```
**Explanation**: Tests filesystem write permissions and basic operations.
- **drwxr-xr-x**: Permissions - owner can read/write/execute, others can read/execute
- **2**: Number of hard links
- **root root**: Owner and group
- **4096**: Directory size in bytes
- **Jan 28 19:00**: Creation timestamp

**Observation**: Filesystem writable and responsive. /tmp directory accessible.

---

### Command 4: cp & ls (Copy test file)
```bash
$ cp /etc/hosts /tmp/runbook-demo/hosts-copy
$ ls -l /tmp/runbook-demo
total 4
-rw-r--r-- 1 root root 247 Jan 28 19:01 hosts-copy
```
**Explanation**: Tests file copy operations and verifies file creation.
- **-rw-r--r--**: Regular file with read/write for owner, read-only for others
- **247**: File size in bytes

**Observation**: File operations working normally. Filesystem I/O operational.

---

## 3. CPU & MEMORY SNAPSHOT

### Command 5: ps - Process Status (SSH daemon)
```bash
$ ps -o pid,pcpu,pmem,comm -p $(pgrep -f sshd | head -1)
PID %CPU %MEM COMM
 745  0.0  0.5 sshd
```
**Explanation**: Shows specific process resource usage.
- **PID**: Process ID
- **%CPU**: CPU usage percentage
- **%MEM**: Memory usage percentage
- **COMM**: Command name

**Observation**: SSH daemon consuming minimal CPU (0.0%) and 0.5% memory - normal operation.

---

### Command 6: free -h (Memory availability)
```bash
$ free -h
              total        used        free      shared  buff/cache   available
Mem:           7.7Gi       2.1Gi       3.8Gi      256Mi       1.8Gi       4.9Gi
Swap:          2.0Gi          0B       2.0Gi
```
**Explanation**: Shows memory usage in human-readable format.
- **total**: Total RAM installed (7.7 GB)
- **used**: Memory currently in use (2.1 GB)
- **free**: Unallocated memory (3.8 GB)
- **buff/cache**: Buffer and cache memory (1.8 GB, can be freed if needed)
- **available**: Memory available for processes (4.9 GB)
- **Swap**: Virtual memory on disk (2.0 GB, unused)

**Observation**: Healthy memory status - 63% available memory. No memory pressure detected.

---

## 4. DISK & IO SNAPSHOT

### Command 7: df -h (Disk space)
```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   15G   32G  32% /
/dev/sda2       100G   45G   50G  47% /var
/dev/sda3       200G  120G   68G  63% /home
/dev/tmpfs      3.8G     0  3.8G   0% /dev/shm
```
**Explanation**: Shows disk space usage across all mounted filesystems.
- **Size**: Total partition size
- **Used**: Space currently used
- **Avail**: Available space remaining
- **Use%**: Percentage of disk used
- **Mounted on**: Where partition is accessible in filesystem

**Observation**: All filesystems have sufficient space. Root (/) at 32%, /home at 63% usage - acceptable levels.

---

### Command 8: du -sh /var/log (Log directory size)
```bash
$ du -sh /var/log
850M  /var/log
```
**Explanation**: Shows total disk usage of the log directory.
- **850M**: Log directory consuming 850 MB of disk space
- **-s**: Summary (total only, don't show subdirectories)
- **-h**: Human-readable format

**Observation**: Log directory at 850MB - reasonable size. Monitor for growth if exceeds 2GB.

---

## 5. NETWORK SNAPSHOT

### Command 9: ss -tulpn (Socket statistics - listening ports)
```bash
$ ss -tulpn | grep -i ssh
tcp   LISTEN  0  128  0.0.0.0:22  0.0.0.0:*  users:(("sshd",pid=745,fd=3))
tcp   LISTEN  0  128  [::]:22     [::]:*    users:(("sshd",pid=745,fd=4))
```
**Explanation**: Shows all listening network sockets and their associated processes.
- **t**: TCP sockets
- **u**: UDP sockets
- **l**: Listening sockets only
- **p**: Show process information
- **n**: Show numeric ports instead of service names
- **LISTEN**: Socket is accepting connections
- **0.0.0.0:22**: Listening on all IPv4 interfaces on port 22
- **[::]:22**: Listening on all IPv6 interfaces on port 22
- **pid=745**: Process ID of SSH daemon

**Observation**: SSH daemon listening on standard port 22 for both IPv4 and IPv6. Normal operation.

---

### Command 10: curl -I / ping (Network connectivity)
```bash
$ ping -c 4 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=119 time=15.2 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=119 time=14.8 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=119 time=15.1 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=119 time=14.9 ms

--- 8.8.8.8 statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/stddev = 14.8/14.9/15.2/0.16 ms
```
**Explanation**: Tests network connectivity and latency.
- **-c 4**: Send 4 ping packets
- **64 bytes**: ICMP packet size
- **ttl=119**: Time-to-live (hops remaining)
- **time=15.2 ms**: Round-trip latency
- **0% packet loss**: All packets received successfully
- **rtt avg=14.9ms**: Average latency

**Observation**: Network connectivity excellent - consistent latency, no packet loss.

---

## 6. LOG REVIEW

### Command 11: journalctl (System journal)
```bash
$ journalctl -u ssh -n 50
Jan 28 18:45:32 devops-server sshd[745]: Server listening on 0.0.0.0 port 22.
Jan 28 18:45:32 devops-server sshd[745]: Server listening on :: port 22.
Jan 28 19:00:15 devops-server sshd[2341]: Accepted password authentication for ubuntu from 192.168.1.100 port 54321 ssh2
Jan 28 19:00:15 devops-server sshd[2341]: pam_unix(sshd:session): session opened for user ubuntu by (uid=0)
Jan 28 19:10:22 devops-server sshd[3451]: Accepted publickey for root from 10.0.0.5 port 55432 ssh2
```
**Explanation**: Shows last 50 lines of SSH service logs from systemd journal.
- **-u ssh**: Filter by unit name (sshd service)
- **-n 50**: Show last 50 entries
- **journalctl**: Reads systemd journal (primary log system)

**Observation**: SSH daemon healthy - listening on both IPv4/IPv6, successful authentications, no errors.

---

### Command 12: tail - Auth logs
```bash
$ tail -n 50 /var/log/auth.log
Jan 28 18:45:32 devops-server sshd[745]: Server listening on 0.0.0.0 port 22.
Jan 28 19:00:15 devops-server sudo: ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/usr/bin/systemctl status ssh
Jan 28 19:15:42 devops-server sshd[4567]: Disconnected from 192.168.1.50 port 54123 [preauth]
```
**Explanation**: Shows authentication-related logs.
- **tail -n 50**: Display last 50 lines
- **/var/log/auth.log**: Contains authentication attempts and sudo usage

**Observation**: One disconnection event (preauth) - client disconnected before authentication. Normal behavior, not an error.

---

## QUICK FINDINGS

✅ **System Status**: HEALTHY
- OS: Debian 11 bullseye with Linux 5.10 kernel
- Memory: 63% available, no pressure
- Disk: All filesystems with sufficient space (root 32%, /home 63%)
- Network: Excellent connectivity, 0% packet loss
- SSH Service: Listening on port 22 (IPv4 & IPv6), accepting connections
- Logs: No errors, normal authentication activity

---

## IF THIS WORSENS - NEXT STEPS

### Escalation Actions (in order):

1. **Enable SSH Debug Logging**
   - Edit `/etc/ssh/sshd_config`: Set `LogLevel DEBUG`
   - Restart service: `systemctl restart ssh`
   - Monitor logs: `journalctl -u ssh -f` (follow mode)
   - Provides more detailed troubleshooting information

2. **Check SSH Configuration & Restart**
   - Validate config: `sshd -t` (test configuration)
   - If config invalid, review: `grep -n "Port" /etc/ssh/sshd_config`
   - Restart service: `systemctl restart ssh`
   - Monitor startup: `systemctl status ssh -l`

3. **Strace & Performance Analysis**
   - Trace SSH process: `strace -p $(pgrep sshd | head -1) -e trace=network` (network calls only)
   - Full trace: `strace -f -o /tmp/sshd.trace -p PID`
   - Analyze delays with: `cat /tmp/sshd.trace | grep -E "time|connect|accept"`
   - Check for I/O bottlenecks or system calls hanging

---

## RUNBOOK METADATA
**Date**: January 28, 2026
**Service**: SSH (sshd)
**Checked By**: DevOps Troubleshooting Drill
**Status**: PASS
**Next Review**: Quarterly or when issues appear
