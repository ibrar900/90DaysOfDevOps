
# Day 04 – Linux Practice: Processes, Services, and Logs

## Objective

Today's goal is to practice Linux fundamentals by running real commands for:
- Process management and inspection
- Service control and status checking
- Log analysis and troubleshooting
- End-to-end mini incident resolution

## 1. Process Checks

### 1.1 List Running Processes (System Overview)

**Command:**
```bash
ps aux | head -n 15
```
<img width="1633" height="797" alt="Screenshot 2026-02-06 153634" src="https://github.com/user-attachments/assets/0f2620a6-e2a2-4eeb-b61c-f48b4e04306f" />


**Purpose:**
- Get a quick snapshot of top running processes
- Identify resource-intensive processes (CPU, memory)
- Check which users are running what processes

**Key Observations:**
- System services (systemd, journald, sshd) running as root
- User processes running under devops-admin
- Docker daemon consuming ~2.1% memory
- Multiple SSH sessions active

**Sample Output:**
```text
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.2 168580 11240 ?        Ss   09:15   0:04 /sbin/init splash
root           2  0.0  0.0      0     0 ?        S    09:15   0:00 [kthreadd]
root         321  0.0  0.3 125896  8756 ?        S<s  09:15   0:00 /lib/systemd/systemd-journald
root         365  0.0  0.4  47528 10124 ?        Ss   09:15   0:02 /usr/bin/containerd
root         452  0.0  0.6 1518492 24880 ?       Ssl  09:15   0:18 /usr/bin/dockerd -H fd://
root         512  0.0  0.2  15400  8952 ?        Ss   09:15   0:00 /usr/sbin/sshd -D
messagebus   598  0.0  0.1   8856  5124 ?        Ss   09:15   0:03 /usr/bin/dbus-daemon --system
root         623  0.0  0.3  30128 12044 ?        Ss   09:15   0:00 /usr/sbin/cron -f
devops+     1847  0.0  0.2  18752  9344 ?        Ss   09:32   0:00 /lib/systemd/systemd --user
devops+     2103  0.1  0.1  11284  5888 pts/0    Ss   10:05   0:00 -bash
devops+     2487  0.0  0.1  13216  4096 pts/0    R+   10:22   0:00 ps aux
```

**Analysis:**
- PID 1 is systemd (init system)
- Docker daemon (PID 452) is healthy and running
- SSH service (PID 512) listening for connections
- Cron daemon (PID 623) managing scheduled tasks
- Current shell session (PID 2103) consuming minimal resources

---

### 1.2 Inspect Processes for SSH Service

**Command:**
```bash
ps aux | grep sshd | grep -v grep
```

**Purpose:**
- Verify SSH daemon is running
- Identify master process and child processes for active sessions
- Cross-check with systemd service status
- Determine resource usage of SSH processes

**Key Observations:**
- Master sshd process running as root (PID 512)
- Two active SSH sessions from remote clients
- Minimal CPU and memory footprint (~0.2% MEM)
- Child processes spawned for each connection

**Sample Output:**
```text
root         512  0.0  0.2  15400  8952 ?        Ss   09:15   0:00 /usr/sbin/sshd -D
root        2089  0.0  0.3  16744 11284 ?        Ss   10:04   0:00 sshd: devops-admin [priv]
devops+     2098  0.0  0.1  16876  7124 ?        S    10:05   0:00 sshd: devops-admin@pts/0
root        2344  0.0  0.3  16744 11108 ?        Ss   10:18   0:00 sshd: monitoring [priv]
```

**Analysis:**
- Master sshd daemon (PID 512) in daemon mode (-D flag)
- Two privilege-separated sessions (PIDs 2089, 2344)
- User sessions running as devops-admin and monitoring users
- pts/0 indicates pseudo-terminal allocation

---

### 1.3 Find Process ID (PID) Using pgrep

**Command:**
```bash
pgrep -a sshd
```

**Purpose:**
- Quickly find PIDs for a specific service name
- Display full command line with -a flag
- Useful for automation scripts

**Sample Output:**
```text
512 /usr/sbin/sshd -D
2089 sshd: devops-admin [priv]
2098 sshd: devops-admin@pts/0
2344 sshd: monitoring [priv]
```

**Analysis:**
- Faster alternative to ps + grep combination
- Clean output suitable for scripting
- Shows all processes matching "sshd" pattern

