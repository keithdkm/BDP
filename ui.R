shinyUI(fluidPage(
        
       
        titlePanel("Race Results Analyzer"),
        
        
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
                                          choices = list(Men =   "M",
                                                      Women = "F"),
                                          selected = c("M","F"))
                             )
                ,              
                                            
                mainPanel(
                        tabsetPanel(    type = "tabs", 
                                        tabPanel("Leaderboard", tableOutput("table")),
                                        tabPanel("Results Summary", plotOutput("distPlot"), tableOutput("summary"))
#                                         tabPanel("Race Summary", tableOutput("summary"))
                                        
                                   )
                                
                         )
     
                )
              )
     )