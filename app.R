library("shiny")

source("R/output-rmd.R", local = TRUE)

ui <- fluidPage(
  fluidRow(column(12, h1("R Markdown Syntax Highlighting in Shiny"))),
  fluidRow(
    column(
      4,
      textAreaInput(
        "rmd_in", label = NULL,
        width = "100%", height = "500px",
        value = paste0(readLines("examples/example.Rmd"), collapse = "\n")
      )
    ),
    column(
      8,
      rmdOutput("rmd_out")
    )
  )
)

server <- function(input, output) {
  output$rmd_out <- renderRmd({
    # Escape the input ALL THE TIME to avoid potential security issues
    # https://github.com/highlightjs/highlight.js/issues/2886
    htmltools::htmlEscape(input$rmd_in)
  })
}

shinyApp(ui = ui, server = server)
