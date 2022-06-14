library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(RSQLite)
library(leaflet)
library(plotly)

shinyUI(fluidPage(
  #for the valuebox
  useShinydashboard(),
  titlePanel("Hungry?!"),
  
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
      selectInput("selectTime","Choose Time Range:", choices = c("0000"="0",
                                                                 "0100"="100",
                                                                 "0200"="200",
                                                                 "0300"="300",
                                                                 "0400"="400",
                                                                 "0500"="500",
                                                                 "0600"="600",
                                                                 "0700"="700",
                                                                 "0800"="800",
                                                                 "0900"="900",
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
        tabPanel("User",
                 h4("Introduction",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("Welcome to Hungry?!, a Fast Food Tracker in KL App created by Jasmine Chong See Yan, Janice Chong See Wai, Goh Qian Xuan and Ng Qiao Fang."),
                 br(),
                 h4("Datasets",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("Location: Scrapped from Google Maps using a Google Maps scraper by Apify. "),
                 h5("Peak hours: Obtained from user's input."),
                 h5("Nutritional information: Obtained from Kaggle."),
                 br(),
                 h4("Sidebar Panel",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("To track the location of fast food branches:"),
                 h5("1. Please select the fast food chain that you want."),
                 h5("2. Click the submit button."),
                 br(),
                 h5("To help contribute to the peak hours data, you can: "),
                 h5("1. Select the time frame of entering."),
                 h5("2. Click submit button."),
                 br(),
                 h4("Summary & Structure Tab",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("Shows the summary and structure of selected fast food location dataset. By default, McDonald's is shown."),
                 br(),
                 h4("Map Tab",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("Shows all branches of the selected fast food chain. By default, McDonald's is selected."),
                 br(),
                 h4("Peak Hours Tab",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("Shows the peak hours of the fast food chain selected in histogram. By default, McDonald's is shown."),
                 br(),
                 h4("Nutritional Information Tab",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("An overview of nutritional information of common fast food menu."),
                 br()),
        tabPanel("Summary & Structure", 
                 h5("Summary ", 
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("summary_location"),
                 br(),
                 h5("Structure ", 
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("structure_location")),
        
        tabPanel("Map", leafletOutput("myMap"),
                 h5("Total number of stores: ", 
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("numStores")),
        tabPanel("Peak Hours", 
                 h5("Note:",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 h5("0 means 0000 hours, 500 means 0500 hours, 1000 means 1000 hours, etc. ",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 plotOutput("plotPeakHrs"),
                 h5("Peak hours: ",
                    style = "font-family: Montserrat; font-weight: bold;"),
                 verbatimTextOutput("peakHrsEach")),
        tabPanel("Nutritional Information",
                 plotlyOutput("plotCarb"),
                 plotlyOutput("plotFibre"), plotlyOutput("plotProtein"), 
                 plotlyOutput("plotSugars"), plotlyOutput("plotSodium")
                 
        )
      )
    )
  )
))