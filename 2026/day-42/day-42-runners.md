# Day 42 – Runners: GitHub-Hosted & Self-Hosted

### Task 1: GitHub-Hosted Runners
1. Create a workflow with 3 jobs, each on a different OS:
   - `ubuntu-latest`
   - `windows-latest`
   - `macos-latest`
2. In each job, print:
   - The OS name
   - The runner's hostname
   - The current user running the job
3. Watch all 3 run in parallel
2026\day-42\yamlfiles\github-hosted.yml

images of gitHUb Action


Writein your notes: What is GitHub-Hosted runner? Who manages it?
 - A GitHub-Hosted runner is a temperory virtual machine (VM) or container that GitHub provides to execute your workflow jobs and get destroyed after run.
 - it Spins up fresh job for each job comes with preinstalled with common tools, langauges.
 - GitHub manages entirely on Microsoft Azure infrastrecture as GitHub it is owned by MicroSoft
 
### Task 2: Explore What's Pre-installed
1. On the `ubuntu-latest` runner, run a step that prints:
   - Docker version
   - Python version
   - Node version
   - Git version
 
2026\day-42\yamlfiles\pre-installed.yml


2. Look up the GitHub docs for the full list of pre-installed software on `ubuntu-latest`

Write in your notes: Why does it matter that runners come with tools pre-installed?

 - Certain tools & langauges needs to be installed to run workflow smooth and fast, 
 - Ex- code checkout needs git
       building need docker it saves writing long setup steps & installing them.
 
### Task 3: Set Up a Self-Hosted Runner
1. Go to your GitHub repo → Settings → Actions → Runners → **New self-hosted runner**
2. Choose Linux as the OS
3. Follow the instructions to download and configure the runner on:
   - Your local machine, OR
   - A cloud VM (EC2, Utho, or any VPS)
4. Start the runner — verify it shows as **Idle** in GitHub

**Verify:** Your runner appears in the Runners list with a green dot.



### Task 4: Use Your Self-Hosted Runner
1. Create `.github/workflows/self-hosted.yml`
2. Set `runs-on: self-hosted`
3. Add steps that:
   - Print the hostname of the machine (it should be YOUR machine/VM)
   - Print the working directory
   - Create a file and verify it exists on your machine after the run
4. Trigger it and watch it run on your own hardware

**Verify:** Check your machine — is the file there? YES

2026\day-42\yamlfiles\self-hosted.yml




### Task 5: Labels
1. Add a **label** to your self-hosted runner (e.g., `my-linux-runner`)
2. Update your workflow to use `runs-on: [self-hosted, my-linux-runner]`
3. Trigger it — does it still pick up the job? YES

Write in your notes: Why are labels useful when you have multiple self-hosted runners?
 - when you have multiple self-hosted runners, labelslet you choose exactly which runner should execute a job.
 
 ### Task 6: GitHub-Hosted vs Self-Hosted
Fill this in your notes:

| | GitHub-Hosted | Self-Hosted |
|---|---|---|
| Who manages it? | GitHub | User Manage it |
| Cost | Every month 2000 mins free | user infrastrecure usage |
| Pre-installed tools | Yes(common langauges, build tools,Docker, etc..) | No(we install and maintain user) |
| Good for | Small indipendent jobs, Quick CI/ Cd setup | Production workloads, Specialized environments |
| Security concern | Controlled by GitHub- carefully handled | User Responsibilty - USer must secure the machine, path OS/tools, and PATsecrets should protect |
