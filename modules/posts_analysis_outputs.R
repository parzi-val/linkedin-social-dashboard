# R/posts_analysis_outputs.R

# Post Type Performance
output$post_type_performance <- renderPlotly({
  data <- filtered_posts() %>%
    group_by(post_type) %>%
    summarise(
      avg_engagement = mean(engagement_rate),
      total_impressions = sum(impressions)
    )
  
  plot_ly(data, x = ~post_type, y = ~avg_engagement, type = 'bar',
          marker = list(color = '#0077B5')) %>%
    layout(xaxis = list(title = "Post Type", automargin = TRUE),
           yaxis = list(title = "Avg Engagement Rate (%)", automargin = TRUE))
})

# Engagement Distribution
output$engagement_distribution <- renderPlotly({
  plot_ly(filtered_posts(), x = ~engagement_rate, type = 'histogram',
          marker = list(color = '#FF6B35')) %>%
    layout(xaxis = list(title = "Engagement Rate (%)", automargin = TRUE),
           yaxis = list(title = "Count", automargin = TRUE))
})

# Impressions vs Engagement Scatter
output$impressions_engagement_scatter <- renderPlotly({
  plot_ly(filtered_posts(), x = ~impressions, y = ~likes + comments + shares,
          type = 'scatter', mode = 'markers',
          color = ~post_type, colors = c('#0077B5', '#00A0DC', '#00C853', '#FF6B35'),
          text = ~post_title, hoverinfo = 'text') %>%
    layout(xaxis = list(title = "Impressions", automargin = TRUE),
           yaxis = list(title = "Total Engagement", automargin = TRUE))
})
