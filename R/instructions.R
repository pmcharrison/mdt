instructions <- function(media_dir) {
  c(
    psychTestR::one_button_page("This test assesses your ability to spot differences between melodies."),
    psychTestR::one_button_page(shiny::div(
      shiny::HTML(
        "<p>In each question you will hear <strong>three versions</strong> of the same <strong>tune</strong>. Each version will be at a different <strong>'pitch'</strong>, being essentially the same tune but played <strong>one step higher</strong> each time.</p><p>One of these three versions will be an <strong>'odd one out'</strong>, in that one of its notes will have been changed. Your task is to identify which version was the <strong>odd one out</strong>.</p>"))),
    psychTestR::audio_NAFC_page(
      label = "example_1",
      prompt = "In this example, the second melody is the 'odd one out'.",
      choices = "Next",
      url = file.path(media_dir, "examples/ex1.mp3"),
      save_answer = FALSE
    ),
    psychTestR::one_button_page("In the real test, we will use unfamiliar melodies that you are unlikely to have heard before."))
}
