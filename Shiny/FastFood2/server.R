# setwd("C:/Users/User/Documents/R/cloned_github/introdatascience/Shiny/FastFood2")
# setwd("D:/User/Documents/Y1S2/WIE2003/Assignments & Assessments/data")
setwd("C:/Users/Janice/Documents/R/introdatascience/Shiny/FastFood2")

library(shiny)
library(plotly)

shinyServer(function(input, output) {
  
  # to record the data into csv
  observeEvent(input$selectTime, {
    if(input$select == "M"){
      vectorM <- data.frame(Type = "McDonald's", Time = input$selectTime)
      write.table(vectorM, file = "mcd_data.csv", sep = ",", append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  observeEvent(input$selectTime, {
    if(input$select == "K"){
      vectorK <- data.frame(Type = "KFC", Time = input$selectTime)
      write.table(vectorK, file = "kfc_data.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  observeEvent(input$selectTime, {
    if(input$select == "P"){
      vectorP <- data.frame(Type = "PizzaHut", Time = input$selectTime)
      write.table(vectorP, file = "phut_data.csv", sep = ",", append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  # locations of fast food chain
  output$myMap <- renderLeaflet({
    location <- read.csv("mcd_locations.csv")
    icon.selected <- list(iconUrl = "https://1000logos.net/wp-content/uploads/2017/03/McDonalds-Logo-1968.png",
                          iconSize = c(48,27))
    
    if(input$select == "M"){
      location <- read.csv("mcd_locations.csv")
      icon.selected <- list(iconUrl = "https://1000logos.net/wp-content/uploads/2017/03/McDonalds-Logo-1968.png",
                            iconSize = c(48,27))
    }
    else if(input$select == "K"){
      location <- read.csv("kfc_locations.csv")
      icon.selected <- list(iconUrl = "https://vectorlogo4u.com/wp-content/uploads/2020/11/KFC-Logo-Vector.png", 
                            iconSize = c(75, 35))
    }
    else if(input$select == "P"){
      location <- read.csv("phut_locations.csv")
      icon.selected <- list(iconUrl = "https://logos-world.net/wp-content/uploads/2021/10/Pizza-Hut-Logo-1999-2010.png", 
                            iconSize = c(48, 27))
    }
    leaflet(data = location) %>% 
      addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
      addMarkers(~longitude, ~latitude, popup = ~as.character(store_name), label = ~as.character(store_name), icon = icon.selected)
  })
  
  #to get total number of locations
  output$numStores <- renderPrint({
    location <- read.csv("mcd_locations.csv")
    
    if(input$select == "M"){
      location <- read.csv("mcd_locations.csv")
    }
    else if(input$select == "K"){
      location <- read.csv("kfc_locations.csv")
    }
    else if(input$select == "P"){
      location <- read.csv("phut_locations.csv")
    }
    nrow(location)
  })
  
  # selectionTime <- function(time, sum){
  #   if(time == input$selectTime){
  #     sum <- sum + 1
  #   }
  #   return(sum)
  # }
  
  # to sum the frequency of time
  peakHours <- function(timeframe, read){
    ppl_df <- matrix(1:24, nrow = 1)
    cnt <- 1
    
    for(i in timeframe){
      one <- subset(read, Time == i)
      #sumPpl <- sum(one$Time) 
      sumRow <- nrow(one)
      ppl_df[,cnt] = sumRow
      # ppl_df[,cnt] = selectionTime(i, sumPpl) 
      cnt <- cnt + 1
    }
    
    return(ppl_df)
  }
  
  # histopgram for peak hours
  output$plotPeakHrs <- renderPlot({
    # timeframe <- c("0", "100", "200", "300", "400", "500", "600", "700", 
    #             "800", "900", "1000", "1100", "1200", "1300", "1400", "1500", 
    #             "1600", "1700", "1800", "1900", "2000", "2100", "2200", "2300")
    
    title <- " "
    
    if(input$select == "M"){
      read <- read.csv("mcd_data.csv")
      title <- "McDonald's Peak Hours"
    }
    else if(input$select == "K"){
      read <- read.csv("kfc_data.csv")
      title <- "KFC Peak Hours"
    }
    else if(input$select == "P"){
      read <- read.csv("phut_data.csv")
      title <- "PizzaHut Peak Hours"
    }
    df_time <- data.frame(read)
    # ppl_df <- peakHours(timeframe, read)
    # colour <- c("#778899", "#ffcaaf", "#c6e2e9", "#cac8f4", "#f1ffc4")
    # barplot(ppl_df, main = title,
    #         xlab = "Time", ylab = "Number of People",
    #         names.arg = timeframe, width = 0.5, col = colour)
    hist(df_time$Time, main = title, xlab = "Time", ylab = "Frequency", breaks = 24, col = "#778899")
  })
  
  
  
  # print peak hour time frame
  output$peakHrsEach <- renderPrint({
    timeframe <- c("0", "100", "200", "300", "400", "500", "600", "700", 
                   "800", "900", "1000", "1100", "1200", "1300", "1400", "1500", 
                   "1600", "1700", "1800", "1900", "2000", "2100", "2200", "2300")
    
    if(input$select == "M"){
      read <- read.csv("mcd_data.csv")
    }
    else if(input$select == "K"){
      read <- read.csv("kfc_data.csv")
    }
    else if(input$select == "P"){
      read <- read.csv("phut_data.csv")
    }
    ppl_df <- peakHours(timeframe, read)
    
    if(which.max(ppl_df) == length(ppl_df)){
      paste(timeframe[which.max(ppl_df)], timeframe[1], sep="-")
    }
    else{
      paste(timeframe[which.max(ppl_df)-1], timeframe[which.max(ppl_df)], sep=" - ")
    }
    
  })
  
  output$plotCarb <- renderPlotly({
    read_nutrition <- read.csv("nutrition.csv")
    plot_ly(data = read_nutrition, x = ~Calories, y = ~Carbohydrates, color = ~Category)
    
  })
  
  output$plotFibre <- renderPlotly({
    read_nutrition <- read.csv("nutrition.csv")
    plot_ly(data = read_nutrition, x = ~Calories, y = ~DietaryFiber, color = ~Category)
  })
  
  output$plotProtein <- renderPlotly({
    read_nutrition <- read.csv("nutrition.csv")
    plot_ly(data = read_nutrition, x = ~Calories, y = ~Protein, color = ~Category)
  })
  
  output$plotSugars<- renderPlotly({
    read_nutrition <- read.csv("nutrition.csv")
    plot_ly(data = read_nutrition, x = ~Calories, y = ~Sugars, color = ~Category)
  })
  
  output$plotSodium<- renderPlotly({
    read_nutrition <- read.csv("nutrition.csv")
    plot_ly(data = read_nutrition, x = ~Calories, y = ~Sodium, color = ~Category)
  })
  
  output$summary_location <- renderPrint({
    if(input$select == "M"){
      read <- read.csv("mcd_locations.csv")
    }
    else if(input$select == "K"){
      read <- read.csv("kfc_locations.csv")
    }
    else if(input$select == "P"){
      read <- read.csv("phut_locations.csv")
    }
    summary(read)
    
  })
  
  output$structure_location <- renderPrint({
    if(input$select == "M"){
      read <- read.csv("mcd_locations.csv")
    }
    else if(input$select == "K"){
      read <- read.csv("kfc_locations.csv")
    }
    else if(input$select == "P"){
      read <- read.csv("phut_locations.csv")
    }
    str(read)
    
  })
  
  
})