# RStudio, Git, GitHub Hell {#troubleshooting}

Problems we have seen and possible solutions.

If you experience some new problem and, especially, find the corresponding solution, [we'd love to hear from you!](https://github.com/jennybc/happy-git-with-r/issues)

## I think I have installed Git but damn if I can find it

When you install Git, try to control or record where it is being installed! Make a mental or physical note of these things.

You may be able to find Git after the fact with these commands in the shell:

* `which git` (Mac, Linux, or anything running a bash shell)

* `where git` (Windows, when not in a bash shell)

It is not entirely crazy to just re-install Git, using a method that leaves it in a more conventional location, and to pay very close attention to where it's being installed. Live and learn.

## Dysfunctional PATH

I'm pretty sure that most cases of RStudio *not* automatically detecting the Git executable stem from problems with `PATH`. This is the set of directories where your computer will look for executables, such as Git (today) or `make` (later in this course). Certain methods of Git installation, especially on Windows and/or older OSes, have a higher tendency to put Git in an unconventional location or to fail to add the relevant directory to `PATH`.

How to see your `PATH`?

In the shell:

``` sh
echo $PATH
```

Take a good hard look at this. See the point above about finding your Git executable or re-installing it while you are **wide awake**. Is the host directory in your `PATH`? No? **Fix that.**

Go [here](http://www.troubleshooters.com/linux/prepostpath.htm) for instructions on what to put in your `.bash_profile` in order to add a directory to `PATH`.

## Push/Pull buttons greyed out in RStudio

Are you sure your local repository is tracking a remote repository, e.g. a GitHub repo? In a shell with working directory set to the local Git repo, enter these commands:
  
``` sh
jenny@2015-mbp myrepo $ git remote -v
origin	https://github.com/jennybc/myrepo (fetch)
origin	https://github.com/jennybc/myrepo (push)

jenny@2015-mbp myrepo $ git branch -vv
* master b8e03e3 [origin/master] line added locally
```

We want to see that fetch and push are set to remote URLs that point to the remote repo. We also want to see that your local master branch has your GitHub master branch as upstream remote.

If you discover you still need to set a remote, go to the shell and get into the working directory of the RStudio Project and Git repo of interest.

  * Initiate the "upstream" or "tracking" relationship by adding a remote. Substitute the HTTPS URL for **your GitHub repo**.

    ``` shell
    git remote add origin https://github.com/jennybc/myrepo.git
    ```
  * Download all the files from the online GitHub repository and deal with any conflicts.
  
    ``` shell
    git pull origin master
    ```

  * Cement the tracking relationship between your GitHub repository and the local repo by pushing and setting the "upstream" remote:
  
    ``` shell
    git push -u origin master
    ```

## I have no idea if my local repo and my remote repo are connected.

See the above section on "Push/Pull buttons greyed out in RStudio."

## Push fail at the RStudio level

Do you get this error in RStudio?

```
error: unable to read askpass response from 'rpostback-askpass'
```

Open the shell: *Tools > Shell*.

``` shell
git push -u origin master
```

## Push rejected, i.e. fail at the Git/GitHub level

You might have changes on the remote AND on your local repo. Just because you don't remember making any edits in the browser doesn't mean you didn't. Humor me.

Pull first. Resolve any conflicts. Then try your push again.

## RStudio is not making certain files available for staging/commiting

Do you have a space in your directory or file names? [A space in a file name is a space in your soul.](https://twitter.com/aaronquinlan/status/711593127551733761) Get rid of it.

Is your Git repo / RStudio Project inside a folder that ... eventually rolls up to Google Drive, DropBox, Microsoft OneDrive, or a network drive? If yes, I recommend you move the repo / Project into a plain old directory that lives directly on your computer and that is not managed by, e.g., Google Drive.

If you cannot deal with the two root causes identified above, then it is possible that a more powerful Git client (chapter \@ref(git-client)) will be able to cope with these situations. But I make no promises. You should also try Git operations from the command line.

## I hear you have some Git repo inside your Git repo

Do not create a Git repository inside another Git repository. Just don't.

If you have a genuine need for this, which is really rare, the proper way to do is is via [submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules).

In STAT 545, we certainly do not need to do this and when we've seen it, it's been a mistake. This has resulted in the unexpected and complete loss of the inner Git repository. To be sure, there was more going on here (cough, GitHub Desktop client), but non-standard usage of Git repos makes it much easier to make costly mistakes.
