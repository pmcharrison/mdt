#' MDT
#'
#' This function defines a melodic discrimination test (MDT)
#' module for incorporation into a psychTestR timeline.
#' Use this function if you want to include the MDT in a
#' battery of other tests, or if you want to add custom psychTestR
#' pages to your test timeline.
#' For demoing the MDT, consider using \code{\link{demo_mdt}()}.
#' For a standalone implementation of the MDT,
#' consider using \code{\link{standalone_mdt}()}.
#' @param num_items (Integer scalar) Number of items in the test.
#' @param take_training (Logical scalar) Whether to include the training phase.
#' @param label (Character scalar) Label to give the MDT results in the output file.
#' @param feedback (Function) Defines the feedback to give the participant
#' at the end of the test. By default no feedback is given.
#' @param media_dir (Character scalar) File path to the directory
#' hosting the test's media files (typically a publicly accessible web directory).
#' @param next_item.criterion (Character scalar)
#' Criterion for selecting successive items in the adaptive test.
#' See the \code{criterion} argument in \code{\link[catR]{nextItem}} for possible values.
#' \code{"bOpt"} corresponds to the setting used in the original MDT paper.
#' @param next_item.estimator (Character scalar)
#' Ability estimation method used for selecting successive items in the adaptive test.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' \code{"BM"}, Bayes modal,
#' corresponds to the setting used in the original MDT paper.
#' \code{"WL"}, weighted likelihood,
#' corresponds to the default setting used in versions <= 1.3.0 of this package.
#' @param next_item.prior_dist (Character scalar)
#' The type of prior distribution to use when calculating ability estimates
#' for item selection.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' Defaults to \code{"norm"} for a normal distribution.
#' See the \code{priorDist} argument in \code{\link[catR]{thetaEst}} for possible values.
#' @param next_item.prior_par (Numeric vector, length 2)
#' Parameters for the prior distribution;
#' see the \code{priorPar} argument in \code{\link[catR]{thetaEst}} for details.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' The dfeault is \code{c(0, 1)}.
#' @param final_ability.estimator
#' Estimation method used for the final ability estimate.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' The default is \code{"WL"}, weighted likelihood,
#' which corresponds to the setting used in the original MDT paper.
#' If a Bayesian method is chosen, its prior distribution will be defined
#' by the \code{next_item.prior_dist} and \code{next_item.prior_par} arguments.
#' @param constrain_answers (Logical scalar)
#' If \code{TRUE}, then item selection will be constrained so that the
#' correct answers are distributed as evenly as possible over the course of the test.
#' We recommend leaving this option disabled.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @note Versions <= 1.3.0 of this package experimented with weighted likelihood
#' ability estimation for item selection.
#' However, current versions of the package revert to Bayes modal
#' ability estimation for item selection,
#' for consistency with the original MDT paper.
#' @export
mdt <- function(num_items = 20L,
                take_training = TRUE,
                label = "MDT",
                feedback = mdt.feedback.no_score(),
                media_dir = "http://media.gold-msi.org/test_materials/MDT/v4",
                next_item.criterion = "bOpt",
                next_item.estimator = "BM",
                next_item.prior_dist = "norm",
                next_item.prior_par = c(0, 1),
                final_ability.estimator = "WL",
                constrain_answers = FALSE,
                dict = mdt::mdt_dict) {
  stopifnot(is.scalar.character(label), is.scalar.numeric(num_items),
            is.scalar.logical(take_training), is.scalar.character(media_dir),
            psychTestR::is.timeline(feedback) ||
              is.list(feedback) ||
              psychTestR::is.test_element(feedback) ||
              is.null(feedback))
  media_dir <- gsub("/$", "", media_dir)

  psychTestR::new_timeline({
    c(
      if (take_training) instructions(media_dir, num_items),
      main_test(label = label, media_dir = media_dir, num_items = num_items,
                next_item.criterion = next_item.criterion,
                next_item.estimator = next_item.estimator,
                next_item.prior_dist = next_item.prior_dist,
                next_item.prior_par = next_item.prior_par,
                final_ability.estimator = final_ability.estimator,
                constrain_answers = constrain_answers),
      feedback
    )},
    dict = dict)
}
