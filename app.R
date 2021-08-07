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
        paste0(readLines("examples/html-vignette.Rmd"), collapse = "\n")
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
    input$rmd_in
  })
}

shinyApp(ui = ui, server = server)
