piat.options <- function() {
  psychTestRCAT::adapt_test_options(
    next_item.criterion = "bOpt",
    next_item.estimator = "WL",
    # next_item.prior_dist = "norm",
    # next_item.prior_par = c(0, 2),
    final_ability.estimator = "WL",
    constrain_answers = TRUE
  )
}
