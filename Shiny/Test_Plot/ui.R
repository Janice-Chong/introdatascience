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
  #setBackgroundColor("#F0FFF0"),
  
  # setBackgroundColor(
  #   color = c("#F7FBFF", "#2171B5"),
  #   gradient = "radial",
  #   direction = c("top", "left")
  # ),
  
  setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "linear",
    direction = "bottom"
  ),
  
  useShinydashboard(), #for the valuebox
  
  titlePanel("Book Keeping"),
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
      valueBoxOutput("vboxF", width = 5),
      valueBoxOutput("vboxR", width = 5),
      valueBoxOutput("vboxU"),
      valueBoxOutput("vboxE"),
      valueBoxOutput("vboxO"),
      plotOutput("plot1")
      
    )
  )
))
