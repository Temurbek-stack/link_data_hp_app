source('share_load.R')

ui <- fluidPage(
  theme = shinytheme("cerulean"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "animate.min.css")
  ),
  tags$head(
    tags$style(HTML("

/* Set background color */
body {
  background-color: #f7f7f7;
}

/* Set font */
body {
  font-family: Arial;
  font-size: 14px;
}

/* Set navigation bar color */
.navbar {
  background-color: #003049;
  border-color: #003049;
}

/* Set navigation bar text color */
.navbar-inverse .navbar-nav>li>a {
  color: #003049;
}

/* Set tab labels color */
.nav-tabs>li>a {
  color: #555;
}

/* Set active tab color */
.nav-tabs>li.active>a, 
.nav-tabs>li.active>a:focus, 
.nav-tabs>li.active>a:hover {
  background-color: #003049;
  color: #fff;
}

/* Set text input style */
input[type=text], 
input[type=number], 
select {
  border-radius: 0;
  border-color: #ddd;
  background-color: #fff;
}

/* Set button style */
.btn-primary {
  background-color: #2c3e50;
  border-color: #2c3e50;
}

/* Set table style */
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: right;
  padding: 6px;
}

th {
  font-weight: bold;
  background-color: #fff;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

/* Set icon color */
.fa {
  color: #2c3e50;
}

h3 {
        color: #E51A4B;
      }
      
      
    "))
  ),
  tags$head(
    tags$link(rel = "stylesheet", 
              type = "text/css", 
              href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css")
  ),
  
  tags$script(HTML("
    $(document).on('shiny:value', function(event) {
      if (event.name === 'predicted_price') {
        window.scrollTo(0, 0);
      }
    });
  ")),
  
  navbarPage(
    tags$head(
      tags$style(HTML("
      .navbar { 
        position: fixed; 
        width: 100%; 
        z-index: 100; 
      }
    ")),
      tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML")
    ),
    title = tags$a(tags$img(src = "Logo/Logo2.png", height = "20px", width = "auto"),
                   href = "https://www.linkdata.uz/"),
    windowTitle = "MyApp",
    id = "nav",
    
    # Here are your panels
    # Wrap each of your panels in a div with class 'main-content'

    # tabPanel("Info",
    #          h3("Information about the App"),
    #          p("Welcome to our pioneering, user-oriented Interactive Dashboard for the Uzbek Car Market. We've meticulously designed and built this dashboard using cutting-edge technology to deliver an all-incompassing and detailed insight into the rapidly shifting car market in Uzbekistan. This dashboard, an amalgamation of in-depth analytics and accessible interfaces, is your tool for gaining valuable insights and making informed decisions."),
    #          p("The dashboard is structured into several dynamic sections, each focusing on a distinct aspect of the market:"),
    # 
    #          # первая
    #          h4("1. Market Overview"),
    #          p("Here you'll find comprehensive, high-level visualization plots offering a wealth of information about the Uzbek car market. We've collated data from Autoelon.uz about cars for sale across various regions of Uzbekistan and coupled this with information from E-notarious.uz about sold cars across these regions. Additionally, you'll find interactive visualizations on price dynamics among car models and market share for all car models for a defined period. By unifying these data points in one place, our aim is to equip you with the information needed to better understand the market dynamics and trends."),
    # 
    #          # вторая
    #          h4("2. Descriptive Analysis"),
    #          p("This section introduces you to the power of data visualization in the context of the Uzbek car market. Detailed maps showcase car models and their locations interactively, enabling you to comprehend the geographical distribution of specific car models. Additionally, you'll find visualizations of car price dynamics over time, fuel types for specified car models, color count, travel distance, transmission types, and more. By synthesizing these various pieces of information into visual, easy-to-understand formats, we empower you to gain a holistic view of the market landscape."),
    #               
    #          # третья
    #          h4("3. Car Price Predictor"),
    #          p("Our advanced Car Price Predictor distinguishes our platform from others. This tool leverages the state-of-the-art Random Forest regression approach, meticulously trained and finely tuned using Bayesian optimization methods. It takes an ensemble approach, averaging predictions from over 100 different finely-tuned Random Forest models, thereby achieving an impressively low mean average error of just 4.2% on the training set. By entering certain car attributes, users receive an estimated price for the car, showcasing the power of modern machine learning and predictive modeling approaches."),
    #           
    #          #четвертая
    #          p("Our relentless commitment to accuracy, relevance, and the latest technology means that our interactive dashboard stands as a testament to the power of modern data visualization and modeling approaches. We are excited to provide a unique perspective on the Uzbekistan car market, offering a smoother, more informed journey for car buyers and sellers. Whether you're an individual, a business, or a researcher, our platform promises a one-of-a-kind experience in navigating the car market dynamics in the region."),
    #          p("We invite you to explore, engage with, and benefit from our dashboard."),
    #          h4("Welcome and happy navigating!")
    # ),
    # 


tabPanel("Оценка Kвартиры",
         br(), br(), br(),
         sidebarLayout(
           sidebarPanel(
             selectInput("location", "B каком районе вы ищете квартиру:", choices = unique_values_dfs[["location"]], selected = "Chilonzor Tumani"),
             sliderInput("n_rooms", "Количество комнат:", min = 1, max = 5, value = 2, step = 1),
             sliderInput("floor_number", "Этаж:", min = 1, max = 40, value = 3, step = 1),
             sliderInput("n_storeys", "Этажность дома:", min = 4, max = 51, value = 4, step = 1),
             sliderInput("total_area_m2", "Общая площадь (м2):", min = 18, max = 250, value = 55, step = 1),
             selectInput("structure", "Планировка:", choices = unique_values_dfs[["structure"]]),
             selectInput("remont", "Pемонт:", choices = unique_values_dfs[["remont"]]),
             selectInput("construction_type", "Тип строения:", choices = unique_values_dfs[["construction_type"]]),
             selectInput("construction_year", "Год постройки/сдачи:", choices = unique_values_dfs[["construction_year"]]),
             selectInput("ceiling_height_category", "Высота потолков:", choices = unique_values_dfs[["ceiling_height_category"]]),
             selectInput("sanuzel", "Санузел:", choices = unique_values_dfs[["sanuzel"]]),
             selectInput("furnished", "Меблирована:", choices = c("Да" = 1, "Нет" = 0)),
             selectInput("market_type", "Тип жилья:", choices = c("Новостройка" = 1, "Вторичный рынок" = 2)),
             selectInput("ownership", "Продавец:", choices = c("Частное" = "Xususiy", "Бизнес" = "Biznes")),
             h2(paste0("Дополнительные")),
             selectizeInput("facilities", "В квартире есть:",
                            choices = c("балкон" = "balcony_fac", "интернет" = "internet_fac", "кабельное тв" = "cabeltv_fac",
                                        # "кондиционер" = "airconditioner_fac", "телевизор" = "tv_fac", "холодильник" = "refrigerator_fac"
                                        "кухня" = "kitchen_fac", "стиральная машина" = "washmachine_fac", "телефон" = "phone_fac"),
                            multiple = TRUE),
             selectizeInput("neighborhood", "Рядом есть:",
                            choices = c("больница" = "hospital_nearby", "детская площадка" = "playground_nearby", "детский сад" = "kindergarten_nearby",
                                        "зелёная зона" = "greenarea_nearby", "кафе" = "cafe_nearby", "магазины" = "markets_nearby",
                                        "остановки" = "busstop_nearby", "парк" = "park_nearby", "поликлиника" = "policlinics_nearby",
                                        "pазвлекательные заведения" = "entertainment_nearby", "рестораны" = "restaurant_nearby",
                                        "стоянка" = "parkingspace_nearby", "супермаркет" = "supermarket_nearby", "школа" = "school_nearby"),
                            multiple = TRUE),
             actionButton("predict", "Oценивать")
           ),

           mainPanel(
             tags$div(
               #class = "animate__animated animate__slideInLeft",
               style = "text-align: center; height: 300px;",
               uiOutput("icons_display", height = "auto")
             ),
             #h3("Estimated price of a car", align = "center"),
             withSpinner(
               uiOutput("predicted_price", style = "text-align:center; font-size: 48px;")
             ),
             br(),
             tags$div(
               style = "text-align: right; padding-right: 10px;",
               textOutput("current_time")
             ),

             br(), br(), br(),
             h2(paste0("Важность переменных в модели Random Forest")),
             fluidRow( width = 6, plotlyOutput('varimportance')),
           )
         )
        )
  )
)

