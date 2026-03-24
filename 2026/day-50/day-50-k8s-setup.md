# Day 50 - Kubernetes Architecture and Cluster Setup

## Kubernetes History (The Story)

### Why Was Kubernetes Created?

Docker revolutionized how we package and deploy applications using containers. However, when organizations started using Docker at scale, they faced significant challenges:

1. **Running hundreds of containers** across multiple servers became a nightmare
2. **Scaling** containers up and down based on demand was manual and error-prone
3. **High availability** - what happens when a server crashes? Containers need to be automatically redistributed
4. **Service discovery** - how do containers find each other in a dynamic environment?
5. **Load balancing** - distributing traffic across multiple container instances
6. **Rolling updates** - deploying new versions without downtime
7. **Self-healing** - automatically restarting failed containers

Docker alone could not solve these problems. It was designed to run containers on a single host, not orchestrate thousands of containers across a cluster.

### Who Created Kubernetes?

- **Google** created Kubernetes, releasing it as an open-source project in 2015
- It was inspired by Google's internal system called **Borg**, which Google used for years to manage millions of containers in production
- The project was donated to the **Cloud Native Computing Foundation (CNCF)**
- It was designed to be a portable, extensible, open-source platform for managing containerized workloads

### What Does "Kubernetes" Mean?

The name **Kubernetes** comes from Greek and means **"helmsman"** or **"pilot"** - the person who steers a ship. This is fitting because Kubernetes steers your containerized applications across a fleet of servers.

**Fun fact:** The abbreviation "K8s" is commonly used, where "8" replaces the 8 letters between "K" and "s".

---

## Kubernetes Architecture

```
                    ┌─────────────────────────────────────────────────────────┐
                    │                      CONTROL PLANE                        │
                    │                        (Master)                         │
                    │                                                           │
                    │  ┌──────────────┐  ┌──────────────┐  ┌─────────────────┐  │
                    │  │   API Server │  │    etcd      │  │ Controller      │  │
                    │  │   (Front Door)│  │  (Database)  │  │ Manager         │  │
                    │  └──────────────┘  └──────────────┘  └─────────────────┘  │
                    │         │                                    │            │
                    │         └────────────────┬───────────────────┘            │
                    │                          │                                │
                    │                   ┌──────▼──────┐                         │
                    │                   │  Scheduler │                         │
                    │                   └────────────┘                         │
                    └─────────────────────────────────────────────────────────┘
                                            │
                          ┌─────────────────┼─────────────────┐
                          │                 │                 │
                    ┌─────▼─────┐     ┌─────▼─────┐     ┌─────▼─────┐
                    │  Worker   │     │  Worker   │     │  Worker   │
                    │   Node 1  │     │   Node 2  │     │   Node 3  │
                    │           │     │           │     │           │
                    │ ┌───────┐ │     │ ┌───────┐ │     │ ┌───────┐ │
                    │ │ Pod 1 │ │     │ │ Pod 3 │ │     │ │ Pod 5 │ │
                    │ │Pod 2  │ │     │ │Pod 4  │ │     │ │Pod 6  │ │
                    │ └───────┘ │     │ └───────┘ │     │ └───────┘ │
                    │           │     │           │     │           │
                    │ ┌───────┐ │     │ ┌───────┐ │     │ ┌───────┐ │
                    │ │kubelet│ │     │ │kubelet│ │     │ │kubelet│ │
                    │ │kube-  │ │     │ │kube-  │ │     │ │kube-  │ │
                    │ │proxy  │ │     │ │proxy  │ │     │ │proxy  │ │
                    │ └───────┘ │     │ └───────┘ │     │ └───────┘ │
                    │ ┌───────┐ │     │ ┌───────┐ │     │ ┌───────┐ │
                    │ │Container│ │     │ │Container│ │     │ │Container│ │
                    │ │Runtime │ │     │ │Runtime │ │     │ │Runtime │ │
                    │ └───────┘ │     │ └───────┘ │     │ └───────┘ │
                    └───────────┘     └───────────┘     └───────────┘
```

### Control Plane Components (Master Node)

The Control Plane is the brain of Kubernetes. It makes all the decisions about the cluster.

