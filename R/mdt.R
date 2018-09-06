#' @export
mdt <- function(num_items = 20L,
                take_training = TRUE,
                label = "MDT",
                feedback = mdt.feedback.no_score(),
                media_dir = "http://media.gold-msi.org/test_materials/MDT/v4",
                next_item.criterion = "bOpt",
                next_item.estimator = "WL",
                final_ability.estimator = "WL",
                constrain_answers = FALSE,
                dict = mdt::dict) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(media_dir),
            psychTestR::is.timeline(feedback) ||
              psychTestR::is.test_element(feedback) ||
              is.null(feedback))
  media_dir <- gsub("/$", "", media_dir)

  psychTestR::new_timeline({
    browser()
    c(
      if (take_training) instructions(media_dir, num_items),
      main_test(label = label, media_dir = media_dir, num_items = num_items,
                next_item.criterion = next_item.criterion,
                next_item.estimator = next_item.estimator,
                final_ability.estimator = final_ability.estimator,
                constrain_answers = constrain_answers)
      # feedback
      stop("need to write method for c.test_element that produces timelines")
    )},
    dict = dict)
}
