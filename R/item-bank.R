#' @export
get_item_bank <- function(media_dir) {
  x <- read.csv(system.file("item-bank.csv", package = "mdt", mustWork = TRUE),
                stringsAsFactors = FALSE)
  x$answer <- x$oddity
  stopifnot(is.numeric(x$answer))
  x$url <- file.path(media_dir, "item_bank/audio_stimuli",
                     paste(x$file_name, "mp3", sep = "."))
  x
}
