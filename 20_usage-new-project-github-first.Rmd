# (PART) Early Usage {-} 

# New project, GitHub first {#new-github-first}

We create a new Project, with the preferred "GitHub first, then RStudio" sequence. Why do we prefer this? Because this method of copying the Project from GitHub to your computer also sets up the local Git repository for immediate pulling and pushing. Under the hood, we are doing `git clone`.

You've actually done this before during set up (chapter \@ref(rstudio-git-github)). We're doing it again, *with feeling*.

## Make a repo on GitHub

**Do this once per new project.**

Go to <https://github.com> and make sure you are logged in.

Click green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Repository name: `myrepo` (or whatever you wish)  
Public  
YES Initialize this repository with a README

Click big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button. Or copy the SSH URL if you chose to set up SSH keys.

## New RStudio Project via git clone

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository. It will be something like this `https://github.com/jennybc/myrepo.git`.
  * Be intentional about where you create this Project.
  * Suggest you "Open in new session".
  * Click "Create Project" to create a new directory, which will be all of these things:
    - a directory or "folder" on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project
  * **In the absence of other constraints, I suggest that all of your R projects have exactly this set-up.**

This should download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

There's a big advantage to the "Github first, then RStudio" workflow: the remote GitHub repo is now the "upstream" remote for your local repo. This is a technical but important point about Git. The practical implication is that you are now set up to push and pull. No need to fanny around setting up Git remotes on the command line or in another Git client.

## Make local changes, save, commit

**Do this every time you finish a valuable chunk of work, probably many times a day.**

From RStudio, modify the `README.md` file, e.g., by adding the line "This is a line from RStudio". Save your changes.

Commit these changes to your local repo. How?

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for any files whose existence or modifications you want to commit.
    - To see more detail on what's changed in file since the last commit, click on "Diff" for a Git pop-up
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message", such as "Commit from RStudio".
  * Click "Commit"

## Push your local changes to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work in your local Git repository, but the changes are not online yet.

This will seem counterintuitive, but first let's stop and pull from GitHub.

Why? Establish this habit for the future! If you make changes to the repo in the browser or from another machine or (one day) a collaborator has pushed, you will be happier if you pull those changes in before you attempt to push.
  
Click the blue "Pull" button in the "Git" tab in RStudio. I doubt anything will happen, i.e. you'll get the message "Already up-to-date." This is just to establish a habit.

Click the green "Push" button to send your local changes to GitHub. You should see some message along these lines.

``` bash
[master dc671f0] blah
 3 files changed, 22 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 myrepo.Rproj
```

## Confirm the local change propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see the new "This is a line from RStudio" in the README.

If you click on "commits," you should see one with the message "Commit from RStudio".

## Make a change on GitHub

Click on README.md in the file listing on GitHub.

In the upper right corner, click on the pencil for "Edit this file".

Add a line to this file, such as "Line added from GitHub."

Edit the commit message in "Commit changes" or accept the default.

Click big green button "Commit changes."

## Pull from GitHub

Back in RStudio locally ...

Inspect your README.md. It should NOT have the line "Line added from GitHub". It should be as you left it. Verify that.

Click the blue Pull button.

Look at README.md again. You should now see the new line there.

## The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending on where you did it, but get local and remote "synced up". Repeat.
