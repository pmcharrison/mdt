input <- readr::read_csv("data-raw/mdt-dict.csv")
names(input)[[1]] <- "key"

russian <- readr::read_csv("data-raw/dict-russian.csv")
names(russian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == russian$key))
input$RU <- russian$RU

italian <- readr::read_csv("data-raw/dict-italian.csv")
names(italian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == italian$key))
input$IT <- italian$IT

german_formal <- readr::read_csv("data-raw/dict-german-formal.csv")
names(german_formal)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == german_formal$key))
input$DE_F <- german_formal$DE_F

spanish <- readr::read_csv("data-raw/dict-spanish.csv")
names(spanish)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == spanish$key))
input$ES <- spanish$ES

latvian <- readr::read_csv("data-raw/dict-latvian.csv")
names(latvian)[[1]] <- "key"
stopifnot(!anyDuplicated(input$key),
          all(input$key == latvian$key))
input$LV <- latvian$LV

portuguese <- read.csv("data-raw/dict-portuguese.csv", stringsAsFactors = FALSE, encoding = "utf-8")
names(portuguese)[[1]] <- "key"
stopifnot(all(input$key == portuguese$key))
input$PT <- portuguese$PT

mdt_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(mdt_dict, overwrite = TRUE)
