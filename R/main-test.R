main_test <- function(label, media_dir, num_items,
                      next_item.criterion,
                      next_item.estimator,
                      next_item.prior_dist,
                      next_item.prior_par,
                      final_ability.estimator,
                      constrain_answers) {
  item_bank <- get_item_bank()
  psychTestRCAT::adapt_test(
    label = label,
    item_bank = item_bank,
    show_item = show_item(media_dir),
    stopping_rule = psychTestRCAT::stopping_rule.num_items(n = num_items),
    opt = mdt.options(next_item.criterion = next_item.criterion,
                      next_item.estimator = next_item.estimator,
                      next_item.prior_dist = next_item.prior_dist,
                      next_item.prior_par = next_item.prior_par,
                      final_ability.estimator = final_ability.estimator,
                      constrain_answers = constrain_answers,
                      item_bank = item_bank)
  )
}

show_item <- function(media_dir) {
  function(item, ...) {
    stopifnot(is(item, "item"), nrow(item) == 1L)
    item_number <- psychTestRCAT::get_item_number(item)
    num_items_in_test <- psychTestRCAT::get_num_items_in_test(item)
    psychTestR::audio_NAFC_page(
      label = paste0("q", item_number),
      prompt = get_prompt(item_number, num_items_in_test),
      choices = get_choices(),
      url = get_item_path(item, media_dir),
      admin_ui = get_admin_ui(item),
      save_answer = FALSE,
      wait = TRUE,
      arrange_choices_vertically = FALSE
    )
  }
}

get_admin_ui <- function(item) {
  item$contour <- ifelse(item$contour_dif == 0, "Preserved", "Violated")
  item$tonality <- ifelse(item$in_key, "Preserved", "Violated")
  df <- item[, c("difficulty",
                 "answer",
                 "contour",
                 "tonality",
                 "num_notes")]
  names(df) <- plyr::revalue(
    names(df),
    c(
      difficulty = "Difficulty",
      answer = "Correct answer",
      contour = "Contour",
      tonality = "Tonality",
      num_notes = "Melody length (notes)"
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
  file.path(media_dir, "item_bank/audio_stimuli",
            paste(item$file_name, "mp3", sep = "."))
}

get_prompt <- function(item_number, num_items_in_test) {
  shiny::div(
    shiny::p(
      psychTestR::i18n(
        "AMDI_0011_I_0001_1",
        sub = list(num_question = item_number,
                   test_length = if (is.null(num_items_in_test))
                     "?" else
                       num_items_in_test))
    ),
    shiny::p(
      psychTestR::i18n("AMDI_0013_I_0001_1")
    ))
}

get_choices <- function() {
  c("1", "2", "3")
}
