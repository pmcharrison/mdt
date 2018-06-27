practice <- function(media_dir) {
  unlist(lapply(
    list(list(id = "ex2", answer = "3"),
         list(id = "ex3", answer = "1")
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = "Which melody was the odd one out?",
          url = file.path(media_dir, "examples", paste0(x$id, ".mp3")),
          choices = c("1", "2", "3"),
          arrange_choices_vertically = FALSE,
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(
            if (answer == x$answer) "You answered correctly!" else
              sprintf("Incorrect. The correct answer was %s.", x$answer)
          )}))}))
}

repeatable_practice <- function(media_dir) {
  c(
    psychTestR::one_button_page("Now you will try a couple of practice questions yourself."),
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_practice", TRUE, state)
    }),
    psychTestR::loop_while(
      test = function(state, ...) psychTestR::get_local("do_practice", state),
      logic = c(
        practice(media_dir),
        psychTestR::NAFC_page(
          label = "check_repeat",
          prompt = "Would you like to try the practice examples again?",
          choices = c("Yes", "No"),
          save_answer = FALSE,
          arrange_vertically = FALSE,
          on_complete = function(state, answer, ...) {
            psychTestR::set_local("do_practice", identical(answer, "No"), state)
          }
        )
      )))}
