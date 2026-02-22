# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

### 1. Create a new branch `feature-login` from `main`, add a couple of commits to it
```bash
git switch -c feature-login
echo "Login feature implementation" > login.txt
git add login.txt
git commit -m "Add login feature file"
echo "Login validation logic" >> login.txt
git commit -m "Add login validation"
```

### 2. Switch back to `main` and merge `feature-login` into `main`
```bash
git switch main
git merge feature-login
```

### 3. Observe the merge — did Git do a **fast-forward** merge or a **merge commit**?
Since `feature-login` was created from the current `main` commit, Git performed a **fast-forward** merge, meaning it simply moved the `main` pointer forward without creating a new merge commit.

### 4. Create another branch `feature-signup`, add commits to it — but also add a commit to `main` before merging
```bash
git switch -c feature-signup
echo "Signup feature implementation" > signup.txt
git add signup.txt
git commit -m "Add signup feature file"
git switch main
echo "Main branch update" > main-update.txt
git add main-update.txt
git commit -m "Update main branch"
```

### 5. Merge `feature-signup` into `main` — what happens this time?
```bash
git switch main
git merge feature-signup
```

This time Git created a **merge commit** because there were commits in both branches that weren't directly related.

### 6. Answer in your notes:

#### What is a fast-forward merge?
A fast-forward merge occurs when the branch being merged is a direct descendant of the current branch. Git simply moves the pointer forward without creating a merge commit.

#### When does Git create a merge commit instead?
Git creates a merge commit when there are commits in both branches that are not directly related (i.e., the branches have diverged).

#### What is a merge conflict?
A merge conflict occurs when Git cannot automatically resolve differences in the same file between branches. To create one intentionally:
```bash
git switch feature-login
echo "This line will cause conflict" > conflict.txt
git add conflict.txt
git commit -m "Add conflicting line"
git switch main
echo "This line will cause conflict" > conflict.txt
git add conflict.txt
git commit -m "Add conflicting line on main"
git switch feature-login
git merge main
# This will result in a merge conflict
```

---

## Task 2: Git Rebase — Hands-On

### 1. Create a branch `feature-dashboard` from `main`, add 2-3 commits
```bash
git switch -c feature-dashboard
echo "Dashboard feature" > dashboard.txt
git add dashboard.txt
git commit -m "Add dashboard feature"
echo "Dashboard styling" >> dashboard.txt
git commit -m "Add dashboard styling"
echo "Dashboard functionality" >> dashboard.txt
git commit -m "Add dashboard functionality"
```

### 2. While on `main`, add a new commit (so `main` moves ahead)
```bash
git switch main
echo "Main update" > main-update.txt
git add main-update.txt
git commit -m "Update main with new feature"
```

### 3. Switch to `feature-dashboard` and rebase it onto `main`
```bash
git switch feature-dashboard
git rebase main
```

### 4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?
```bash
git log --oneline --graph --all
```

The history will show a clean, linear history where the commits from `feature-dashboard` appear after the latest `main` commits, rather than creating a merge commit.

### 5. Answer in your notes:

#### What does rebase actually do to your commits?
Rebase takes the commits from your current branch and reapplies them on top of another branch's base commit, effectively rewriting history.

#### How is the history different from a merge?
Rebase creates a linear history, while merge creates a branching history with merge commits.

#### Why should you **never rebase commits that have been pushed and shared** with others?
Rebasing rewrites commit history, which would cause problems for others who have based their work on those commits.

#### When would you use rebase vs merge?
Use rebase for cleaning up local commits before sharing, and use merge for integrating changes from shared branches.

---

## Task 3: Squash Commit vs Merge Commit

### 1. Create a branch `feature-profile`, add 4-5 small commits (typo fix, formatting, etc.)
```bash
git switch -c feature-profile
echo "Profile feature" > profile.txt
git add profile.txt
git commit -m "Add profile feature"
echo "Fix typo" >> profile.txt
git commit -m "Fix typo in profile"
echo "Format code" >> profile.txt
git commit -m "Format profile code"
echo "Add comments" >> profile.txt
git commit -m "Add comments to profile"
echo "Update documentation" >> profile.txt
git commit -m "Update profile documentation"
```

### 2. Merge it into `main` using `--squash` — what happens?
```bash
git switch main
git merge feature-profile --squash
git commit -m "Squash merge of profile feature"
```

### 3. Check `git log` — how many commits were added to `main`?
Only **one** commit was added to `main` (the squashed commit).

### 4. Create another branch `feature-settings`, add a few commits
```bash
git switch -c feature-settings
echo "Settings feature" > settings.txt
git add settings.txt
git commit -m "Add settings feature"
echo "Add settings validation" >> settings.txt
git commit -m "Add settings validation"
```

