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
      output$distPlot <- renderPlot({
      read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/Lab_8/artist.csv")
      df <- data.frame(read$JustinBieber, read$JamieMiller, read$ShawnMendes)
  
      cntB <- read$JustinBieber
      cntM <- read$JamieMiller
      cntS <- read$ShawnMendes
      
      if(input$select == "JB"){
        cntB <- cntB + 1
        
      } 
      else if(input$select == "JM"){
        cntM <- cntM + 1
      }  
      else if(input$select == "SM"){
        cntS <- cntS + 1
      } 
      
      
      df <- data.frame(JustinBieber = cntB, JamieMiller = cntM, ShawnMendes = cntS)
      df
      write.csv(df, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Lab_8/artist.csv", row.names = FALSE)
      vecName <- c("Justin Bieber", "Jamie Miller", "Shawn Mendes")
      vec <- c(cntB, cntM, cntS)
      cnt <- data.frame(Artist = vecName, Count = vec)
      cnt_m <- matrix(1:3, nrow = 1)
      cntt <- 1
      for(i in vecName){
        ppl_df[,cntt] = vec[i]
        cntt <- cntt + 1
      }
      title <- "Favourite Artist"
      colour <- c("#778899", "#ffcaaf", "#c6e2e9")
      barplot(vec, main = title,
              xlab = "Artist", ylab = "Popularity",
              names.arg = vecName, width = 0.5, col = colour)

    })

})
