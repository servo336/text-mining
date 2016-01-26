fluidPage(
  # Application title
  titlePanel("Text Mining"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Select a biography:",
                  choices = biographies),
      actionButton("update", "Load"),
      hr(),
      sliderInput("max",
                  "Set Number of Words:",
                  min = 1,  max = 100,  value = 70),
      sliderInput("freq",
                  "Set Term Frequency:",
                  min = 1,  max = 10, value = 3)
      
    ),
    
    # Show Word Cloud
    mainPanel(
      tabsetPanel(
        tabPanel("Term Frequency", plotOutput("termplot")), 
        tabPanel("Word Cloud", plotOutput("wordcloud"))
      )
      
    )
  )
)