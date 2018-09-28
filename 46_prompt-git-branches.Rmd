# Branches {#branches}

Practice creating and managing your git branches.

Branching means that you take a detour from the main stream of development and
do work without changing the main stream. It allows one or many people to work
in parallel without overwriting each other's work.

Branching in git is very lightweight, which means creating a branch and
switching between branches is nearly instantaneous. This means git encourages
workflows which create small branches for exploration or new features, often
merging them back together quickly.

## Create a new branch

You can create a new branch with `git branch`, then checkout the branch with `git checkout`

```shell
git branch issue-5
git checkout issue-5
```

However you can also use the shortcut `git checkout -b issue-5`, which does the
same as above.

Once you have switched to a branch you can commit to it as you normally would.

## Switching branches

You use `git checkout` to switch between branches.

But what do you do if you are working on a branch and need to switch,
but the work on the branch is not complete? One option is the [Git
stash](https://git-scm.com/book/en/v2/ch00/_git_stashing), but generally a
better option is to commit the current state with a temporary commit. Here I
use 'WIP' to indicate work in progress.

```shell
git commit --all -m WIP
git checkout master
```

Then when you come back to the branch and continue your work, you
need to remove the temporary commit by [resetting](#reset) your state. The
current commit's parent is given by `HEAD^`. But if this is difficult to
remember you can alternatively use `git log` to lookup the SHA value of the
previous commit.

```shell
git checkout issue-5
git reset HEAD^
```

Now your repository will be back in the state prior to your temporary commit.

## Merging a branch

Once you have done your work and commited your results to your branch you can
then switch back to the master branch to merge the branch.

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
conflict, which you can do with `git status`

```
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

In this conflict the lines between `<<<<<< HEAD:index.html` and `======` is
the content from the branch you are currently on. The lines between `=======`
and `>>>>>>> issue-5:index.html` are the branch we are merging.

To resolve the conflict edit the lines how you want it to be in the merged
result, including removing the conflict markers `<<<<<<`, `======` and
`>>>>>>`.

```html
<div id="footer">
please contact us at email.support@github.com
</div>
```

Then run `git add index.html` and `git commit` to finalize the merge.

### Bailing out

If during the merge you get confused about the state of things or make a
mistake, use `git merge --abort` to abort the merge and go back to the state
prior to runnning `git merge`. Then you can try to complete the merge again.

Git Basic Branching and Merging:

<https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging>
