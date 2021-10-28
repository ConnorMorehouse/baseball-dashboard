#####
# packages #
#####
library(shiny)
library(shinydashboard)
library(tidyverse)
library(baseballr)
library(shinyjs)
library(ggpubr)

#####
# functions #
#####



#####
# data loading # 
#####

# pbp_2019_df <- fread('pbp_2019.csv')


#####
# og ui #
#####

# Define UI for application that draws a histogram
# ui <- fluidPage(
#    
#    # Application title
#    titlePanel("Old Faithful Geyser Data"),
#    
#    # Sidebar with a slider input for number of bins 
#    sidebarLayout(
#       sidebarPanel(
#          sliderInput("bins",
#                      "Number of bins:",
#                      min = 1,
#                      max = 50,
#                      value = 30)
#       ),
#       
#       # Show a plot of the generated distribution
#       mainPanel(
#          plotOutput("distPlot")
#       )
#    )
# )

#####
# another example ui #
#####

# ui <- fluidPage(tabsetPanel(
#   
#   tabPanel("Follower Counts", 
#            
#            useShinyjs(),
#            
#            sidebarLayout(
#              sidebarPanel(
#                # follower range slider #
#                sliderInput(inputId = 'follower_range', label = 'Follower Range',
#                            min = 0, max = max(artists$followers.total), 
#                            value = c(0,max(artists$followers.total)),
#                            ticks = F,
#                            step = 5000),
#                
#                # number of results #
#                selectInput(inputId  = 'results', 
#                            label = 'Number of results', 
#                            choices = c(5,10,15,20,25,50,100),
#                            selected = 50),
#                
#                # decreasing/increasing follower counts #
#                checkboxInput(inputId = 'decreasing',
#                              label = 'Sort followers decreasing?',
#                              value = T),
#                
#                # checkbox to include genre filter #
#                checkboxInput('include_genre', 'Include genre filter?'),
#                
#                # genre selection #
#                uiOutput('genre')
#                
#              ),
#              mainPanel(
#                
#                # table output #
#                tableOutput(outputId = 'followers_table')
#              )
#            )
#   ),
#   
#   tabPanel("Individual Artist Info", 
#            sidebarLayout(
#              sidebarPanel(
#                
#                # artist name input #
#                textInput(inputId = 'radar_name1', 'artist name', value = 'Mac Miller'),
#                
#                # artist compartison checkbox #
#                checkboxInput(inputId = 'artist_comparison', 'compare aritists?', value = F),
#                
#                # compartison artist name input #
#                uiOutput(outputId = 'artist_comparison_ui')
#                
#              ),
#              mainPanel(
#                
#                # radar output #
#                plotOutput(outputId = 'radar')
#              )
#            )
#   ),
#   
#   tabPanel("Collection Search", 
#            
#            # text input for artist name #
#            textInput(inputId = 'term', 'Search Collection', value = 'Mac Miller'),
#            
#            # table output #
#            tableOutput(outputId = 'search')
#   )
# )
# )

#####
# ui #
#####

ui <- fluidPage(tabsetPanel(
  
  tabPanel("panel 1", 
           
           dashboardPage(
             dashboardHeader(
               
             ),
             dashboardSidebar(
               sliderInput(inputId = 'la_slider',
                           'launch angle',
                           value = c(-15, 55),
                           min = -15,
                           max = 55)
             ),
             dashboardBody(
               plotOutput(outputId = 'test')
             )
  )
  ),
  
  tabPanel("panel 2", 
           sidebarLayout(
             sidebarPanel(
               
             ),
             mainPanel(
              
             )
           )
  ),
  
  tabPanel("panel 3", 

  )
)
)


#####
# server #
#####

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   # output$distPlot <- renderPlot({
   #    # generate bins based on input$bins from ui.R
   #    x    <- faithful[, 2] 
   #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
   #    
   #    # draw the histogram with the specified number of bins
   #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
   # })
  
  output$test <- renderPlot(pbp_2019_df %>%
    filter(matchup.batter.fullName == 'Juan Soto' & last.pitch.of.ab == 'true') %>%
    ggplot(aes(x = hitData.launchAngle)) +
    geom_density())
  
  # output$test <- renderPlot(ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  #                                 geom_point())
}

shinyApp(ui = ui, server = server)

