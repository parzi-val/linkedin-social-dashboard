# global.R


library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(DT)
library(lubridate)

data_dir <- "archive"

safe_read <- function(file) {
  fp <- file.path(data_dir, file)
  if (file.exists(fp)) {
    message("✅ Loaded ", file)
    read_csv(fp, show_col_types = FALSE)
  } else {
    warning("Missing file: ", file)
    tibble()
  }
}

posts_data <- safe_read("posts.csv") %>%
  mutate(date = as_date(date))

followers_data <- safe_read("followers.csv") %>%
  mutate(date = as_date(date))

profile_views <- safe_read("profile_views.csv") %>%
  mutate(date = as_date(date))

daily_metrics <- safe_read("daily_metrics.csv") %>%
  mutate(date = as_date(date))


total_followers <- tail(followers_data$followers, 1)
total_posts <- nrow(posts_data)
avg_engagement_rate <- mean(posts_data$engagement_rate, na.rm = TRUE)
total_impressions <- sum(posts_data$impressions, na.rm = TRUE)
