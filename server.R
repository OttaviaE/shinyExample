# step 1: just build the app and make it work

server <- function(input, output){
  output$graph <- renderPlot({
    if(input$dataset == "rock"){
      data <- rock
    } else if (input$dataset == "pressure" ){
      data <- pressure
    } else if (input$dataset == "cars") {
      data <- cars
    }
    plot(data[, c(1:2)])
  })

  output$summary <- renderPrint({
    if(input$dataset == "rock"){
      data <- rock
    } else if (input$dataset == "pressure" ){
      data <- pressure
    } else if (input$dataset == "cars") {
      data <- cars
    }
    summary(data[, c(1:2)])
  })
}

# step 2: too much code 

server <- function(input, output){
  values <- reactiveValues()
  dataInput <- reactive({
    if(input$dataset == "rock"){
      data <- rock
    } else if (input$dataset == "pressure" ){
      data <- pressure
    } else if (input$dataset == "cars") {
      data <- cars
    }
  })
  observe({
    values$data <- data.frame(dataInput())
  })

    output$graph <- renderPlot({
       plot(values$data[, c(1:2)])
    })

    output$summary <- renderPrint({
    summary(values$data)
    })
}

# better, but i want an action button

 server <- function(input, output){
  values <- reactiveValues()
  dataInput <- reactive({
    if(input$dataset == "rock"){
      data <- rock
    } else if (input$dataset == "pressure" ){
      data <- pressure
    } else if (input$dataset == "cars") {
      data <- cars
    }
  })
  observeEvent(input$load, {
    values$data <- data.frame(dataInput())
  })

  output$graph <- renderPlot({
    plot(values$data[, c(1:2)])
  })

  output$summary <- renderPrint({
    summary(values$data)
  })
}

# ... and I don't want error messages 

server <- function(input, output){
    values <- reactiveValues()
    dataInput <- reactive({
      if(input$dataset == 1){
        data <- rock
      } else if (input$dataset == 2 ){
        data <- pressure
      } else if (input$dataset == 3) {
        data <- cars
      }
    })
    observeEvent(input$load, {
      values$data <- data.frame(dataInput())
    })

  output$graph <- renderPlot({
    validate(
      need(input$load > 0, "Waiting for data")
    )
    plot(values$data[, c(1:2)])
  })

  output$summary <- renderPrint({
    validate(
      need(input$load > 0, "Waiting for data")
    )
    summary(values$data)
  })
}
# 
# # and now I want to upload my data  
server <- function(input, output){
  values <- reactiveValues()
  dataInput <- reactive({
    if(input$dataset == 1){
      data <- rock
    } else if (input$dataset == 2 ){
      data <- pressure
    } else if (input$dataset == 3) {
      data <- cars
    } else if (input$dataset == 4) {
      data <- read.csv(input$example$datapath)
    }
  })
  observeEvent(input$load, {
    values$data <- data.frame(dataInput())
  })
  
  output$var1 <- renderUI({
    var_names <- ncol(values$data)
    nam <- colnames(values$data)
    selectInput("var", label = "Select y:",
                choices = c(nam), multiple = F,
                selected = nam[1])
  })
  
  output$var2 <- renderUI({
    var_names2 <- ncol(values$data)
    nam2 <- colnames(values$data)
    selectInput("var2", label = "Select x:",
                choices = c(nam2), multiple = F,
                selected = nam2[1])
  })

  output$graph <- renderPlot({
    validate(
      need(input$load > 0, "Waiting for data")
    )
    if (any(colnames(values$data) == "condition") ){
      plot(values$data$tr ~ values$data$condition,
           xlab = "Condition", ylab = "TR")
    } else {
      plot(values$data[, c(1:2)])
    }
  })

  output$summary <- renderPrint({
    validate(
      need(input$load > 0, "Waiting for data")
    )
    if (any(colnames(values$data) == "condition") ){
      summary(values$data[, c(2:3)])
    } else {
      summary(values$data[, c(1:2)])
    }
  })
}