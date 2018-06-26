main_test <- function(label, media_dir, num_items) {
  psychTestRCAT::adapt_test(
    label = label,
    item_bank = get_item_bank(),
    show_item = show_item(media_dir),
    stopping_rule = psychTestRCAT::stopping_rule.num_items(n = num_items),
    opt = piat.options()
  )
}

show_item <- function(media_dir) {
  function(item, ...) {
    stopifnot(is(item, "item"), nrow(item) == 1L)
    item_number <- psychTestRCAT::get_item_number(item)
    num_items_in_test <- psychTestRCAT::get_num_items_in_test(item)
    psychTestR::video_NAFC_page(
      label = paste0("q", item_number),
      prompt = get_prompt(item_number, num_items_in_test),
      choices = get_choices(),
      url = get_item_path(item, media_dir),
      admin_ui = get_admin_ui(item, media_dir),
      save_answer = FALSE
    )
  }
}

get_admin_ui <- function(item, media_dir) {
  item$URL <- file.path(media_dir, item$Filename)
  df <- item[, c("answer",
                 "difficulty",
                 "HeardRange",
                 "Level",
                 "AbsDiff_TrueIm_Probe",
                 "Actual_LastHrd_probeprob",
                 "URL")]
  df$answer <- plyr::mapvalues(df$answer,
                               from = c(0, 1),
                               to = c("No match", "Match"),
                               warn_missing = FALSE)
  names(df) <- plyr::revalue(
    names(df),
    c(
      answer = "Correct answer",
      difficulty = "Difficulty",
      HeardRange = "Number of unique played notes",
      Level = "Number of imagined arrows",
      AbsDiff_TrueIm_Probe = "Distance between true note and probe",
      Actual_LastHrd_probeprob = "Probe probability based on distance"
    ))
  tab <- htmltools::tags$table(
    lapply(seq_along(df),
           function(i) shiny::tags$tr(
             shiny::tags$td(names(df)[i],
                            style = "padding:10px;"),
             shiny::tags$td(format(df[[i]], digits = 3),
                            style = "padding:10px;"))))
  shiny::wellPanel(
    shiny::h4("Item information"),
    tab
  )
}

get_item_path <- function(item, media_dir) {
  stopifnot(is(item, "item"), nrow(item) == 1L)
  file.path(media_dir, item$Filename)
}

get_prompt <- function(item_number, num_items_in_test) {
  shiny::div(
    shiny::p(
      "Question ",
      shiny::strong(item_number),
      " out of ",
      shiny::strong(if (is.null(num_items_in_test)) "?" else num_items_in_test)),
    shiny::p(
      "Did the final tone match the note you were imagining?"
    ))
}

get_choices <- function() {
  c(`Match` = "1", `No match` = "0")
}
