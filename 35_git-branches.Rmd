# Branches {#branches}

Branching means that you take a detour from the main stream of development and
do work without changing the main stream. It allows one or many people to work
in parallel without overwriting each other's work.

Branching in git is very lightweight, which means creating a branch and
switching between branches is nearly instantaneous. This means git encourages
workflows which create small branches for exploration or new features, often
merging them back together quickly.

## Create a new branch

You can create a new branch with `git branch`, then checkout the branch with `git checkout`. To distinguish it from the main stream of development, presumably on `master`, we'll call this a "feature branch".

```shell
git branch issue-5
git checkout issue-5
```

You can also use the shortcut `git checkout -b issue-5` to create and checkout the branch all at once.

Once you have switched to a branch, you can commit to it as usual.

## Switching branches

You use `git checkout` to switch between branches.

But what do you do if you are working on a branch and need to switch,
but the work on the current branch is not complete? One option is the [Git
stash](https://git-scm.com/book/en/v2/ch00/_git_stashing), but generally a
better option is to safeguard the current state with a temporary commit. Here I
use "WIP" as the commit message to indicate work in progress.

```shell
git commit --all -m "WIP"
git checkout master
```

Then when you come back to the branch and continue your work, you
need to undo the temporary commit by [resetting](#reset) your state. Specifically, we want a mixed reset. This is "working directory safe", i.e. it does not affect the state of any files. But it does peel off the temporary WIP commit. Below, the reference `HEAD^` says to roll the commit state back to the parent of the current commit (`HEAD`).

```shell
git checkout issue-5
git reset HEAD^
```

If this is difficult to remember, or to roll the commit state back to a different previous state, the reference can also be given as the SHA of a specific commit, which you can see via `git log`.

## Merging a branch

Once you have done your work and committed it to the feature branch, you can switch back to `master` and merge the feature branch.

```shell
git checkout master
git merge issue-5
```

## Dealing with conflicts

Most of the time, the merge will go smoothly. However if both the branches you
are merging changed the same part of the same file you will get a merge
conflict.

```shell
git merge issue-5
# Auto-merging index.html
# CONFLICT (content): Merge conflict in index.html
# Automatic merge failed; fix conflicts and then commit the result.
```

The first thing to do is **NOT PANIC**. Merge conflicts are not the end of the
world and most are relatively small and straightforward to resolve.

The first step to solving a merge conflict is determining which files are in
conflict, which you can do with `git status`:

```shell
git status
# On branch master
# You have unmerged paths.
#   (fix conflicts and run "git commit")
# 
# Unmerged paths:
#   (use "git add <file>..." to mark resolution)
# 
#     both modified:      index.html
# 
# no changes added to commit (use "git add" and/or "git commit -a")
```

So this shows only `index.html` is unmerged and needs to be resolved. We can
then open the file to see what lines are in conflict.

```html
<<<<<<< HEAD:index.html
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
 please contact us at support@github.com
</div>
>>>>>>> issue-5:index.html
```

In this conflict, the lines between `<<<<<< HEAD:index.html` and `======` are
the content from the branch you are currently on. The lines between `=======`
and `>>>>>>> issue-5:index.html` are from the feature branch we are merging.

To resolve the conflict, edit this section until it reflects the state you want in the merged result. Pick one version or the other or create a hybrid. Also remove the conflict markers `<<<<<<`, `======` and `>>>>>>`.

```html
<div id="footer">
please contact us at email.support@github.com
</div>
```

Now run `git add index.html` and `git commit` to finalize the merge. CONFLICTS RESOLVED.

### Bailing out

If, during the merge, you get confused about the state of things or make a
mistake, use `git merge --abort` to abort the merge and go back to the state
prior to running `git merge`. Then you can try to complete the merge again.

Git Basic Branching and Merging:

<https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging>
