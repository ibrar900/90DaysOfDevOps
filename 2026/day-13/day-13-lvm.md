# Day 13 – Linux Volume Management (LVM)  
**Super Simple Guide for Beginners – 2026 Edition**

**Watch First:** [Linux LVM Tutorial Video](https://youtu.be/Evnf2AAt7FQ?si=ncnfQYySYtK_2K3c) – it's 10–15 mins, explains everything visually.

LVM = Logical Volume Manager. It's like magic for storage: Combine disks (physical volumes), group them (volume groups), and slice into flexible parts (logical volumes) that you can grow/shrink.

<img width="1396" height="727" alt="Screenshot 2026-02-06 205616" src="https://github.com/user-attachments/assets/f0f7d176-1f14-4c82-987c-b0e3acee7524" />
<img width="1396" height="727" alt="Screenshot 2026-02-06 205616" src="https://github.com/user-attachments/assets/daf32cc7-ddfa-4af5-b204-90cc3e8b3aa8" />
<img width="1402" height="739" alt="Screenshot 2026-02-06 202743" src="https://github.com/user-attachments/assets/08282a3b-aa79-4581-aab2-a2738ffb774a" />
<img width="1408" height="697" alt="Screenshot 2026-02-06 203038" src="https://github.com/user-attachments/assets/6772c6a1-d436-4185-ba21-ebaf70c9ced3" />
<img width="1606" height="868" alt="Screenshot 2026-02-06 194720" src="https://github.com/user-attachments/assets/521149ef-c78c-4f3d-85a6-96bd65748126" />
<img width="1850" height="881" alt="Screenshot 2026-02-06 202716" src="https://github.com/user-attachments/assets/f9fbdd7c-eb7c-40a6-8924-28869bec6b42" />



## Before You Start (5 Minutes Setup)
- Switch to root: `sudo -i` or `sudo su` (all commands need root).  
# Day 13 – Linux Volume Management (LVM)

## Task
Learn LVM to manage storage flexibly – create, extend, and mount volumes.


## Task 1: Check Current Storage
Run: `lsblk`, `pvs`, `vgs`, `lvs`, `df -h`

<img width="866" height="514" alt="Screenshot 2026-02-06 174315" src="https://github.com/user-attachments/assets/74e53179-a712-4157-9181-65d5e1f36d38" />


## Task 2: Create Physical Volume

<img width="1109" height="527" alt="Screenshot 2026-02-06 204216" src="https://github.com/user-attachments/assets/4ce79d30-c45a-48ea-871d-0abee7971921" />


## Task 3: Create Volume Group

<img width="1040" height="1015" alt="Screenshot 2026-02-06 205458" src="https://github.com/user-attachments/assets/ca89936d-0c43-490d-b7fc-688c8b099a55" />


## Task 4: Create Logical Volume

<img width="1114" height="852" alt="Screenshot 2026-02-06 205926" src="https://github.com/user-attachments/assets/71cced1d-c99d-41db-a76d-fa62ea1b9073" />


## Task 5: Format and Mount

<img width="1104" height="1016" alt="Screenshot 2026-02-06 210926" src="https://github.com/user-attachments/assets/d2b3429f-b4d6-47a2-98c6-57ef07b96cd0" />


## Task 6: Extend the Volume

<img width="1121" height="1015" alt="Screenshot 2026-02-06 212023" src="https://github.com/user-attachments/assets/09e69178-2d06-44d7-9299-68b475e8b98f" />


## Task 7: Mounting PV directly

<img width="1024" height="365" alt="image" src="https://github.com/user-attachments/assets/d2e03ad6-3571-4347-a9e3-07575536ce0f" />


## Commands Used

* `lsblk` - List block devices and their mount
* `df -h` - Show mounted filesystem usage
* `pvcreate /dev/sdb` - Initialize partition as PV
* `pvs` - List all PVs
* `vgcreate vg_name /dev/sdb` - Create a VG from PVs
* `vgs` - List all VGs
* `lvcreate -n lv_name -L 5G vg_name` - Create LV of 5GB
* `lvextend -L +2G /dev/vg_name/lv_name` - Extend LV by 2GB
* `lvs` - List all LVs
* `mkfs.ext4 /dev/vg_name/lv_name` - Create ext4 filesystem
* `mount /dev/vg_name/lv_name /mnt/data` - Mount created LV
* `resize2fs /dev/vg_name/lv_name` - Resize ext2/3/4 filesystem
* `mkfs -t ext4 /dev/sdb /mnt/data` - Directly mount PV

## What I learned

- Storage hierarchy in LVM: Physical Volumes (PV) → Volume Groups (VG) → Logical Volumes (LV).

- Flexibility of LVM: Unlike traditional partitions, LVM allows resizing volumes dynamically without downtime.

- Creating and managing PVs: Learned how to initialize raw disks/partitions into physical volumes using pvcreate.

- Grouping storage with VGs: Multiple PVs can be combined into a single Volume Group, making storage management easier.

- Filesystem resizing: After extending an LV, the filesystem (resize2fs) must also be resized to use the new space.

- Mounting volumes: Learned how to format (mkfs.ext4) and mount LVs to directories for actual usage.

- Direct PV mounting: Although possible to mount a PV directly, it’s not recommended — LVM provides abstraction and flexibility.

 
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
