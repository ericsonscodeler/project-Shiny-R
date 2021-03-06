library(shinydashboard)
library(shiny)
library(plotly)
library(datasets)

ui <- dashboardPage(skin = "green",
  
  dashboardHeader(
    title = "Grafico para mostra altura e peso medio de mulheres americas entre 30 - 39 anos de idade",
    titleWidth = 1000
  ), #header
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Grafico",tabName = "grafico",icon=icon("chart-bar"))#item
    )#menu
  ),#Sidebar
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "grafico",
              fluidRow(
                box(title = "Grafico Scatter", plotlyOutput("plot1",height = 250)),
                box(title = "Grafico Barra", plotlyOutput("plot2",height = 250)),
                
              fluidRow(
                box(title = "Dataset", tableOutput("data"),width = 5),
              )#fluidRowSecond
                )#fluidRowFirst
              )#item
    )#tabItems
  )#body
)


server<- function(input, output, session) {
  
  output$data <- renderTable({
    head(women)
  })
  
  output$plot1 <- renderPlotly({
    plot_ly(data=women,
            x=~height,
            y=~weight,
            type="scatter",
            mode = "markers")
  })
  
  
  output$plot2 <- renderPlotly({
    plot_ly(data=women,
            x=~height,
            y=~weight,
            type="bar")
  })
  
}
shinyApp(ui = ui, server = server)