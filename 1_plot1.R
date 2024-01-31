# Cover Letter ----
# Plot research experience over time

# load packages
library(tidyverse)
library(here)
library(showtext)
library(ggthemes)
library(ggrepel)

# load data
hours_data <- read_csv(here("hours_data.csv"))

# load font
font_add_google(name = "hanken grotesk", db_cache = FALSE)
showtext_auto()

tmp_date <- hours_data |> filter(month == 0 | is.na(labels) == FALSE)

# hours experience vs year in school
ggplot(hours_data, aes(x = month, y = sum_hours)) +
  geom_line(color = "#81A969") +
  scale_y_continuous(limits = c(0,200)) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "#F4FDEE", color = "#F4FDEE"),
    panel.background = element_rect(fill = "#F4FDEE", color = "#F4FDEE"),
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
    label = c("First day of\nclass", "Joined SCL", "", "Joined DICE",
              "Joined RAM", "Started thesis"),
    box.padding = 3,
    mapping = aes(segment.size = 0.2, segment.color	= "#a6a6a6")
  )