### 5. Merge it into `main` **without** `--squash` (regular merge) — compare the history
```bash
git switch main
git merge feature-settings
```

### 6. Answer in your notes:

#### What does squash merging do?
Squash merging combines all commits from a branch into a single commit before merging it into the target branch.

#### When would you use squash merge vs regular merge?
Use squash merge when you want to keep a clean history with fewer commits, especially for feature branches with many small commits.

#### What is the trade-off of squashing?
The trade-off is losing individual commit history, which makes it harder to understand the evolution of changes.

---

## Task 4: Git Stash — Hands-On

### 1. Start making changes to a file but **do not commit**
```bash
echo "Work in progress" > work.txt
echo "More work" >> work.txt
# Don't commit yet
```

### 2. Now imagine you need to urgently switch to another branch — try switching. What happens?
```bash
git switch main
# This will show an error about uncommitted changes
```

### 3. Use `git stash` to save your work-in-progress
```bash
git stash
# Or with a message:
git stash push -m "Work in progress on main"
```

### 4. Switch to another branch, do some work, switch back
```bash
git switch feature-login
echo "New work on feature" > feature.txt
git add feature.txt
git commit -m "Add feature work"
git switch main
```

### 5. Apply your stashed changes using `git stash pop`
```bash
git stash pop
```

### 6. Try stashing multiple times and list all stashes
```bash
git stash push -m "First stash"
git stash push -m "Second stash"
git stash list
```

### 7. Try applying a specific stash from the list
```bash
git stash apply stash@{1}
```

### 8. Answer in your notes:

#### What is the difference between `git stash pop` and `git stash apply`?
- `git stash pop` applies the stash and removes it from the stash list
- `git stash apply` applies the stash but keeps it in the stash list

#### When would you use stash in a real-world workflow?
Stash is useful when you need to quickly switch branches to fix an urgent issue, or when you want to test something without committing incomplete work.

---

## Task 5: Cherry Picking

### 1. Create a branch `feature-hotfix`, make 3 commits with different changes
```bash
git switch -c feature-hotfix
echo "Hotfix 1" > hotfix1.txt
git add hotfix1.txt
git commit -m "Hotfix 1"
echo "Hotfix 2" > hotfix2.txt
git add hotfix2.txt
git commit -m "Hotfix 2"
echo "Hotfix 3" > hotfix3.txt
git add hotfix3.txt
git commit -m "Hotfix 3"
```

### 2. Switch to `main`
```bash
git switch main
```

### 3. Cherry-pick **only the second commit** from `feature-hotfix` onto `main`
```bash
git cherry-pick <commit-hash-of-hotfix2>
# Find the commit hash first:
git log --oneline
# Then cherry-pick using the specific commit hash
```

### 4. Verify with `git log` that only that one commit was applied
```bash
git log --oneline
```

### 5. Answer in your notes:

#### What does cherry-pick do?
Cherry-pick applies the changes from a specific commit to the current branch, allowing you to selectively pick commits from other branches.

#### When would you use cherry-pick in a real project?
Use cherry-pick when you need to apply specific fixes or features from one branch to another without merging the entire branch.

#### What can go wrong with cherry-picking?
- Conflicts can occur if the same lines were modified
- The commit might not apply cleanly if dependencies are missing
- It can create duplicate commits if not careful with history

---

## Summary of Git Commands Used

```bash
git switch -c feature-login
git merge feature-login
git switch -c feature-signup
git switch main
git merge feature-signup
git switch -c feature-dashboard
git switch main
git rebase main
git switch -c feature-profile
git merge feature-profile --squash
git switch -c feature-settings
git switch main
git merge feature-settings
git stash
git stash push -m "description"
git stash list
git stash apply stash@{1}
git switch -c feature-hotfix
git cherry-pick <commit-hash>
```

## Git Commands Update for `git-commands.md`

```markdown
## Advanced Git Commands

### Merge
- `git merge <branch-name>` - Merge branch into current branch
- `git merge <branch-name> --squash` - Squash merge branch into current branch

### Rebase
- `git rebase <branch-name>` - Rebase current branch onto another branch

### Stash
- `git stash` - Save changes to stash
- `git stash pop` - Apply and remove latest stash
- `git stash apply stash@{n}` - Apply specific stash
- `git stash list` - List all stashes
- `git stash push -m "message"` - Stash with message

### Cherry Pick
- `git cherry-pick <commit-hash>` - Apply specific commit to current branch

### History Visualization
- `git log --oneline --graph --all` - Visualize complete history
```

**End of Day 24 Notes**  
This completes the advanced Git operations including merge, rebase, stash, and cherry-pick. These commands are essential for managing complex Git workflows and maintaining clean, organized repositories.