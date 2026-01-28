# Linux Troubleshooting Runbook: Docker Service

## Target Service/Process
**Service:** Docker (dockerd)
**Purpose:** Container runtime and orchestration
**Date:** January 28, 2026
**Environment:** Ubuntu 22.04 LTS / Linux Production Server

---

## 1. Environment Basics

### Command 1: System Information
```bash
uname -a
```
**Purpose:** Display complete system information including kernel version, architecture, and hostname.

**Example Output:**
```
Linux devops-server 5.15.0-91-generic #101-Ubuntu SMP x86_64 x86_64 x86_64 GNU/Linux
```

**Line-by-line Explanation:**
- `Linux` - Operating system name
- `devops-server` - Hostname of the machine
- `5.15.0-91-generic` - Kernel version (important for compatibility checks)
- `#101-Ubuntu SMP` - Kernel build number and type (Symmetric Multi-Processing)
- `x86_64 x86_64 x86_64` - Machine hardware, processor, and platform architecture
- `GNU/Linux` - Operating system type

**Why This Matters:** Kernel version affects Docker features, security patches, and module support.

---

### Command 2: Distribution Information
```bash
lsb_release -a
# or
cat /etc/os-release
```
**Purpose:** Identify the Linux distribution and version for package compatibility.

**Example Output:**
```
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
```

**Line-by-line Explanation:**
- `Distributor ID` - Linux distribution name
- `Description` - Full description with version
- `Release` - Version number
- `Codename` - Release codename (used for repository management)

**Observation:** Running Ubuntu 22.04 LTS (Jammy) - stable and well-supported for Docker.

---

## 2. Filesystem Sanity Check

### Command 3: Create Test Directory
```bash
mkdir /tmp/runbook-demo
```
**Purpose:** Verify filesystem write permissions and available inodes.

**Explanation:** Creates a temporary directory to test basic filesystem operations.
- `/tmp` - Temporary filesystem (usually tmpfs or regular disk)
- `runbook-demo` - Test directory name

**Expected Result:** Directory created successfully without permission errors.

---

### Command 4: Copy File and List Contents
```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```
**Purpose:** Test file operations and verify permissions.

**Example Output:**
```
-rw-r--r-- 1 root root 220 Jan 28 19:00 hosts-copy
```

**Line-by-line Explanation:**
- `-rw-r--r--` - File permissions (owner: read/write, group: read, others: read)
- `1` - Number of hard links
- `root root` - Owner and group
- `220` - File size in bytes
- `Jan 28 19:00` - Last modification timestamp
- `hosts-copy` - Filename

**Observation:** Filesystem operations working normally. No disk full errors.

---

## 3. CPU & Memory Snapshot

### Command 5: Process CPU/Memory Usage
```bash
ps -eo pid,pcpu,pmem,vsz,rss,comm --sort=-pcpu | head -15
```
**Purpose:** Identify top CPU-consuming processes with memory details.

**Example Output:**
```
PID  %CPU %MEM    VSZ   RSS COMMAND
1234  8.5  2.3 1847392 186540 dockerd
5678  3.2  1.1  892456  89234 containerd
9012  1.8  0.5  456789  45678 kubelet
```

**Command Breakdown:**
- `ps` - Process status command
- `-e` - Select all processes
- `-o` - Output format specification
- `pid` - Process ID
- `pcpu` - CPU usage percentage
- `pmem` - Memory usage percentage
- `vsz` - Virtual memory size (KB)
- `rss` - Resident Set Size - actual physical RAM used (KB)
- `comm` - Command name
- `--sort=-pcpu` - Sort by CPU (descending)
- `head -15` - Show top 15 processes

**Observation:** Docker daemon using 8.5% CPU - normal during container operations. No runaway processes detected.

---

### Command 6: Memory Details
```bash
free -h
```
**Purpose:** Display system memory usage in human-readable format.

**Example Output:**
```
              total        used        free      shared  buff/cache   available
Mem:           15Gi       8.2Gi       2.1Gi       256Mi       5.1Gi       6.8Gi
Swap:         4.0Gi       512Mi       3.5Gi
```

**Line-by-line Explanation:**
- `total` - Total installed RAM (15GB)
- `used` - RAM used by processes (8.2GB)
- `free` - Completely unused RAM (2.1GB)
- `shared` - Memory used by tmpfs/shared memory (256MB)
- `buff/cache` - Disk cache and buffers (5.1GB) - can be freed if needed
- `available` - Memory available for new apps without swapping (6.8GB)
- `Swap` - Virtual memory on disk

