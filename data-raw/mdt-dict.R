input <- read.csv("data-raw/mdt-dict.csv", encoding = "UTF-8", stringsAsFactors = FALSE)
names(input)[[1]] <- "key"

russian <- read.csv("data-raw/dict-russian.csv", stringsAsFactors = FALSE)
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

italian <- read.csv("data-raw/italian_dict.csv", stringsAsFactors = FALSE, encoding = "UTF-8")
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

mdt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mdt_dict, overwrite = TRUE)
