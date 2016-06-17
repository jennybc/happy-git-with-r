# Why Git? Why GitHub?

Data analysts can use the [Git version control system](https://git-scm.com) to manage a motley assortment of project files in a sane way (e.g., data, code, reports, etc.). This has benefits for the solo analyst and, especially, for anyone who wants to communicate and collaborate with others. Git helps you organize your project over time and across different people and computers. Hosting services like [GitHub](https://github.com), [Bitbucket](https://bitbucket.org), and [GitLab](https://about.gitlab.com) provide a home for your Git-based projects on the internet. A remote host like GitHub is critical for making your projects available for others to read or, perhaps, modify.

What's special about using R and Git(Hub)?

  * the active R package development community on GitHub
  * workflows for R scripts and [R Markdown](http://rmarkdown.rstudio.com) files that make it easy to share source and rendered results on GitHub
  * Git- and GitHub-related features of the [RStudio IDE](https://www.rstudio.com/products/rstudio-desktop/)

We target [GitHub](https://github.com) -- not [Bitbucket](https://bitbucket.org) or [GitLab](https://about.gitlab.com) -- for the sake of specificity. However, all the big-picture principles and even some mechanics will carry over to these alternative hosting platforms.

## Audience and pre-reqs

The target audience for this site is someone who analyzes data, probably with R, though much of the content may be useful to analysts using other languages. While R package development with Git(Hub) is absolutely in scope, it's not an explicit focus or requirement.

The site is aimed at intermediate to advanced R users, who are comfortable writing R scripts and managing R projects. You should have a good grasp of files and directories and be generally knowledgeable about where things live on your computer.

Although we will show alternatives for most Git operations, we will inevitably spend some time in the shell and we assume some prior experience. For example, you should know how to open up a shell, navigate to a certain directory, and list the files there. You should be comfortable using shell commands to view/move/rename files and to work with your command history.

## What this is NOT

We aim to teach novices about Git on a strict "need to know" basis. Git was built to manage development of the Linux kernel, which is probably very different from what you do. Most people need a small subset of Git's functionality and that will be our focus. If you want a full-blown exposition of Git as a directed acyclic graph or a treatise on the Git-Flow branching strategy, you will be sad.