**Observation:** 6.8Gi available memory - healthy. Swap usage at 512Mi - acceptable.

---

## 4. Disk & I/O Snapshot

### Command 7: Disk Space Usage
```bash
df -h
```
**Purpose:** Check filesystem disk space utilization.

**Example Output:**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        98G   67G   27G  72% /
/dev/sdb1       200G  145G   46G  76% /var/lib/docker
tmpfs           7.4G  256M  7.2G   4% /tmp
```

**Column Explanation:**
- `Filesystem` - Device or partition name
- `Size` - Total capacity
- `Used` - Space consumed
- `Avail` - Free space available
- `Use%` - Percentage used
- `Mounted on` - Mount point directory

**Observation:** Docker volume at 76% - monitor closely. Root partition at 72% - acceptable.

---

### Command 8: Docker Directory Size
```bash
du -sh /var/lib/docker
```
**Purpose:** Calculate total space consumed by Docker data.

**Example Output:**
```
145G    /var/lib/docker
```

**Command Breakdown:**
- `du` - Disk usage command
- `-s` - Summary only (don't show subdirectories)
- `-h` - Human-readable format (K, M, G)
- `/var/lib/docker` - Docker's default data directory

**Observation:** Docker using 145GB - large image/container footprint. Consider cleanup.

---

## 5. Network Snapshot

### Command 9: Network Connections
```bash
ss -tulpn | grep dockerd
```
**Purpose:** List all TCP/UDP listening ports for Docker daemon.

**Example Output:**
```
tcp   LISTEN 0   128   127.0.0.1:2375   0.0.0.0:*   users:(("dockerd",pid=1234,fd=8))
tcp   LISTEN 0   128   [::]:2376        [::]:*      users:(("dockerd",pid=1234,fd=9))
```

**Command Breakdown:**
- `ss` - Socket statistics (modern replacement for netstat)
- `-t` - TCP sockets
- `-u` - UDP sockets
- `-l` - Listening sockets only
- `-p` - Show process using socket
- `-n` - Numeric addresses (don't resolve hostnames)

**Column Explanation:**
- `tcp` - Protocol type
- `LISTEN` - Socket state
- `0` - Receive queue
- `128` - Send queue/backlog
- `127.0.0.1:2375` - Local address:port (insecure Docker API)
- `0.0.0.0:*` - Remote address
- `users` - Process information

**Observation:** Docker API listening on 2375 (HTTP) and 2376 (HTTPS). Port 2375 should be restricted!

---

### Command 10: Network Connectivity Test
```bash
curl -I https://registry.hub.docker.com
```
**Purpose:** Verify connectivity to Docker Hub registry.

**Example Output:**
```
HTTP/2 200
server: nginx
date: Wed, 28 Jan 2026 19:00:00 GMT
content-type: text/html
```

**Explanation:**
- `curl` - Transfer data from/to server
- `-I` - Fetch headers only (HEAD request)
- `HTTP/2 200` - Successful response

**Observation:** Docker Hub reachable - image pulls should work.

---

## 6. Logs Reviewed

### Command 11: Systemd Journal Logs
```bash
journalctl -u docker.service -n 50 --no-pager
```
**Purpose:** Review recent Docker service logs from systemd.

**Example Output:**
```
Jan 28 18:55:12 devops-server dockerd[1234]: time="2026-01-28T18:55:12Z" level=info msg="API listen on /var/run/docker.sock"
Jan 28 18:56:30 devops-server dockerd[1234]: time="2026-01-28T18:56:30Z" level=warning msg="Failed to retrieve image manifest"
Jan 28 18:58:00 devops-server dockerd[1234]: time="2026-01-28T18:58:00Z" level=info msg="Container started" container_id=abc123
```

**Command Breakdown:**
- `journalctl` - Query systemd journal
- `-u docker.service` - Filter by unit (service) name
- `-n 50` - Show last 50 entries
- `--no-pager` - Output without pager (for scripts)

**Observation:** One warning about image manifest retrieval at 18:56:30 - transient network issue. Otherwise healthy.

---

### Command 12: Docker Daemon Logs
```bash
tail -n 50 /var/log/daemon.log | grep docker
```
**Purpose:** Check system daemon log for Docker-related entries.

**Example Output:**
```
Jan 28 19:00:15 devops-server dockerd: Container health check passed for webapp
Jan 28 19:00:45 devops-server dockerd: Pulling image nginx:latest
```

**Command Breakdown:**
- `tail` - Output last part of file
- `-n 50` - Last 50 lines
- `/var/log/daemon.log` - System daemon log file
- `grep docker` - Filter for Docker-related lines

**Observation:** Normal operations. Health checks passing.

---

## 7. Quick Findings

Healthy:
- Docker daemon running stably with moderate CPU usage (8.5%)
- Memory available: 6.8Gi - sufficient headroom
- Network connectivity to Docker Hub functional
- No critical errors in last 50 log entries

Warnings:
- Docker data directory at 76% capacity (145GB/200GB) - approaching threshold
- Insecure Docker API (port 2375) exposed on localhost - security risk
- One transient image manifest retrieval warning - likely network hiccup

Metrics Summary:
- CPU: 8.5% (dockerd) - Normal
- Memory: 8.2Gi/15Gi used (54%) - Healthy
- Disk: 72% root, 76% Docker volume - Monitor
- Network: All tests passing

---

## 8. If This Worsens - Next Steps

If Docker performance degrades or issues escalate, take these actions:

### 1. Enable Debug Logging
```bash
# Edit Docker daemon config
sudo vim /etc/docker/daemon.json
# Add: {"debug": true, "log-level": "debug"}
sudo systemctl restart docker
```
Purpose: Capture detailed diagnostic information for troubleshooting.

### 2. Collect System Call Trace
```bash
sudo strace -p $(pgrep dockerd) -o /tmp/docker-strace.log -ff -tt
```
Purpose: Trace system calls to identify blocking operations or errors.
Flags:
- `-p` - Attach to process ID
- `-o` - Output file
- `-ff` - Follow forks
- `-tt` - Timestamps with microseconds

### 3. Analyze I/O Bottlenecks
```bash
sudo iotop -o -a
# or
sudo iostat -x 2 5
```
Purpose: Identify processes causing high disk I/O that might slow Docker.

### 4. Clean Up Docker Resources
```bash
# Remove unused containers, images, volumes
docker system prune -a --volumes
# Check space reclaimed
du -sh /var/lib/docker
```
Purpose: Free up disk space if approaching capacity limits.

### 5. Check Container-Specific Issues
```bash
# List all containers with status
docker ps -a
# Inspect failing container
docker inspect <container_id>
# Get container logs
docker logs --tail 100 <container_id>
```
Purpose: Drill down to specific container problems.

### 6. Monitor Resource Limits
```bash
# Check container resource constraints
docker stats --no-stream
# Review Docker daemon resource limits
systemctl show docker.service | grep Limit
```
Purpose: Verify containers aren't hitting memory/CPU limits.

---

## Additional Useful Commands

### Performance Monitoring
```bash
# Real-time process monitoring
htop
# or for Docker-specific
docker stats

