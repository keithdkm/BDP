shinyUI(fluidPage(
        
       
        titlePanel("Race Results Analyzer"),
        
        
        sidebarLayout(
                sidebarPanel(
                        sliderInput("age.range",
                                    label = "Select Runner Age Range",
                                    min = 16,
                                    max = 70,
                                    value = c(16,70))
                       
                        ,
                        checkboxGroupInput("gender",
                                          label = "Show Me: ",
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