library(magick)
library(here)
library(tidyverse)
library(fs)

paths <- here(
  "img",
  c("no_github.png", "ours-you.png", "ours-them.png",
    "theirs.png", "fork-them.png", "fork-ours.png")
)

x <- paths %>% set_names(~ path_ext_remove(path_file(.x))) %>% map(image_read)
str(x)

dat <- tibble(
  img = x,
  anno = c("no_github", "ours (1 of 2)", "ours (2 of 2)",
           "theirs", "fork (1 of 2)", "fork (2 of 2)")
)

sz <- 45
x_anno <- map2(
  dat$img, dat$anno,
  ~image_annotate(.x, .y, size = sz, gravity = "northwest", location = "+25+25")
)

x_anno[[1]]
x_anno[[2]]
x_anno[[3]]
x_anno[[4]]
x_anno[[5]]
x_anno[[6]]

top_row <- x_anno %>%
  head(3) %>%
  image_join() %>%
  image_scale("x200") %>%
  image_append()
top_row
bot_row <- x_anno %>%
  tail(3) %>%
  image_join() %>%
  image_scale("x200") %>%
  image_append()
bot_row
all <- c(top_row, bot_row) %>% image_join() %>% image_append(stack = TRUE)
all

image_write(all, here("img", "six-configs.png"))
