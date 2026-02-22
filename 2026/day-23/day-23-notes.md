# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?
A branch in Git is a lightweight movable pointer to a commit. It allows you to diverge from the main line of development and make changes without affecting the main branch.

### 2. Why do we use branches instead of committing everything to `main`?
Branches allow us to work on features, experiments, or bug fixes in isolation. This prevents breaking the main codebase and enables parallel development, code review, and safer deployment practices.

### 3. What is `HEAD` in Git?
`HEAD` is a special pointer in Git that points to the current branch you're working on. It always points to the latest commit on that branch.

### 4. What happens to your files when you switch branches?
When you switch branches, Git updates the working directory to match the state of the branch you're switching to. If there are uncommitted changes, Git will either let you switch or ask you to stash them depending on the situation.

---

## Task 2: Branching Commands — Hands-On

### 1. List all branches in your repo
```bash
git branch -a
```

### 2. Create a new branch called `feature-1`
```bash
git branch feature-1
```

### 3. Switch to `feature-1`
```bash
git switch feature-1
```

### 4. Create a new branch and switch to it in a single command — call it `feature-2`
```bash
git switch -c feature-2
```

### 5. Try using `git switch` to move between branches — how is it different from `git checkout`?
- `git switch` is the modern way to switch branches, introduced in Git 2.23
- `git checkout` can be used for both switching branches and checking out files
- `git switch` is more explicit and safer for branch switching

### 6. Make a commit on `feature-1` that does **not** exist on `main`
```bash
echo "New feature content" > feature.txt
git add feature.txt
git commit -m "Add feature file"
```

### 7. Switch back to `main` — verify that the commit from `feature-1` is not there
```bash
git switch main
git log --oneline
```

### 8. Delete a branch you no longer need
```bash
git branch -d feature-2
```

### 9. Add all branching commands to your `git-commands.md`
```markdown
## Branching Commands

- `git branch` - List branches
- `git branch <branch-name>` - Create new branch
- `git switch <branch-name>` - Switch to branch
- `git switch -c <branch-name>` - Create and switch to new branch
- `git branch -d <branch-name>` - Delete branch
- `git branch -a` - List all branches (local and remote)
```

---

## Task 3: Push to GitHub

### 1. Create a **new repository** on GitHub (do NOT initialize it with a README)
Go to GitHub and create a new repository named `devops-git-practice` without initializing with a README.

### 2. Connect your local `devops-git-practice` repo to the GitHub remote
```bash
git remote add origin https://github.com/your-username/devops-git-practice.git
```

### 3. Push your `main` branch to GitHub
```bash
git push -u origin main
```

### 4. Push `feature-1` branch to GitHub
```bash
git push -u origin feature-1
```

### 5. Verify both branches are visible on GitHub
Check GitHub repository page to confirm both branches are present.

### 6. Answer in your notes: What is the difference between `origin` and `upstream`?
- `origin` is the remote repository that points to your forked repository
- `upstream` is the original repository that you forked from

---

## Task 4: Pull from GitHub

### 1. Make a change to a file **directly on GitHub** (use the GitHub editor)
Edit a file in your GitHub repository using the web editor.

### 2. Pull that change to your local repo
```bash
git pull origin main
```

### 3. Answer in your notes: What is the difference between `git fetch` and `git pull`?
- `git fetch` downloads changes from remote but doesn't merge them
- `git pull` downloads changes and automatically merges them into your current branch

---

## Task 5: Clone vs Fork

### 1. **Clone** any public repository from GitHub to your local machine
```bash
git clone https://github.com/username/repository-name.git
```

### 2. **Fork** the same repository on GitHub, then clone your fork
1. Go to GitHub and click "Fork" button on the repository
2. Clone your fork:
```bash
git clone https://github.com/your-username/repository-name.git
```

### 3. Answer in your notes:
#### What is the difference between clone and fork?
- `clone` creates a copy of a repository in your local machine
- `fork` creates a copy of a repository in your GitHub account

#### When would you clone vs fork?
- Clone when you want to work on your own copy of a repository
- Fork when you want to contribute to someone else's repository

#### After forking, how do you keep your fork in sync with the original repo?
Add the original repository as an upstream remote:
```bash
git remote add upstream https://github.com/original-username/repository-name.git
```
Then fetch and merge changes:
```bash
git fetch upstream
git switch main
git merge upstream/main
git push origin main
```

---

## Summary of Git Commands Used

```bash
git branch -a
git branch feature-1
git switch feature-1
git switch -c feature-2
git switch main
git branch -d feature-2
git remote add origin https://github.com/your-username/devops-git-practice.git
git push -u origin main
git push -u origin feature-1
git pull origin main
git clone https://github.com/username/repository-name.git
git remote add upstream https://github.com/original-username/repository-name.git
```

