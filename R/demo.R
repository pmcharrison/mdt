#' @export
demo_mdt <- function(num_items = 20L,
                     take_training = TRUE,
                     feedback = mdt::mdt.feedback.simple_score(),
                     admin_password = "demo",
                     researcher_email = "p.m.c.harrison@qmul.ac.uk",
                     languages = mdt_languages()) {
  elts <- c(
    mdt::mdt(num_items = num_items,
             take_training = take_training,
             feedback = feedback),
    psychTestR::final_page("You may now close the browser window.")
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = "MDT demo",
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = TRUE,
                                   languages = languages))
}