#### 1. API Server (kube-apiserver)
- **What it does:** Acts as the front door to the entire Kubernetes cluster
- Every command (`kubectl`) goes through the API Server first
- It validates and configures data for all objects (pods, services, deployments, etc.)
- It is the only component that talks to etcd
- **Think of it as:** The reception desk of a hotel - all requests go through it

#### 2. etcd
- **What it does:** A distributed key-value database that stores all cluster data
- Stores the entire state of the cluster: what pods exist, what nodes exist, their configurations
- Only the API Server talks directly to etcd
- **Think of it as:** The master guest book that records everything happening in the hotel

#### 3. Scheduler (kube-scheduler)
- **What it does:** Decides WHICH node a new pod should run on
- Considers factors like: resource availability, affinity rules, data locality
- It watches for new pods and assigns them to suitable nodes
- **Think of it as:** The manager who decides which room to assign to each guest

#### 4. Controller Manager (kube-controller-manager)
- **What it does:** Runs controller processes that regulate the state of the cluster
- Controllers watch the cluster and make adjustments to match desired state
- Types of controllers:
  - Node Controller: Notices when nodes go down
  - Replication Controller: Ensures correct number of pods are running
  - Endpoints Controller: Connects services to pods
  - Service Account Controller: Creates service accounts
- **Think of it as:** The housekeeping manager who ensures everything stays in order

### Worker Node Components

Worker Nodes are the machines that actually run your applications.

#### 1. kubelet
- **What it does:** An agent that runs on each node in the cluster
- It talks to the API Server and manages pods on its node
- It ensures containers are running and healthy
- It starts, stops, and restarts containers based on instructions
- **Think of it as:** The room service staff who actually tends to guest needs

#### 2. kube-proxy
- **What it does:** The network proxy that runs on each node
- Maintains network rules that allow communication to pods
- Handles routing of traffic between pods and services
- Enables service discovery and load balancing
- **Think of it as:** The concierge who directs guests to the right rooms

#### 3. Container Runtime
- **What it does:** The software that actually runs containers
- Common options: containerd, CRI-O, Docker (though Docker support is deprecated)
- Responsible for pulling images, creating containers, managing lifecycle
- Must be CRI-compatible (Container Runtime Interface)
- **Think of it as:** The actual bed and amenities in the hotel room

### What Happens When You Run `kubectl apply -f pod.yaml`?

Let's trace the journey:

```
┌──────────┐    1. Send request    ┌───────────┐    2. Validate & Store    ┌─────────┐
│ kubectl  │ ────────────────────▶ │ API Server │ ────────────────────────▶ │  etcd   │
│ (CLI)    │                       │            │                          │         │
└──────────┘                       └───────────┘                           └─────────┘
                                          │
                                          │ 3. Save desired state
                                          │
                                          ▼
                                 ┌────────────────┐
                                 │     etcd       │
                                 │ (stores config)│
                                 └────────────────┘
                                          │
                                          │ 4. Scheduler notices
                                          │    new unassigned pod
                                          ▼
                                 ┌────────────────┐
                                 │   Scheduler    │
                                 │                │
                                 └────────────────┘
                                          │
                                          │ 5. Decide which node
                                          │    should run the pod
                                          ▼
                                 ┌────────────────┐
                                 │  API Server   │
                                 │ (updates pod   │
                                 │  assignment)   │
                                 └────────────────┘
                                          │
                                          │ 6. kubelet on that node
                                          │    notices the assignment
                                          ▼
                                 ┌────────────────┐
                                 │    kubelet     │
                                 │ (creates pod   │
                                 │  using container│
                                 │  runtime)      │
                                 └────────────────┘
                                          │
                                          ▼
                                 ┌────────────────┐
                                 │   Container    │
                                 │    Runtime     │
                                 │ (runs the      │
                                 │  container)    │
                                 └────────────────┘
```

### What Happens If the API Server Goes Down?

- **kubectl commands fail** - You cannot interact with the cluster
- **Existing pods continue running** - They were already scheduled and running
- **New pods cannot be scheduled** - The scheduler can't assign new pods
- **Self-healing stops** - Failed pods won't be restarted
- **The cluster is effectively "blind"** - You can see current state but cannot make changes

