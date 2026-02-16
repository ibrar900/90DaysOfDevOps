# Update the System Packages
sudo apt update && sudo apt upgrade -y # update the system packages

# Install Git
sudo apt install git -y # install git
git --version # check git version

# Configure Git
git config --global user.name "Your Name" # set the user name
git config --global user.email "[EMAIL_ADDRESS]" # set the user email
git config --global user.name # show the user name
git config --global user.email # show the user email

# Initialize a New Git Repository
git init # initialize a new git repository
git clone URL # clone a repository from a remote location to local
git add # add file to the staging area
git add . or git add * # add all files to the staging area
git reset file # reset the file to the last commit
git reset --hard # reset the repository to the last commit
git rm --catche # remove file from the staging area
git status # show the status of the repository
git log # show the commit history
git branch # show the branches
git commit -m "comment" # commit the changes
git revert commit-id # revert the commit
git reset commit-id # reset the repository to the commit-id
git push origin "branch name" # push the changes to the remote repository
git push origin master # push the changes to the remote repository(master=local folder)
git pull origin main # pull the changes from the remote repository(main=github remote folder)
git remote -v # show the remote repositories
git remote set-url origin urllink of HTTP/SSH
git checkout -b "branch name" # create a new branch and switch to it
git branch # show the branches
git switch "branch name" # switch to a branch
git checkout "branch name" # switch to a branch
git branch -d "branch name" # delete a branch
git branch -D "branch name" # delete a branch
git branch -a # show all the branches
git branch -r # show the remote branches
git branch -v # show the branches with the last commit message
git branch -vv # show the branches with the last commit message and the remote branch
git branch -vvv # show the branches with the last commit message and the remote branch and the upstream branch
