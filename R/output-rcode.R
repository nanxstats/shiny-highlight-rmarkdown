# Modified from https://github.com/statistikat/codeModules/blob/master/R/renderCode.R

library("htmltools")

rcodeContainer <- function(...) {
  rcode <- HTML(as.character(tags$code(class = "language-r", ...)))
  tags$div(tags$pre(rcode, style = "background-color: #FFFFFF;"))
}

rcodeHighlightDeps <- function() {
  src <- "www/highlight-rmarkdown/"
  tagList(
    singleton(list(
      includeCSS(file.path(src, "highlight-theme.css")),
      includeScript(file.path(src, "highlight.min.js")),
      includeScript(file.path(src, "r.js"))
    )),
    singleton(list(
      tags$script(
        "Shiny.addCustomMessageHandler(
           'highlight-rcode',
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
  )
}

renderRcode <- function(expr, env = parent.frame(), quoted = FALSE, outputArgs = list(), delay = 100) {
  func <- exprToFunction(expr, env, quoted)
  renderFunc <- function(shinysession, name, ...) {
    value <- func()
    for (d in delay) {
      shinysession$sendCustomMessage("highlight-rcode", list(id = name, delay = d))
    }
    return(paste(utils::capture.output(cat(value)), collapse = "\n"))
  }
  markRenderFunction(rcodeOutput, renderFunc, outputArgs = outputArgs)
}

rcodeOutput <- function(outputId) {
  tagList(
    rcodeHighlightDeps(),
    uiOutput(outputId, container = rcodeContainer)
  )
}
