## ----include = FALSE----------------------------------------------------------
RUN_LIVE <- FALSE
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(LLMRpanel)

# Closed items receive the first displayed option. Open items receive a
# fixed sentence.
first_shown <- function(experiments, ...) {
  experiments$response_text <- vapply(seq_len(nrow(experiments)), function(i) {
    shown <- experiments$option_order[i]
    if (is.na(shown)) "Because it reaches the most people."
    else strsplit(shown, "|", fixed = TRUE)[[1]][1]
  }, character(1))
  experiments$success <- TRUE
  experiments
}

