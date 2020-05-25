function(input, output){
  values <- reactiveValues()
  dataInput <- reactive({
    if(input$dataset == 1){
      data <- rock
    } else if (input$dataset == 2 ){
      data <- pressure
    } else if (input$dataset == 3) {
      data <- mtcars
    } else if (input$dataset == 4) {
      data <- read.csv(input$example$datapath)
    }
  })
  observeEvent(input$load, {
    values$data <- data.frame(dataInput())
  })
  shinyjs::onclick("imp_det",
                   shinyjs::toggle(id = "details_import", anim = TRUE))
  observeEvent(input$load, {
    values$data <- data.frame(dataInput())
  })
  output$var1 <- renderUI({    # remember variable 1? here it is how we extract it
    nam <- colnames(values$data) # from the data set
    selectInput("var1", label = "Select x:", # create the input
                choices = c(nam), multiple = F,
                selected = nam[1])
  })
  
  output$var2 <- renderUI({
    nam2 <- colnames(values$data) # create the input for variable 2
    selectInput("var2", label = "Select y:",
                choices = c(nam2), multiple = F,
                selected = nam2[1])
  })
  
  newdata <- observeEvent(input$select, # use observe event so that the app will 
                          { # wait for you to decide before acting
                            # Besides, you're creating a new (smaller) object
                            values$df <- values$data[c(input$var1, input$var2)]
                          })
  output$graph <- renderPlot({
    validate(
      need(input$select > 0, "Waiting for data") # I changed the validation from
    )                                        # load to select
    df <- values$df # store the new object into an R object
    plot(df[, c(1:2)]) # use it normally
    
    
  })
  
  output$summary <- renderPrint({
    validate(
      need(input$select > 0, "Waiting for data")
    ) 
    df <- values$df # same 
    summary(df[, c(1:2)])
    
  })
  
  output$points <- renderPrint({
    df <- values$df # store the dataframe in an object 
    pointID <- nearPoints(df, # the dataframe
                          input$plot_click, # the command for a reaction
                          xvar = names(df)[colnames(df) == input$var1], # xvar of the graph
                          yvar = names(df)[colnames(df) == input$var2], # yvar of the graph,
                          addDist = FALSE) 
    validate(
      need(nrow(pointID) != 0, "Click on a point") # Waiting message
    )
    pointID
  })
  
  output$brush <- renderPrint({
    df <- values$df # store the dataframe in an object 
    brushID <- brushedPoints(df,# the  dataframe 
                             input$plot_brush, # the command for a reaction
                             xvar = names(df)[colnames(df) == input$var1], # xvar of the graph
                             yvar = names(df)[colnames(df) == input$var2], # yvar of the graph
    )
    validate(
      need(nrow(brushID) != 0, "Highlight Area") # Waiting message
    )
    brushID
  })
  
}