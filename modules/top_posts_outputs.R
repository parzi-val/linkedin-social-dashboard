# R/top_posts_outputs.R

# Top Posts Table
output$top_posts_table <- renderDT({
  filtered_posts() %>%
    select(Date = date, Title = post_title, Type = post_type,
           Impressions = impressions, Likes = likes, Comments = comments,
           Shares = shares, `Eng. Rate (%)` = engagement_rate) %>%
    arrange(desc(`Eng. Rate (%)`)) %>%
    head(20) %>%
    mutate(
      Date = as.character(Date),
      Impressions = round(Impressions),
      Likes = round(Likes),
      Comments = round(Comments),
      Shares = round(Shares),
      `Eng. Rate (%)` = round(`Eng. Rate (%)`, 2)
    ) %>%
    datatable(
      options = list(pageLength = 10, scrollX = TRUE),
      rownames = FALSE
    )
})
