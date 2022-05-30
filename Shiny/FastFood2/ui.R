library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(RSQLite)
library(leaflet)

shinyUI(fluidPage(
  #for the valuebox
  useShinydashboard(),
  titlePanel("Fast Food Chain in Kuala Lumpur"),
  
  #for the background and font
  tags$head(
    # Note the wrapping of the string in HTML()
    tags$style(HTML("
     @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@200&display=swap');
      
      body {
        background-color: #E6E6FA;
        color: black;
      }
      h2 {
        font-family: Montserrat;
      }
      .shiny-input-container {
        background-color: #4B0082;
        color: #FFFFFF;
        font-family: Montserrat;
        font-weight: bold;
      }"))
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("select","Choose Fast Food Chain:", choices = c("McDonald's"="M", 
                                                                  "KFC"="K",
                                                                  "PizzaHut"="P"),selected = "M"),
      submitButton("Submit", icon = icon("redo")),
      br(),
      numericInput("numPpl", "Enter number of people: ", value=0),
      selectInput("selectTime","Choose Time Range:", choices = c("0000"="0000",
                                                                 "0100"="0100",
                                                                 "0200"="0200",
                                                                 "0300"="0300",
                                                                 "0400"="0400",
                                                                 "0500"="0500",
                                                                 "0600"="0600",
                                                                 "0700"="0700",
                                                                 "0800"="0800",
                                                                 "0900"="0900",
                                                                 "1000"="1000",
                                                                 "1100"="1100",
                                                                 "1200"="1200",
                                                                 "1300"="1300", 
                                                                 "1400"="1400",
                                                                 "1500"="1500",
                                                                 "1600"="1600",
                                                                 "1700"="1700",
                                                                 "1800"="1800",
                                                                 "1900"="1900",
                                                                 "2000"="2000",
                                                                 "2100"="2100",
                                                                 "2200"="2200",
                                                                 "2300"="2300"), selected = "1300"),
      submitButton("Submit", icon = icon("redo")),
      style = "background-color: #4B0082;"
    ),
    
    mainPanel(
      style = "font-family: Montserrat; font-weight: bold;",
      tabsetPanel(
        tabPanel("Map", leafletOutput("myMap"),
                 h5("Total number of stores: ", 
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("numStores")),
        tabPanel("Peak Hours", plotOutput("plotPeakHrs"),
                 h5("Peak hours: ",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("peakHrsEach"))
      )
    )
  )
))
