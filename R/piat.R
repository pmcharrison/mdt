#' @export
piat <- function(num_items = 25L,
                 take_training = TRUE,
                 label = "PIAT",
                 feedback = piat.feedback.no_score(),
                 media_dir = "http://media.gold-msi.org/test_materials/PIAT/1-0-1/mp4") {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(media_dir),
            is.null(feedback) || is(feedback, "test_element"))
  media_dir <- gsub("/$", "", media_dir)

  c(
    if (take_training) training(media_dir, num_items),
    main_test(label, media_dir, num_items),
    feedback
  )
}
