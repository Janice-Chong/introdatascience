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
library(RSQLite)

#data <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/dataBranch.csv")


 #conn <-  dbConnect(RSQLite::SQLite(), "branch.db")
 #dbGetQuery(conn, "SELECT * FROM branch_data")
# dbGetQuery(conn,"SELECT branch, people, amtSpent, time FROM branch_data
#                  WHERE time >= 1500")
# dbExecute(conn, "DELETE FROM branch_data WHERE branch = 'TTDI'")
# dbGetQuery(conn, "SELECT * FROM branch.db")

# Write the csv dataset into a table names branch_data
#dbWriteTable(conn, "branch_data", data)
# List all the tables available in the database
#dbListTables( branch_data")
# dbExecute(conn, "INSERT INTO branch_data VALUES
#           ('TTDI', 3, 35, 1530)")
# dbGetQuery(conn, "SELECT * FROM branch_data")
#dbDisconnect(conn)



shinyServer(function(input, output) {
  values <- reactiveValues(totalF=0)
  profitBB <- reactiveValues(totalBB=0)
  observeEvent(input$amountF, {
    if(input$select == "BB"){
      values$totalF <- values$totalF + input$amountF
      vectorBB <- data.frame(Branch = "Bukit Bintang", People = input$amountF, amtSpent = input$amtPrice, Time = input$selectTime)
      write.table(vectorBB, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  valuesR <- reactiveValues(totalR=0)
  observeEvent(input$amountF, {
    if(input$select == "SP"){
      valuesR$totalR <- valuesR$totalR + input$amountF
      vectorSP <- data.frame(Branch = "Sri Petaling", People = input$amountF, amtSpent = input$amtPrice, Time = input$selectTime)
      write.table(vectorSP, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  valuesU <- reactiveValues(totalU=0)
  observeEvent(input$amountF, {
    if(input$select == "TTDI"){
      valuesU$totalU <- valuesU$totalU + input$amountF
      vectorTT <- data.frame(Branch = "TTDI", People = input$amountF, amtSpent = input$amtPrice, Time = input$selectTime)
      write.table(vectorTT, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  
  valuesE <- reactiveValues(totalE=0)
  observeEvent(input$amountF, {
    if(input$select == "BTS"){
      valuesE$totalE <- valuesE$totalE + input$amountF
      vectorBTS <- data.frame(Branch = "Berjaya Times Square", People = input$amountF, amtSpent = input$amtPrice, Time = input$selectTime)
      write.table(vectorBTS, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  valuesO <- reactiveValues(totalO=0)
  observeEvent(input$amountF, {
    if(input$select == "NU"){
      valuesO$totalO <- valuesO$totalO + input$amountF
      vectorNU <- data.frame(Branch = "NU", People = input$amountF, amtSpent = input$amtPrice, Time = input$selectTime)
      write.table(vectorNU, file = "C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv", sep = ",",append = TRUE, 
                  quote = FALSE, col.names = FALSE, row.names = FALSE)
    }
  })
  valueTot <- reactiveValues(total=0)
  observeEvent(input$amountF, {
    valueTot$total <- valueTot$total + input$amountF
  })
  
  output$vboxF <- shinydashboard::renderValueBox({
    ppl_df <- branchAmt()
    shinydashboard::valueBox(ppl_df[1]+values$totalF-values$totalF, 
                             subtitle = "Bukit Bintang", 
                             icon = icon("cutlery", lib = "font-awesome", verify_fa = FALSE),
                             color = "green", 
                             width = 1)
  })
  output$vboxR <- shinydashboard::renderValueBox({
    ppl_df <- branchAmt()
    shinydashboard::valueBox(ppl_df[2]+valuesR$totalR-valuesR$totalR, 
                             subtitle = "Sri Petaling", 
                             icon = icon("bank", lib = "font-awesome", verify_fa = FALSE),
                             color = "orange", 
                             width = 1)
  })
  output$vboxU <- shinydashboard::renderValueBox({
    ppl_df <- branchAmt()
    shinydashboard::valueBox(ppl_df[3]+valuesU$totalU-valuesU$totalU, 
                             subtitle = "TTDI", 
                             icon = icon("bolt", lib = "font-awesome", verify_fa = FALSE),
                             color = "light-blue", 
                             width = 1)
  })
  output$vboxE <- shinydashboard::renderValueBox({
    ppl_df <- branchAmt()
    shinydashboard::valueBox(ppl_df[4]+valuesE$totalE-valuesE$totalE, 
                             subtitle = "Berjaya Times Square", 
                             icon = icon("tv", lib = "font-awesome", verify_fa = FALSE),
                             color = "purple", 
                             width = 1)
  })
  output$vboxO <- shinydashboard::renderValueBox({
    ppl_df <- branchAmt()
    shinydashboard::valueBox(ppl_df[5]+valuesO$totalO-valuesO$totalO, 
                             subtitle = "NU", 
                             icon = icon("credit-card", lib = "font-awesome", verify_fa = FALSE),
                             color = "yellow", 
                             width = 0)
  })
  
  output$total <- renderText({
    paste("Total : ", valueTot$total)
  })
  
  branchAmt <- function(){
    read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv")
    branch <- c("Bukit Bintang", "Sri Petaling", "TTDI", "Berjaya Times Square", "NU")
    ppl_df <- matrix(1:length(branch), nrow = 1)
    cnt <- 1
    for(i in branch){
      one <- subset(read, Branch==i)
      sumAmt <- sum(one$amtSpent) 
      ppl_df[,cnt] = selectionBranch(i, sumAmt)
      cnt <- cnt + 1
    }
    return(ppl_df)
  }
  
  # matrixCol <- function(colour){
  #   cnt <- 0
  #   mat_col <- matrix(1:length(colour), nrow = 1)
  #   for(i in colour){
  #     mat_col[, cnt] <- i
  #   }
  #   return(mat_col)
  # }
  
  output$plot1 <- renderPlot({
    read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv")
    branch <- c("Bukit Bintang", "Sri Petaling", "TTDI", "Berjaya Times Square", "NU")
    ppl_df <- matrix(1:length(branch), nrow = 1)
    cnt <- 1
    for(i in branch){
      one <- subset(read, Branch==i)
      sumAmt <- sum(one$amtSpent)
      ppl_df[,cnt] = selectionBranch(i, sumAmt)
      cnt <- cnt + 1
    }
    branch <- c("Bukit Bintang", "Sri Petaling", "TTDI", "Berjaya Times Square", "NU")
    colour <- c("#b5e3d8", "#ffcaaf", "#c6e2e9", "#cac8f4", "#f1ffc4", nrow = 1)
    barplot(ppl_df, main = "Sales McD",
            xlab = "Branches", ylab = "Revenue(RM)",
            names.arg = branch, width = 0.5, col = colour)
  })
  
  output$plot2 <- renderPlot({
    x_name <- c(1300, 1400, 1500, 1600, 1700, 1800)
    read <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Shiny/Fast_Food/Data_Branch.csv")
    
    ppl_df <- matrix(1:6, nrow = 1)
    cnt <- 1
    for(i in x_name){
      one <- subset(read, Time==i)
      sumPpl <- sum(one$People) 
      ppl_df[,cnt] = selectionTime(i, sumPpl) 
      cnt <- cnt + 1
    }
    
    colour <- c("#b5e3d8", "#ffcaaf", "#c6e2e9", "#cac8f4", "#f1ffc4")
    barplot(ppl_df, main = "Peak Hours",
            xlab = "Time", ylab = "Number of People",
            names.arg = x_name, width = 0.5, col = colour)
  })
  
  selectionTime <- function(time, sum){
    if(time == input$selectTime){
      sum <- sum + input$amountF - input$amountF
    }
    # else if(time == 1400){
    #   sum <- sum + input$amountF
    # }
    # else if(time == 1500){
    #   sum <- sum + input$amountF
    # }
    # else if(time == 1600){
    #   sum <- sum + input$amountF
    # }
    # else if(time == 1700){
    #   sum <- sum + input$amountF
    # }
    # else if(time == 1800){
    #   sum <- sum + input$amountF
    # }
    return(sum )
  }
  
  selectionBranch <- function(branch, sum){
    if(branch == input$select){
      sum <- sum + input$amtPrice - input$amtPrice
    }
    return(sum)
  }
  # output$table <- renderTable({
  #   conn <-  dbConnect(RSQLite::SQLite(), "branch.db")
  #   #dbWriteTable(conn, "branch_data", data, append = TRUE)
  #   #dbExecute(conn, "DELETE FROM branch_data ")
  #   dbGetQuery(conn, "SELECT * FROM branch_data")
  #   
  #   
  # })
  
  # on.exit(dbDisconnect(conn))
  
  
})

