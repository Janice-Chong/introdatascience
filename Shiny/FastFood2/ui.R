#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(RSQLite)
library(leaflet)

shinyUI(fluidPage(
  #for the valuebox
  useShinydashboard(),
  titlePanel("Fast Food Chain in KL"),
  
  #for the background and font
  tags$head(
    # Note the wrapping of the string in HTML()
    tags$style(HTML("
     @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@200&display=swap');
      
      body {
        background-color: #FFFAFA;
        color: black;
      }
      h2 {
        font-family: 'Montserrat', sans-serif;
      }
      .shiny-input-container {
        color: #2F4F4F;
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
      submitButton("Submit", icon = icon("redo"))
    ),
      mainPanel(
        tabsetPanel(
          tabPanel("Map", leafletOutput("myMap")),
          tabPanel("Peak Hours", plotOutput("plotPeakHrs"))
        )
      )
  )
)
)
            
