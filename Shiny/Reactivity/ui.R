#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict horse power from MPG"),

    sidebarLayout(
        sidebarPanel(
           sliderInput("sliderMPG", "What is the MPG of the car?",
                       10, 35, value = 20),
           checkboxInput("show_model1", "Show/hide  model 1", value = TRUE),
           checkboxInput("show_model2", "Show/hide  model 2", value = TRUE),
           submitButton("Submit")
        ),

        mainPanel(
            plotOutput("plot1"),
            h3("Predicted horse power from model 1: "),
            textOutput("predict1"),
            h3("Predicted horse power from model 2: "),
            textOutput("predict2")
        )
    )
))
