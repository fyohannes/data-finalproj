#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(fs)
library(sf)
library(gganimate)
library(shinythemes)
#Will allow me to put themes and designs
library(leaflet)
library(leaflet.extras)
#These two libraries will help me make my map
library(readr)
library(tidyverse)


un_graph <- read_rds("UN.rds")
world_bank <- read_rds("Worldbank.rds")
map <- read_rds("map.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("superhero"),
   
   # Application title
   titlePanel("Ethiopia Economic Development"),
   
   tabsetPanel(
     tabPanel("Economic Changes", 
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "input_1",
          label = "Economic Changes",
          choices = c(
            "GDP Per Capita" = "GDP per capita",
            "Employment Rate in Agriculture" = "Employment in agriculturee",
            "Different Job Sectors" = "Economy"
          )
        )
          ),
      
      # # Show a tabset that includes a About,Economic Change, and Social Indicators,and Summary
      #of the generated distribution
      mainPanel(
        plotOutput("Economic_Changes")) 
          )
   ),
   tabPanel("Economic Indicators for the World Bank", 
            # Sidebar with a slider input for number of bins 
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  inputId = "input_4",
                  label = "Economic Indicators ",
                  choices = c(
                    "Taxes on income, profits and capital gains (% of revenue)" = "Taxes on income, profits and capital gains (% of revenue)",
                    "Total greenhouse gas emissions (kt of CO2 equivalent)" = "Total greenhouse gas emissions (kt of CO2 equivalent)",
                    "Merchandise imports (current US$)" = "Merchandise imports (current US$)"
                  ))
              ),
              
              # # Show a tabset that includes a About,Economic Change, and Social Indicators,and Summary
              #of the generated distribution
              mainPanel(
                plotOutput("Economic_Indicators3"))
            )
   ),
   tabPanel("Social Indicators for the UN", 
            # Sidebar with a slider input for number of bins 
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  inputId = "input_2",
                  label = "Social Indicators ",
                  choices = c(
                    "Fertility Rate (live births per Woman)" = "Fertility rate, totalj",
                    "Refugees and People of Concern to the UNHRC" = "Refugees and others of concern to UNHCR 000"
                  ))
              ),
              
              # # Show a tabset that includes a About,Economic Change, and Social Indicators,and Summary
              #of the generated distribution
              mainPanel(
                plotOutput("Social_Indicators1"))
            )
   ),
   tabPanel("Social Indicators for the World Bank", 
            # Sidebar with a slider input for number of bins 
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  inputId = "input_5",
                  label = "Social Indicators",
                  choices = c(
                    "Primary School Enrollment by gender"="School enrollment, primary",
                    "Mortality Rate under the age of 5"= "Mortality rate, under-5",
                    "Incidents of Malaria"= "Incidence of malaria",
                    "Number of Maternal Deaths"= "Number of maternal deaths",
                    "Primary School Enrollment for males"="School enrollment, primary, male ",
                    "Primary School Enrollment for females"="School enrollment, primary, female",
                    "Access to electricity(% of population)"="Access to electricity (% of population)",
                    "Urban population (% of total population)"="Urban population (% of total population)"
                  ),
                  selected = "School enrollment, primary")
              ),
              
              # # Show a tabset that includes a About,Economic Change, and Social Indicators,and Summary
              #of the generated distribution
              mainPanel(
                plotOutput("Social_Indicators5")) 
            )),
            
   tabPanel("Summary",
            mainPanel (
              h2("Purpose behind the Project"),
              h5("In this project, I'm using data from the Worldbank and The UN that shows the social and economic changes that have been occurring in Ethiopia in the last 15 years. The UN data shows data from the last fifteen years, while the Worldbank has data from the last 40. I'm trying to uncover the relationship between the social and economic indicators. Some social indicators include primary school education for male and female children and life expectancy, while the economic indicators show GDP and workforce participation. One would think that the economic growth that Ethiopia has been experiencing would lead to a better living standard for the people of Ethiopia. But is that really the case? Does the economic boom benefit the people, or those in power? The latter part of the question might be a bit difficult to answer giving the scope, but it will be interesting to compare the changes over time.
                 "),
              h2("Conclusions")
              )),
   tabPanel("About",
            mainPanel(
              
              # Provide information about the data source 
              
              h2("The Data"),
              h5("These visualizations are based on data from the World Bank and the United Nations"), 
              # understand what is being presented
              h6("The World Bank:Ethiopia",href="https://data.worldbank.org/country/ethiopia"),
              h6("Ethiopia", href="http://data.un.org/en/iso/et.html"),
              # Ensure that the minimum relevant background is provided to)
              
              
              
              h5("Citation"),
              h6("The World Bank and The United Nations "),
              
              # Include information about the app author so that anyone impressed by my Shiny App can contact me to offer me a job
              
              h2("About Me: Feven Yohannes"),
              h5("I am a Harvard undergraduate studying Government and Economics. My family is orginally from Eritrea and Ethiopia and I am interested in following the current event issues in these countries."),
              h5("Contact me at fyohannes@college.harvard.edu or connect with me on LinkedIn", a("HERE", href="https://www.linkedin.com/in/feven-yohannes-06190118a/")),
              
              # Include a link to the Source Code for reproducibility and credibility
              
              h2("Source Code"),
              h5("The source code for this Shiny App can be found at my GitHub", a("HERE", href=""))
            ))
   

   )
   )

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$Economic_Changes <- renderPlot({
      un_graph$value_new <- as.numeric(un_graph$value_new)
      
      if(input$input_1 %in% c("GDP per capita","Employment in agriculturee")){
      un_graph %>%
      filter(str_detect(merged,fixed(input$input_1))) %>%
      ggplot(aes(x=Years,y=value_new,group=merged)) +geom_point(color="red") +geom_line() +
      labs(
        title="A measure of Economic Change #looking at input",
        x="Year",
        y=input$input_1)}
      else{
        
      un_graph %>%
          filter(str_detect(merged,fixed("Economy"))) %>%
          ggplot(aes(x=Years,y=value_new, group=merged)) +geom_point(color="purple") +
          #Changing the alpha transparency of the points
          geom_smooth(se= FALSE, method = "lm") +
          #Adding a best fit line
          facet_grid(. ~ merged) +
          labs(title = "Change in job sectors",
               x = "Years",
               y= "% of employed population")}
      
  })
  output$Social_Indicators1 <- renderPlot({
      un_graph$value_new <- as.numeric(un_graph$value_new)
      un_graph %>%
      filter(str_detect(merged,fixed(input$input_2))) %>%
      ggplot(aes(x=Years,y=value_new,group=merged)) +geom_point(color="green") +geom_line() +
      labs(
        title="A measure of change with a Social Indicator from the UN #looking at input",
        x="Year",
        y=input$input_2
      )
  })
  output$Social_Indicators <- renderPlot({
    world_bank$value <- as.numeric(world_bank$value)
    world_bank %>%
      filter(value != "NA" ) %>%
      filter(str_detect(Indicator.Name,fixed(input$input_3))) %>%
      ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
      labs(
        title="A measure of change with a Social Indicator from the World Bank #looking at input",
        x="Year",
        y=input$input_3
      )
      
  })
  output$Economic_Indicators3 <- renderPlot({
    world_bank$value <- as.numeric(world_bank$value)
    if(input$input_4 == "Taxes on income, profits and capital gains (% of revenue)"){
    world_bank %>%
      filter(value != "NA" ) %>%
      filter(str_detect(Indicator.Name,fixed(input$input_4))) %>%
      ggplot(aes(x=Years_new,y=value)) +geom_col(fill="lightblue") +
      labs(
        title="A measure of Economic Change from the World Bank #looking at input",
        x="Year",
        y=input$input_4
      )}
    else {
      world_bank %>%
        filter(value != "NA" ) %>%
        filter(str_detect(Indicator.Name,fixed(input$input_4))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="blue") +
        labs(
          title="A measure of Economic Change from the World Bank #looking at input",
          x="Year",
          y=input$input_4
        ) 
    }
  })
  output$Social_Indicators5 <- renderPlot({
    world_bank$value <- as.numeric(world_bank$value)
    if(input$input_5 %in% c("School enrollment, primary")) {
      world_bank %>%
        filter(str_detect(Indicator.Name,fixed("School enrollment, primary"))) %>%
        filter(!str_detect(Indicator.Name,"private")) %>%
        filter(str_detect(Indicator.Name,fixed("% gross"))) %>%
        ggplot(aes(x=Years_new,y=value,color=Indicator.Name)) +geom_point() +
        geom_smooth(se = FALSE, method = "lm") + 
        labs(
          title= paste(input$input_5, "by gender"),
          x="Year",
          y= "School Enrollemnt as Gross Percent of Primary School Population")
    }
    else{
      world_bank %>%
        filter(value != "NA" ) %>%
        filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
        geom_smooth(se = FALSE, method = "lm") +
        labs(
          title="A measure of change with a Social Indicator from the World Bank #looking at input",
          x="Year",
          y=input$input_5)
    }
  })
}

  # Run the application 
shinyApp(ui = ui, server = server)

