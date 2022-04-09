library(shiny)

ui <- fluidPage(
  titlePanel("Page with Slide Input Demo"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 10, min = 1, max = 50)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("hist")),
        tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
)

server <- function(input, output){
  output$hist <- renderPlot({
    hist(rnorm(input$num))
    })
  output$summary <- renderPrint({summary(rnorm(input$num))})
}

shinyApp(ui=ui, server=server)
