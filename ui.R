# ui.R

ui <- dashboardPage(
  skin = "blue",
  
  dashboardHeader(title = "LinkedIn Analytics"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("Posts Analysis", tabName = "posts", icon = icon("chart-line")),
      menuItem("Audience", tabName = "audience", icon = icon("users")),
      menuItem("Top Posts", tabName = "top_posts", icon = icon("star"))
    ),
    
    hr(),
    
    dateRangeInput("date_range", "Date Range:",
                   start = today() - months(3),
                   end = today(),
                   min = min(dates),
                   max = max(dates)),
    
    selectInput("post_type_filter", "Post Type:",
                choices = c("All", unique(posts_data$post_type)),
                selected = "All")
  ),
  
  dashboardBody(
    tabItems(
      # Overview Tab
      tabItem(tabName = "overview",
              fluidRow(
                valueBoxOutput("total_followers", width = 3),
                valueBoxOutput("total_posts", width = 3),
                valueBoxOutput("avg_engagement", width = 3),
                valueBoxOutput("total_impressions", width = 3)
              ),
              
              fluidRow(
                box(
                  title = "Followers Growth", status = "primary", solidHeader = TRUE,
                  width = 6, plotlyOutput("followers_plot")
                ),
                box(
                  title = "Profile Views", status = "info", solidHeader = TRUE,
                  width = 6, plotlyOutput("profile_views_plot")
                )
              ),
              
              fluidRow(
                box(
                  title = "Engagement Over Time", status = "success", solidHeader = TRUE,
                  width = 12, plotlyOutput("engagement_timeline")
                )
              )
      ),
      
      # Posts Analysis Tab
      tabItem(tabName = "posts",
              fluidRow(
                box(
                  title = "Post Performance by Type", status = "primary", solidHeader = TRUE,
                  width = 6, plotlyOutput("post_type_performance")
                ),
                box(
                  title = "Engagement Rate Distribution", status = "warning", solidHeader = TRUE,
                  width = 6, plotlyOutput("engagement_distribution")
                )
              ),
              
              fluidRow(
                box(
                  title = "Impressions vs Engagement", status = "info", solidHeader = TRUE,
                  width = 12, plotlyOutput("impressions_engagement_scatter")
                )
              )
      ),
      
      # Audience Tab
      tabItem(tabName = "audience",
              fluidRow(
                box(
                  title = "Daily Activity", status = "primary", solidHeader = TRUE,
                  width = 6, plotlyOutput("daily_activity")
                ),
                box(
                  title = "Engagement Breakdown", status = "success", solidHeader = TRUE,
                  width = 6, plotlyOutput("engagement_breakdown")
                )
              ),
              
              fluidRow(
                box(
                  title = "Weekly Posting Pattern", status = "info", solidHeader = TRUE,
                  width = 12, plotlyOutput("weekly_pattern")
                )
              )
      ),
      
      # Top Posts Tab
      tabItem(tabName = "top_posts",
              fluidRow(
                box(
                  title = "Top Performing Posts", status = "primary", solidHeader = TRUE,
                  width = 12, DTOutput("top_posts_table")
                )
              )
      )
    )
  )
)
