# Introduce yourself to Git {#hello-git}

In the shell (Appendix \@ref(shell)):

``` bash
git config --global user.name 'Jennifer Bryan'
git config --global user.email 'jenny@stat.ubc.ca'
git config --global --list
```

substituting your name and **the email associated with your GitHub account**. 

## More about `git config`

An easy way to get into a shell from RStudio is *Tools > Terminal* or *Tools > Shell*. More about the shell in the Appendix \@ref(shell).

Special Windows gotchas: If you are struggling on Windows, consider there are different types of shell and you might be in the wrong one. Short version: you want to see `MSYS` or `MINGW64` in the status bar, not `cmd.exe`. Read more in [the Appendix](#windows-shell-hell).

What user name should you give to Git? This does not have to be your GitHub username, although it can be. Another good option is your actual first name and last name. Your commits will be labelled with this name, so this should be informative to potential collaborators.

What email should you give to Git? This __must__ be the email associated with your GitHub account.

These commands return nothing. You can check that Git understood what you typed by looking at the output of `git config --global --list`.

Another Git option that many people eventually configure is the editor. At some point, you will fail to give Git what it wants in terms of a commit message and it will kick you into an editor. This can be distressing, if it's not your editor of choice and you don't even know how to save and quit. You can enforce your will with something along these lines:

``` bash
git config --global core.editor 'emacs'
```

Substitute your preferred editor for `emacs` here.
