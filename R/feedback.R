#' MDT feedback (no score)
#'
#' Here the participant is given no feedback at the end of the test.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @export
#' @examples
#' \dontrun{
#' demo_mdt(feedback = mdt.feedback.no_score())}
mdt.feedback.no_score <- function(dict = mdt::mdt_dict) {
  psychTestR::new_timeline(
    psychTestR::one_button_page(
      psychTestR::i18n("AMDI_0014_I_0001_1")
    ),
    dict = dict
  )
}

#' MDT feedback (simple score)
#'
#' Here the participant's score is reported at the end of the test.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @export
#' @examples
#' \dontrun{
#' standalone_mdt(feedback = mdt.feedback.simple_score())}
mdt.feedback.simple_score <- function(dict = mdt::mdt_dict) {
  psychTestR::new_timeline(
    psychTestR::reactive_page(function(answer, ...) {
      psychTestR::one_button_page(shiny::div(
        shiny::p(psychTestR::i18n("AMDI_0014_I_0001_1")),
        shiny::p(psychTestR::i18n("AMDI_0017_I_0001_1"),
                 shiny::strong(round(answer$ability, digits = 2)))
      ))
    }),
    dict = dict
  )
}
