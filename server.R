library(stringr)
library(ggplot2)
library(lubridate)
library(Hmisc)



chilly<-read.csv("chilly.csv",header= TRUE)

#split Athelete details field into Age and Gender fields and remove original field
chilly[,c("Age","Gender")]<-str_split_fixed(chilly$Athlete.Details," ",n=3)[,c(1,3)]
chilly$Age<-as.integer(chilly$Age)
chilly$Gender<-as.factor(chilly$Gender)
chilly$Athlete.Details<-NULL

#create times for calculations
chilly$Ptime<-as.difftime(as.character(chilly$Time),format = "%H:%M:%S")


shinyServer(function(input, output) {
        
     
        
        output$distPlot <- renderPlot({ pts<-chilly[chilly$Age>=input$age.range[1] & chilly$Age<=input$age.range[2], c("Age","Ptime","Gender")]  
                                        qplot(x = Age,y = as.numeric(Ptime),data = pts,color = Gender)
                                        } )
        output$summary<-renderPrint({
                summary(chilly)})
        output$table <- renderTable({chilly[,2:6]})   
})
