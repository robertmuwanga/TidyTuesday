library(dplyr)
library(ggplot2)
library(readr)
library(stringr)
library(purrr)

data <- read_csv('EDULIT_DS_06052019101747206.csv')
data <- data %>% select(-TIME) # Remove duplicate column
redundant_data <- 'Pupil-teacher ratio in ' # Redundant string when extracting education type below.

data$Education_type <- str_split(string = data$Indicator, pattern = redundant_data) %>% 
    map_chr(function(x) x[2]) %>% 
    str_split(pattern = '\\(') %>%
    map_chr(function(x) x[1] %>% str_trim)

# Spead of education types over the years
data %>%
    ggplot(aes(x = Education_type)) + 
    geom_bar() + 
    coord_flip() + 
    facet_wrap( ~ Time)


