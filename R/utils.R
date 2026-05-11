#' Omnibus goodness of fit test for heterogeneous treatment effect estimators
#'
#' @param Y The observed outcomes
#' @param Yhat The predicted outcomes
#' @param Z The observed treatment assignments
#' @param phat The estimated propensity scores
#' @param tauhat The predicted conditional average treatment effects
#' @param vcov.type The type of heteroskedasticity-consistent standard errors
#'
#' @returns A list containing the summary of the linear regression used for the
#'   omnibus test and the fitted linear model object
omnibus_test <- function(Y, Yhat, Z, phat, tauhat, vcov.type = "HC3") {
  if (length(phat) == 1) {
    phat <- rep(phat, length(Y))
  }
  weights <- 1 / (phat * (1 - phat))
  mean_prediction <- (Z - phat)
  differential_prediction <- (Z - phat) * (tauhat - mean(tauhat))
  df <- data.frame(
    target = unname(Y),
    Yhat = unname(Yhat),
    mean_prediction = unname(mean_prediction),
    differential_prediction = unname(differential_prediction)
  )
  if (var(Yhat) == 0) {
    blp <- lm(
      target ~ Yhat + mean.prediction + differential_prediction + 0,
      weights = weights,
      data = df
    )
  } else{
    blp <- lm(
      target ~ Yhat + mean_prediction + differential_prediction,
      weights = weights,
      data = df
    )
  }

  blp_summary <- lmtest::coeftest(
    blp, vcov = sandwich::vcovCL, type = vcov.type
  )
  dimnames(blp_summary)[[2]][4] <- gsub("[|]", "", dimnames(blp_summary)[[2]][4])
  blp_summary[, 4] <- ifelse(
    blp_summary[, 3] < 0,
    1 - blp_summary[, 4]/2,
    blp_summary[, 4]/2
  )

  return(list(summary = blp_summary, model = blp))
}


#' Relative error assessment for heterogeneous treatment effect estimators
#'
#' @param X The observed covariate matrix
#' @param Y The observed outcomes
#' @param Z The observed treatment assignments
#' @param tauhat The predicted conditional average treatment effects
#' @param tauhat_ref The reference conditional average treatment effects
#' @param muhat1 The predicted potential outcome under treatment
#' @param muhat0 The predicted potential outcome under control
#' @param phat The estimated propensity scores
#'
#' @returns A list containing the relative error and its standard error.
relative_error <- function(X, Y, Z, tauhat, tauhat_ref, muhat1, muhat0, phat) {
  weighted_ATE <- (tauhat - tauhat_ref) * (
    Z * (Y - muhat1) / phat + muhat1 - (1 - Z) * (Y - muhat0) / (1 - phat) - muhat0
  )
  if_semiefficient <- tauhat^2 - tauhat_ref^2 - 2 * mean(weighted_ATE)
  return(
    list(
      rel_error = mean(if_semiefficient),
      se = sd(if_semiefficient) / sqrt(length(Y))
    )
  )
}
