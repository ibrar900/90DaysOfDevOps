# Day 29 – Docker Basics

## Task 1: What is Docker?

### What is a Container and Why Do We Need Them?

A **container** is a lightweight, standalone executable package that includes everything needed to run a piece of software: code, runtime, libraries, and system settings. Containers virtualize the operating system, allowing multiple applications to run in isolated environments on the same host.

**Why we need containers:**
- **Consistency**: Same environment from development to production
- **Isolation**: Applications don't interfere with each other
- **Portability**: Works the same on any machine with Docker
- **Lightweight**: Shares OS kernel, unlike VMs
- **Fast deployment**: Start in seconds
- **Resource efficiency**: Lower overhead than VMs

### Containers vs Virtual Machines

| Feature | Containers | Virtual Machines |
|---------|------------|-------------------|
| **Isolation** | Process-level | Full OS isolation |
| **Size** | MBs (lightweight) | GBs (heavy) |
| **Boot time** | Seconds | Minutes |
| **Shared kernel** | Yes | No |
| **Resource usage** | Low | High |
| **Operating system** | Shares host OS | Runs full OS |

**Key difference**: Containers virtualize the operating system at the process level, while VMs virtualize the entire hardware stack with their own OS.

### Docker Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Docker Client                           │
│                   (docker CLI commands)                      │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          │ REST API
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    Docker Daemon                              │
│                 (dockerd - background service)                │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │
│  │   Images     │  │  Containers  │  │   Volumes    │        │
│  └──────────────┘  └──────────────┘  └──────────────┘        │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                   Docker Registry                            │
│                    (Docker Hub)                               │
└─────────────────────────────────────────────────────────────┘
```

**Components:**
- **Docker Client**: The CLI tool (`docker` command) that users interact with
- **Docker Daemon**: The background service that manages containers, images, volumes, and networks
- **Images**: Read-only templates used to create containers
- **Containers**: Runnable instances of images
- **Registry**: Storage location for images (Docker Hub is the default public registry)

---

## Task 2: Install Docker

### Installation Steps

```bash
# Update package index
sudo apt update

# Install dependencies
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify installation
docker --version
docker-compose --version
```

### Verify Installation

```bash
sudo docker run hello-world
```

**Expected output:**
```
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

---

## Task 3: Run Real Containers

### Run Nginx Container

```bash
# Run Nginx in detached mode
docker run -d --name my-nginx -p 8080:80 nginx

# Access in browser at http://localhost:8080
```

### Run Ubuntu Container (Interactive Mode)

```bash
# Run Ubuntu in interactive mode
docker run -it --name my-ubuntu ubuntu /bin/bash

# Inside container, try commands:
ls
cat /etc/os-release
hostname
exit
```

### List Containers

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a
```

### Stop and Remove Container

```bash
# Stop a container
docker stop my-nginx

# Remove a container
docker rm my-nginx
```

---

## Task 4: Explore

### Detached Mode

```bash
# Run in detached mode (-d flag)
docker run -d --name nginx-detached nginx

# Container runs in background
# Use docker logs to see output
docker logs nginx-detached
```

### Custom Name

```bash
# Give custom name (--name flag)
docker run -d --name my-custom-nginx nginx
```

### Port Mapping

```bash
# Map host port to container port (-p host:container)
docker run -d --name nginx-port -p 8080:80 nginx

# Host port 8080 -> Container port 80
```

### Check Logs

```bash
# View container logs
docker logs container_name

# Follow logs in real-time
docker logs -f container_name
```

### Run Command Inside Container

```bash
# Execute command in running container
docker exec container_name ls

# Interactive shell
docker exec -it container_name /bin/bash
```

---

## Summary of Docker Commands

| Command | Description |
|---------|-------------|
| `docker run` | Run a container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop` | Stop a container |
| `docker rm` | Remove a container |
| `docker logs` | View container logs |
| `docker exec` | Run command in container |
| `docker images` | List images |
| `docker pull` | Pull an image |
| `docker rmi` | Remove an image |

---

## Notes

- `-it`: Interactive mode with terminal
- `-d`: Detached mode (background)
- `-p`: Port mapping (host:container)
- `--name`: Custom container name
- `-f`: Follow logs (tail -f equivalent)

---

**Learning completed on**: Day 29 - Docker Basics
