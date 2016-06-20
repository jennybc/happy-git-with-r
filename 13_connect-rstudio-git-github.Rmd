# Connect RStudio to Git and GitHub

This is the big moment where we verify that RStudio can issue Git commands on your behalf. Assuming that you've gotten local Git to talk to GitHub, this means you'll also be able to pull from and push to GitHub from RStudio.

## Prerequisites

We assume the following: 

  * You've registered a free GitHub account (chapter \@ref(github-acct)).
  * You've installed/updated R and RStudio (chapter \@ref(install-r-rstudio)).
  * You've installed Git (chapter \@ref(install-git)).
  * You've introduced yourself to Git (chapter \@ref(hello-git)).
  * You've confirmed that you can push to / pull from GitHub from the command line (chapter \@ref(push-pull-github)).
  * You've cached your credentials or set up SSH keys, so you don't need to authenticate yourself to GitHub interactively *optional but highly recommended* (chapters \@ref(credential-caching) and \@ref(ssh-keys)).

## Step 1: Make a new repo on GitHub

**Do this once per new project.**

Go to <https://github.com> and make sure you are logged in.

Click green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Repository name: `myrepo` (or whatever you wish, we will delete this)  
Public  
YES Initialize this repository with a README

Click big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button. Or copy the SSH URL if you chose to set up SSH keys.

## Step 2: Clone the new GitHub repository to your computer via RStudio

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository. It will be something like this `https://github.com/jennybc/myrepo.git`.
    - Do you NOT see an option to get the Project from Version Control? Go to chapter \@ref(rstudio-see-git) for tips on how to help RStudio find Git.
  * Take charge of -- or at least notice! -- the local directory for the Project. A common rookie mistake is to have no idea where you are saving files or what your working directory is. Pay attention. Be intentional. Personally, I would do this in `~/tmp`.
  * I suggest you check "Open in new session", as that's what you'll usually do in real life.
  * Click "Create Project" to create a new directory, which will be all of these things:
    - a directory or "folder" on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project
  * **In the absence of other constraints, I suggest that all of your R projects have exactly this set-up.**

This should download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

There's a big advantage to the "Github first, then RStudio" workflow: the remote GitHub repo is now the "upstream" remote for your local repo. This is a technical but important point about Git. The practical implication is that you are now set up to push and pull. No need to fanny around setting up Git remotes on the command line or in another Git client.

## Step 2 plan B: Connect a local RStudio project to a GitHub repo

This workflow is the reverse of the above and cannot be executed from within R/RStudio. But sometimes it's necessary.

  * Create a new RStudio project: *File > New Project > New Directory > Empty Project*.
  
  * Directory name: `myrepo` (or whatever you named the GitHub repo)
  
  * Take charge of -- or at least notice! -- the local directory where this Project will live.
  
  * YES check "Create a git repository".
  
    - Do you NOT see an option to get the Project from Version Control? Go to chapter \@ref(rstudio-see-git) for tips on how to help RStudio find Git.
    
  * I suggest you check "Open in new session", as that's what you'll usually do in real life.

  * Click "Create Project" to create a new directory, which will be all of these things:
    - a directory or "folder" on your computer
     - a Git repository, ~~linked to a remote GitHub repository~~ *no, tragically this is not yet true ... we deal with that next*
    - an RStudio Project
  * **In the absence of other constraints, I suggest that all of your R projects have exactly this set-up.**

  * Initiate the "upstream" or "tracking" relationship by adding a remote. Go to *Tools > [shell](git09_shell.html)* and do this, substituting the HTTPS or SSH URL for **your GitHub repo**, according to your setup:

    ``` shell
    git remote add origin https://github.com/jennybc/myrepo.git
    ```
    
  * Download all the files from the online GitHub repository (possibly just `README.md`, at this point).
  
    ``` shell
    git pull origin master
    ```

  * Cement the tracking relationship between your GitHub repository and the local repo by pushing and setting the "upstream" remote:
  
    ``` shell
    git push -u origin master
    ```

It is possible you will be challenged for username and password here, but that means you should read up on caching your credentials (chapter \@ref(credential-caching)) or settting up SSH keys (chapter \@ref(ssh-keys)) so this stops happening.

## Step 3: Make local changes, save, commit

**Do this every time you finish a valuable chunk of work, probably many times a day.**

From RStudio, modify the `README.md` file, e.g., by adding the line "This is a line from RStudio". Save your changes.

Commit these changes to your local repo. How?

From RStudio:

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for any files whose existence or modifications you want to commit.
    - To see more detail on what's changed in file since the last commit, click on "Diff" for a Git pop-up
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message"
  * Click "Commit"

## Step 4: Push your local changes online to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work in your local Git repository, but the changes are not online yet.

This will seem counterintuitive, but first let's stop and pull from GitHub.

 Why? Establish this habit for the future! If you make changes to the repo in the browser or from another machine or (one day) a collaborator has pushed, you will be happier if you pull those changes in before you attempt to push.
  
Click the blue "Pull" button in the "Git" tab in RStudio. I doubt anything will happen, i.e. you'll get the message "Already up-to-date." This is just to establish a habit.

Click the green "Push" button to send your local changes to GitHub. You should see some message along these lines.

``` sh
[master dc671f0] blah
 3 files changed, 22 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 myrepo.Rproj
```

## The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending on where you did it, but get local and remote "synced up". Repeat.

## What if this doesn't work?

Some people, at least under the severe time pressure of a live workshop, may not have success using Git and GitHub from RStudio. This is rare but happens and we can generally sort this out later. In the meantime, you can make commits and pulls/pushes using Git commands in the shell or with one of the other Git clients recommended in chapter \@ref(git-client). The use of Git and GitHub from within RStudio is just a convenience, but one worth exploiting.
