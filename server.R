# server.R

server <- function(input, output, session) {
  
  # Reactive filtered data
  filtered_posts <- reactive({
    data <- posts_data %>%
      filter(date >= input$date_range[1] & date <= input$date_range[2])
    
    if (input$post_type_filter != "All") {
      data <- data %>% filter(post_type == input$post_type_filter)
    }
    
    data
  })
  
  filtered_followers <- reactive({
    followers_data %>%
      filter(date >= input$date_range[1] & date <= input$date_range[2])
  })
  
  filtered_profile_views <- reactive({
    profile_views %>%
      filter(date >= input$date_range[1] & date <= input$date_range[2])
  })
  
  # Source server modules
  source(file.path("modules", "overview_outputs.R"), local = TRUE)
  source(file.path("modules", "posts_analysis_outputs.R"), local = TRUE)
  source(file.path("modules", "audience_outputs.R"), local = TRUE)
  source(file.path("modules", "top_posts_outputs.R"), local = TRUE)
  
}