**This is why production clusters need high availability for the control plane!**

### What Happens If a Worker Node Goes Down?

1. The Controller Manager (specifically Node Controller) notices the node isn't responding
2. After a timeout period (default 40 seconds), the node is marked as "Unknown" or "NotReady"
3. Pods running on that node are marked for rescheduling
4. Replication Controller/DaemonSet ensures pods are recreated on healthy nodes
5. New pods are scheduled on available nodes
6. **Self-healing in action!** The cluster recovers automatically

---

## kubectl Installation

`kubectl` is the command-line tool used to interact with Kubernetes clusters.

### Installation Methods

#### macOS
```bash
brew install kubectl
```

#### Linux (amd64)
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

#### Windows (with Chocolatey)
```bash
choco install kubernetes-cli
```

#### Windows (Manual)
1. Download the latest release from https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
2. Add the binary to your PATH
3. Verify with `kubectl version --client`

### Verification
```bash
kubectl version --client
```
Expected output: Shows kubectl version information

---

## Local Kubernetes Cluster Setup

### Option Chosen: [kind (Kubernetes in Docker)]

**Why kind?**
- Lightweight and fast to set up
- Runs Kubernetes clusters inside Docker containers
- Perfect for local development and testing
- Easy to create and destroy clusters
- Lower resource usage compared to minikube (when using VM)

### Installation

#### macOS
```bash
brew install kind
```

#### Linux
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

#### Windows
Download from: https://kind.sigs.k8s.io/docs/user/quick-start/#installation

### Creating a Cluster

```bash
kind create cluster --name devops-cluster
```

### Verification Commands
```bash
kubectl cluster-info
kubectl get nodes
```

### Alternative: minikube

If you prefer minikube, here's how to set it up:

#### Installation
```bash
# macOS
brew install minikube

# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Windows (Chocolatey)
choco install minikube
```

#### Starting a Cluster
```bash
minikube start
```

**Note:** minikube creates a single-node cluster, usually inside a VM (VirtualBox, Hyper-V, or Docker driver)

---

## Exploring Your Cluster

### Basic Cluster Information

```bash
# View cluster information
kubectl cluster-info

# List all nodes in the cluster
kubectl get nodes

# Get detailed information about a specific node
kubectl describe node <node-name>

# List all namespaces
kubectl get namespaces

# List all pods across all namespaces
kubectl get pods -A

# Get pods with extra details
kubectl get pods -A -o wide
```

### Exploring kube-system Namespace

The `kube-system` namespace contains the system pods that make Kubernetes work.

```bash
kubectl get pods -n kube-system
```

### Understanding kube-system Pods

| Pod Name | Component | Purpose |
|----------|-----------|---------|
| etcd-* | etcd | Stores all cluster state and configuration |
| kube-apiserver-* | API Server | Front door for all Kubernetes operations |
| kube-scheduler-* | Scheduler | Decides pod placement across nodes |
| kube-controller-manager-* | Controller Manager | Runs controllers that maintain desired state |
| kube-proxy-* | kube-proxy | Manages network rules and pod communication |
| coredns-* | CoreDNS | Provides DNS-based service discovery |

### What Each System Pod Does

1. **etcd**: The brain's memory - stores everything about the cluster
2. **kube-apiserver**: The brain's communication center - all requests pass through here
3. **kube-scheduler**: The decision maker - assigns pods to nodes
4. **kube-controller-manager**: The maintenance crew - keeps things running smoothly
5. **kube-proxy**: The network manager - routes traffic between pods
6. **coredns**: The phone book - helps services find each other by name

---

## Cluster Lifecycle Operations

### Deleting a Cluster
```bash
kind delete cluster --name devops-cluster
# OR for minikube:
minikube delete
```

### Recreating a Cluster
```bash
kind create cluster --name devops-cluster
# OR for minikube:
minikube start
```

### Verify Cluster Status
```bash
kubectl get nodes
```

### kubectl Context Commands

```bash
# Check which cluster kubectl is currently connected to
kubectl config current-context

# List all available contexts (clusters)
kubectl config get-contexts

# View the full kubeconfig file
kubectl config view
```

