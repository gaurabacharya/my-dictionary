# Gaurab Acharya

library(shiny)
library(shinythemes)
library(data.table)

#17-18 stats
stats1718 <- read.csv("stats-17-18.csv")

#18-19 stats
stats1819 <- read.csv("stats-18-19.csv")

#19-20 stats
stats1920 <- read.csv("stats-19-20.csv")

 
#User Interface
ui <- fluidPage(theme = shinytheme("sandstone"),
	navbarPage(
		"NBA Stats App",
		tabPanel("Home",
				sidebarPanel(
				  selectInput("dataset", "Select a Season:",
				    choices = list("2017-2018 Season", "2018-2019 Season", "2019-2020 Season"),
				    selected = "2019-2020 Season"),
				  
					selectInput("stat", "Choose a Stat Category:",
						choices = list("PTS", "AST", "STL", "BLK", "TRB"),
						selected = "PTS"),
					
					actionButton("submitbutton", "Submit", class = "btn btn-primary")
				),
				
				mainPanel(
					
					verbatimTextOutput('contents'),
					tableOutput('tabledata')
				)
		)
		
	)
)

#Server Function
server <- function(input, output, session) {
  datasetInput <- reactive({
    num = 0
    stat = ""
    if (input$stat == "PTS") {
      num = 29
    } else if (input$stat == "AST") {
      num = 24
    } else if (input$stat == "STL") {
      num = 25
    } else if (input$stat == "BLK") {
      num = 26
    } else {
      num = 23
    }
    data <- stats1920
    if (input$dataset == "2017-2018 Season") {
      data <- stats1718
    } else if (input$dataset == "2018-2019 Season") {
      data <- stats1819
    } else {
      data <- stats1920
    }
    
    Player <- data[,1]
    category <- data[,num]
    df <- data.frame(Player, category)
    names(df) <- c("Player", input$stat)
    Output <- df
  })
	
	#Output Text Box
	output$contents <- renderPrint ({
		if (input$submitbutton > 0) {
			isolate("Table is Ready")
		} else {
			return("Server ready to make Table")
		}
	})
	
	#Results Table
	output$tabledata <- renderTable({
		if (input$submitbutton > 0) {
			isolate(datasetInput())
		}
	})
	
}

shinyApp(ui = ui, server = server)

