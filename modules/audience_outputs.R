# R/audience_outputs.R

# Daily Activity
output$daily_activity <- renderPlotly({
  data <- filtered_posts() %>%
    group_by(date) %>%
    summarise(posts = n())
  
  plot_ly(data, x = ~date, y = ~posts, type = 'bar',
          marker = list(color = '#0077B5')) %>%
    layout(xaxis = list(title = "Date", automargin = TRUE),
           yaxis = list(title = "Number of Posts", automargin = TRUE))
})

# Engagement Breakdown
output$engagement_breakdown <- renderPlotly({
  data <- filtered_posts() %>%
    summarise(
      Likes = sum(likes),
      Comments = sum(comments),
      Shares = sum(shares),
      Clicks = sum(clicks)
    ) %>%
    pivot_longer(everything(), names_to = "metric", values_to = "value")
  
  plot_ly(data, labels = ~metric, values = ~value, type = 'pie',
          marker = list(colors = c('#0077B5', '#00A0DC', '#00C853', '#FF6B35'))) %>%
    layout(title = "")
})

# Weekly Pattern
output$weekly_pattern <- renderPlotly({
  data <- filtered_posts() %>%
    mutate(weekday = wday(date, label = TRUE, week_start = 1)) %>%
    group_by(weekday) %>%
    summarise(
      posts = n(),
      avg_engagement = mean(engagement_rate)
    )
  
  plot_ly(data, x = ~weekday, y = ~avg_engagement, type = 'bar',
          marker = list(color = '#0077B5')) %>%
    layout(xaxis = list(title = "Day of Week", automargin = TRUE),
           yaxis = list(title = "Avg Engagement Rate (%)", automargin = TRUE))
})
