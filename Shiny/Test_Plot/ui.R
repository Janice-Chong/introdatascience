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
  
  titlePanel("BOOK KEEPING"),
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
      selectInput("select","Choose Expenditure Type:", choices = c("Food"="Food", 
                                           "Rent"="Rent",
                                           "Utilities"="Utilities",
                                           "Entertaiment"="Entertaiment",
                                           "Others"="Others"), selected = "Food"),
      numericInput("amountF", "Enter Amount Spent: ", value=0),
      # numericInput("amountR", h3("Enter amount for Rent"), value=0),
      # numericInput("amountE", h3("Enter amount for Entertaiment"), value=0),
      submitButton("Submit", icon = icon("redo")),
      #submitButton("Submit")
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("plot1")),
        tabPanel("Summary", 
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
                 )
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
