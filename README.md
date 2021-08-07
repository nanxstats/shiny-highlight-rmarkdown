# shiny-highlight-rmarkdown

Offers `renderRmd()` and `rmdOutput()`: syntax highlighting for R Markdown
output in Shiny using highlight.js.

Also offers `renderRcode()` and `rcodeOutput()` for R code output
syntax highlighting.

You can use either one independently or use the two together.

## Demo

<https://nanx.shinyapps.io/shiny-highlight-rmarkdown/>

or

```r
shiny::runGitHub("nanxstats/shiny-highlight-rmarkdown", ref = "main")
```

## Why

- [shiny:::showcaseUI](https://github.com/rstudio/shiny/blob/master/R/showcase.R)
  and [codeModules::renderCode](https://github.com/statistikat/codeModules)
  offer an R syntax highlighting solution but do not support R Markdown.
- Sometimes you want a lightweight R or R Markdown syntax highlighting solution
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
    - Modified version of `github.min.css` theme based on colors in
      [`rstudio.css`](https://github.com/rstudio/shiny/blob/master/inst/www/shared/highlight/rstudio.css)

## License

MIT
