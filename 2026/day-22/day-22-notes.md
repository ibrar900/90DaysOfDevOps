Day 22- Introduction to Git: My first repository
''''
Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

image
''''
Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

image
'''
Task 3: Crrate git-commands.md file and write all git commands in it
....

Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. Check the commit history

image
'''

Task 5: Make More Changes and Build History
1. Edit git-commands.md -- add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different message
4. Repeat this process atleast 3 times so you have multiple commits in your history
5. View the full history in a compact format

image
'''
Task 6: understand the Git workflow
....
1. what is the difference between git add and git commit ?
    . git add is used to add the files to the staging area
    . git commit is used to commit the changes to the repository with history and id
2. what is the difference between git init and git clone ?
    . git init is used to initialize a new repository
    . git clone is used to clone a repository from a remote location
3. what is the difference between git branch and git checkout ?
    . git branch is used to create a new branch
    . git checkout is used to switch to a branch    
4. what does staging area do ? why doesn't Git commit directly to the repository ?
    . staging area stores files before commiting either i can unsatage the files and make changes or i can commit the files. where mistakes can change and revert back at staging area. multiple files can be added to the staging area and then committed.
5. What information does git log show ?
    . git log is used to show the commit history
6. what is ./git folder and what happens if i delete it ?
    . ./git folder is the hidden folder that stores the repository history, configuration, and objects.
    . if i delete it, the repository will be deleted and i will have to initialize it again. it is laike normal directory.
7. What is the difference between a working directory and a staging area and repository ?
    . working directory - it is the project directory where you write files, changes are stored, Not commited.
    . staging area - it is the place where the files are stored for commiting either unsatge for changes
    . repository - it is the remote directory where the branch files are stored after commiting  with history and id