### Understanding kubeconfig

**What is kubeconfig?**
- A YAML file that contains cluster authentication information
- Defines clusters, users, and contexts
- Allows switching between multiple clusters

**Default Location:**
- Linux/macOS: `~/.kube/config`
- Windows: `%USERPROFILE%\.kube\config`

**Structure:**
```yaml
apiVersion: v1
kind: Config
clusters:
- name: devops-cluster
  cluster:
    server: https://127.0.0.1:6443
    certificate-authority-data: <base64-encoded-ca>
users:
- name: kubernetes-admin
  user:
    client-certificate-data: <base64-encoded-cert>
    client-key-data: <base64-encoded-key>
contexts:
- name: devops-cluster@kubernetes
  context:
    cluster: devops-cluster
    user: kubernetes-admin
current-context: devops-cluster
```

---

## Useful kubectl Commands Cheat Sheet

| Command | Description |
|---------|-------------|
| `kubectl get pods` | List pods in default namespace |
| `kubectl get pods -A` | List all pods in all namespaces |
| `kubectl get nodes` | List all cluster nodes |
| `kubectl get services` | List all services |
| `kubectl get deployments` | List all deployments |
| `kubectl get namespaces` | List all namespaces |
| `kubectl describe <resource> <name>` | Get detailed info about a resource |
| `kubectl apply -f <file.yaml>` | Create/update resources from file |
| `kubectl delete -f <file.yaml>` | Delete resources from file |
| `kubectl logs <pod-name>` | View pod logs |
| `kubectl exec -it <pod-name> -- /bin/bash` | Shell into a pod |
| `kubectl get nodes -o wide` | Get nodes with additional network info |
| `kubectl cluster-info` | Show cluster endpoints |
| `kubectl api-resources` | List all API resources |

---

## Key Concepts Summary

### Pod
- Smallest deployable unit in Kubernetes
- Represents a single instance of a running process
- Can contain one or more containers
- Gets its own IP address

### Node
- A worker machine (physical or virtual)
- Runs kubelet, kube-proxy, and container runtime
- Reports to the control plane

### Cluster
- A set of nodes that run containerized applications
- One node is the master (control plane)
- Multiple worker nodes run the workloads

### Namespace
- Virtual cluster backed by the same physical cluster
- Used to organize and isolate resources
- Default namespaces: default, kube-system, kube-public

---

## Screenshot Section

### kubectl get nodes Output
[Screenshot of cluster node status should appear here]

### kubectl get pods -n kube-system Output
[Screenshot of system pods should appear here]

---

## Notes and Observations

### What I Learned Today

1. **Kubernetes orchestrates containers** - It solves the scaling, high availability, and management problems that Docker alone cannot address.

2. **Control Plane is the brain** - The API Server, etcd, Scheduler, and Controller Manager work together to manage the cluster.

3. **Worker nodes do the work** - kubelet, kube-proxy, and container runtime run on each node to execute workloads.

4. **Self-healing is built-in** - Kubernetes automatically restarts failed pods, replaces nodes, and maintains desired state.

5. **kubectl is powerful** - The command-line tool provides full access to cluster operations.

### Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| kubectl not found | Add kubectl to PATH or reinstall |
| Cannot connect to cluster | Check if cluster is running with `kind get clusters` |
| Image pull errors | Check container registry access |
| Node in NotReady state | Check kubelet logs and node resources |

---

## Resources

- Official Kubernetes Documentation: https://kubernetes.io/docs/
- kubectl Reference: https://kubernetes.io/docs/reference/kubectl/
- kind Documentation: https://kind.sigs.k8s.io/
- minikube Documentation: https://minikube.sigs.k8s.io/docs/

---

## Next Steps

Now that the local cluster is set up, the next steps would be:
1. Deploy your first application to Kubernetes
2. Create pods, deployments, and services
3. Learn about Kubernetes networking
4. Explore volume management
5. Set up monitoring and logging

---

**Remember:** The best way to learn Kubernetes is by breaking things and fixing them!

**#90DaysOfDevOps** **#DevOpsKaJosh** **#TrainWithShubham**
