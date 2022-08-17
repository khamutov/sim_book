[![Build Status1](https://travis-ci.com/rstudio/bookdown-demo.svg?branch=master)](https://travis-ci.com/rstudio/bookdown-demo)

Build Word version (for uploading to GDoc)
```
docker run -v ${PWD}:/build/input bookdown Rscript -e 'bookdown::render_book("/build/input", output_format="word_document")'
```
