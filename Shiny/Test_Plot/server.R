#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
   values <- reactiveValues(totalF=0)
   observeEvent(input$amountF, {
     if(input$select == "Food"){
       values$totalF <- values$totalF + input$amountF
     }
   })
   valuesR <- reactiveValues(totalR=0)
   observeEvent(input$amountF, {
     if(input$select == "Rent"){
       valuesR$totalR <- valuesR$totalR + input$amountF
     }
   })
   valuesU <- reactiveValues(totalU=0)
   observeEvent(input$amountF, {
     if(input$select == "Utilities"){
       valuesU$totalU <- valuesU$totalU + input$amountF
     }
   })
   
   valuesE <- reactiveValues(totalE=0)
   observeEvent(input$amountF, {
     if(input$select == "Entertaiment"){
       valuesE$totalE <- valuesE$totalE + input$amountF
     }
   })
   valuesO <- reactiveValues(totalO=0)
   observeEvent(input$amountF, {
     if(input$select == "Others"){
       valuesO$totalO <- valuesO$totalO + input$amountF
     }
   })
   
   output$vboxF <- shinydashboard::renderValueBox({
     shinydashboard::valueBox(values$totalF, 
              subtitle = "Food", 
              icon = icon("cutlery", lib = "font-awesome", verify_fa = FALSE),
              color = "green", 
              width = 1)
   })
   output$vboxR <- shinydashboard::renderValueBox({
     shinydashboard::valueBox(valuesR$totalR, 
                              subtitle = "Rent", 
                              icon = icon("bank", lib = "font-awesome", verify_fa = FALSE),
                              color = "orange", 
                              width = 1)
   })
   output$vboxU <- shinydashboard::renderValueBox({
     shinydashboard::valueBox(valuesU$totalU, 
                              subtitle = "Utilities", 
                              icon = icon("bolt", lib = "font-awesome", verify_fa = FALSE),
                              color = "light-blue", 
                              width = 1)
   })
   output$vboxE <- shinydashboard::renderValueBox({
     shinydashboard::valueBox(valuesE$totalE, 
                              subtitle = "Entertaiment", 
                              icon = icon("tv", lib = "font-awesome", verify_fa = FALSE),
                              color = "purple", 
                              width = 1)
   })
   output$vboxO <- shinydashboard::renderValueBox({
     shinydashboard::valueBox(valuesO$totalO, 
                              subtitle = "Others", 
                              icon = icon("credit-card", lib = "font-awesome", verify_fa = FALSE),
                              color = "yellow", 
                              width = 0)
   })
   
    output$plot1 <- renderPlot({
      x_name <- c("Food", "Rent", "Utilities", "Entertaiment", "Others")
      colour <- c("#b5e3d8", "#ffcaaf", "#c6e2e9", "#cac8f4", "#f1ffc4")
      amt <- c(values$totalF, valuesR$totalR, valuesU$totalU,valuesE$totalE, valuesO$totalO)
      barplot(amt, main = "Expenditures",
              xlab = "Types of Expenditure", ylab = "Amount Spent",
              names.arg = x_name, width = 0.5, col = colour)
    })
    
    
})
