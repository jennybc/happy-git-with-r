# (PART) Classroom {-} 

# Run a course with GitHub {#classroom-overview}

GitHub makes a wonderful platform on which to run a course. I've been doing this on [github.com](https://github.com) since 2014 in [STAT 545](http://stat545.com), an 80-student grad course in data analysis with R, and in a second large, code-intensive graduate course in statistical genomics. We're running all of the courses for UBC's [Master of Data Science program](https://ubc-mds.github.io) off a private instance of [GitHub Enterprise](https://enterprise.github.com/home) hosted in Canada.

## Benefits

For the instructor

  * If you already use Git/GitHub, it's extremely efficient to use the same workflows to manage course materials, student work, and communication with students and TAs.
    - When I switched to Git/GitHub and R Markdown, abandoning my old "system" of accepting all manner of stuff as email attachments? It was the first time I actually ran the code in my students' final projects, because it was so easy to get it on my computer in an organized fashion. I even made some corrections as pull requests!
  * If you're still in your early days with Git/GitHub, the sheer volume of operations and regular small deadlines will increase your mastery very quickly. Practice makes perfect! However, I would not recommend running a course on GitHub as your *first* substantial version control project.

For the students

  * I have found that students adjust to Git/GitHub fairly quickly and genuinely like it. They find it gratifying to see their beautiful, figure-rich R Markdown reports up on the internet. Since it's easy to expose their work within the class, we do alot of peer review. I find that expertise spreads around the class like a virus. That applies to the main course substance as well as workflow.
  * Many students are specifically interested in learning Git and GitHub, as a complement to the coding and analytical skills we teach in these courses. The fact that we use it for course mechanics kills two birds with one stone. Teaching the use of distributed version control is a valid pedagogical goal in and of itself.

## The STAT 545 student setup

GitHub's Organizations/Teams and API have changed over the 3+ years we've been doing this, so my approach has evolved over time and is also shaped by hard experience.

Major points:

  * [Create an Organization](https://help.github.com/articles/creating-a-new-organization-account/) for the course.
    - Immediately request an [Education discount](https://education.github.com) for the Organization, so that you get unlimited private repos.
  * Have your students register for free, personal [GitHub accounts](https://github.com).
    - Encourage them to request an [Education discount](https://education.github.com) on their own behalf (aka "student developer pack"). But rest assured, nothing you need for your course machinery will depend on this.
  * Get the GitHub usernames from your students -- we use a [Shiny](http://deanattali.com/blog/shiny-persistent-data-storage/) [app](http://deanattali.com/2015/06/14/mimicking-google-form-shiny/)! -- plus some shred of information that allows you link them back to your official course list.
  * Create a students [Team](https://help.github.com/enterprise/2.7/admin/guides/user-management/organizations-and-teams/) and a TA Team. I make such teams for each run of the course, e.g. `2016_students` and `2016_ta`.
  * Invite students to join your course organization and the students team. Ditto for TAs and the TA team.
  * Create a canonical name for each student, based on the official course list, i.e. `lastname_firstname`.
  * Create a repository for each student, using the student's canonical name.
    - This is a private repository within the course Organization.
    - I turn wikis off and either let GitHub auto-initialize or immediately push files, including a README, into the repos.
    - Give the student team read or pull access to each student's repo. Yes, this allows them to see each others work. I discuss this elsewhere.
    - Give the TA team write or push access to each student's repo.
    - Add the student as collaborator with write or push access.
    - Unwatch these repos personally! Wow such notification.

That's the setup! I use the [gh](https://github.com/gaborcsardi/gh) and [purrr](https://github.com/hadley/purrr) packages to script all of this [GitHub API](https://developer.github.com/v3/) work. *In a second wave, I'll post code snippets for the above operations.*
    
What you should NOT do (voice of experience, here):

Do NOT allow students to create their own repositories.

  - You will have a naming convention and they will never, ever, ever follow it.
  - You need to have admin rights over their course repo, so you can manipulate it at will via the GitHub API. You will ask them to add you and the TAs as collaborators, but they will not all manage to execute this task.
  - You will want to do various bulk operations on the repos and your API work will be simpler if the repos belong to the same Organization vs looping over randomly named repos owned by random people, subject to their whims.
  
## The homework-flow

In class, the students [take possession of their repos](http://stat545.com/git08_claim-stat545-repo.html), from RStudio via *File > New Project*. They do the bulk of their coursework here: it is a directory on their computer, a Git repo associated with GitHub remote, and an RStudio project.

Typically homework is done in R Markdown, using the [`github_document`](http://rmarkdown.rstudio.com/github_document_format.html) output format. They commit and push `.Rmd`, `.md`, and any necessary files, such a figures.

Homework is submitted by opening an issue:

  * Issue name is "Mark homework x of lastname_firstname". OK not really, but I can dream.
  * Body should contain SHA of their latest commit, tag(s) for the marking TA or the TA team, and, ideally, links to the file(s) to be marked.
  
TAs leave feedback here. Actual marks are stored elsewhere and distributed via email. As the TAs mark, they close the issues.

After homework submission, we randomly assign each student to review the work of two peers. Each peer review assignment takes the form of an issue, assigned to the reviewer. Students leave feedback for each other here. As the TAs mark, they read and assess these peer reviews (also marked!) and close the issues.

## Repo as sampler



    
    
    
    
    
