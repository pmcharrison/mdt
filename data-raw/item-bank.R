item_bank <- read.csv("data-raw/item-bank.csv", stringsAsFactors = FALSE)
item_bank$answer <- item_bank$oddity
stopifnot(is.numeric(item_bank$answer))
devtools::use_data(item_bank, overwrite = TRUE)
