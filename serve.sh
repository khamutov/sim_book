#!/bin/sh

set -ev

Rscript -e "bookdown:::serve_book(in_session = TRUE)"
