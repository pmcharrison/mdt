input <- read.csv("data-raw/mdt-dict.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(input)[[1]] <- "key"

russian <- read.csv("data-raw/dict-russian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

italian <- read.csv("data-raw/dict-italian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

german_formal <- read.csv("data-raw/dict-german-formal.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(german_formal)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == german_formal$key))
input$DE_F <- german_formal$DE_F

spanish <- read.csv("data-raw/dict-spanish.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(spanish)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == spanish$key))
input$ES <- spanish$ES

latvian <- read.csv("data-raw/dict-latvian.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(latvian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == latvian$key))
input$LV <- latvian$LV


mdt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mdt_dict, overwrite = TRUE)