---

## 2. Service Checks

**Target Service:** `ssh.service` (OpenSSH Server)

### 2.1 Check Service Status

**Command:**
```bash
sudo systemctl status ssh
```

**Purpose:**
- Verify if SSH service is active and enabled
- View recent log entries inline
- Check service health and uptime
- Identify configuration file location

**Key Observations:**
- Service state: **active (running)**
- Loaded from: `/lib/systemd/system/ssh.service`
- Enabled at boot: **yes**
- Main PID: 512 (matches ps output)
- Uptime: Running since 09:15:23 (1 hour 10 minutes)
- No recent errors or warnings

**Sample Output:**
```text
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-01-27 09:15:23 IST; 1h 10min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 498 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 512 (sshd)
      Tasks: 1 (limit: 4557)
     Memory: 3.2M
        CPU: 142ms
     CGroup: /system.slice/ssh.service
             └─512 /usr/sbin/sshd -D

Jan 27 09:15:23 ubuntu-devops-lab systemd[1]: Starting OpenBSD Secure Shell server...
Jan 27 09:15:23 ubuntu-devops-lab sshd[512]: Server listening on 0.0.0.0 port 22.
Jan 27 09:15:23 ubuntu-devops-lab sshd[512]: Server listening on :: port 22.
Jan 27 09:15:23 ubuntu-devops-lab systemd[1]: Started OpenBSD Secure Shell server.
Jan 27 10:04:52 ubuntu-devops-lab sshd[2089]: Accepted publickey for devops-admin from 192.168.1.105 port 54321 ssh2: RSA
Jan 27 10:18:34 ubuntu-devops-lab sshd[2344]: Accepted password for monitoring from 192.168.1.110 port 48792 ssh2
```

**Analysis:**
- Pre-flight check (sshd -t) passed successfully
- Service listening on both IPv4 (0.0.0.0) and IPv6 (::) on port 22
- Two successful logins: one via public key, one via password
- Memory usage: 3.2 MB (very efficient)
- CPU time: 142ms (minimal overhead)
- CGroup hierarchy shows process isolation

---

### 2.2 List All Running Services

**Command:**
systemctl status | head -n 20      and systemctl status | tail -n 20

<img width="1492" height="816" alt="Screenshot 2026-02-06 154810" src="https://github.com/user-attachments/assets/aa278c2c-5a83-4c1e-aad2-dbe96c527da5" />


```bash
systemctl list-units --type=service --state=running | head -n 20
```
<img width="1454" height="534" alt="image" src="https://github.com/user-attachments/assets/6b14db4e-50b0-4eb8-b2e1-dd03c3879288" />

**Purpose:**
- Get overview of all active systemd services
- Confirm critical services are operational
- Identify unexpected services

**Key Observations:**
- 45 services currently running
- Core services: networking, cron, ssh, docker, containerd
- System services: systemd-journald, systemd-logind, dbus
- User services: user@1000.service (for devops-admin)

**Sample Output:**
```text
UNIT                          LOAD   ACTIVE SUB     DESCRIPTION
accounts-daemon.service          loaded active running Accounts Service
containerd.service            loaded active running containerd container runtime
cron.service                  loaded active running Regular background program processing daemon
dbus.service                  loaded active running D-Bus System Message Bus
docker.service                loaded active running Docker Application Container Engine
ssh.service                   loaded active running OpenBSD Secure Shell server
systemd-journald.service      loaded active running Journal Service
```

**Analysis:**
- System is in a healthy state with essential DevOps tooling active
- Services are properly categorized under their respective slices
- Journald is active, ensuring log persistence

---

## 3. Log Checks

### 3.1 View Latest Logs for SSH Service

**Command:**
```bash
sudo journalctl -u ssh -n 25
```

**Purpose:**
- Inspect specific service logs for errors or suspicious activity
- Verify successful service operations
- Troubleshoot recent failures

**Key Observations:**
- Log entries are chronological and include timestamps
- Shows source of logins (IP addresses and ports)
- Identifies authentication methods used (publickey vs password)

