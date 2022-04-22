#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

shinyServer(function(input, output) {
  valuesM <- reactiveValues(totalM=0)
  observeEvent(input$numPpl, {
    if(input$select == "M"){
      valuesM$totalM <- valuesM$totalM + input$numPpl
      vectorM <- data.frame(Type = "McDonald's", People = input$numPpl, Time = input$selectTime)
      write.table(vectorM, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/mcd_data.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  valuesK <- reactiveValues(totalK=0)
  observeEvent(input$numPpl, {
    if(input$select == "K"){
      valuesK$totalK <- valuesK$totalK + input$numPpl
      vectorK <- data.frame(Type = "KFC", People = input$numPpl, Time = input$selectTime)
      write.table(vectorK, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/kfc_data.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  valuesP <- reactiveValues(totalP=0)
  observeEvent(input$numPpl, {
    if(input$select == "P"){
      valuesP$totalP <- valuesP$totalP + input$numPpl
      vectorP <- data.frame(Type = "PizzaHut", People = input$numPpl, Time = input$selectTime)
      write.table(vectorP, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/phut_data.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  output$myMap <- renderLeaflet({
    data1 <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/mcd_locations.csv")
    if(input$select == "M"){
      data1 <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/mcd_locations.csv")
    }
    else if(input$select == "K"){
      data1 <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/kfc_locations.csv")
    }
    else if(input$select == "P"){
      data1 <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/phut_locations.csv")
    }
    leaflet(data = data1) %>% addProviderTiles(providers$Stamen.TonerLite, 
                                               options = providerTileOptions(noWrap = TRUE))%>% addMarkers(~longitude, ~latitude, popup = ~as.character(store_name), label = ~as.character(store_name))
  })
  peakHours <- function(x_name, read){
      ppl_df <- matrix(1:24, nrow = 1)
      cnt <- 1
      for(i in x_name){
        one <- subset(read, Time==i)
        sumPpl <- sum(one$People) 
        ppl_df[,cnt] = selectionTime(i, sumPpl) 
        cnt <- cnt + 1
      }
    return(ppl_df)
  }
  output$plotPeakHrs <- renderPlot({
    x_name <- c("0000", "0100", "0200", "0300", "0400", "0500", "0600", "0700", 
                "0800", "0900", "1000", "1100", "1200", "1300", "1400", "1500", 
                "1600", "1700", "1800", "1900", "2000", "2100", "2200", "2300")
    ppl_df <- matrix(1:24, nrow = 1)
    title <- " "
    #read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/mcd_data.csv")
    # 
    # ppl_df <- matrix(1:6, nrow = 1)
    # cnt <- 1
    # for(i in x_name){
    #   one <- subset(read, Time==i)
    #   sumPpl <- sum(one$People) 
    #   ppl_df[,cnt] = selectionTime(i, sumPpl) 
    #   cnt <- cnt + 1
    # }
    if(input$select == "M"){
      read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/mcd_data.csv")
      ppl_df <- peakHours(x_name, read)
      title <- "McDonald's Peak Hours"
    }
    else if(input$select == "K"){
      read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/kfc_data.csv")
      ppl_df <- peakHours(x_name, read)
      title <- "KFC Peak Hours"
    }
    else if(input$select == "P"){
      read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2/phut_data.csv")
      ppl_df <- peakHours(x_name, read)
      title <- "PizzaHut Peak Hours"
    }
    
    colour <- c("#778899", "#ffcaaf", "#c6e2e9", "#cac8f4", "#f1ffc4")
    barplot(ppl_df, main = title,
            xlab = "Time", ylab = "Number of People",
            names.arg = x_name, width = 0.5, col = colour)
  })
  
  selectionTime <- function(time, sum){
    if(time == input$selectTime){
      #sum <- sum + input$numPpl - input$numPpl
      sum <- sum + input$numPpl
    }
    return(sum)
  }
})
