input <- read.csv("data-raw/mdt-dict.csv", stringsAsFactors = FALSE)
names(input)[[1]] <- "key"

mdt_dict <- psychTestR::i18n_dict$new(input)
devtools::use_data(mdt_dict, overwrite = TRUE)
