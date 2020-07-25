#Automated testing for MDT
library(psychTestR)
library(testthat)

dir <- system.file("MDT", package = "mdt", mustWork = TRUE)

number_items <- 18 #number of items

app <<- AppTester$new(dir)

# ID
app$expect_ui_text("Please enter your participant ID. Next")
app$set_inputs(p_id = "abcde")
app$click_next()

# Training
app$expect_ui_text("For each question of this test, you will hear three versions of the same tune. Each version will be at a different pitch, essentially the same tune but played one step higher each time. One of these three versions will be an odd one out – one of its notes will have been changed. Your task is to identify which one was the odd one out. Next")
app$click_next()

app$expect_ui_text("In this example, the second melody is the odd one out. Click here to play Next")
app$click("Next")

app$expect_ui_text("Now you will try a couple of practice questions yourself. You won't have heard any of these melodies before. Next")
app$click_next()

app$expect_ui_text("Which melody was the odd one out? Click here to play 1 2 3")
app$click("3")

app$expect_ui_text("Correct! Next")
app$click_next()

app$expect_ui_text("Which melody was the odd one out? Click here to play 1 2 3")
app$click("2")

app$expect_ui_text("Incorrect. The first melody was the odd one out. Next")
app$click_next()

app$expect_ui_text("Do you want to go back to see the instructions and practice questions again? Yes, go back No, I'm ready to continue")
app$click("continue") # "Yes" = "go back"

app$expect_ui_text(paste0("You are about to start the main test, where you will answer ", number_items," questions similar to the ones that you've just tried. Don't worry if you find some questions difficult - if you really don't know the answer, just give your best guess. Next"))
app$click_next()

# Main test
q <- 1 # Number of question
for (i in sample(1:3, number_items, replace=TRUE)){
  app$expect_ui_text(paste("Question", q, "out of", number_items, "Which melody was the odd one out? Click here to play 1 2 3"))
  app$click(i)
  print(paste("answer id =", i))
  q <- q + 1
}

app$expect_ui_text("You finished the test! Next")
app$click_next()

if (FALSE) {
  # Results
  results <- app$get_results() %>% as.list()
  MDT_ability_sem <<- results[["MDT"]][["ability_sem"]]
  MDT_ability <<- results[["MDT"]][["ability"]]

  print(paste("Standard error of measurement of MDT", MDT_ability_sem))
}

app$stop()
