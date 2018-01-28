# Existing project, GitHub last {#existing-github-last}

An explicit workflow for connecting an existing local R project to GitHub, when for some reason you cannot or don't want to do a "GitHub first" workflow (see chapters \@ref(new-github-first) and \@ref(existing-github-first)).

When might this come up? Maybe if it's an existing project that is also a Git repo with a history you care about? Then you have to do this properly.

This is less desirable for a novice because it involves command line Git. You can't stay within RStudio.

## Make or verify an RStudio Project

We assume you've got your existing R project isolated in a directory on your computer.

If it's not already an RStudio Project, make it so:

  * Create a new RStudio project: *File > New Project > Existing Directory*.
  * Yes: "Open in new session".

If it's already an RStudio Project, launch it.

## Make or verify a Git repo

You should be in RStudio now, in your project.

Is it already a Git repository? The presence of the Git pane should tip you off. If yes, you're done.

If not:

*Tools > Project Options ... > Git/SVN* Under Version control system, select "Git". Confirm New Git Repository? Yes!

Project should re-launch in RStudio and you should now have a Git pane.

## Stage and commit

If your local project was already a Git repo and was up-to-date, move on. Otherwise, you probably need to stage and commit.

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for all files you want to commit.
    - Default: stage it.
    - When to reconsider: this will all go to GitHub. So do consider if that is appropriate for each file. **You can absolutely keep a file locally, without committing it to the Git repo and sending to GitHub**. Just let it sit there in your Git pane, without being staged. No harm will be done. If this is a long-term situation, list the file in `.gitignore`.
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message".
  * Click "Commit"

## Make a repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click the green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Pick a repository name -- it should probably match the name of your local Project and directory. Why confuse yourself?

Public or private, as appropriate and possible  
DO NOT initialize this repository with a README.

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button. Or copy the SSH URL if you chose to set up SSH keys.

## Connect to GitHub

Add your GitHub repo as a remote on your local repo. Go to *Tools > shell* and do this, substituting the HTTPS or SSH URL for **your GitHub repo**, according to your setup:

        git remote add origin https://github.com/jennybc/myrepo.git

  * Push and cement the tracking relationship between your local `master` branch and `master` on GitHub:
  
        git push --set-upstream origin master

## Confirm the local change propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see all the project files you committed there.

If you click on "commits," you should see one with the message "init".

## The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it\* depending on where you did it, but get local and remote "synced up". Repeat.

\* Note that in general (and especially in future when collaborating with other developers) you will usually need to pull changes from the remote (GitHub) before pushing the local changes you have made. For this reason, it's a good idea to try and get into the habit of pulling before you attempt to push.
