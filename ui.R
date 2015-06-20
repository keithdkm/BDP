shinyUI(fluidPage(
        
       
        titlePanel("Race Performance Analyzer"),
        
        
        sidebarLayout(
                sidebarPanel(
                        sliderInput("age.range",
                                    label = h4("Select Runner Age Range"),
                                    min = 10,
                                    max = 80,
                                    value = c(10,80))
                       
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
                                        tabPanel("Finish Distribution", plotOutput("distPlot")), 
                                        tabPanel("Race Summary", verbatimTextOutput("summary")), 
                                        tabPanel("Leaderboard", tableOutput("table"))
                                   )
                                
                         )
     
                )
              )
     )