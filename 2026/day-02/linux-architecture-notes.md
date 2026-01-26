# Linux Architecture, Processes, and systemd

> Goal: Understand how Linux works under the hood so you can debug services and systems confidently.

---

## 1. Big Picture Mindmap (Text Blueprint)

Linux System  
├── Kernel (core)  
│   ├── Manages hardware (CPU, RAM, disks, network)  
│   ├── Handles system calls from programs  
│   └── Manages processes, memory, I/O, drivers  
├── User Space  
│   ├── Shells (bash, zsh, etc.)  
│   ├── User programs (nginx, docker, vim, python, etc.)  
│   └── System tools (ps, top, systemctl, journalctl)  
└── Init System (systemd on most distros)  
    ├── PID 1 – first userspace process  
    ├── Starts and stops services (units)  
    └── Manages targets (boot levels), logging, dependencies  

---

## 2. Core Components of Linux

### Kernel
- Single **core** of the OS – always running after boot.
- Talks directly to hardware via drivers.
- Exposes system calls so programs can create files, processes, network connections, etc.

### User Space
- Everything that is **not** kernel: shells, CLI tools, servers, GUIs.
- Users run commands, scripts, and services here.
- Crashes here usually do not crash the whole system (kernel isolates processes).

### Init System / systemd
- First userspace process (PID 1) started by the kernel.
- Starts essential services during boot (networking, logging, ssh, etc.).
- Restarts failed services, manages dependencies, and controls shutdown/reboot.

---

## 3. How Processes Are Created and Managed

### Process Basics
- A process = running instance of a program with its own PID.
- Parent/child relationship: shells or systemd spawn processes.
- Typical flow:
  1. User runs a command (e.g., `nginx`).
  2. Shell/systemd uses fork/exec to create a new process.
  3. Kernel schedules process on CPU and manages its memory.

### Process States
- **Running**: Currently executing on CPU or ready to run.
- **Sleeping**: Waiting for something (disk, network, input).
- **Stopped**: Paused (e.g., via `Ctrl+Z` or `SIGSTOP`).
- **Zombie**: Process finished but parent has not read its exit status.
- **Uninterruptible sleep (D)**: Waiting on critical I/O.

---

## 4. What systemd Does and Why It Matters

### What systemd Does
- PID 1: The **init** system that starts after the kernel.
- Reads unit files (service, socket, timer, target, etc.).
- Starts, stops, restarts, and monitors services.
- Handles dependencies (start database before app, networking before ssh, etc.).

### Why It Matters for DevOps
- Services in production are usually managed by systemd.
- You use it to:
  - Check service status when something is down.
  - Restart crashed services cleanly.
  - Enable services to start at boot.
  - Inspect logs quickly during incidents.

---

## 5. Daily Useful Commands

1. `ps aux`: Show all processes.
2. `top` or `htop`: Live view of CPU, memory, and processes.
3. `systemctl status <service>`: Check service status.
4. `systemctl restart <service>`: Restart a service.
5. `journalctl -u <service> --since \"10 min ago\"`: View recent logs.