# I/O wait and system stats
vmstat 2 5

# Network bandwidth usage
iftop -i eth0

# Open file descriptors
lsof -p $(pgrep dockerd) | wc -l
```

### Docker-Specific Diagnostics
```bash
# Docker daemon info
docker info

# Check Docker version
docker version

# Inspect Docker networks
docker network ls
docker network inspect bridge

# Check Docker volumes
docker volume ls
docker volume inspect <volume_name>

# View Docker events live
docker events --since '1h'
```

### System Health
```bash
# Check kernel ring buffer for hardware errors
dmesg -T | tail -50

# Review out-of-memory killer logs
grep -i 'out of memory' /var/log/syslog

# Check failed systemd services
systemctl --failed

# Verify time synchronization (important for distributed systems)
timedatectl status
```

---

## Runbook Completion

Date Completed: January 28, 2026, 7:00 PM IST
Executed By: DevOps Engineer
Status: System Healthy - Monitoring Recommended
Next Review: Within 24 hours or upon service degradation

---

## Notes

- This runbook should be executed whenever Docker performance anomalies are suspected
- All commands tested on Ubuntu 22.04 LTS with Docker Engine 24.x
- Adjust filesystem paths and service names based on your specific environment
- Keep this runbook version-controlled and update after infrastructure changes
- Consider automating these checks with monitoring tools (Prometheus, Grafana, Datadog)

Remember: Always capture evidence before making changes in production!
