# Resetting {#reset}

Practice recovering from mistakes.

Use a repository you've create earlier in tutorial for this. It only needs to be local, i.e. this does not involve GitHub.

If it's not your most recent commit, seriously consider just letting that go. Just. Let. It. Go.

So you want to undo the last commit?

If "YES UNDO IT COMPLETELY": `git reset --hard HEAD^`. You will lose any changes that were not reflected in the commit-before-last!

If "YES undo the commit, but leave the files in that state (but unstaged)": `git reset HEAD^`. Your files will stay the same but the commit will be undone and nothing will be staged.

If "YES go right back to the moment before I committed": `git reset --soft HEAD^`. Your files will stay the same but the commit will be undone. Even your staged changes will be restored.

**If you just want to fiddle the most recent commit or its message, you can amend it. You can do this from RStudio!**

  * Make the change you want and amend the commit.
  * Do you only want to change the commit message?
    - Make another small change. Surely you have a typo somewhere? Amend the commit, which gives you the chance to edit the message

To amend from the command line, using an editor to create the message:

``` bash
git commit --amend
```

To amend from the command line, providing the new message:

``` bash
git commit --amend -m "New commit message"
```

Git Reset Demystified:

<https://git-scm.com/blog>
