#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output) {
  output$plot1 <- renderPlot({
    set.seed(2016-05-25)
    numberPoints <- input$numeric
    
    minX <- input$sliderX[1]
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]
    
    dataX <- runif(numberPoints, minX, maxX)
    dataY <- runif(numberPoints, minY, maxY)
    
    xLab <- ifelse(input$show_xLabel, "x-axis", "")
    yLab <- ifelse(input$show_yLabel, "y-axis", "")
    title <- ifelse(input$show_title, "Title", "")
    
    
    
    plot(dataX, dataY, xlab = xLab, ylab = yLab, main = title,
         xlim = c(-100,100), ylim = c(-100,100))
  })


})
