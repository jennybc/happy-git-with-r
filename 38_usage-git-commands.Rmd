# Git commands {#usage-git-cmds}

Here's a start on the various Git commands that have been largely going on under the hood. We've tried to pick workflows that have RStudio doing this for us. But all of this can be done from the command line.

*Unless you use the [GitHub API](https://developer.github.com/v3/), most of the GitHub bits really have to be done from the browser.*

New local git repo from a repo on GitHub:

``` bash
git clone https://github.com/jennybc/happy-git-with-r.git
```

Check the remote was cloned successfully:

``` bash
git remote --verbose
```

Stage local changes, commit:

``` bash
git add foo.txt
git commit --message "A commit message"
```

Check on the state of the Git world:

``` bash
git status
git log
```

Compare versions:

``` bash
git diff
```

Add a remote to existing local repo:

``` bash
git remote add origin https://github.com/jennybc/happy-git-with-r
git remote --verbose
git remote show origin
```

Push local master to GitHub master and have local master track master on GitHub:

``` bash
git push --set-upstream origin master
## shorter form
git push -u origin master
## you only need to set upstream tracking once!
```

Regular push:

``` bash
git push 
## the above usually implies (and certainly does in our tutorial)
git push origin master
## git push [remote-name] [branch-name]
```

Pull commits from GitHub:

``` bash
git pull
```

Pull commits and don't let it put you in a merge conflict pickle:

``` bash
git pull --ff-only
```

Fetch commits

``` bash
git fetch
```

Switch to a branch

``` bash
git checkout [branch-name]
```

Checking remote and branch tracking

``` bash
git remote -v
git branch -vv
```
