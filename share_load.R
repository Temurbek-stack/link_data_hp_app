##  load library --------------------
library(shinydashboard)
library(shinydashboardPlus)
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(stringr)
# library(withr)
library(shinyjs)
# library(magrittr)
# library(scales)
# library(lattice)
# library(leaflet)
# library(leaflet.minicharts)
library(magrittr)
library(shinythemes)
library(shinyWidgets)
library(htmltools)
library(htmlwidgets)
library(shinymaterial)
##necessary only if the prediction tab is deployed together. if not do not load these 7 packages
library(randomForest)
#library(caret)
#library(e1071)
library(ranger)
library(forcats)
library(shinyjs)
library(shinycssloaders)


#load datasets
##needed only for the predict tab
#load("shinysample.rda")
load("unique_values_of_categorical_vars.RData")

## for month variable
current_date <- Sys.Date()

## necessary only for the predict tab
neighborhood_and_facilities <- c("hospital_nearby", "playground_nearby", "kindergarten_nearby", "greenarea_nearby", "cafe_nearby", "markets_nearby",
                                 "busstop_nearby", "park_nearby", "policlinics_nearby", "entertainment_nearby", "restaurant_nearby",
                                 "parkingspace_nearby", "supermarket_nearby", "school_nearby",
                                 "balcony_fac", "internet_fac", "cabeltv_fac",# "airconditioner_fac", "tv_fac", refrigerator_fac"
                                 "kitchen_fac",  "washmachine_fac", "phone_fac")



model <- readRDS("rf_best_trimmed_wo_actvref_50trees.rds")
