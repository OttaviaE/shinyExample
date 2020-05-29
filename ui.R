library(shiny)
library(shinyjs)
library(shinythemes)

fluidPage(includeCSS("style.css"),
          useShinyjs(),  # Set up shinyjs
          sidebarLayout(
            sidebarPanel(style = "background-color: 		#e1e9f9;",
                         a(id = "imp_det", h3("Choose a dataset", style = "font-style: normal; font-size: 14pt;"), href = "#"),
                         shinyjs::hidden(div(
                           id = "details_import",
                           helpText(
                             h5("You can also upload your data!")
                           )
                         )),
                         selectInput(inputId = "dataset",
                                     label = "",
                                     choices = list("rock" = 1,
                                                    "pressure" = 2,
                                                    "cars" = 3,
                                                    "I want to use my data!!" =4)),
                         
                         conditionalPanel(
                           condition = "input.dataset == '4'",
                           fileInput("example",
                                     "", accept = c("csv"))
                         ), 
                         actionButton("load", "Upload data"), # This is the button for uploading 
                         # the data
                         conditionalPanel(                    # It appears only when the data are 
                           condition = "input.load >= '1'",   # loaded
                           uiOutput("var1"),                 # contains the name for variable 1
                           uiOutput("var2"),                 # contains the name for variable 2
                           actionButton("select", "Select & Display") # This is the button for 
                         ),                              # selecting the variables and actually see
                         # something
            ),
            
            mainPanel(
              plotOutput(
                "graph", 
                click = clickOpts(id = "plot_click"), # when we click we select a point
                brush = brushOpts(id = "plot_brush") # whe we highlight an area we select
              ),     # many rows
              fluidRow( # it displays on the same row multiple arguments
                column(4, # first column with the summary verbatim output
                       verbatimTextOutput(
                         "summary"
                       )), 
                column(4,  # second column with another verbatim output for the points
                       verbatimTextOutput(
                         "points"
                       )
                ),
                column(4, 
                       verbatimTextOutput(
                         "brush"
                       ))
              )
              
            ) # display output
          ))