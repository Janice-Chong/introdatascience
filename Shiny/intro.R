library(shiny)
ui <- fluidPage(
  sliderInput(
    inputId = "num",
    label = "choose a number",
    value = 10, min = 1, max = 50
  ), 
  plotOutput("hist")
)
server <- function(input, output){
  output$hist <- renderPlot({
    tittle <- "50 render normal values"
    hist(rnorm(input$num))
  })
}
shinyApp(ui = ui, server = server)

