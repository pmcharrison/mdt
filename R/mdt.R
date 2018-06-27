#' @export
mdt <- function(num_items = 20L,
                take_training = TRUE,
                label = "MDT",
                feedback = mdt.feedback.no_score(),
                media_dir = "http://media.gold-msi.org/test_materials/MDT/v4",
                next_item.criterion = "bOpt",
                next_item.estimator = "WL",
                final_ability.estimator = "WL",
                constrain_answers = FALSE) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(media_dir),
            is.null(feedback) || is(feedback, "test_element"))
  media_dir <- gsub("/$", "", media_dir)

  c(
    if (take_training) training(media_dir, num_items),
    main_test(label = label, media_dir = media_dir, num_items = num_items,
              next_item.criterion = next_item.criterion,
              next_item.estimator = next_item.estimator,
              final_ability.estimator = final_ability.estimator,
              constrain_answers = constrain_answers),
    feedback
  )
}
