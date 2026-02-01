# Day 08: Cloud Server Setup - Docker, Nginx & Web Deployment Made Simple

Hello Ibrar (@ibrarahmad900)! It's 11:01 AM IST on February 01, 2026, in Bengaluru—perfect time for a hands-on cloud session before lunch. This guide follows the README.md instructions exactly, but I've made it super simple for beginners: short steps, clear explanations, text-based diagrams (blueprints for workflows), and images from the internet to visualize. I'll use AWS EC2 (Free Tier) as the example (Utho is similar—adapt as needed). At the end, a troubleshooting guide for common hiccups.

Think of this as building your first "cloud house": Launch the foundation (instance), connect the door (SSH), install furniture (Docker/Nginx), open windows (security groups), and check the diary (logs).

## Prerequisites (Quick Check)
- AWS account (sign up at aws.amazon.com—use Free Tier to avoid costs).
- Basic Linux commands (from previous days).
- SSH tool: Terminal (Mac/Linux) or PuTTY (Windows).
- If using Utho: Similar to AWS, but login as root (no key needed initially).

If missing anything, pause and set up—takes 5-10 mins.

## Overall Workflow Blueprint (Text Diagram)
Visualize the process as a simple flowchart (imagine arrows connecting boxes):

```
Start
├── Prerequisites (Account, SSH Tool)
├── Part 1: Launch Instance (Create VM)
│   └── SSH Connect (Remote Access)
├── Part 2: Install Software (Update, Docker, Nginx)
│   └── Verify Running (Check Status)
├── Part 3: Security Config (Open Ports)
│   └── Test in Browser (See Welcome Page)
├── Part 4: Extract Logs (View & Save)
│   └── Download to Local (SCP)
└── End: Document & Submit (Markdown + Files)
```

This blueprint shows the linear flow—each part builds on the last.

<img width="977" height="727" alt="image" src="https://github.com/user-attachments/assets/b37ca25b-1e21-4ae5-a34e-2993bcf0dbbf" />

## Part 1: Launch Cloud Instance & SSH Access (15 Minutes)
Goal: Get a virtual server running and connect to it remotely.

### Step 1: Create a Cloud Instance
1. Log in to AWS Console (console.aws.amazon.com).
2. Search for "EC2" > Click "Launch instance".
3. Name: "MyDevOpsServer".
4. OS: Amazon Linux or Ubuntu (Free Tier eligible)—choose Ubuntu Server for familiarity.
5. Instance type: t2.micro (free).
6. Key pair: Create new (download .pem file—keep safe!).
7. Network: Default VPC; enable public IP.
8. Storage: Default 8GB.
9. Launch! Wait 2-3 mins, then note the Public IPv4 address (e.g., 3.111.222.333).

**Blueprint Diagram for Launch:**
```
AWS Console
├── Search EC2
├── Launch Instance Button
├── Fill Details (Name, OS, Type, Key)
└── Launch & Wait (Get IP)
```

### Step 2: Connect via SSH
1. Open terminal.
2. Set key permissions: `chmod 400 your-key.pem` (secure it).
3. Connect: `ssh -i "your-key.pem" ubuntu@<your-ip>` (for Ubuntu; use ec2-user for Amazon Linux).
4. Type "yes" to trust host first time.
5. You're in! Run `whoami` to confirm (output: ubuntu).

<img width="1784" height="1184" alt="image" src="https://github.com/user-attachments/assets/94937a75-39fd-4d9b-b7ec-2f6e12114fbb" />

**Troubleshooting Tip (Quick Fix Here):** If "Permission denied (publickey)": Check key path, permissions (chmod 400), or IP. Wrong user? Use ec2-user for Amazon Linux.

## Part 2: Install Docker & Nginx (20 Minutes)
Goal: Update server and set up web server software.

### Step 1: Update System
1. Run: `sudo apt update && sudo apt upgrade -y` (for Ubuntu).
2. Wait 2-5 mins—keeps system secure.

### Step 2: Install Docker
(README title mentions Docker, so include it—useful for containers.)
1. Install: `sudo apt install docker.io -y`.
2. Start: `sudo systemctl start docker`.
3. Enable boot: `sudo systemctl enable docker`.
4. Verify: `sudo docker --version` (output: Docker version 20.xx).

<img width="1366" height="758" alt="image" src="https://github.com/user-attachments/assets/ba7a9629-f172-4517-9d70-48b26050171b" />

### Step 3: Install Nginx
1. Install: `sudo apt install nginx -y`.
2. Start: `sudo systemctl start nginx`.
3. Enable: `sudo systemctl enable nginx`.
4. Verify: `sudo systemctl status nginx` (output: active (running)).

