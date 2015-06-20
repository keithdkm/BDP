library(stringr)
library(ggplot2)
library(lubridate)
library(Hmisc)





shinyServer(function(input, output) {
        
        chilly<-read.csv("chilly.csv",header= TRUE)
        
        #split Athlete details field into Age and Gender fields and remove original field
        chilly[,c("Age","Gender")]<-str_split_fixed(chilly$Athlete.Details," ",n=3)[,c(1,3)]
        chilly$Age<-as.integer(chilly$Age)
        chilly$Gender<-as.factor(chilly$Gender)
        chilly$Athlete.Details<-NULL
        
        #create times for calculations
        chilly$Ptime<-strptime(chilly$Time,format = "%H:%M:%S")
        secs<-with(chilly$Ptime,3600*hour+60*min+sec)
        Pace<-(secs/13.1)/60
        chilly$Pace<-paste0(as.character(floor(Pace)),":",sprintf("%02d",floor((Pace-floor(Pace))*60)))

        
        #create age categorization for runners
        chilly$age.class<-cut2(chilly$Age, cuts = c(16,20,30,40,50,60,70))

        
#         output$ages<-levels(chilly$age.class)
     
        
        output$distPlot <- renderPlot({ pts<-chilly[chilly$Age>=input$age.range[1] & chilly$Age<=input$age.range[2] & chilly$Gender %in% input$gender, 
                                                    c("Age","Ptime","Gender")]  
                                        qplot(x = Age,y = Ptime,data = pts,color = Gender)
                                        } )
        output$summary<-renderPrint({
                summary(chilly)})
        output$table <- renderTable({chilly[(chilly$Age>=input$age.range[1] & chilly$Age<=input$age.range[2] & chilly$Gender %in% input$gender),
                                            c(2,4,6,5,3,8)]})   
})
