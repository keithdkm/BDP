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
        chilly$Pacetime<-(secs/13.1)/60  #Pacetime used for all calculations 
        chilly$Pace<-printPace(chilly$Pacetime)

        
        #create age categorization for runners

        chilly$age.class<-cut(chilly$Age, 
                              breaks = c(15,19,29,39,49,59,70),
                              labels = c("16-19","20-29","30-39","40-49", "50-59","60 and Over"))
      
     
        
        output$distPlot <- renderPlot({ pts<-chilly[chilly$age.class    %in% input$age.range & 
                                                    chilly$Gender %in% input$gender, 
                                                    c("Age","Ptime","Gender","age.class")] 
                                        
                                        qplot(x = age.class,
                                              y = Ptime,data = pts, 
                                              color = Gender,
                                              geom = c("boxplot"),
                                              xlab = "Age Division", 
                                              ylab = "Finish Time (hh:mm)")+
                                              scale_color_manual(values = c("M" = "#56B4E9",'F' = "#E69F00"),
                                                                 breaks = c("F","M"),
                                                                 labels = c("Women", "Men"))
                                        } )
        
        
        output$summary<-   renderTable({ 
                
                
                                        runnersub<-chilly[chilly$age.class %in% input$age.range & 
                                                          chilly$Gender    %in% input$gender,]
                                        if (nrow(runnersub)>0) {
                                                                out<-aggregate(Pacetime~age.class+Gender,
                                                                               data = runnersub,
                                                                               function(x) {c (mean(x),median (x),min(x),length(x))})
                                        
                                                                out<-data.frame("Age Division" = out$age.class,
                                                                                "Gender"       = out$Gender,
                                                                                "No of Runners" = as.integer(out$Pacetime[,4]),
                                                                                "Best Pace"    = printPace(out$Pacetime[,3]),
                                                                                "Average Pace" = printPace(out$Pacetime[,1]), 
                                                                                "Median Pace"  = printPace(out$Pacetime[,2])
                                                                                )
                        
                                                                out}
               
                                                                           
                })
        output$table <- renderTable({chilly[(chilly$age.class %in% input$age.range & 
                                             chilly$Gender    %in% input$gender),
                                                                                c(2,4,6,5,3,9)]})   
})
