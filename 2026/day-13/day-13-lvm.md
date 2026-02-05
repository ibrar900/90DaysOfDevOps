# Day 13 – Linux Volume Management (LVM)  
**Super Simple Guide for Beginners – 2026 Edition**

**Watch First:** [Linux LVM Tutorial Video](https://youtu.be/Evnf2AAt7FQ?si=ncnfQYySYtK_2K3c) – it's 10–15 mins, explains everything visually.

LVM = Logical Volume Manager. It's like magic for storage: Combine disks (physical volumes), group them (volume groups), and slice into flexible parts (logical volumes) that you can grow/shrink.

## Before You Start (5 Minutes Setup)
- Switch to root: `sudo -i` or `sudo su` (all commands need root).  
- No extra disk? Create a fake one (as in README): 

Terminal---- bash
  dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024  # 1GB fake disk
  losetup -fP /tmp/disk1.img  # Attach as loop device
  losetup -a  # Check name, e.g., /dev/loop0 – use this instead of /dev/sdb
  
- Real disk? Use `lsblk` to find it (e.g., /dev/sdb – careful, don't use your main disk!).

**Structure Diagram for LVM Basics** (Like Building Blocks):

Physical Volumes (PV) → Raw disks (e.g., /dev/sdb)
     ↓
Volume Group (VG) → Pool of PVs (combine space)
     ↓
Logical Volumes (LV) → Slices from VG (like partitions, but flexible)
     ↓
Format & Mount → Use as folder (e.g., /mnt/data)


*(Picture: LVM building blocks diagram – shows PV → VG → LV flow with arrows.)*

## Challenge Tasks (Hands-On – Do in Order)

### Task 1: Check Current Storage
**Goal**: See what's there before changes.

Commands:
Terminal---- bash

lsblk      # Shows disks/partitions
pvs        # Physical volumes
vgs        # Volume groups
lvs        # Logical volumes
df -h      # Mounted filesystems

**Expected Output Example** (yours may differ):
- lsblk: sda (main), sdb (new disk)  
- pvs/vgs/lvs: Empty if no LVM yet  
- df -h: Shows / with space used

**Screenshot Suggestion**: Run all and capture terminal.  
*(Picture: lsblk command output – tree view of disks like sda, sdb.)*

### Task 2: Create Physical Volume (PV)
**Goal**: Prepare disk for LVM.

Command:
Terminal ----- bash

pvcreate /dev/sdb   # Or /dev/loop0 for fake
pvs                 # Verify

**What Happens**: Marks disk as PV (like labeling a box).  
Output: "Physical volume /dev/sdb successfully created."

**Blueprint Diagram**:

Raw Disk (/dev/sdb)
     ↓ pvcreate
Physical Volume (PV) → Ready for group
     ↓ pvs → Shows PV details (size, free)


### Task 3: Create Volume Group (VG)
**Goal**: Group PVs into a pool.

Command:
Terminal ---- bash
vgcreate devops-vg /dev/sdb
vgs                 # Verify


**What Happens**: Creates VG (big pool from PV space).  
Output: "Volume group devops-vg successfully created."

### Task 4: Create Logical Volume (LV)
**Goal**: Slice VG into usable volume.

Command:
Terminal ---- bash
lvcreate -L 500M -n app-data devops-vg
lvs                 # Verify

**What Happens**: 500MB LV from VG (like cutting a piece).  
Output: "Logical volume app-data created."

### Task 5: Format and Mount
**Goal**: Make LV usable as folder.

Commands:
Terminal ---- bash
mkfs.ext4 /dev/devops-vg/app-data   # Format as ext4 filesystem
mkdir -p /mnt/app-data              # Create mount point
mount /dev/devops-vg/app-data /mnt/app-data  # Mount
df -h /mnt/app-data                 # Verify space

**What Happens**: Formats (like painting the box), mounts (attaches to folder).  
Output: df -h shows 500M available.

**Screenshot Suggestion**: df -h after mount.  
*(Picture: mount command example – showing df -h with new /mnt volume.)*

### Task 6: Extend the Volume
**Goal**: Grow LV bigger (LVM magic!).

Commands:
Terminal ---- bash
lvextend -L +200M /dev/devops-vg/app-data   # Add 200M
resize2fs /dev/devops-vg/app-data           # Resize filesystem
df -h /mnt/app-data                         # Verify now 700M

**What Happens**: Extends without downtime.  
Output: "Size extended successfully."

## Documentation Template (day-13-lvm.md)
Copy and fill:

markdown
# Day 13 – LVM Challenge

## Commands Used
lsblk, pvs, vgs, lvs, df -h  
pvcreate /dev/sdb  
vgcreate devops-vg /dev/sdb  
lvcreate -L 500M -n app-data devops-vg  
mkfs.ext4 /dev/devops-vg/app-data  
mkdir -p /mnt/app-data  
mount /dev/devops-vg/app-data /mnt/app-data  
lvextend -L +200M /dev/devops-vg/app-data  
resize2fs /dev/devops-vg/app-data  

## Screenshots Attached
- lsblk before/after
- pvs/vgs/lvs
- df -h after mount & extend

## What I Learned (3 points)
1. LVM makes storage flexible – add space without new disks
2. pvcreate prepares disks, vgcreate pools them, lvcreate slices
3. Extend with lvextend + resize2fs – no downtime!
```

## Submission
1. Fork 90DaysOfDevOps repo.  
2. Go to `2026/day-13/`.  
3. Add `day-13-lvm.md` + screenshots (e.g., pvcreate-output.png).  
4. Commit/push.

## Learn in Public (LinkedIn Post Idea)
"Day 13 LVM done! Created PV/VG/LV, extended 500M to 700M easily. Storage magic! #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham" + screenshot of df -h.

## Why This Matters for DevOps
LVM for flexible cloud/server storage – grow databases/logs without downtime. Common in AWS EBS, Kubernetes PVs.

## Best Troubleshooting Guide (Top 10 Issues + Fixes)
| Issue | Cause | Fix |
|-------|-------|-----|
| pvcreate: Device not found | Wrong disk name | lsblk to check; use /dev/sdb or loop |
| No space for lvcreate | Small disk | Use bigger dd count (e.g., count=2048 for 2GB) |
| mkfs.ext4 fails | Already formatted | Wipe with dd if=/dev/zero of=/dev/lv bs=1M count=1 |
| mount: wrong fs type | Not formatted | Run mkfs.ext4 first |
| lvextend: not enough space | VG full | Add another PV: pvcreate /dev/sdc; vgextend devops-vg /dev/sdc |
| resize2fs: device busy | Mounted | It's OK – resize2fs works on mounted ext4 |
| losetup not found | Minimal system | sudo apt install loop-utils |
| LVM commands not installed | New Ubuntu | sudo apt install lvm2 |
| "Insufficient free extents" | VG space low | pvs/vgs to check free; extend VG |
| Unmount after test | Forgot to unmount | umount /mnt/app-data; lvremove app-data; vgremove devops-vg; pvremove /dev/sdb |

This guide is complete, visual, and easy – watch video, then run commands in order!  

If error, match to troubleshooting. Ready for Task 1? Type `lsblk` now. Let me know how it goes! 🚀