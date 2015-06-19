shinyUI(fluidPage(
        
       
        titlePanel("Race Performance Analyzer"),
        
        
        sidebarLayout(
                sidebarPanel(
                        sliderInput("age.range",
                                    label = h4("Select Runner Age Range"),
                                    min = 10,
                                    max = 80,
                                    value = c(20,50))),
                       
#                         ,
#                         radioButtons(input$gender,
#                                      "Gender: ",
#                                        Male = "M",
#                                        Female = "F",
#                                        Both = c("M","F"))                
                        
                
               
                        mainPanel(
                                tabsetPanel(type = "tabs", 
                                            tabPanel("Finish Distribution", plotOutput("distPlot")), 
                                            tabPanel("Race Summary", verbatimTextOutput("summary")), 
                                            tabPanel("Leaderboard", tableOutput("table")))
                                
                        )
                
      
)))