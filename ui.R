#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

fluidPage(
  
  titlePanel("Sector Top Stock Comparer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("userticker", "Choose a ticker:", choices = tickers),
    ),
    mainPanel(
      shiny::plotOutput("stock_table")
    )
  )
)