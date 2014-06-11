library(shiny)
library(ggplot2)

# Define UI for dataset viewer application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Data Science Salaries Around the World in 2013"),
        
        # Sidebar with controls to select regions and employment type
        sidebarLayout(
        sidebarPanel(
                selectInput("region1", h4("Choose a region to view salary data:"),
                            choices = c("Asia","Australia & NZ",
                                        "E. Europe","Latin America",
                                        "MidEast & Africa","US & Canada",
                                        "W. Europe")),
                
                selectInput("region2", "Compare the region above with...", 
                            choices = c("Global","Asia","Australia & NZ",
                                        "E. Europe","Latin America",
                                        "MidEast & Africa","US & Canada",
                                        "W. Europe")),
                
                radioButtons("status", label = h4("Employment Type"),
                             choices = list("Company or Self Employed" = 1,
                                            "University or Government" = 2,
                                            "Both" = 3), 
                             selected = 3),
                
                checkboxInput("average", label = strong("Show Regional Average in the plot"),
                              value = TRUE),
                        
                br(),
                helpText(strong("What you can do:"),p("Explore average salaries for data science in 2013."),
                        p("Select a region to display salary data from the study. You may compare this region 
                        with another - or compare it with global average salaries."),
                        p("Choose whether you are interested in data from the private sector,
                        the public sector, or both."),
                        p('The regional average is plotted alongside employment data (you may
                        unselect the check box to remove it.)'))
        ),
        
        mainPanel(
                tabsetPanel(type = "tabs", 
                    tabPanel("Plot", plotOutput("plot")),
                    tabPanel("Customized Data", 
                             h3("Your Customized Data Selection"),
                             h5(em("You can change the data by using the
                                input widgets on the left")),tableOutput("table"),
                             em(strong("Note:"),br(),code("avgSalary"),
                                " is represented in thousands of US Dollars")),
                    tabPanel("Raw Data Set",
                             h3("Full data set"),
                             p("The variable ",code("count")," represents the total
                                number of repsondents by region and employment
                                status"),tableOutput("fullTable")),
                    br(),
                    em("Source: data excerpted from 2013 KDnuggets Annual Salary Poll.",br(),
                       "Retrieved from http://www.kdnuggets.com/2013/02/salary-analytics-data-mining-data-science-professionals.html",
                       align = "center")
                        )
                 )
)))