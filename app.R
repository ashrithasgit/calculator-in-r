library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("num1", "Enter the first number:", value = 0),
      numericInput("num2", "Enter the second number:", value = 0),
      selectInput("operation", "Choose an operation:", 
                  choices = c("Addition" = "add", 
                              "Subtraction" = "subtract", 
                              "Multiplication" = "multiply", 
                              "Division" = "divide")),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      h4("Result"),
      verbatimTextOutput("result")
    )
  )
)

# Define the server
server <- function(input, output, session) {
  
  calculate_result <- eventReactive(input$calculate, {
    num1 <- input$num1
    num2 <- input$num2
    operation <- input$operation
    
    if (operation == "add") {
      return(num1 + num2)
    } else if (operation == "subtract") {
      return(num1 - num2)
    } else if (operation == "multiply") {
      return(num1 * num2)
    } else if (operation == "divide") {
      if (num2 == 0) {
        return("Error: Division by zero")
      } else {
        return(num1 / num2)
      }
    }
  })
  
  output$result <- renderText({
    calculate_result()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
