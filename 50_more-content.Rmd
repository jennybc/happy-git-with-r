# (PART) More {-} 

placeholders and notes

# stuff

## git stuff

link out to full tutorials w/ good visuals

filesystem / working directory

vs

staging area

vs

???

make sure understand you can have a file locally that git is not tracking and is not pushing/pulling to github.  It's ok to not stage everything. If a long-term situation, gitignore so it doesn't clutter things up and bug you.

  * `git add -A` 

## The repeated amend

local only, i.e. never amend a commit that's already pushed

affecting a remote, explain why so dangerous and when it *might* be ok

## Disaster recovery

Break it down:

  * Is something wrong with my filesystem, files?
  * Is my git repo messed up?
  * How can I keep this from happening again?
  
Best case, you have no filesystem problem, only a git problem. And some sort of reset usually works.

Practice burn it all down.

Editing most recent commit or just its message.

Rebase avoidance techniques.

Headless state. Rebase hell.

<http://stackoverflow.com/questions?sort=votes>

Commiting things you didn't mean to (too big, secret)

Not being able to do something, like edit last commit (technically I wanted to do interactive rebase, in order to edit last commit w/o amending it), because of having unstaged changes.

## Engage with R source on GitHub

Browsing

Searching

  * My gist, re: the cran user: <https://gist.github.com/jennybc/4a1bf4e9e1bb3a0a9b56>
  * Recent search for roxygen template usage in the wild: <https://github.com/search?utf8=✓&q=man-roxygen+in:path&type=Code&ref=searchresults>

Being a useful useR

  * stay informed re: development
  * use issues for bug reports, feature requests
  * make pull requests
  
## Workflow and psychology

Stress of working in the open

Workflows for group of 1, 2, 5, 10.
