#' @export
demo_piat <- function(num_items = 20L,
                      take_training = TRUE,
                      feedback = piat::piat.feedback.simple_score(),
                      admin_password = "demo",
                      researcher_email = "p.m.c.harrison@qmul.ac.uk") {
  elts <- c(
    psychTestR::one_button_page("Welcome to the PIAT demo!"),
    piat::piat(num_items = num_items,
               take_training = take_training,
               feedback = piat::piat.feedback.simple_score()),
    psychTestR::final_page("You may now close the browser window.")
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::pt_options(title = "PIAT demo",
                                admin_password = admin_password,
                                researcher_email = researcher_email,
                                demo = TRUE))
}
