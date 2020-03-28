library(shiny)
library(shinyjs)
library(shinythemes)

# ui <- fluidPage(
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = "dataset",
#                   label = "Choose a dataset:",
#                   choices = c("rock", "pressure", "cars"))
#     ), 
#     
#     mainPanel(
#       plotOutput(
#         "graph"
#       ), 
#       verbatimTextOutput(
#         "summary"
#       )
#     ) # display output
#   )
# )

# add the action button ----
# ui <- fluidPage(
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = "dataset",
#                   label = "Choose a dataset:",
#                   choices = c("rock", "pressure", "cars")),
# 
#       actionButton("load", "Upload data")
#       ),
#     mainPanel(
#       plotOutput(
#         "graph"
#       ),
#       verbatimTextOutput(
#         "summary"
#       )
#     ) # display output
#   )
#  )
# 
# # I want to upload my own data ----
# 
# ui <- fluidPage(
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = "dataset",
#                   label = "Choose a dataset:",
#                   choices = list("rock" = 1,
#                                  "pressure" = 2,
#                                  "cars" = 3,
#                                  "I want to use my data!!" =4)),
#       conditionalPanel(
#         condition = "input.dataset == '4'",
#         fileInput("example",
#                   "", accept = c("text/csv"))
#       ),
#       actionButton("load", "Upload data")
#     ),
# 
#     mainPanel(
#       plotOutput(
#         "graph"
#       ),
#       verbatimTextOutput(
#         "summary"
#       )
#     ) # display output
#   )
# )

# ui for exploring teh columns 

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = list("rock" = 1,
                                 "pressure" = 2,
                                 "cars" = 3,
                                 "I want to use my data!!" =4)),
      
      conditionalPanel(
        condition = "input.dataset == '4'",
        fileInput("example",
                  "", accept = c("text/csv"))
      ), 
      actionButton("load", "Upload data"),
      conditionalPanel(
        condition = "input.load >= '1'", 
        uiOutput("var1"),
        uiOutput("var2"), 
        actionButton("select", "Select & Display")
      ),
  
    ),
    
    mainPanel(
      plotOutput(
        "graph"
      ),
      verbatimTextOutput(
        "summary"
      )
    ) # display output
  )
)


# # customize app ----
# ui <- fluidPage(
#  # theme = shinytheme("journal"),
#   includeCSS("examplestyle.css"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = "dataset",
#                   label = "Choose a dataset:",
#                   choices = list("rock" = 1,
#                                  "pressure" = 2,
#                                  "cars" = 3,
#                                  "I want to use my data!!" =4)),
#       conditionalPanel(
#         condition = "input.dataset == '4'",
#         fileInput("example",
#                   "", accept = c("text/csv"))
#       ),
#       actionButton("load", "Upload data")
#     ),
# 
#     mainPanel(
#       plotOutput(
#         "graph"
#       ),
#       verbatimTextOutput(
#         "summary"
#       )
#     ) # display output
#   )
# )