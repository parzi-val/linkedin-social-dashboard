# R/overview_outputs.R

# Value Boxes
output$total_followers <- renderValueBox({
  valueBox(
    format(round(tail(filtered_followers()$followers, 1)), big.mark = ","),
    "Total Followers",
    icon = icon("users"),
    color = "blue"
  )
})

output$total_posts <- renderValueBox({
  valueBox(
    nrow(filtered_posts()),
    "Posts Published",
    icon = icon("file-alt"),
    color = "green"
  )
})

output$avg_engagement <- renderValueBox({
  valueBox(
    paste0(round(mean(filtered_posts()$engagement_rate, na.rm = TRUE), 2), "%"),
    "Avg Engagement Rate",
    icon = icon("heart"),
    color = "red"
  )
})

output$total_impressions <- renderValueBox({
  valueBox(
    format(sum(filtered_posts()$impressions), big.mark = ","),
    "Total Impressions",
    icon = icon("eye"),
    color = "yellow"
  )
})

# Followers Growth Plot
output$followers_plot <- renderPlotly({
  plot_ly(filtered_followers(), x = ~date, y = ~followers, type = 'scatter', mode = 'lines',
          line = list(color = '#0077B5', width = 3)) %>%
    layout(xaxis = list(title = "Date"),
           yaxis = list(title = "Followers"),
           hovermode = 'x unified')
})

# Profile Views Plot
output$profile_views_plot <- renderPlotly({
  plot_ly(filtered_profile_views(), x = ~date, y = ~views, type = 'scatter', mode = 'lines',
          fill = 'tozeroy', fillcolor = 'rgba(0, 119, 181, 0.2)',
          line = list(color = '#0077B5')) %>%
    layout(xaxis = list(title = "Date"),
           yaxis = list(title = "Profile Views"),
           hovermode = 'x unified')
})

# Engagement Timeline
output$engagement_timeline <- renderPlotly({
  data <- filtered_posts() %>%
    group_by(date) %>%
    summarise(
      Likes = sum(likes),
      Comments = sum(comments),
      Shares = sum(shares)
    )
  
  plot_ly(data, x = ~date) %>%
    add_trace(y = ~Likes, name = 'Likes', type = 'scatter', mode = 'lines',
              line = list(color = '#00A0DC')) %>%
    add_trace(y = ~Comments, name = 'Comments', type = 'scatter', mode = 'lines',
              line = list(color = '#00C853')) %>%
    add_trace(y = ~Shares, name = 'Shares', type = 'scatter', mode = 'lines',
              line = list(color = '#FF6B35')) %>%
    layout(xaxis = list(title = "Date"),
           yaxis = list(title = "Count"),
           hovermode = 'x unified')
})
