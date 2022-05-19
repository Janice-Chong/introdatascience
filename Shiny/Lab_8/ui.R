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

    # Application title
    titlePanel("Artist Podium"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
          selectInput("select","Who is your favourite artist:", 
                      choices = c("Justin Bieber"="JB", 
                                  "Jamie Miller"="JM",
                                  "Shawn Mendes"="SM"),selected = "JB")
            
        ),

        # Show a plot 
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
