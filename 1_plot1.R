# Cover Letter ----
# Plot research experience over time

# load packages
library(tidyverse)
library(here)
library(showtext)
library(ggthemes)
library(ggrepel)

set.seed(101)

# load data
hours_data <- read_csv(here("hours_data.csv"))

# load font
font_add_google(name = "hanken grotesk", db_cache = FALSE)
showtext_auto()

tmp_date <- hours_data |> filter(month == 0 | is.na(labels) == FALSE)

# hours experience vs year in school
myplot <-
  ggplot(hours_data, aes(x = month, y = sum_hours)) +
  geom_line(color = "#81A969") +
  scale_y_continuous(limits = c(0,200)) +
  theme_minimal() +
  theme(
    plot.background = element_blank(),
    panel.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major = element_line(color = "#a6a6a6", linewidth = 0.1),
    axis.text.x = element_blank()
  ) +
  labs(
    x = NULL,
    y = "experience (hrs)"
  ) +
  geom_text_repel(
    data = tmp_date,
    label = c("First day\nof class", "Joined SCL", "", "Joined DICE",
              "Joined RAM", "Started thesis"),
    box.padding = 0.8,
    mapping = aes(lineheight = 0.3, segment.size = 0.2, segment.color	= "#a6a6a6")
  )

ggsave(here("myplot.png"), myplot, height = 340, width = 400, units = "px")
