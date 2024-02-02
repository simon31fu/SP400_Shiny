#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(plotly)
function(input, output, session) {
  
  user_selection <- reactive({
    input$userticker
  })
  
  #Filter
  selected_stock <- reactive({
    filter(x, symbol == user_selection())
  })
  
  output$stock_table <- renderPlotly({
      # Get the sector of the selected symbol
      selected_sector <- selected_stock()$sector
      
      # Filter data based on the sector
      same_sector_stocks <- filter(x, sector == selected_sector)
      
      # Sort the filtered data frame in descending order based on weight
      sorted_stocks <- arrange(same_sector_stocks, desc(weight))
      
      # Get top 2 rows
      top_stocks <- head(sorted_stocks, 2)
      
      # Get stock prices for the top 2 stocks
      
      prices_df <- top_stocks$symbol %>%
        tq_get(get = 'stock.prices', from = '2020-01-01', to = '2023-01-31') %>%
        select(symbol, date, adjusted) %>%
        group_by(symbol) %>%
        mutate(
          ret_log = log(adjusted/lag(adjusted))
        )
      
      plotly::plot_ly(data = prices_df, x = ~date, y = ~ret_log, type = 'scatter', mode = 'lines', name = ~symbol)
    }
  }