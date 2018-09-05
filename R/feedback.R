#' @export
mdt.feedback.no_score <- function(dict = mdt::dict) {
  psychTestR::new_timeline(
    psychTestR::one_button_page(
      shiny::HTML(psychTestR::i18n("AMDI_0014_I_0001_1"))
    ),
    dict = dict
  )
}

#' @export
mdt.feedback.simple_score <- function(dict = mdt::dict) {
  psychTestR::new_timeline(
    psychTestR::reactive_page(function(answer, ...) {
      psychTestR::one_button_page(shiny::div(
        shiny::p(shiny::HTML(psychTestR::i18n("AMDI_0014_I_0001_1"))),
        shiny::p(shiny::HTML(psychTestR::i18n("AMDI_0017_I_0001_1")),
                 shiny::strong(round(answer$ability, digits = 2)))
      ))
    }),
    dict = dict
  )
}
