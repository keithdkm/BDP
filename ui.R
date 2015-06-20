shinyUI(fluidPage(
        
       
        titlePanel("Running Race Results Analyzer"),
        
        fluidRow(column(h4("Introduction"),p("Almost all running races are electronically timed and the results made available on the web. Often these results are just a long list of runners and their times and don't allow an 
individual runner to compare his or her performance to runners of the same age and gender.  This application allows that analysis to be done."), p(" As an example of 
what it can do, it has been loaded with data
                   from the 2014 Chilly Half Marathon held in Newton, MA in November, downloaded from the Racewire website. ") , h4("How to Use it"),p('

The app provides two views of the data - a Leaderboard tab that 
                          lists the competitors in the order that they finished their race and a Results Summary tab that plots the distribution of the runners by their gender and age division.
                          The runners can be filtered from both views to exclude genders and age divisions by checking and unchecking the boxes on the left of the page'),offset = 0.25,width =11)),
        sidebarLayout(
                sidebarPanel(
                        checkboxGroupInput("age.range",
                                                label = "Select Runner Age Range",
                                                choices = list(`16-19` = "16-19",
                                                               `20-29` = "20-29",
                                                               `30-39` = "30-39",
                                                               `40-49` = "40-49", 
                                                               `50-59` = "50-59",
                                                               `60 and Over` = "60 and Over"),
                                                selected = c("16-19","20-29","30-39","40-49", "50-59","60 and Over"))
                                    
                                           #                                     
                                           #                                     min = 16,
                                           #                                     max = 67,
                                           #                                     value = c(16,67))
                                           #                         
                        ,
                        checkboxGroupInput("gender",
                                          label = "Select Gender ",
                                          choices = list(Women = "F",Men =   "M"),
                                          selected = c("M","F"))
                             )
                ,              
                                            
                mainPanel(
                        tabsetPanel(    type = "tabs", 
                                        tabPanel("Leaderboard", tableOutput("table")),
                                        tabPanel("Results Summary", 
                                                 h3("Results Distribution"),
                                                 plotOutput("distPlot"), 
                                                 h3("Performance Summary for the Selected groups"),
                                                 tableOutput("summary"))
#                                         tabPanel("Race Summary", tableOutput("summary"))
                                        
                                   )
                                
                         )
     
                )
              )
     )