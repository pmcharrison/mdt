#' Demo MDT
#'
#' This function launches a demo for the MDT.
#'
#' @param num_items (Integer scalar) Number of items in the test.
#' @param feedback (Function) Defines the feedback to give the participant
#' at the end of the test. Defaults to a graph-based feedback page.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' Defaults to \code{"demo"}.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' Defaults to \email{p.m.c.harrison@qmul.ac.uk},
#' the email address of this package's developer.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @param ... Further arguments to be passed to \code{\link{mdt}()}.
#' @export
demo_mdt <- function(num_items = 10L,
                     feedback = psychTestRCAT::cat.feedback.graph("MDT"),
                     admin_password = "demo",
                     researcher_email = "p.m.c.harrison@qmul.ac.uk",
                     dict = mdt::mdt_dict,
                     ...) {
  elts <- c(
    psychTestR::new_timeline(psychTestR::one_button_page(
      psychTestR::i18n("demo_intro"),
      button_text = psychTestR::i18n("AMDI_0016_I_0001_1")
    ), dict = dict),
    mdt::mdt(num_items = num_items,
             feedback = feedback,
             dict = dict,
             ...),
    psychTestR::new_timeline(
      psychTestR::final_page(psychTestR::i18n("you_may_close_browser")),
      dict = dict
    )
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = "MDT demo",
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = TRUE,
                                   languages = "EN"))
}
