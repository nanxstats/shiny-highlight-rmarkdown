# shiny-highlight-rmarkdown

Offers `renderRmd()` and `rmdOutput()`:
lightweight syntax highlighting for R Markdown output in Shiny.

## Demo

```r
shiny::runGitHub("nanxstats/shiny-highlight-rmarkdown", ref = "main")
```

## Why

- [shiny:::showcaseUI](https://github.com/rstudio/shiny/blob/master/R/showcase.R)
offers a syntax highlighting solution but does not support R Markdown.
- Sometimes you want a lightweight R Markdown syntax highlighting solution
  in Shiny that does not involve introducing dependencies such as `shinyAce`.

## How

> First, they take the dinglebop, and they smooth it out with a bunch of schleem.

- R
    - Modified from [codeModules::renderCode](https://github.com/statistikat/codeModules)
- JS/CSS
    - highlight.js
    - Modified version of the Markdown language highlighter `markdown.min.js`
    - Modified version of the R language highlighter `r.min.js`
    - Original version of the YAML language highlighter `yaml.min.js`
    - Modified version of `github.min.css` theme based on colors in [`rstudio.css`](https://github.com/rstudio/shiny/blob/master/inst/www/shared/highlight/rstudio.css)

## License

MIT
