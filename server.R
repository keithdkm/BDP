library(stringr)
library(ggplot2)
library(lubridate)
library(Hmisc)
library(plyr)
library(xtable)





shinyServer(function(input, output) {
        
        printPace<-function(p){
                                min<-floor(p)
                                sec<-round((p-min)*60)
                                
                                min[sec==60]<-min[sec==60]+1
                                sec[sec==60]<-0 
                                paste0(as.character(min),":",sprintf("%02d",sec),' min/mile') }
        
        
        chilly<-read.csv("chilly.csv",header= TRUE)
    
        
        
        #split Athlete details field into Age and Gender fields and remove original field
        chilly[,c("Age","Gender")]<-str_split_fixed(chilly$Athlete.Details," ",n=3)[,c(1,3)]
        chilly$Age<-as.integer(chilly$Age)
        chilly$Gender<-as.factor(chilly$Gender)
        chilly$Athlete.Details<-NULL
        
        #create times for calculations
        chilly$Ptime<-strptime(chilly$Time,format = "%H:%M:%S")
        secs<-with(chilly$Ptime,3600*hour+60*min+sec)
        chilly$Pacetime<-(secs/13.1)/60
        chilly$Pace<-printPace(chilly$Pacetime)

        
        #create age categorization for runners

        chilly$age.class<-cut(chilly$Age, 
                              breaks = c(15,20,30,40,50,60,70),
                              labels = c("16-19","20-29","30-39","40-49", "50-59","60 and Over"))
      
     
        
        output$distPlot <- renderPlot({ pts<-chilly[chilly$Age>=input$age.range[1] & chilly$Age<=input$age.range[2] & chilly$Gender %in% input$gender, 
                                                    c("Age","Ptime","Gender","age.class")] 
                                        
                                        qplot(x = age.class,y = Ptime,data = pts, color = Gender,geom = c("boxplot"),xlab = "Age Division", ylab = "Finish Time")
                                        } )
        output$summary<-renderTable({ runnersub<-chilly[chilly$Age>=input$age.range[1] & chilly$Age<=input$age.range[2] & chilly$Gender %in% input$gender,]
                
                out<-tapply(runnersub$Pacetime,
                            runnersub$age.class, 
                            mean,na.rm=TRUE)
                
        out<-out[!(is.na(out))]
                out<-data.frame("Age Division" = row.names(out), "Average Pace" = printPace(out) )
                row.names(out)<-NULL
                out
                
#                                                 ddply(chilly[chilly$Age>=input$age.range[1] & 
#                                                    chilly$Age<=input$age.range[2] & 
#                                                    chilly$Gender %in% input$gender,],.(Gender),summarize, 
#                                                                                     Mean = mean(Pacetime))
                })
        output$table <- renderTable({chilly[(chilly$Age>=input$age.range[1] & 
                                             chilly$Age<=input$age.range[2] & 
                                             chilly$Gender %in% input$gender),
                                                                                c(2,4,6,5,3,9)]})   
})
