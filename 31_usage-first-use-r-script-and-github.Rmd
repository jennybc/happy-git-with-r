# Render an R script {#r-test-drive}

An underappreciated fact is that much of what you can do with R Markdown? ... you can also do with an R script.

If you're in analysis mode and want a report as a side effect, write an R script. If you're writing a report with a lot of R code in it, write Rmd. In either case, render to markdown.

In R markdown, prose is top-level and code is tucked into chunks.

In R scripts, code is top-level and prose is tucked into comments.

Hands-on experiment: start with an R Markdown file, such as the one you made in your Rmd test drive (chapter \@ref(rmd-test-drive)). Or the boilerplate Rmd RStudio makes with *File > New File > R Markdown ...*:

  * Save the file as `foo.R`, as opposed to `foo.Rmd`.
  * Anything that's not R code? Like the YAML and the English prose? Protect it with roxygen-style comments: start each line with `#'`.
  * Anything that's R code? Let it exist "as is" as top-level code.
  * Change the syntax of R chunk headers like so:
  
    Before: ` ```{r setup, include = FALSE}`  
    After: `#+ r setup, include = FALSE`

  * Delete the 3 backticks that end each chunk.

If you're having syntax struggles, here's another exercise:

  * Create a very simple R script. Literally, you could summarize and make a plot from the iris data. Make it boring.
  * Click on the "notebook" icon in RStudio to "Compile Report". You'll get a very nice HTML report.
  * Copy the YAML from the Rmd test drive (chapter \@ref(rmd-test-drive)), but prepend each line with `#'`.

All the workflow tips from the Rmd test drive (chapter \@ref(rmd-test-drive)) transfer: when you script an analysis, render it to markdown, commit the `.R`, the `.md`, any associated figures, and push to GitHub. Collaborators can see your code but also browse the result without running it.
