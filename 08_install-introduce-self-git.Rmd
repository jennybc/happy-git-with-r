# Introduce yourself to Git {#hello-git}

In the shell (Appendix \@ref(shell)):

``` bash
git config --global user.name 'Jennifer Bryan'
git config --global user.email 'jenny@stat.ubc.ca'
git config --global --list
```

substituting your name and **the email associated with your GitHub account**. 

## More about `git config`

From RStudio, go to *Tools > Shell* and tell Git your name and **GitHub email** by typing (use your own name and email):

Note: If you are on Windows, check the title bar of the shell that was opened! If you see `cmd.exe` at the end of the status bar, this is the Windows Command Prompt. If you instead see `MINGW64` at the beginning, you have successfully opened Git Bash!

Note: If you are **not** in an R Project that is version controlled with git, *Tools > Shell* will open Windows Command Prompt. If this is the case and RStudio still opens `cmd.exe`, check *Tools > Global Options > Git/SVN* and tick the box for "Use Git Bash as shell for Git projects". You may need to restart RStudio.

  * `git config --global user.name 'Jennifer Bryan'`
  
    - This does __NOT__ have to be your GitHub username, although it can be. Another good option is your actual first name and last name. Your commits will be labelled with this name, so this should be informative to potential collaborators.

  * `git config --global user.email 'jenny@stat.ubc.ca'`
  
    - This __must__ be the email that you used to sign up for GitHub.

These commands return nothing. You can check that Git understood what you typed by looking at the output of `git config --global --list`.
