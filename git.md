# Useful info about Git & Github 

- Visit https://git-scm.com/ for more details on git commands and usages.

## Notes/considerations

- use atomic commits > commits focused on 'a single thing'. Make the commits be clear and don't 'pollute' them with lots of stuff. It then will be easier to track changes, revert, update, etc.
- from git [docs](https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?h=v2.36.1#n181) > use 'present tense imperative' when adding the message for your commit.
    - ex: 'Update method to use 2 parameters' instead of 'I updated the method to use 2 parameters'
- use the `.gitignore` file to ignore files from being tracked by git
    - useful resource: https://www.toptal.com/developers/gitignore
- what is `HEAD` from git? 
    - pointer that refers to the current 'location' in your repo
    - points to a branch reference (HEAD references a branch)
        - branch points to a commit
    - `refs/heads/` folder from within the `.git` folder will have 1 file for each of your branches. Each file will contain a reference to the last commit from that branch
    - ex: opening `refs/heads/main` will show you the last commit from the `main` branch

    ![refsHeadsMain](./resources/refs-heads-main.png)
    ![refsHeadsMainCommit](./resources/refs-heads-main-commit.png)
- there may be times (ex: when creating a new file) when switching to another branch will also 'drag' your local changes (the file added) with you
- fast-forward merge: you merge changes into a branch and that branch didn't have any other commits before the merge (you just "synced" the receiving branch with some updates)
    - this means you don't have merge conflicts that need to be resolved
- when using git & Github, it is important to create and use SSH keys when performing certain operations (e.g. push) instead of entering Github username & password each time. See more [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)
- `Remote tracking branch` > reference to the state of a branch on the remote
    - last remote commit
    - Ex: `origin/main`
    - `git branch -r` > shows remote tracking branches
    - `main`(local branch) vs `origin/main`(remote branch)
    - you can perform: `git checkout origin/main`
- Fetching:
    - download changes from remote repo but don't automatically apply them to working files
    - 'please go and get the latest info from Github but don't screw up my working directory'
- Github repos:
    - can be either public or private
    - you can add collaborators
    - use the README file as info about the repo, useful links, images, etc
    - use Markdown for the README file
    - use Gists for sharing small pieces of code
    - use Pages as a website for your work; Pages are hosted & published via Github (static webpage)
- The `feature branch workflow`:
    - use separate branches for your work
    - don't use the main branch directly 
    - involves code reviews + pull requests
- Forking:
    - creating a 'copy' of some repo 
    - helps when there is a need of greater collaboration but without involving need of access, push & other permissions or restrictions from the original repo
    - you have your own repo, as a copy of the original repo
    - you can create PRs from your fork to the original repo 
    - Ex: 
        - fork the repo
        - clone the fork
        - add upstream remote (of the original repo so you can get changes from the original repo)
        - do some work
        - push to origin (fork's origin remote)
        - open a PR (to merge into the original repo branch)
 
## GUI Clients

- GitKraken
- Tower
- Github Desktop
- Ungit
- Sourcetree

## git commands

- `git init` > create a repo at the current folder path. Will create a `.git` folder
- `remove .git` > will delete the repo
- `git log` > shows the history of commits
    - `git log --abbrev-commit` > shows the git history but uses shorther commit hash (instead of all characters from the commit's hash)
    - `git log --oneline` > shows the git history but displays only the first line from the commit message
- `git config --global [configurations]` > make changes inside the configuration file. Will apply changes for ALL local repos
    - Ex: `git config --global user.name "Cristian"` > configures/sets "Cristian" as the author's name for commit messages
    - Ex: `git config --global user.emal "myEmail@provider.com"` > configures/sets "myEmail@provider.com" as the author's email for commit messages
    - Ex: `git config --global user.name` > displays what global name was set as the author's name for commit messages
    - Ex: `git config --global core.editor "..."` > use this to set your default editor when adding messages to your commits (when you omit the `-m` parameter for `git commit`)
        - Ex: VSCode: `git config --global core.editor "code --wait"` . also pls check out [this thread](https://stackoverflow.com/questions/30024353/how-can-i-use-visual-studio-code-as-default-editor-for-git) from Stackoverflow on how to properly set this for VSCode
- `git status` > shows info about repo's current status, branch you're currently on, changed files, etc. 
    - Ex: 
        ```bash 
        On branch main
        Your branch is up to date with 'origin/main'.

        Changes not staged for commit:
            (use "git add <file>..." to update what will be committed)
            (use "git restore <file>..." to discard changes in working directory)
            modified:   git.md

        no changes added to commit (use "git add" and/or "git commit -a")
        ```
- `git add file1 file2 file3 ...` > will add the files to the staging area, preparing them for being commited
    - `git add .` > adds all changed files to the staging area
- `git commit -m "commit message"` > creates a commit with the "commit message" message. If you just run `git commit` this will open your default text editor (set for git) and prompt you to enter the commit's message
    - `git commit --ammend` > "redo" previous commit.
        - useful when you forgot to add something to a commit or when you'd like to update the commit's message
- `git branch` > shows all branches 
    - `git branch <branchName>` > create the `branchName` branch 
    - `git switch <branchName>` > switch to the `branchName` branch. Automatically tracks a remote branch
        - or `git checkout <branchName>`
    - `git switch -` > go back to the branch you were before. useful when you enter a DETACHED HEAD and want to go back
        - Ex: 
            ```bash
            git switch main // on main branch 
            git switch bugfix // on bugfix branch 
            git switch - // back on main branch
            ``` 
    - `git branch -d <branchName>` > delete the `branchName` branch 
        - for this to work, you need to be on a different branch than the one you want to delete
        - there's also a `force delete` (when the branch is not merged) > `git branch -D <branchName>`
    - `git branch -m <branchName>` > rename the current branch you're on to 'branchName'
        - you need to be checked out on the branch you want to rename
    - `git branch -v` > see extra details about branches. Ex: see last commit from that branch
- `git switch -c <branchName>` > create & switch to the `branchName` branch 
    - or `git checkout -b <branchName>`
- `git merge <branchName` 
    - merges work from `branchName` into your current branch 
    - Ex: 
        ```bash
        git switch main
        git merge bugfix
        ``` 
        - will merge changes from the `bugfix` branch into `main`
        - merge changes from a branch into your current branch 
        - need to be checked out on the 'receiving' branch and 'receive' (merge) changes from another branch
- `git diff` 
    - show changes between commits, branches, tags, etc 
    - Ex: compare staging area with working directory (working dir = changes NOT staged for next commit)
    - uses 2 files when comparing: file "a" and file "b"
    - `git diff` > will show changes NOT staged
    - `git diff --staged` or `git diff --cached` > shows staged changes; 'show me what will be included in my commit if I commit now'
    - `git diff HEAD` > show ALL changes since last commit (staged + unstaged)
    - `git diff HEAD <file1> <file2>` ... > show changes since last commit for specific file(s)
    - `git diff --staged <file1> <file2>` ... > show staged changes for specific file(s)
    - `git diff branch1..branch2` > show changes between branches. See more about ".." vs "..." [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-comparing-branches-in-pull-requests)
    - `git diff <commitHash1>..<commitHash2>` > show changes between 2 commits
- `git stash` > stash/save your changes and use them in the future
    - `git stash save` > save staged + unstaged changes
    - `git stash pop` > remove most recent stash and apply changes back to your working directory (stashed changes WILL BE DELETED)
    - `git stash apply` > same as `pop` but stashed changes are NOT deleted
    - `git stash list` > view all stashes 
    - `git stash apply stash@{2}` > apply a specific stash from the list of stashes
    - `git stash drop stash@{2}` > delete a specific stash from the list of stashes
    - `git stash clear` > remove all stashes
- `git checkout <commitHash>` > checkout (go to/use) a specific commit
    - will move to a DETACHED HEAD state
    - usually HEAD points to a branch reference (pointer to last commit from the branch)
    - 'schema': HEAD > branch > commit 
    - checking out a specific branch > detached HEAD (no more referencing a branch)
    - "re-attach" HEAD by simply switching back to a branch or create a new branch
    - Ex: 
        ```bash
        git checkout abc1235c // detached HEAD (HEAD points to `abc1235c`)
        git switch -c <branchName> // HEAD points to branchName (no longer DETACHED)
        ``` 
    - `git checkout HEAD~1` > refers to the commit before HEAD 
    - `git checkout HEAD~3` > 3 commits before HEAD 
    - `git checkout HEAD <fileName>` > reset changes from `fileName` to what they were on last commit (HEAD). Basically if you modified something in `fileName`, this will discard your changes
        - equivalent: `git checkout -- <fileName>` or `git restore <fileName>`
- `git restore` > discard changes
    - `git restore <fileName>` > discard changes made to `fileName`
    - `git restore --source HEAD~1 <fileName>` > reset fileName to 1 commit before HEAD; can even use a commit hash instead of HEAD~1
    - `git restore --staged <fileName>` > remove `fileName` from staging area (unstage a file)
- `git reset` > reset repo & commits
    - `git reset <commitHash>` > resets repo to `commitHash`; removes the commits but the changes are still present in your working dir (they are unstaged)
    - `git reset --hard <commitHash>` > resets commits + deletes changes from working dir (all changes are gone)
- `git revert <commitHash>` > same as `reset` but it will create a new commit which reverses the changes
    - Ex: - commit with message "added new text file"; > revert > "Reverts added new text file" 
- `git remote` > view remotes for a repo
    - `git remote add <name> <url>` ; add new remote
        - connect local repo with the one in the cloud
        - remote names are usually called 'origin' 
        - this makes local repo "point to" cloud repo
- `git push <remote> <branch>` > push local changes from a branch up into the Cloud
    - remote == 'where to push'
    - Ex: `git push origin main` > pushes `main` branch into `origin`
    - `git push <remote> <localBranch>:<remoteBranch>` > push `localBranch` to a remote branch with a different name (`remoteBranch`); not very usual
    - `git push -u origin main` > push and set upstream branch + track branch for future pushes 
- `git fetch <remote>` > fetch from the remote
    - Ex: `git fetch origin`
    - will update remote tracking branches
    - `git fetch <remote> <branch>`
    - fetching will also 'get' new branches that were created and you don't see them (yet) locally
- `git pull` > similar to fetch BUT it WILL update HEAD branch with the changes 
    - if you're on a branch and you 'pull' it will update your working directory
    - `git pull` == `git fetch` (get updates) + `git merge` (apply changes to your working branch)
    - `git pull <remote> <branch>`
    - pulls can have merge conflicts
    - `git pull` == `git pull origin <branchName>` (means that if you were checked out on `branchName`, running `git pull` is enough to bring in remote changes from `origin/branchName`) 
    
 
## macOS/Terminal commands 

Especially useful when interacting/using git from the Terminal

- `open .` > opens the current folder in Finder
- `ls folderName` > lists the content of folderName
- `open folderName` > opens the folderName folder inside Finder
- `touch file.txt` > creates file.txt
- `touch file1.txt file2.txt file3.txt` > creates multiple files at once
- `touch path/to/file/file.txt` > creates file.txt at the specified path: path/to/file/
- `rm fileName` > deletes fileName from current folder
- `rm -rf folderName` > deletes folderName folder (`rf` stands for `recursive` and `force`)