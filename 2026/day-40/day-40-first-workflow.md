# Day 40 – Your First GitHub Actions Workflow
## Task 1: Set Up
1. Create a new **public** GitHub repository called `github-actions-practice`
2. Clone it locally
3. Create the folder structure: `.github/workflows/`

![screenshot](structure.png)

## Task 2: Hello Workflow
Create `.github/workflows/hello.yml` with a workflow that:
1. Triggers on every `push`
2. Has one job called `greet`
3. Runs on `ubuntu-latest`
4. Has two steps:
   - Step 1: Check out the code using `actions/checkout`
   - Step 2: Print `Hello from GitHub Actions!`

Push it. Go to the **Actions** tab on GitHub and watch it run.

**Verify:** Is it green? Click into the job and read every step.
  Yes, it is green.
![screenshot](green.png)

## Task 3: understand the anatomy
on:
- defines when the workflow should (run) trigger. it listens for events push/ schedule job by default.

jobs:
- list of tasks/ steps in jobs that the workflow will execute. A workflow can have multiple jobs that can run sequentially or in parallel.

runs-on:
- specifies the type of machine to run the job on. it is ubuntu-latest/ macOS-latest/ Windows-latest.

steps:
- individual tasks that make up a job. each step runs a specific command or action.

uses:
- tells the github workflow to use prebuild actions. checkout action to clone the repository.

run:
- aloows you to run a command directly on the runner.

name: (on a step)
- gives the step a human-readable name that will be displayed in the workflow run logs. it helps to understand what the step is doing at a glance.

## Task 4: Add More Steps
Update `hello.yml` to also:
1. Print the current date and time
2. Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
3. List the files in the repo
4. Print the runner's operating system

![screeshot](hello workflow jobs steps.png)

## Task 5: Break It On Purpose
1. Add a step that runs a command that will **fail** (e.g., `exit 1` or a misspelled command)
2. Push and observe what happens in the Actions tab
3. Fix it and push again

Error: 
![screenshot](error.png)

Fix it:
![screenshot](fix.png)


Failed pipiline looks like:
 - Red X icon in Actions tab
 - message shows Failed
 - Failed job Heighlighted in red
 - Eroor message in the logs
 - click on failed job  read the errors and fix it.


- 

---