**Sample Output:**
```text
Jan 27 10:45:12 ubuntu-devops-lab sshd[2512]: Received SIGHUP; restarting.
Jan 27 10:45:12 ubuntu-devops-lab sshd[2512]: Server listening on 0.0.0.0 port 22.
Jan 27 10:45:12 ubuntu-devops-lab sshd[2512]: Server listening on :: port 22.
Jan 27 10:52:04 ubuntu-devops-lab sshd[2680]: Invalid user admin from 10.0.0.42 port 56789
Jan 27 10:52:04 ubuntu-devops-lab sshd[2680]: Connection closed by authenticating user admin 10.0.0.42 port 56789 [preauth]
Jan 27 11:15:33 ubuntu-devops-lab sshd[2844]: Accepted publickey for devops-admin from 192.168.1.105 port 33452 ssh2
```

**Analysis:**
- Service was successfully reloaded at 10:45
- Detected a failed login attempt for non-existent user "admin" from internal IP
- Recent successful login confirms service availability

---

### 3.2 Follow System Logs in Real-time

**Command:**
<img width="1644" height="336" alt="image" src="https://github.com/user-attachments/assets/be6574fe-0ba2-4ad7-91eb-f4a94e9c59a6" />

```bash
sudo tail -f /var/log/syslog | grep -i "error\|fail\|warn"
```

**Purpose:**
- Monitor system health as events occur
- Filter for critical keywords during troubleshooting
- Observe impact of configuration changes in real-time

**Key Observations:**
- Caught a minor warning about NTP synchronization
- No critical kernel or hardware failures reported
- Useful for observing service start/stop sequences

---

## 4. Mini Troubleshooting Flow

**Scenario:** SSH service is reported as inaccessible.

### Step 1: Initial Investigation (Service Status)
**Command:** `sudo systemctl status ssh`
<img width="1535" height="676" alt="image" src="https://github.com/user-attachments/assets/679b698b-d2b2-46ab-8bea-586e23993347" />

**Observation:** Active state is `failed (Result: exit-code)`. Main PID is gone.

### Step 2: Root Cause Analysis (Logs)
**Command:** `sudo journalctl -u ssh -e`
<img width="1429" height="359" alt="image" src="https://github.com/user-attachments/assets/66dece02-167f-4600-8672-b8038e83f07b" />

**Observation:** Log shows: `/etc/ssh/sshd_config line 45: Bad configuration option: MaxAuthTries10`. There is a missing space.

### Step 3: Resolution (Fix and Reload)
**Commands:**
```bash
sudo sed -i 's/MaxAuthTries10/MaxAuthTries 10/' /etc/ssh/sshd_config
sudo systemctl restart ssh
```
<img width="1259" height="707" alt="image" src="https://github.com/user-attachments/assets/7e0a98d5-218a-4673-aa6f-87ba46ce6edf" />

### Step 4: Verification (Process and Port)
**Commands:**
```bash
pgrep sshd
sudo ss -tulpn | grep :22
```
<img width="844" height="203" alt="image" src="https://github.com/user-attachments/assets/6d396f4a-8c36-43c4-8d1a-74b8ba98d302" />

**Outcome:** sshd process is back (PID 3045). Port 22 is listening. Incident resolved.

---

## 5. Linux Practice Mind Map Structure

```text
Linux Basics (Processes, Services, Logs)
│
├── Process Management
│   ├── Commands: ps aux, top, htop, pgrep
│   ├── Key Concepts: PID, PPID, States (S, R, Z), User Ownership
│   └── Actions: Listing, Filtering, Monitoring, Sending Signals (kill)
│
├── Service Management (systemd)
│   ├── Commands: systemctl status/start/stop/restart/enable/disable
│   ├── Key Concepts: Unit files, States (active, inactive, failed), Enabled vs Active
│   └── Actions: Life cycle management, boot-time configuration
│
├── Log Analysis
│   ├── Tools: journalctl, tail, cat, grep, less
│   ├── Key Locations: /var/log/syslog, /var/log/auth.log, /var/log/dmesg
│   └── Actions: Filtering by service, following real-time, searching for patterns
│
└── Troubleshooting Flow
    ├── 1. Symptom Identification (Report/Monitoring)
    ├── 2. Status Check (systemctl status)
    ├── 3. Log Inspection (journalctl/tail)
    ├── 4. Root Cause Analysis (Config/Resource/Permission)
    ├── 5. Mitigation/Fix (Edit/Restart)
    └── 6. Verification (Status/Process/Port)
```
