library(RTLedu)
library(tidyquant)
x <- RTLedu::sp400_desc
tickers <- sort(unique(x$symbol))
