# Pull, but you have local work {#pull-tricky}

Problem: You want to pull changes from upstream, but you have done some new work locally since the last time you pulled. This often comes up because what you actually want to do is *push*, but first you must incorporate the upstream changes.

For the sake of simplicity, assume we're dealing with the `master` branch and the upstream remote is called `origin`.

Recent commit history of `origin/master`:

``` sh
A--B--C
```

Recent commit history of the local `master` branch:

``` sh
A--B--D
```

or maybe

``` sh
A--B--(uncommitted changes)
```

Your goal: get commit `C` into your local branch, while retaining the work in commit `D` or your uncommitted changes.

  * Local state is `A--B--(uncommitted changes)`: You could use `git stash`. Or you could just make a commit to simplify your life (see next scenario).
  * Local state is `A--B--D`: You can get to `A--B--D--C` or `A--B--(something that includes C and D)`.
  * Local state is `A--B--D--(uncommitted changes)`: You could just make a commit -- a new one or amend `D` -- to simplify your life (go back previous scenario).

## Local work is uncommitted

Local state is `A--B--(uncommitted changes)`.

### Happy simple cases

There are two happy scenarios, in which `git pull` will still "just work":

  * You've introduced completely new files that don't exist in the remote branch and, therefore, cannot possibly have conflicting changes. You're in luck! You can just `git pull`.
  * The files affected by your local work have ZERO overlap with the files affected by the changes you need to pull from the remote. You're also in luck! You can just `git pull`.
  
Summary of these happy `git pull` scenarios:

``` sh
      Remote: A--B--C

Local before 'git pull': A--B--(uncommitted changes)
 Local after 'git pull': A--B--C--(uncommitted changes)
```
  
### `git stash` works sometimes

If your changes affect a file (`foo.R` in the example below) that has also been changed in commit `C`, you cannot `git pull`. You can try, but you will fail and it will look something like this:

```
jenny@2015-mbp ethel $ git pull
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 1 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From github.com:jennybc/ethel
   db046b4..2d33a6f  master     -> origin/master
Updating db046b4..2d33a6f
error: Your local changes to the following files would be overwritten by merge:
        foo.R
Please commit your changes or stash them before you merge.
Aborting
```

Now what? First, you must safeguard your local changes by either stashing or committing them.

I am not a big fan of `git stash`; I think it's usually better to take every possible chance to solidify your skills around core concepts and operations, e.g., make a commit, possibly in a branch. But I will admit this might be the most appropriate situation for using `git stash`.

`git stash` is a way to temporarily store some changes to get them out of the way. Now you can do something else, without a lot of fuss. In our case, "do something else" is to get the upstream changes with a nice, simple `git pull`. Then you reapply and delete the stash and pick up where you left off.

