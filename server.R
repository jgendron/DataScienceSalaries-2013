library(shiny)
library(ggplot2)
library(RColorBrewer)

## Generate data frame
        ## Data extracted from report "Salary/Income of Analytics/Data Mining/Data 
        ## Science professionals" provided by KDNuggets. Retreived from
        ## http://www.kdnuggets.com/2013/02/salary-analytics-data-mining-data-science-professionals.html

region <- c(rep("US & Canada",3),rep("Australia & NZ",3),rep("W. Europe",3),
            rep("MidEast & Africa",3),rep("Latin America",3),rep("Asia",3),
            rep("E. Europe",3),"Global")
status <- c(rep(c("Average of Region","Company or Self Employed","University or Government"),7),
            "Average of Region")
avgSalary <- c(128.8,131.3,112.1,108.1,112.9,75,85.1,90.4,59.6,83.5,90.5,45,68.3,
               68.8,67.5,59.8,63.3,36.7,43.9,47.1,32.5,109.2)
count <- c(223,194,29,8,7,1,75,62,13,13,11,2,12,8,4,23,20,3,9,7,2,363)
data <- data.frame(region,status,avgSalary,count)

## build all possible queries to data
full <- c(data$status=="Average of Region" | data$status=="Company or Self Employed" | data$status=="University or Government")
all.Corp <- c(data$status=="Average of Region" | data$status=="Company or Self Employed")
all.Gov <- c(data$status=="Average of Region" | data$status=="University or Government")
corp.Gov <-c(data$status=="University or Government" | data$status=="Company or Self Employed")
gov <- c(data$status=="University or Government")
corp <- c(data$status=="Company or Self Employed")

shinyServer(
        function(input, output) {
            
        type <- reactive({if (input$average == TRUE) {
                        if (input$status == 1) {
                                all.Corp
                        } else if (input$status == 2){
                                all.Gov
                        } else {
                                full
                        }
                        
                } else if (input$average == FALSE) {
                        if (input$status == 1) {
                                corp
                        } else if (input$status == 2){
                                gov
                        } else {
                                corp.Gov
                        } 
                }
        })    

## Analysis - subset data based on user input
        data.show <- reactive({
                data[which((data$region==input$region1 | data$region==input$region2) &
                                (type())),-4]
        })

## Generate output
        output$table <- renderTable({
                data.show()
        })

        output$fullTable <-renderTable({
                data
        })

        output$plot <- renderPlot({
                data <- data.show()
                p<-ggplot(data,
                aes(x=region, y=avgSalary, fill=status)) +
                geom_bar(position="dodge",stat="identity", colour="black") +
                scale_fill_brewer(palette="Accent") +
                xlab("Regions") + 
                ylab("Average Annual Salary (thousands of USD)") +
                ggtitle("Analytics and Data Science Professionals
                        \nAverage Annual Salary by Region and Employment")
                print(p)
       })
})