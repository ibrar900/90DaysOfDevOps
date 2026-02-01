**Day 09 – Linux User & Group Management Challenge**  
**Simple, Beginner-Friendly Guide (Fully Updated as per README)**

Hello Ibrar!  
Today we’re going to practice **real-world Linux User & Group Management** — exactly what DevOps engineers do every day to control who can access what on servers.

We’ll follow the README instructions exactly, but I’ve made everything **super simple**, visual, and easy to understand with:
- Step-by-step instructions
- Text-based structure & blueprint diagrams
- Real screenshots from the internet
- Best troubleshooting guide

### Overall Workflow Blueprint (Easy to Follow)
```
Start → Task 1 (Create 3 Users) 
      → Task 2 (Create 2 Groups) 
      → Task 3 (Assign Users to Groups) 
      → Task 4 (Shared Directory with 775 Permissions) 
      → Task 5 (Team Workspace with nairobi) 
      → Verify Everything 
      → Create day-09-user-management.md + Screenshots 
      → Submit & Share on LinkedIn
```

### Prerequisites (5 minutes)
- Ubuntu/Debian server or VM (use your Day 08 cloud instance or local VM)
- Logged in as root or a user with sudo privileges
- Basic terminal comfort

### Task 1: Create Three Users (20 minutes)

**Goal**: Create `tokyo`, `berlin`, and `professor` with home directories and passwords.

**Steps**:
1. Create users with home directory:  
   ```bash
   sudo useradd -m tokyo
   sudo useradd -m berlin
   sudo useradd -m professor
   ```
2. Set passwords (you will be prompted):  
   ```bash
   sudo passwd tokyo
   sudo passwd berlin
   sudo passwd professor
   ```

**Verification**:
```bash
cat /etc/passwd | grep -E 'tokyo|berlin|professor'
ls /home
```

**Screenshot Suggestion** (Example of useradd command):  

<img width="721" height="440" alt="image" src="https://github.com/user-attachments/assets/cb478b1e-4ece-4f78-a6d6-90ea9813e111" />

**Blueprint Diagram for Task 1**:
```
sudo useradd -m tokyo     → Creates user + home folder
     ↓
sudo passwd tokyo         → Sets password
     ↓
Check: cat /etc/passwd    → Shows user details
     ↓
ls /home                  → Shows user folders
```

### Task 2: Create Two Groups (10 minutes)

**Steps**:
```bash
sudo groupadd developers
sudo groupadd admins
```

**Verification**:
```bash
cat /etc/group | grep -E 'developers|admins'
```

**Screenshot Suggestion** (/etc/group example):  
<img width="829" height="479" alt="image" src="https://github.com/user-attachments/assets/b9fd33f6-818a-4150-92f9-ef2dff1a4a7e" />

### Task 3: Assign Users to Groups (15 minutes)

**Steps**:
```bash
sudo usermod -aG developers tokyo
sudo usermod -aG developers berlin
sudo usermod -aG admins berlin
sudo usermod -aG admins professor
```

**Verification**:
```bash
groups tokyo
groups berlin
groups professor
id berlin
```

**Screenshot Suggestion** (usermod + groups command):  
<img width="1074" height="672" alt="image" src="https://github.com/user-attachments/assets/f0057f07-ef70-4afc-bc68-c022dda655f1" />


### Task 4: Shared Directory (20 minutes)

**Steps**:
```bash
sudo mkdir -p /opt/dev-project
sudo chgrp developers /opt/dev-project
sudo chmod 775 /opt/dev-project
```

**Verification**:
```bash
ls -ld /opt/dev-project
```

**Screenshot Suggestion** (ls -ld permissions example):  

<img width="1572" height="1066" alt="image" src="https://github.com/user-attachments/assets/b1539860-d927-42ed-b9f2-9d471c116c0e" />

**Blueprint Diagram**:
```
mkdir /opt/dev-project
     ↓
chgrp developers /opt/dev-project
     ↓
chmod 775 /opt/dev-project   → rwxrwxr-x
     ↓
ls -ld → drwxrwxr-x ... developers
```

### Task 5: Team Workspace (20 minutes)

**Steps**:
```bash
sudo useradd -m nairobi
sudo groupadd project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
sudo mkdir -p /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```

**Test** (as nairobi):
```bash
sudo -u nairobi touch /opt/team-workspace/teamfile.txt
ls /opt/team-workspace
```

**Verification**: `ls -ld /opt/team-workspace`

### Final Documentation (day-09-user-management.md)
Copy and fill this template:

```markdown
# Day 09 – Linux User & Group Management Challenge

## Users & Groups Created
- Users: tokyo, berlin, professor, nairobi
- Groups: developers, admins, project-team

## Group Assignments
- tokyo → developers
- berlin → developers, admins
- professor → admins
- nairobi → project-team

## Directories Created
- /opt/dev-project → 775, group: developers
- /opt/team-workspace → 775, group: project-team

## Commands Used
useradd -m, passwd, groupadd, usermod -aG, chgrp, chmod 775, ls -ld

## What I Learned
1. useradd -m creates home directory automatically
2. -aG adds user to group without removing existing groups
3. 775 permission allows group members to read/write/execute

## Screenshots Attached
- useradd output
- /etc/group
- ls -ld /opt/dev-project
- ls -ld /opt/team-workspace
```

### Best Troubleshooting Guide (Most Common Issues & Fixes)

| Problem                              | Cause                                      | Fix                                                                 |
|--------------------------------------|--------------------------------------------|---------------------------------------------------------------------|
| Permission denied                    | Not using sudo                             | Add `sudo` before command                                           |
| User already exists                  | Trying to create again                     | Use `id username` to check, then `userdel username`                 |
| Can't add to group                   | Forgot `-aG`                               | Use `usermod -aG group user` (not `-G`)                             |
| Directory permission wrong           | Wrong chmod number                         | Use `chmod 775 /path` (7=owner rwx, 7=group rwx, 5=others rx)       |
| ls -ld shows wrong group             | Forgot chgrp                               | Run `sudo chgrp group /path`                                        |
| User can't create file in shared dir | Not in correct group                       | Check `groups username`; add with usermod -aG                       |
| sudo -u user fails                   | Wrong username or no password              | Set password first with `sudo passwd user`                          |
| /opt directory not accessible        | Root-only                                  | Use `sudo mkdir` and `sudo chmod`                                   |

**Pro Tip**: Always verify with `ls -ld /path` and `groups username` after changes.

### Submission Checklist
- Create `day-09-user-management.md` in your fork → `2026/day-09/`
- Add 4–6 screenshots
- Commit & push

### Learn in Public (LinkedIn Post Idea)
```text
Just completed Day 09 User & Group Management Challenge! ✅

Created users (tokyo, berlin, professor, nairobi), groups (developers, admins, project-team), and shared directories with 775 permissions.

Key learning: Use -aG with usermod to add users to groups safely!

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham #Linux #UserManagement
```

You now have a complete, simple, visual, and practical guide!  
Follow the steps exactly → you’ll finish successfully.

If you get stuck on any step, reply with the error message — I’ll help instantly.  
Ready to start Task 1? Go for it! 💪

Happy Learning, Ibrar!  
TrainWithShubham Style 🚀
