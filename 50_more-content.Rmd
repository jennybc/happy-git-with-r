# (PART) More {-} 

# Notes

Notes for future

## Common workflow questions

### Common predicaments and how to recover/avoid

https://twitter.com/JennyBryan/status/743457387730735104

### Keep something out of Git

List it in `.gitignore.`

### I didn't mean to commit that

Committing things you didn't mean to (too big, secret). How to undo.

## git stuff

Git explainers, heavy on the diagrams

https://twitter.com/JennyBryan/status/743548245645791232

A Visual Git Reference  
http://marklodato.github.io/visual-git-guide/index-en.html

A successful Git branching model  
http://nvie.com/posts/a-successful-git-branching-model/

A successful Git branching model considered harmful  
https://barro.github.io/2016/02/a-succesful-git-branching-model-considered-harmful/

Git Tutorials from Atlassian
https://www.atlassian.com/git/tutorials/

Software Carpentry Git Novice Lesson  
http://swcarpentry.github.io/git-novice/

Michael Freeman slides on Git collaboration  
http://slides.com/michaelfreeman/git-collaboration#/

GitHub Training materials  
https://services.github.com/kit/

Git for Ages 4 and Up  
<https://www.youtube.com/watch?v=3m7BgIvC-uQ>

Learn Git Branching  
http://learngitbranching.js.org

A Git Workflow Walkthrough Series
http://vallandingham.me/git-workflow.html

  * Part 1: Feature Branches
  * Part 2: Reviewing Pull Requests
  * Part 3: Reviewing Pull Requests Locally
  * Part 4: Merging Pull Requests

Git from the inside out  
https://codewords.recurse.com/issues/two/git-from-the-inside-out

## The repeated amend

A way to commit often, without exposing your WIP on GitHub or without creating a very cluttered history.

Make changes. Reach a decent stopping point. Test, check, if a package ... Render if an analysis .... Nothing broken?

Commit. **Don't push.**

Make more progress. Keep testing or checking or rendering. Inspect diffs to watch what's changing.

Are things broken? Use an appropriate reset to fall back.

Are things improving? Commit but **amend** the previous commit.

Keep going like this until you've built up a commit you can be proud of.

**Now push.**

It is important to not push amended commits unless you really know what you're doing and you can be quite sure that no one else has pulled your work.

## Disaster recovery

<http://stackoverflow.com/questions?sort=votes>

Break it down:

  * Is something wrong with my filesystem/files?
  * Is my git repo messed up?
  * How can I keep this from happening again?
  
Rebase avoidance techniques.

Headless state. Rebase hell.

What to do when you can't, e.g., switch branches. Stashing and WIP commits.

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

Workflows for group of 1, 2, 5, 10

  * Fork and Pull vs Shared Repository
  
    - <https://help.github.com/articles/about-collaborative-development-models/>
    - <https://help.github.com/articles/using-pull-requests/>

## How the square bracket links work

Context: you prefer to link with text, not a chapter or section number.

  * GOOD! Here's a link to [Contributors].
  * BAD. You can see contributors in \@ref(contrib).

Facts and vocabulary

  * Each chapter is a file. These files should begin with the chapter title using a level-one header, e.g., `# Chapter Title`.
  * A chapter can be made up of sections, indicated by lower-level headers, e.g., `## A section within the chapter`.
  * There are three ways to address a section when creating links within your book:
    - **Explicit identifier**: In `# My header {#foo}` the explicit identifier is `foo`.
    - **Automatically generated identifier**: `my-header` is the auto-identifier for `# My header`. Pandoc creates auto-identifiers according to rules laid out in [Extension: auto_identifiers](http://pandoc.org/README.html#extension-auto_identifiers).
    - The header text, e.g., `My header` be used verbatim as an **implicit header reference**. See [Extension: implicit_header_references](http://pandoc.org/README.html#extension-implicit_header_references) for more.
  * All 3 forms can be used to create cross-references but you build the links differently.
  * Advantage of explicit identification: You are less likely to update the section header and then forget to make matching edits to references elsewhere in the book.

How to make text-based links using explicit identifiers, automatic identifiers, and implicit references:

  * Use implicit reference alone to get a link where the text is exactly the section header:
    - `[Introduce yourself to Git]` [Introduce yourself to Git]
    - `[Success and operating systems]` [Success and operating systems]
  * You can provide custom text for the link with all 3 methods of addressing a section:
    - Implicit header reference: `[link text][Recommended Git clients]` [link text][Recommended Git clients]    
    - Explicit identifier: `[hello git! I'm Jenny](#hello-git)` [hello git! I'm Jenny](#hello-git)
    - Automatic identifier: `[Any text you want](#recommended-git-clients)` [Any text you want](#recommended-git-clients)
