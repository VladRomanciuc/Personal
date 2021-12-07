#Google keywords script

# Install packages
install.packages("readr")
install.packages("gtrendsR")
install.packages("purrr")
install.packages("dplyr")
install.packages("readxl")

# Load packages
library(readr)
library(gtrendsR)
library(purrr)
library(dplyr)
library(readxl)

# Extract the keywords from a .csv list
kwlist <- readLines("keywords.csv")

# View the list of keywords
View(kwlist)

# Function to set the geographic region, interested timeframe, search channel and return only the interest_over_time
googleTrendsData <- function (keywords) { 
  country <- c('GB') 
  time <- ("2017-01-01 2021-01-01") 
  channel <- 'web' 
  
  trends <- gtrends(keywords, 
                   gprop = channel,
                   geo = country,
                   time = time ) 
  
  results <- trends$interest_over_time 
}

# Check and return error message in console if encountered
output <- data.frame()

#Mapping and export the results as a .csv file
for (i in c(1:length(kwlist))) {
  try({
    output_new = map_dfr(.x = kwlist[i],
                         .f = googleTrendsData) %>%
      data.frame()
    output <- rbind(output, output_new)
  })
  write.csv(output, 'keywordsresults.csv')
}
