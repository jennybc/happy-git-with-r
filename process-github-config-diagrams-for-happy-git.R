library(tidyverse)
library(magick)
library(fs)
library(here)

# TODO: soon, I should move the source Keynote document (or part of it)
# into this project
img_paths <- dir_ls("~/rrr/happy-git-with-r-slides/github-configs/2020-06_usethis-motivated-git-diagrams/")

path_file(img_paths)

# practicing
y <- image_read(img_paths[[2]])
y

# wow much fiddling here to get the crop geometry right
# the border is just an visual aid
z <- image_crop(y, geometry = "660x640+450+10")
z %>%
  image_border(color = "blue")

# doing it to all figs
dir_create(here("img", "github-configs"))

f <- function(file) {
  file %>%
    image_read() %>%
    image_crop(geometry = "660x640+450+10") %>%
    image_write(here("img", "github-configs", path_file(file)))
}

walk(img_paths, f)

cropped_paths <- dir_ls(here("img", "github-configs"))

path_file(img_paths)

name_dat <- tibble(
  raw = path_file(img_paths)
) %>%
  mutate(number = str_extract(raw, "\\d+(?=[.]jpeg$)"))

usethis_labels <- tribble(
  ~ number, ~ label,
  "001", "no_github",
  "002", "ours-you",
  "003", "ours-them",
  "004", "theirs",
  "005", "fork-them",
  "006", "fork-them-pull-request",
  "007", "fork-ours",
  "008", "fork_upstream_is_not_origin_parent"
)

name_dat <- name_dat %>%
  left_join(usethis_labels)

file_copy(
  cropped_paths,
  here("img", path_ext_set(name_dat$label, "png"))
)
