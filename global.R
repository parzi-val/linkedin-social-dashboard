# global.R

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(DT)
library(lubridate)

# Generate Synthetic LinkedIn Data
set.seed(123)

# Date range: last 6 months
dates <- seq(today() - months(6), today(), by = "day")

# Posts data (realistic engagement for ~1000 followers)
posts_data <- tibble(
  date = sample(dates, 50, replace = TRUE),
  post_id = 1:50,
  post_type = sample(c("Article", "Image", "Video", "Text"), 50, replace = TRUE, 
                     prob = c(0.15, 0.35, 0.20, 0.30)),
  impressions = rpois(50, 200) + runif(50, 50, 400),
  likes = rpois(50, 8) + runif(50, 2, 20),
  comments = rpois(50, 1) + runif(50, 0, 5),
  shares = rpois(50, 0.5) + runif(50, 0, 3),
  clicks = rpois(50, 10) + runif(50, 2, 15)
) %>%
  mutate(
    engagement_rate = ((likes + comments + shares) / impressions) * 100,
    post_title = paste("Post about", sample(c("AI", "Leadership", "Marketing", "Tech", "Career", "Innovation"), 50, replace = TRUE))
  ) %>%
  arrange(desc(date))

# Daily metrics aggregation
daily_metrics <- posts_data %>%
  group_by(date) %>%
  summarise(
    posts = n(),
    total_impressions = sum(impressions),
    total_engagement = sum(likes + comments + shares),
    avg_engagement_rate = mean(engagement_rate)
  )

# Followers growth (realistic for ~1000 followers)
followers_data <- tibble(
  date = dates,
  followers = cumsum(c(950, rpois(length(dates) - 1, 0.3))) + rnorm(length(dates), 0, 0.5)
)

# Profile views (realistic for ~1000 followers)
profile_views <- tibble(
  date = dates,
  views = rpois(length(dates), 15) + runif(length(dates), 5, 25)
)
