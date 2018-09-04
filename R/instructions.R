info_page <- function(id) {
  psychTestR::one_button_page(shiny::HTML(psychTestR::i18n(id)),
                              button_text = psychTestR::i18n("AMDI_0016_I_0001_1"))
}

audio_ex_page <- function(prompt_id, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = shiny::HTML(psychTestR::i18n(prompt_id)),
    choices = psychTestR::i18n("AMDI_0016_I_0001_1"),
    url = url,
    save_answer = FALSE
  )
}

instructions <- function(media_dir, num_items) {
  psychTestR::new_timeline({
    c(
      info_page("AMDI_0001_I_0001_1"),
      psychTestR::code_block(function(state, ...) {
        psychTestR::set_local("do_intro", TRUE, state)
      }),
      psychTestR::loop_while(
        test = function(state, ...) psychTestR::get_local("do_intro", state),
        logic = c(
          info_page("AMDI_0002_I_0001_1"),
          audio_ex_page("AMDI_0003_I_0001_1", file.path(media_dir, "examples/ex1.mp3")),
          info_page("AMDI_0004_I_0001_1"),
          practice(media_dir),
          ask_repeat()
        )),
      psychTestR::one_button_page(shiny::HTML(psychTestR::i18n(
        "AMDI_0009_I_0001_1", sub = list(test_length = num_items)
      )))
    )})
}
