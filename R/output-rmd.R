# Modified from https://github.com/statistikat/codeModules/blob/master/R/renderCode.R

library("htmltools")

rmdContainer <- function(...) {
  rmd <- HTML(as.character(tags$code(class = "language-md", ...)))
  tags$div(tags$pre(rmd, style = "background-color: #FFF;"))
}

rmdHighlightDeps <- function() {
  src <- "www/highlight-rmarkdown/"
  singleton(list(
    includeScript(file.path(src, "highlight.min.js")),
    includeScript(file.path(src, "markdown.js")),
    includeScript(file.path(src, "r.js")),
    includeScript(file.path(src, "yaml.min.js")),
    includeCSS(file.path(src, "github.css")),
    tags$script(
      "Shiny.addCustomMessageHandler(
           'highlight-rmd',
           function (message) {
               var id = message['id'];
               var delay = message['delay'];
               setTimeout(
                   function () {
                       var el = document.getElementById(id);
                       hljs.highlightElement(el);
                   },
                   delay
               );
           }
       );"
    )
  ))
}

renderRmd <- function(expr, env = parent.frame(), quoted = FALSE, outputArgs = list(), delay = 100) {
  func <- exprToFunction(expr, env, quoted)
  renderFunc <- function(shinysession, name, ...) {
    value <- func()
    for (d in delay) {
      shinysession$sendCustomMessage("highlight-rmd", list(id = name, delay = d))
    }
    return(paste(utils::capture.output(cat(value)), collapse = "\n"))
  }
  markRenderFunction(rmdOutput, renderFunc, outputArgs = outputArgs)
}

rmdOutput <- function(outputId) {
  tagList(
    rmdHighlightDeps(),
    uiOutput(outputId, container = rmdContainer)
  )
}
