Introduction to Git: My Forst Repository
''''
### Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

```bash
# Verify Git is installed
git --version

# Set up your Git identity
git config --global user.name "Your Name"
git config --global user.email "[EMAIL_ADDRESS]"

# Verify your configuration
git config --global user.name
git config --global user.email
```

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

```bash
# Create a new folder
mkdir devops-git-practice

# Initialize it as a Git repository
git init

# Check the status
git status

# Explore the hidden .git/ directory
ls -a
```

### Task 3: Create Your Git Commands Reference
1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
3. For each command, write:
   - What it does (1 line)
   - An example of how to use it

```bash
# Create a new file
touch git-commands.md

# Add the Git commands you've used so far
git add git-commands.md

# Commit with a meaningful message
git commit -m "Add Git commands reference"

# View your commit history
git log
```

### Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history

```bash
# Stage your file
git add git-commands.md

# Check what's staged
git status

# Commit with a meaningful message
git commit -m "Add Git commands reference"

# View your commit history
git log
```

### Task 5: Make More Changes and Build History
1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format

```bash
# Edit git-commands.md
# Add more commands as you discover them

# Check what changed since your last commit
git diff

# Stage and commit again with a different, descriptive message
git add git-commands.md
git commit -m "Add Git commands reference"

# View the full history in a compact format
git log --oneline
``` 

### Task 6: Understand the Git Workflow
Answer these questions in your own words (add them to a `day-22-notes.md` file):
1. What is the difference between `git add` and `git commit`?
2. What does the **staging area** do? Why doesn't Git just commit directly?
3. What information does `git log` show you?
4. What is the `.git/` folder and what happens if you delete it?
5. What is the difference between a **working directory**, **staging area**, and **repository**?

```bash
# Create a new file
touch day-22-notes.md

# Add the answers to the questions
# Write your answers in your own words

# Stage and commit the file
git add day-22-notes.md
git commit -m "Add Git commands reference"

# View your commit history
git log --oneline
``` 

### Task 7: Ongoing Task
**Keep updating `git-commands.md` every day** as you learn new Git commands in the upcoming days. This will become your personal Git reference. Maintain a clean commit history — one commit per update with a clear message.

```bash
# Edit git-commands.md
# Add more commands as you discover them

# Check what changed since your last commit
git diff

# Stage and commit again with a different, descriptive message
git add git-commands.md
git commit -m "Add Git commands reference"

# View the full history in a compact format
git log --oneline
``` 

### Task 8: Hints
- All you need today are about 8-10 Git commands — Google them, try them, break things
- Read what `git status` tells you — it's your best friend
- Use `man git-<command>` or `git <command> --help` to explore

```bash
# Explore Git commands
man git
git --help
git <command> --help
``` 

### Task 9: Submission
1. Share a screenshot of your `git log --oneline` output showing multiple commits
2. Add your `day-22-notes.md` to `2026/day-22/`
3. Commit and push to your fork
4. Add your submission for Community Builder of the week on discord

```bash
# Share a screenshot of your git log --oneline output
# Add your day-22-notes.md to 2026/day-22/
# Commit and push to your fork
git add day-22-notes.md
git commit -m "Add Git commands reference"
git push
``` 

### Task 10: Learn in Public
Share your first Git repo and commit history on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**

