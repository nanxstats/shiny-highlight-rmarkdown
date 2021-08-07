library("shiny")

source("R/output-rmd.R", local = TRUE)
source("R/output-rcode.R", local = TRUE)

ui <- fluidPage(
  fluidRow(column(12, h1("R Markdown Syntax Highlighting in Shiny"))),
  fluidRow(
    column(
      4,
      textAreaInput(
        "rmd_in",
        label = NULL,
        width = "100%", height = "500px",
        value = paste0(readLines("examples/example.Rmd"), collapse = "\n")
      )
    ),
    column(
      8,
      rmdOutput("rmd_out")
    )
  ),
  fluidRow(column(12, h1("R Syntax Highlighting in Shiny"))),
  fluidRow(
    column(
      4,
      textAreaInput(
        "rcode_in",
        label = NULL,
        width = "100%", height = "300px",
        value = paste0(readLines("examples/example.R"), collapse = "\n")
      )
    ),
    column(
      8,
      rcodeOutput("rcode_out")
    )
  )
)

server <- function(input, output) {
  # ALWAYS escape the input to avoid potential security issues
  # https://github.com/highlightjs/highlight.js/issues/2886
  output$rmd_out <- renderRmd({
    htmltools::htmlEscape(input$rmd_in)
  })
  output$rcode_out <- renderRcode({
    htmltools::htmlEscape(input$rcode_in)
  })
}

shinyApp(ui = ui, server = server)
