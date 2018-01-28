# Existing project, GitHub last {#existing-github-last}

An explicit workflow for connecting an existing local R project to GitHub, when for some reason you cannot or don't want to do a "GitHub first" workflow (see chapters \@ref(new-github-first) and \@ref(existing-github-first)).

When does this come up? Example: it's an existing project that is already a Git repo with a history you care about. Then you have to do this properly.

This is less desirable for a novice because there are more opportunities to get confused and make a mistake. RStudio and the [usethis](https://cran.r-project.org/package=usethis) package are gradually making this easier, so you can avoid working with Git in the shell. But command line Git remains a viable option. All are covered below.

## Make or verify an RStudio Project

We assume you've got your existing R project isolated in a directory on your computer.

If it's not already an RStudio Project, make it so:

  * If you use the [usethis](https://cran.r-project.org/package=usethis) package, set the existing directory as the current project with `proj_set()`, then do `usethis::use_rstudio()`.
  * Within RStudio you can do: *File > New Project > Existing Directory* and, if you wish, "Open in new session".

If your project is already an RStudio Project, launch it.

## Make or verify a Git repo

You should be in RStudio now, in your project.

Is it already a Git repository? The presence of the Git pane should tip you off. If yes, you're done.

If not, you have several options:

  * If you have the [usethis](https://cran.r-project.org/package=usethis) package, call `usethis::use_git()`.
  * In RStudio, go to *Tools > Project Options ... > Git/SVN*. Under "Version control system", select "Git". Confirm New Git Repository? Yes!
  * In the shell, in Project's directory, do `git init`.

If you used RStudio or usethis, the Project should re-launch in RStudio. Do that yourself if you did `git init`. RStudio should now have a Git pane.

## Stage and commit

If your local project was already a Git repo and was up-to-date, move on. Otherwise, you probably need to stage and commit.

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for all files you want to commit.
    - Default: stage everything
    - When to do otherwise: this will all go to GitHub. So consider if that is appropriate for each file. **You can absolutely keep a file locally, without committing it to the Git repo and sending to GitHub**. Just let it sit there in your Git pane, without being staged. No harm will be done. If this is a long-term situation, list the file in `.gitignore`.
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message".
  * Click "Commit"

## Make and connect a GitHub repo, option 1

If you use the [usethis](https://cran.r-project.org/package=usethis) package AND you have configured a GitHub Personal Access Token (PAT), do this in R:

    usethis::use_github()
    
This will create a new repo on GitHub, add it as a remote, set up a tracking branch, and open it in your browser. Read the `use_github()` help to learn about its arguments and advice on configuring a PAT.

## Make and connect a GitHub repo, option 2

### Make a new repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click the green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Pick a repository name -- it should probably match the name of your local Project and directory. Why confuse yourself?

Public or private, as appropriate and possible  
DO NOT initialize this repository with a README.

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button. Or copy the SSH URL if you chose to set up SSH keys.

### Connect local repo to GitHub repo

You can do this in the shell or, with recent versions of RStudio, via RStudio.

### In RStudio

Click on the "two purple boxes and a white square" in the Git pane. Click "Add remote". Paste the URL here and pick a remote name, almost certainly `origin`. Now "Add".

We should be back in the "New Branch" dialog (if not, click on the "two purple boxes and a white square" in the Git pane again). I assume you're on the `master` branch want it to track `master` on GitHub. Enter `master` as the branch name and make sure "Sync branch with remote" is checked. Click "Create" (yes, even though the branch already exists). In the next dialog, choose "overwrite".

### In the shell

In a shell, do this, substituting your URL:

        git remote add origin https://github.com/jennybc/myrepo.git

Push and cement the tracking relationship between your local `master` branch and `master` on GitHub:
  
        git push --set-upstream origin master

## Confirm the local files propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see all the project files you committed there.

If this project already had a Git history, it should be reflected on GitHub.

## The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending on where you did it, but get local and remote "synced up". Repeat.

Note that in general (and especially in future when collaborating with other developers) you will usually need to pull changes from the remote (GitHub) before pushing the local changes you have made. For this reason, it's a good idea to try and get into the habit of pulling before you attempt to push.
