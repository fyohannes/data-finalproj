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
world_bank_primary <- read_rds("Worldbank_primary.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("superhero"),
   
   # Application title
   titlePanel("Ethiopia Economic Development"),
   tabsetPanel(
     
     #Here, I wanted to have a tab panel that introduced viewers to the country of Ethiopia.
     # I showed a map through leaflet and included a short paragraph on the history.
     
     tabPanel("Ethiopia", 
                mainPanel(
                  h3("Map of Ethiopia"),
                  h6("A map of Ethiopia that shows the largest cities throughout the country"),
                  leafletOutput("m"),
                  h3("Ethiopia's Political and Economic History"),
                  h4("Ethiopia is a multi-ethnic country in Eastern Africa and is often known as one of the only countries in Africa to have not been colonized. They are home to a vibrant and long-lasting culture, stemming from the Kingdom of Aksum the Abyssinian Empire. Over the last eighty years, Ethiopia has seen great political and economic change. Haile Selassie succeeded Empress Regnant, Zewditu, in 1930, and ruled during the fight against Italian colonization. He was disposed of his leadership in 1974 by the Derg, a communist party backed by the Soviet Union, which completely changed the political arena, civil rights and liberties, as well as the economy. Mengistu, the acting dictator, was overthrown by the Ethiopian People’s Revolutionary Democratic Front. Currently, Dr. Abiy Ahmed, a progressive leader, has made massive economic reforms and has attempted to allow for more political freedom, while also dealing with the consequences of ethnic tensions.") 
              ))
    ,
    
    #This tab panel will show different indicators from the UN.
    
     tabPanel("Economic Changes", 
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
  
#This side bar panel will have different output options depending on the choice chosen. The input id connects with my output below which filters for the choice selected.
        
        selectInput(
          inputId = "input_1",
          label = "Economic Changes",
          choices = c(
            "GDP Per Capita in US Dollars" = "GDP per capita",
            "Employment Rate in Agriculture (% of gross value added)" = "Employment in agriculturee",
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
                    "Fertility Rate (live births per Woman)" = "Fertility rate",
                    "Refugees and People of Concern to the UNHRC" = "Refugees and others of concern to UNHCR"
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
    
#Including a summary page to explain motives and conclusions.

   tabPanel("Summary",
            mainPanel (
              h2("Purpose behind the Project"),
              h5("In this project, I'm using data from the Worldbank and The UN that shows the social and economic changes that have been occurring in Ethiopia in the last 15 years. The UN data shows data from the last fifteen years, while the Worldbank has data from the last 40. I'm trying to uncover the relationship between the social and economic indicators. Some social indicators include primary school education for male and female children and life expectancy, while the economic indicators show GDP and workforce participation. One would think that the economic growth that Ethiopia has been experiencing would lead to a better living standard for the people of Ethiopia. But is that really the case? Does the economic boom benefit the people, or those in power? The latter part of the question might be a bit difficult to answer giving the scope, but it will be interesting to compare the changes over time.
                 "),
              h2("Conclusions"),
              h5("By looking at the data, we can see that there has been massive economic development, especially in recent years. GDP per capita has substantially increased since 2010 with a GDP per capita of as of 2018. Furthermore, more people are straying away from the agricultural sector and are moving to the industry and service sectors, with the service exceeding 40 percent of the employed population. These upwards trend of development are also prevalent in some of the social indicators. For example, primary school enrollment has increased, mortality for children under the age of five and number of maternal deaths has declined incredibly. These indicators are especially significant to analyze, because often times the prosperity of a nation’s youth and female population can indicate the conditions of the country. From these indicators, as well as other indicators such as expected life expectancy and access to electricity, we can assume that the one’s general well-being in life has improved. Naturally, with any economic development, comes great social and environmental consequences. One can see that total greenhouse gas emissions of carbon dioxide has skyrocketed since 2000 in conjunction with more economic development such as manufacturing and urbanization. Additionally, refugees and those who the United Nations Human Right’s Committee deem as a people at risk, has increased since 2005. This is something interesting to look it because one would not expect this upward trend with increased living standards and improvement of the country’s overall economy. However, this demonstrates some of the problems that can arise with a rapid development. Thus, although economic development has not caused issues such as increased refugees, the subsequent effects of increased socioeconomic gaps, and consequences of urbanization could lead ti increased violence, especially with heightened ethnic tensions, leading to increased refugees. Overall, it is interesting to compare the state of the country and the people in comparison to the growth of the economy.")
              )),
   tabPanel("About",
            mainPanel(
              
              # Provide information about the data source 
              
              h2("The Data"),
              h5("These visualizations are based on data from the World Bank and the United Nations."), 
              h5("Note about the Data: 
                 
              Similiar to other developing countries, the data conducted in Ethiopia throughout the last 50 years has been incomplete. Thus, there were many misisng values for different indicators; however, the plots derived from these datasets do not show these values as missing, but may"),
  
               # Understand what is being presented
             
              h6("The World Bank:Ethiopia", a("HERE", href="https://data.worldbank.org/country/ethiopia")),
              h6("The UN:Ethiopia", a("HERE", href="http://data.un.org/en/iso/et.html")),
              # Ensure that the minimum relevant background is provided to)
              
              
              # Include information about the app author so that anyone impressed by my Shiny App can contact me to offer me a job
              
              h2("About Me: Feven Yohannes"),
              h5("I am a Harvard undergraduate studying Government and Economics. My family is orginally from Eritrea and Ethiopia, and I am interested in following the current event issues in these countries."),
              h5("Contact me at fyohannes@college.harvard.edu or connect with me on LinkedIn", a("HERE", href="https://www.linkedin.com/in/feven-yohannes-06190118a/")),
              
              # Include a link to the Source Code for reproducibility and credibility
              
              h2("Source Code"),
              h5("The source code for this Shiny App can be found at my GitHub", a("HERE", href="https://github.com/fyohannes/final_project_Ethiopia.git"))
            ))
   

   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$Economic_Changes <- renderPlot({
      un_graph$value_new <- as.numeric(un_graph$value_new)
      
      #Making an ifelse statement so I can render different outputs within the same sidebar panel
      
      if(input$input_1 %in% c("GDP per capita","Employment in agriculturee")){
      un_graph %>%
      filter(str_detect(merged,fixed(input$input_1))) %>%
      
      #Filtering within my merged column to get the indicator chosen above in my sidebar panel
      #Graphing with ggplot like usual
          
      ggplot(aes(x=Years,y=value_new,group=merged)) +geom_point(color="red",size=3) +geom_line() +
      labs(
        title=paste("Economic Change looking at", input$input_1),
        x="Year",
        y=input$input_1)}
      else{
      
      #Making my facet grid graph for different sectors in employment
        
      un_graph %>%
          filter(str_detect(merged,fixed("Economy"))) %>%
          ggplot(aes(x=Years,y=value_new, group=merged)) +geom_point(color="purple") +
          
          #Changing the alpha transparency of the points
          
          geom_smooth(se= FALSE, method = "lm") +
          
          #Adding a best fit line
          #Using facet_grid to look at multiple sectors within on graph
          
          facet_grid(. ~ merged) +
          labs(title = "Change in Job Sectors",
               x = "Years",
               y= "% of employed population")}
      
  })
  output$Social_Indicators1 <- renderPlot({
      un_graph$value_new <- as.numeric(un_graph$value_new)
      
      #Making an if else statement 
      
      if(input$input_2 %in% c("Fertility rate")){
      un_graph %>% 
      filter(str_detect(merged,fixed(input$input_2))) %>%
      ggplot(aes(x=Years,y=value_new,group=merged)) +geom_point(color="purple",size=3) +geom_line() +
      labs(
        title=paste("Average Fertility Rates for Women"),
        x="Year",
        y="Births per Woman"
      ) }
     
       #Making an output for my refugee plot 
      
      else{
        un_graph %>% 
          filter(str_detect(merged,fixed(input$input_2))) %>%
          ggplot(aes(x=Years,y=value_new,group=merged)) + geom_col(fill="palegreen3") +
          
          #Found some cool ggplot colors for my graph 
          
          labs(
            title=paste("Change in Number of Refugees and People at Risk According to the United Nations"),
            x="Year",
            y="Number of Refugees (thousands)"
          )
      }
  })
  output$Social_Indicators <- renderPlot({
    world_bank$value <- as.numeric(world_bank$value)
    world_bank %>%
      
      #Filter for NA
      
      filter(value != "NA" ) %>%
      filter(str_detect(Indicator.Name,fixed(input$input_3))) %>%
      ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
      labs(
        title=paste("A measure of Social change in regards to", input$input_3),
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
        title=paste("Taxes on income, profits and capital gains"),
        x="Year",
        y="% of revenue"
      )}
    else if(input$input_4 == "Total greenhouse gas emissions (kt of CO2 equivalent)") {
      world_bank %>%
        filter(value != "NA" ) %>%
       
         #Filtering out NA's
        
        filter(str_detect(Indicator.Name,fixed(input$input_4))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_line(color="blue") +
        labs(
          title=paste("Total greenhouse gas emissions (kt of CO2 equivalent)"),
          x="Year",
          y="kt of CO2 equivalent"
        ) 
    }
    else{
      world_bank %>%
        filter(value != "NA" ) %>%
        filter(str_detect(Indicator.Name,fixed(input$input_4))) %>%
        filter(str_detect(Indicator.Name,fixed("current US"))) %>%
        
        #I filtered just to get the value wanted in US dollars
        
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
        
        #Making a regression
       
         geom_smooth(se = FALSE, method = "lm") +
        labs(
          title=paste("Merchanise Imports"),
          x="Year",
          y=input$input_4)
    }
  })
  output$Social_Indicators5 <- renderPlot( {
    world_bank$value <- as.numeric(world_bank$value)
    if(input$input_5 %in% c("School enrollment, primary")) {
      world_bank %>%
        filter(str_detect(Indicator.Name,fixed("School enrollment, primary"))) %>%
        
        #Filtering out for private school and only filtering for gross enrollment rates
        
        filter(!str_detect(Indicator.Name,"private")) %>%
        filter(str_detect(Indicator.Name,fixed("% gross"))) %>%
        ggplot(aes(x=Years_new,y=value,color=Indicator.Name)) +geom_point() +
       
         #Regression of my graph
        
        geom_smooth(se = FALSE, method = "lm") + 
        labs(
          title= "Primary School Enrollment by gender",
          x="Year",
          y= "Gross Percent of Primary School Population")
    }
    else if(input$input_5 == "Number of maternal deaths") {
      world_bank %>%
        filter(value != "NA" ) %>%
       
         #Filtering out NA's
       
        filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_col(fill="firebrick4") +
        labs(
          title=paste("Maternal Deaths"),
          x="Year",
          y=input$input_5
        )}
    else if(input$input_5 == "Incidence of malaria") {
      world_bank %>%
        filter(value != "NA" ) %>%
        
        #Filtering out NA's
       
         filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
        geom_smooth(se = FALSE, method = "lm") + 
        labs(
          title=paste("Incidents of Malaria"),
          x="Year",
          y="Number of Incidents(per 1,000 people)"
        ) 
    }
    else if(input$input_5 == "Mortality rate, under-5") {
      world_bank %>%
        filter(value != "NA" ) %>%
       
         #Filtering out NA's
        
        filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="red") + geom_smooth(se = FALSE, method = "lm") + 
        labs(
          title=paste("Mortality rate under-5"),
          x="Year",
          y="Number of deaths per 1,000 live births"
        )}
    
      else if(input$input_5 == "Urban population (% of total population)") {
        world_bank %>%
          filter(value != "NA" ) %>%
          #Filtering out NA's
          filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
          ggplot(aes(x=Years_new,y=value)) +geom_col(fill="orchid2") +
          labs(
            title="Urban population",
            x="Year",
            y="% of total population"
          ) 
    }
    else{
      world_bank %>%
        filter(value != "NA" ) %>%
        filter(str_detect(Indicator.Name,fixed(input$input_5))) %>%
        ggplot(aes(x=Years_new,y=value)) +geom_point(color="orange") +
        
        #Making a regression
       
         geom_smooth(se = FALSE, method = "lm") +
        labs(
          title=paste("A measure of Social change in regards to", input$input_5),
          x="Year",
          y=input$input_5)
    }
    })
  output$m <- renderLeaflet({
   
    # Making a map with leaflet
    #I customized the viewing frame and alsi allowed dragging of the curser 
    
    m <- leaflet(options = leafletOptions(dragging = TRUE,
                                          minZoom = 5,
                                          maxZoom = 8)) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)  %>% 
     
       #Making the map have cities and population as a pop up
      
      addMarkers(lng=map$lng, lat=map$lat,popup = paste("City", map$city, "<br>",
                                                          "Population:", map$population_proper, "<br>"))
      m
  
  })
}

  # Run the application 
shinyApp(ui = ui, server = server)

