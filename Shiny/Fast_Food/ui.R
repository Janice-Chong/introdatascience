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

shinyUI(fluidPage(
  setBackgroundColor("#2F4F4F"),
  
  # setBackgroundColor(
  #   color = c("#F7FBFF", "#2171B5"),
  #   gradient = "radial",
  #   direction = c("top", "left")
  # ),
  
  # setBackgroundColor(
  #   color = c("#F7FBFF", "#2171B5"),
  #   gradient = "linear",
  #   direction = "bottom"
  # ),
  
  useShinydashboard(), #for the valuebox
  
  titlePanel("MCD"),
  #navbarPage(title = span( "Book Keeping", style = "background-color: #DEEBF7")),
  tags$head(
    # Note the wrapping of the string in HTML()
    tags$style(HTML("
     @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@200&display=swap');
      
      body {
        background-color: #2F4F4F;
        color: white;
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
      selectInput("select","Choose Branch Location:", choices = c("Bukit Bintang"="BB", 
                                                                   "Sri Petaling"="SP",
                                                                   "TTDI"="TTDI",
                                                                   "Berjaya Times Square"="BTS",
                                                                   "NU Sentral"="NU"), selected = "BB"),
      numericInput("amountF", "Enter number of people: ", value=0),
      numericInput("amtPrice", "Enter amount spent: ", value=0),
      selectInput("selectTime","Choose Time Range:", choices = c("1300"="1300", 
                                                                  "1400"="1400",
                                                                  "1500"="1500",
                                                                  "1600"="1600",
                                                                  "1700"="1700",
                                                                  "1800"="1800"), selected = "1300"),
      #numericInput("amountR", h3("Enter amount for Rent"), value=0),
      # numericInput("amountE", h3("Enter amount for Entertaiment"), value=0),
      submitButton("Submit", icon = icon("redo")),
      #submitButton("Submit")
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Peak Hours", plotOutput("plot2")),
        tabPanel("Sales", 
                 verbatimTextOutput("summary"),
                 br(),
                 valueBoxOutput("vboxF"),
                 valueBoxOutput("vboxR"),
                 valueBoxOutput("vboxU"),
                 valueBoxOutput("vboxE"),
                 valueBoxOutput("vboxO"),
                 absolutePanel(
                   verbatimTextOutput("total"),
                   top = 320,
                   left = 30,
                   draggable = TRUE
                 ), 
                 plotOutput("plot1")
        ),
        tabPanel("Table", tableOutput("table"))
      ),
      # valueBoxOutput("vboxF", width = 5),
      # valueBoxOutput("vboxR", width = 5),
      # valueBoxOutput("vboxU"),
      # valueBoxOutput("vboxE"),
      # valueBoxOutput("vboxO"),
      #plotOutput("plot1")
      
      
    )
  )
))
