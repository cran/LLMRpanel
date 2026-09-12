## ----include = FALSE----------------------------------------------------------
# Every chunk below runs offline through a deterministic runner, so the
# vignette executes during package builds without credentials or charges.
# One chunk near the end is gated by RUN_LIVE for a genuinely live call.
RUN_LIVE <- FALSE
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(LLMRpanel)

# A deterministic stand-in for the model: it always picks the first
# DISPLAYED option of a closed item (so option-order randomization shows up
# in the shares) and answers open items with a fixed sentence.
first_shown <- function(experiments, ...) {
  experiments$response_text <- vapply(seq_len(nrow(experiments)), function(i) {
    shown <- experiments$option_order[i]
    if (is.na(shown)) "Because it reaches the most people."
    else strsplit(shown, "|", fixed = TRUE)[[1]][1]
  }, character(1))
  experiments$success <- TRUE
  experiments
}