For more details about stashing, I recommend the coverage in the "Filesystem interactions" chapter of Git in Practice ([book website](https://gitinpractice.com) or [read on GitHub](https://github.com/GitInPractice/GitInPractice#readme)).

Here's the best case scenario for "stash, pull, unstash" in the example above (FYI: as a policy, I associate a message with a stash, because one of my main objections is how quickly stashes become an unmanageable vat of unlabelled mystery meat):

```
jenny@2015-mbp ethel $ git stash save
Saved working directory and index state WIP on master: db046b4 Merge branch 'master'of github.com:jennybc/ethel
jenny@2015-mbp ethel $ git pull
Updating db046b4..2d33a6f
Fast-forward
 foo.R | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
jenny@2015-mbp ethel $ git stash pop
Auto-merging foo.R
On branch master
Your branch is up-to-date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   foo.R

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (012c4dcd3a4c3af6757c4c3ca99a9eaeff1eb2a4)
```

That is what success looks like. You've achieved this:

``` sh
      Remote: A--B--C

Local before: A--B--(uncommitted changes)
 Local after: A--B--C--(uncommitted changes)
```

### `git stash` with conflicts

If your local changes have some overlap with changes you are pulling, you will, instead get a merge conflict from `git stash pop`. Then you have more work to do. In this case, you have gained nothing by using `git stash` in the first place, which explains my general lack of enthusiasm for `git stash`.

Here how to execute the `git stash` workflow in our example, in the face of conflicts (based on [this Stack Overflow answer](https://stackoverflow.com/a/27382210/2825349)):

```
jenny@2015-mbp ethel $ git stash save
Saved working directory and index state WIP on master: 2d33a6f Back to 5

jenny@2015-mbp ethel $ git pull
Updating 2d33a6f..1eddf9e
Fast-forward
 foo.R | 1 +
 1 file changed, 1 insertion(+)
 
jenny@2015-mbp ethel $ git stash pop
Auto-merging foo.R
CONFLICT (content): Merge conflict in foo.R

< RESOLVE THE CONFLICT MANUALLY HERE! >

jenny@2015-mbp ethel $ git reset
Unstaged changes after reset:
M       foo.R

jenny@2015-mbp ethel $ git stash drop
Dropped refs/stash@{0} (7928db50288e9b4d934803b6b451a000fd7242ed)
```

Phew, we are done. Note that we had to edit the conflicted files to resolve the problems.

We've achieved this:

``` sh
      Remote: A--B--C

Local before: A--B--(uncommitted changes)
 Local after: A--B--C--(uncommitted changes*)
```

The asterisk on `uncommitted changes*` indicates that your uncommitted changes might now reflect adjustments made when you resolved the conflicts.

## Local work is committed

Remote state is `A--B--C`.  
Local state is `A--B--D`.

### Pull (fetch and merge)

The simplest option is to fetch the commits from upstream and merge them, which is what `git pull` does. This is a good option if you're new to Git. It leads to a messier history, but if you are new-ish to Git, this is the least of your worries. Merge, be happy, and carry on.

```
jenny@2015-mbp ethel $ git pull

< YOU MIGHT BE KICKED INTO AN EDITOR HERE RE: MERGE COMMIT MESSAGE! >

Merge made by the 'recursive' strategy.
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
```

Depending on your version of Git, your config, and your use of a GUI, you might be required to confirm/edit a commit message for the merge commit.

We've achieved this:

``` sh
      Remote: A--B--C

Local before: A--B--D
 Local after: A--B--D--(merge commit)
                  \_C_/
```

TO ADD: what about merge conflict

### Pull and rebase

This creates a nicer history than `git pull` when integrating local and remote commits. It avoids a merge commit, so the history is less cluttered and is linear.

```
jenny@2015-mbp ethel $ git pull --rebase
First, rewinding head to replay your work on top of it...
Applying: Take max
```

We've achieved this:

``` sh
      Remote: A--B--C

Local before: A--B--D
 Local after: A--B--C--D
```

TO ADD: what about merge conflict

## Other scenarios

There are actually more ways to handle this situation, that you can explore as you gain experience and start to care more about the history. We sketch some ideas here.

### Use a temporary branch for local work

Recall:  
Remote state is `A--B--C`.  
Local state is `A--B--(uncommitted changes)`.

This is an alternative to the stash workflow that has the advantage of giving you practice with Git techniques that are more generally useful. It also leads to a nice history.

Create a new, temporary branch and commit your uncommitted changes there. Checkout `master` and `git pull` to get changes from upstream. You now need to recover the work from the commit in the temporary branch. Options:

  * Merge the temporary branch into `master`.
  * Cherry pick the commit from the temporary branch into `master`.
  
In either case, it is still possible you will need to deal with merge conflicts.

In either case, if you felt forced you to commit before you were ready, you can either do a mixed reset to "uncommit" but keep the changes on `master` or keep amending until you are satisfied with the commit.

## Some local work is committed, some is not

This is an awkward hybrid situation that can be handled with a combination of strategies seen above: make a pragmatic commit on `master` or a temporary branch. Integrate the upstream and local changes in `master`. If you aren't happy with the final pragmatic commit (which only exists locally), reset or amend until you are.
