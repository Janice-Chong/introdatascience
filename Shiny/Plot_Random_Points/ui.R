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

    titlePanel("Plot Random Numbers"),

    sidebarLayout(
        sidebarPanel(
            numericInput("numeric", "How many random numbers should be plotted?",
                         value = 1000, min = 1, max = 1000, step = 1),
            sliderInput("sliderX", "Pick minimum and maximun X values.", -100, 100, value = c(-50, 50)),
            sliderInput("sliderY", "Pick minimum and maximun Y values.", -100, 100, value = c(-50, 50)),
            checkboxInput("show_xLabel", "Show/Hide x-axis label", value = TRUE),
            checkboxInput("show_yLabel", "Show/Hide y-axis label", value = TRUE),
            checkboxInput("show_title", "Show/Hide title")
        ),

       
        mainPanel(
            h3("Graph of Random Points"),
            plotOutput("plot1")
        )
    )
))
