

fluidPage(
        tags$head(
        tags$style(HTML('#action{background-color:orange}')),
        tags$style(HTML('#text{background-color:orange}'))
    ),
    titlePanel("EasyBuild package finder and builder"),
    
    fluidRow(column(6,h4("Choose EasyBuild package to install"))),
    
    ## input box for which package to install
    textInput("text", label = h3("Package to install"), value = "Copy/paste full EB package name..."),

    fluidRow(column(8, verbatimTextOutput("value"))),
    hr(),
    actionButton("action", label = "Submit for install"),
    hr(),    
    fluidRow(
        column(4, selectInput("repts", "1st line per program:", c("No","Yes")))
    ),
    hr(),
    fluidRow(
        column(6,h4("Installed packages")),
        column(6,h4("Available packages"))
        ),
    hr(),
    fluidRow(
        column(6,DT::dataTableOutput("table2")),
        column(6,DT::dataTableOutput("table1"))
    )
    # Create a new row for the table.
    #DT::dataTableOutput("table")
    #DT::dataTableOutput("table")
)

