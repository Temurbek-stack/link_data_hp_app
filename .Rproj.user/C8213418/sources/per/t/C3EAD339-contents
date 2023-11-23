## load
source('share_load.R')

server <- 
  function(input, output, session) {
    
    session$sendCustomMessage(type = 'headers', message = list(
      'X-Frame-Options' = 'ALLOW-FROM https://app.powerbi.com'
    ))
    
    i_prog <- 1
    tot_step <- 30
    
      ### 3rd Tab. Predictor
      withProgress(message = 'Loading...', value = (i_prog-1)/tot_step, {
        # Increment the progress bar, and update the detail text.
        incProgress( i_prog/tot_step, detail = NULL)
        ##Sys.sleep(0.1)

      })
      i_prog <- i_prog + 1

      output$predicted_price <- renderText(NULL)


      observeEvent(input$predict, {
        # Prepare new_flat data
        new_flat <- data.frame(location = as.factor(input$location),
                              n_rooms = as.numeric(input$n_rooms),
                              floor_number = as.numeric(input$floor_number),
                              n_storeys = as.numeric(input$n_storeys),
                              total_area_m2 = as.numeric(input$total_area_m2),
                              structure = as.factor(input$structure),
                              remont = as.factor(input$remont),
                              construction_type = as.factor(input$construction_type),
                              construction_year = as.factor(input$construction_year),
                              ceiling_height_category = as.factor(input$ceiling_height_category),
                              sanuzel = as.factor(input$sanuzel),
                              furnished = as.numeric(input$furnished),
                              market_type = as.numeric(input$market_type),
                              ownership = as.factor(input$ownership)
                              
        )
        selected_other_features <- c(input$facilities, input$neighborhood)
#        selected_other_features <- input$neighborhood

        for (feature in neighborhood_and_facilities) {
          new_flat[[feature]] <- ifelse(feature %in% selected_other_features, 1, 0)
        }
        
        unique_locations <- unique_values_dfs[["location"]]
        # Create new columns
        for(loc in unique_locations) {
          loc_clean <- gsub(" ", ".", loc)
          column_loc <- paste("location", loc_clean, sep = "_")
          new_flat[[column_loc]] <- ifelse(new_flat$location == loc, 1, 0)
        }
        
        unique_structure <- unique_values_dfs[["structure"]]
        for(str in unique_structure) {
          str_clean <- gsub(" ", ".", str)
          column_str <- paste("structure", str_clean, sep = "_")
          new_flat[[column_str]] <- ifelse(new_flat$structure == str, 1, 0)
        }
        
        unique_remont <- unique_values_dfs[["remont"]]
        for(rem in unique_remont) {
          rem_clean <- gsub(" ", ".", rem)
          column_rem <- paste("remont", rem_clean, sep = "_")
          new_flat[[column_rem]] <- ifelse(new_flat$remont == rem, 1, 0)
        }
        
        unique_construction_type <- unique_values_dfs[["construction_type"]]
        for(con_type in unique_construction_type) {
          con_type_clean <- gsub(" ", ".", con_type)
          column_con_type <- paste("construction_type", con_type_clean, sep = "_")
          new_flat[[column_con_type]] <- ifelse(new_flat$construction_type == con_type, 1, 0)
        }
        
        unique_construction_year <- unique_values_dfs[["construction_year"]]
        for(con_year in unique_construction_year) {
          con_year_clean <- gsub(" ", ".", con_year)
          column_con_year <- paste("construction_year", con_year_clean, sep = "_")
          new_flat[[column_con_year]] <- ifelse(new_flat$construction_year == con_year, 1, 0)
        }
        
        unique_ceiling_height_category <- unique_values_dfs[["ceiling_height_category"]]
        for(ceiling in unique_ceiling_height_category) {
          ceiling_clean <- gsub(" ", ".", ceiling)
          column_ceiling <- paste("ceiling_height_category", ceiling_clean, sep = "_")
          new_flat[[column_ceiling]] <- ifelse(new_flat$ceiling_height_category == ceiling, 1, 0)
        }
        
        unique_sanuzel <- unique_values_dfs[["sanuzel"]]
        for(san in unique_sanuzel) {
          san_clean <- gsub(" ", ".", san)
          column_san <- paste("sanuzel", san_clean, sep = "_")
          new_flat[[column_san]] <- ifelse(new_flat$sanuzel == san, 1, 0)
        }
        
        unique_ownership <- unique_values_dfs[["ownership"]]
        for(own in unique_ownership) {
          own_clean <- gsub(" ", ".", own)
          column_own <- paste("ownership", own_clean, sep = "_")
          new_flat[[column_own]] <- ifelse(new_flat$ownership == own, 1, 0)
        }
        
        new_flat <- new_flat %>%
          select(-location, -structure, -construction_type, -construction_year, 
                 -sanuzel, -ownership, -ceiling_height_category, -remont)
        
        #browser()
        
        new_flat <- new_flat %>%
          rename(location_Mirzo.Ulug.bek.Tumani=`location_Mirzo.Ulug‘bek.Tumani`, 
                 location_Sirg.ali.tumani=`location_Sirg'ali.tumani`,
                 structure_Смежно.раздельная=`structure_Смежно-раздельная`,
                 construction_year_1960...1979=`construction_year_1960.-.1979`,
                 construction_year_1980...1989=`construction_year_1980.-.1989`,
                 construction_year_1990...2000=`construction_year_1990.-.2000`,
                 construction_year_2001...2010=`construction_year_2001.-.2010`,
                 construction_year_2011...2014=`construction_year_2011.-.2014`,
                 ) %>%
          mutate(month_numeric = floor((year(current_date) - 1970) * 12 + month(current_date) - 1))
        
        # new_flat <- rbind(shinysample[, -1] , new_flat)
        # new_flat <- new_flat[-1,]
        # Define the server logic (continuation)
        predicted_price <- NULL
        predicted_price <- round(predict(model, newdata = new_flat), 0)


        output$predicted_price <- renderUI({
 #         Sys.sleep(2)
          HTML(paste0('<span style="color: #003049">Oценочная Cтоимость Kвартиры:</span>',"<br>", "$ ", round(predicted_price / 100, 0) * 100, " \u00b1 ", round(predicted_price * 5.78 / 10000, 0) * 100))
        })


        output$icons_display <- renderUI({
          # Include Font Awesome icons
          tagList(
            tags$i(class = "fa-solid fa-building-user",
                   style = "font-size: 300px; margin-right: 10px;"),
            tags$i(class = "fa-solid fa-money-check-dollar",
                   style = "font-size: 300px;")
          )
        })
        

      })



      ############ variable importance #############
      varImpPlot(model)

      importance_data <- model$importance
      importance_df <- data.frame(
        Variable = row.names(importance_data),
        Importance = importance_data[,1]
      )
      
      
      
      
      # Function to aggregate importance based on prefixes
      aggregate_importance <- function(prefix, new_name) {
        subset_df <- subset(importance_df, grepl(prefix, Variable))
        if (nrow(subset_df) == 0) return(NULL)
        data.frame(Variable = new_name, Importance = mean(subset_df$Importance))
      }
      
      # Define your mappings
      prefixes_to_aggregate <- list(
        "location_" = "Pайон расположения",
        "structure_" = "Планировка",
        "remont_" = "Pемонт",
        "construction_type_" = "Тип строения",
        "construction_year_" = "Год постройки/сдачи",
        "ceiling_height_category_" = "Высота потолков",
        "sanuzel_" = "Санузел",
        "ownership_" = "Продавец",
        "_nearby" = "Что есть поблизости",
        "_fac" = "Дополнительные удобства в квартире"
      )
      
      # Aggregate and create a new data frame
      aggregated_df <- do.call(rbind, lapply(names(prefixes_to_aggregate), function(prefix) {
        aggregate_importance(prefix, prefixes_to_aggregate[[prefix]])
      }))
      
      # Remove aggregated variables from the original data frame
      importance_df <- importance_df[!grepl(paste(names(prefixes_to_aggregate), collapse="|"), importance_df$Variable), ]
      
      # Combine aggregated data with the remaining variables
      importance_df <- rbind(importance_df, aggregated_df)
      
      # Relabel other variables
      names_mapping <- c(
        n_rooms = "Количество комнат",
        floor_number = "Этаж",
        n_storeys = "Этажность дома",
        total_area_m2 = "Общая площадь",
        furnished = "Меблирована",
        market_type = "Тип жилья",
        month_numeric = "Tенденция по времени"
      )
      # Function to apply the mapping
      apply_mapping <- function(variable_name) {
        if (variable_name %in% names(names_mapping)) {
          return(names_mapping[variable_name])
        } else {
          return(variable_name)
        }
      }
      
      # Apply the mapping to your data frame
      importance_df$Variable <- sapply(importance_df$Variable, apply_mapping)
      
      # Calculate Relative Importance
      total_importance <- sum(importance_df$Importance)
      importance_df$RelativeImportance <- importance_df$Importance / total_importance * 100
      
      # Plot the data
      p <- ggplot(importance_df, aes(x = reorder(Variable, RelativeImportance), y = RelativeImportance)) +
        geom_bar(stat = "identity", fill = "steelblue") +
        geom_text(aes(label = paste0(round(RelativeImportance, 2), "%")),
                  position = position_dodge(width = 0.9), vjust = 0.5, hjust = -0.2) +
        coord_flip() +
        theme_minimal() +
        labs(x = "", y = "Importance")
      
      # Render the plot in Shiny
      output$varimportance <- renderPlotly({
        ggplotly(p) %>%
          layout(paper_bgcolor = "transparent", plot_bgcolor = "transparent", bgalpha = 0, autosize = TRUE)
      })
      
      
  }