**Blueprint Diagram for Installation:**
```
Server Terminal
├── sudo apt update/upgrade
├── Install Docker (apt install docker.io)
│   └── Start/Enable/Verify
└── Install Nginx (apt install nginx)
    └── Start/Enable/Status
```

## Part 3: Security Group Configuration (10 Minutes)
Goal: Allow web traffic (port 80 for HTTP).

1. In AWS Console: EC2 > Your instance > "Security" tab > Click security group link.
2. Edit inbound rules: Add rule - Type: HTTP, Port: 80, Source: 0.0.0.0/0 (anywhere).
3. Save.
4. Test: In browser, go to http://<your-ip> —see Nginx welcome page!

<img width="1200" height="729" alt="image" src="https://github.com/user-attachments/assets/f772b8d7-b8d4-4c54-9b0a-c458e7d0be63" />

<img width="295" height="171" alt="image" src="https://github.com/user-attachments/assets/05b659fa-7f91-437d-9ea6-b33487767d01" />

**Troubleshooting Tip:** Page not loading? Check IP (copy from AWS), security group (port 80 open?), Nginx status (running?).

## Part 4: Extract Nginx Logs (15 Minutes)
Goal: View and save server activity logs.

### Step 1: View Nginx Logs
1. Access log: `sudo tail -n 100 /var/log/nginx/access.log` (last 100 entries).
2. Error log: `sudo tail -n 100 /var/log/nginx/error.log`.

### Step 2: Save Logs to File
1. Combine: `sudo cat /var/log/nginx/access.log > ~/nginx-logs.txt` (or append error log: `sudo cat /var/log/nginx/error.log >> ~/nginx-logs.txt`).

### Step 3: Download Log File to Your Local Machine
1. Local terminal: `scp -i your-key.pem ubuntu@<your-ip>:~/nginx-logs.txt .` (downloads to current dir).
*(Image: Extracting Nginx access logs in terminal - shows tail/cat commands on logs.)*

**Blueprint Diagram for Logs:**
```
Server Logs
├── View (tail -n 100 /var/log/nginx/access.log)
├── Save (cat access.log > nginx-logs.txt)
└── Download (scp from local machine)
```

## Documentation Template (Your day-08-cloud-deployment.md)
Copy this into your Markdown file:

# Day 08: Cloud Deployment

## Commands Used
- Launch: (AWS Console steps)
- SSH: ssh -i key.pem ubuntu@ip
- Update: sudo apt update && sudo apt upgrade -y
- Docker: sudo apt install docker.io -y; sudo systemctl start/enable docker
- Nginx: sudo apt install nginx -y; sudo systemctl start/enable/status nginx
- Logs: sudo tail -n 100 /var/log/nginx/access.log > nginx-logs.txt
- Download: scp -i key.pem ubuntu@ip:~/nginx-logs.txt .

## Challenges Faced
- [E.g., SSH key permission error: Fixed with chmod 400 key.pem]
- [E.g., Port not open: Added security rule for 80]

## What I Learned
- Launching cloud VMs is like renting a computer online.
- SSH is secure remote control.
- Docker/Nginx for apps/web servers.
- Security groups act as firewalls.
- Logs tell the server's story.

## Why This Matters for DevOps
As per README: Provisioning, remote management, deployment, logs, security—core for real jobs.

## Submission
1. Fork 90DaysOfDevOps repo.
2. Add to 2026/day-08/: day-08-cloud-deployment.md, nginx-logs.txt, screenshots (ssh-connection.png, nginx-webpage.png, docker-nginx.png).
3. Commit/push.

## Learn in Public
Post on LinkedIn: "Deployed my first cloud server with Nginx! Faced SSH issues but solved with chmod. #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham" + screenshot of welcome page.

## Full Troubleshooting Guide
- **Instance Launch Fails:** Free Tier limit? Check AWS dashboard; use t2.micro.
- **SSH Connection Refused:** Wrong IP? Copy from AWS. Key wrong? Verify name/path. Firewall? Open port 22 in security group.
- **Apt Update Errors:** No internet? Check instance connectivity (ping 8.8.8.8). Proxy? Configure in /etc/environment.
- **Docker/Nginx Install Fails:** Not root? Use sudo. Repo issue? apt update first.
- **Nginx Not Starting:** Port conflict? ss -tuln | grep 80; kill if needed. Check status for errors.
- **Page Not Accessible:** Wrong IP? Use public IP. Security? Add HTTP rule. Browser cache? Incognito mode.
- **Logs Empty:** No traffic? Refresh page multiple times. Wrong path? ls /var/log/nginx.
- **SCP Download Fails:** Key issue? Same as SSH. File not exist? Check ls ~/nginx-logs.txt on server.

This guide is self-contained—follow steps, and you'll succeed! If stuck, communities from previous chats can help. Happy deploying,! 🚀
