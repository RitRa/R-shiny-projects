#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# To run library(DT), Please ensure you have the latest shiny version 
#
# install.packages("devtools")
# devtools::install_version("shiny", "1.2.0")

# The R package DT provides an R interface to the JavaScript library DataTables. 
library(DT)

library(shiny)
library(shinythemes)
library(shinydashboard)

library(ggplot2)

data(iris)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Iris dataset"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       
       # Select variable for y-axis
       selectInput(inputId = "y", 
                   label = "Y-axis:",
                   choices = c("Sepal.Length"          = "Sepal.Length", 
                               "Sepal.Width"              = "Sepal.Width",
                               "Petal.Length"          = "Petal.Length", 
                               "Petal.Width"              = "Petal.Width"), 
                   selected = "audience_score"),
       
       # Select variable for x-axis
       selectInput(inputId = "x", 
                   label = "X-axis:",
                   choices = c("Sepal.Length"          = "Sepal.Length", 
                               "Sepal.Width"              = "Sepal.Width",
                               "Petal.Length"          = "Petal.Length", 
                               "Petal.Width"              = "Petal.Width"), 
                   selected = "critics_score"),
       
       # Select variable for color
       selectInput(inputId = "z", 
                   label = "Color by:",
                   choices = c("Species" = "Species"),
                   selected = "mpaa_rating")
     ),
     
     # Outputs
     mainPanel(
       tabsetPanel(
         id = 'dataset',
         tabPanel("graph",  plotOutput(outputId = "scatterplot")),
         tabPanel("iris",  DT::dataTableOutput("mytable3"))
       )
     )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # scatterplot
  output$scatterplot <- renderPlot({
    ggplot(data = iris, aes_string(x = input$x, y = input$y,
                                     color = input$z)) +
      geom_point()
  })
  
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)

