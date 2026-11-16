# Standard pairwise / proportion / DTA meta-analysis with srma's protocol defaults.
# Usage: Rscript meta_analysis.R <data.csv> <type> <outdir> [sm]
#   type: binary     study,event.e,n.e,event.c,n.c        sm: RR (default) | OR | RD
#         continuous study,mean.e,sd.e,n.e,mean.c,sd.c,n.c sm: MD (default) | SMD
#         generic    study,TE,seTE (ratio measures on log scale) sm: label, e.g. HR | RR | OR | MD
#         proportion study,event,n                         sm: PLOGIT (default) | PRAW
#         dta        study,TP,FP,FN,TN                     (bivariate Reitsma model)
# Defaults: random effects, REML tau^2 (ML for GLMM proportions), Hartung-Knapp CI with
# ad hoc "se" correction, prediction interval,
# funnel plot + Egger test only when k >= 10.
# Writes: summary.txt, estimates.csv, forest.png, [funnel.png], [sroc.png].
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) stop("Usage: Rscript meta_analysis.R <data.csv> <type> <outdir> [sm]")
csv <- args[1]; type <- args[2]; outdir <- args[3]; sm <- if (length(args) > 3) args[4] else NA
if (!file.exists(csv)) stop("Data file not found: ", csv)
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
d <- read.csv(csv, check.names = FALSE, stringsAsFactors = FALSE)

need <- list(binary = c("study", "event.e", "n.e", "event.c", "n.c"),
             continuous = c("study", "mean.e", "sd.e", "n.e", "mean.c", "sd.c", "n.c"),
             generic = c("study", "TE", "seTE"),
             proportion = c("study", "event", "n"),
             dta = c("study", "TP", "FP", "FN", "TN"))
if (!type %in% names(need)) stop("type must be one of: ", paste(names(need), collapse = ", "))
miss <- setdiff(need[[type]], names(d))
if (length(miss)) stop("Missing columns for ", type, ": ", paste(miss, collapse = ", "))
d <- d[complete.cases(d[need[[type]]]), ]
k <- nrow(d)
if (k < 2) stop("Need at least 2 studies with complete data; got ", k)

png_out <- function(name, expr, width = 2400, height = max(1400, 300 + 110 * k)) {
  png(file.path(outdir, name), width = width, height = height, res = 300)
  on.exit(dev.off())
  expr
}

if (type == "dta") {
  library(mada)
  fit <- reitsma(d)
  s <- summary(fit)
  sens <- s$coefficients["sensitivity", c(1, 5, 6)]
  fpr <- s$coefficients["false pos. rate", c(1, 5, 6)]
  spec <- 1 - fpr[c(1, 3, 2)]
  est <- data.frame(model = "bivariate", measure = c("sensitivity", "specificity"),
                    est = c(sens[1], spec[1]), lower = c(sens[2], spec[2]),
                    upper = c(sens[3], spec[3]), k = k)
  dor <- (est$est[1] / (1 - est$est[1])) / ((1 - est$est[2]) / est$est[2])
  est <- rbind(est, data.frame(model = "derived", measure = c("DOR", "LR+", "LR-"),
    est = c(dor, est$est[1] / (1 - est$est[2]), (1 - est$est[1]) / est$est[2]),
    lower = NA, upper = NA, k = k))
  writeLines(c(capture.output(print(madad(d))), "", capture.output(print(s)),
               "", "Point estimates (DOR, LR+, LR-) derived from pooled sens/spec; CIs not computed."),
             file.path(outdir, "summary.txt"))
  write.csv(est, file.path(outdir, "estimates.csv"), row.names = FALSE)
  png_out("sroc.png", { plot(fit, sroclwd = 2, predict = TRUE, main = "SROC (bivariate model)")
                        points(fpr(d), sens(d), pch = 1) }, height = 2400)
  png_out("forest.png", { par(mfrow = c(1, 2))
                          forest(madad(d), type = "sens", main = "Sensitivity")
                          forest(madad(d), type = "spec", main = "Specificity") }, width = 3600)
  cat("DTA meta-analysis done:", k, "studies ->", outdir, "\n")
  quit(save = "no")
}

library(meta)
# adhoc.hakn.ci = "se": HKSJ CI is never narrower than the classic random-effects CI
# (HKSJ alone can be anti-conservative when tau^2 is ~0, e.g. homogeneous trials).
common_args <- list(studlab = d$study, method.tau = "REML", method.random.ci = "HK",
                    adhoc.hakn.ci = "se", prediction = TRUE)
m <- switch(type,
  binary = do.call(metabin, c(list(d$event.e, d$n.e, d$event.c, d$n.c,
                   sm = if (is.na(sm)) "RR" else sm, method = "MH"), common_args)),
  continuous = do.call(metacont, c(list(d$n.e, d$mean.e, d$sd.e, d$n.c, d$mean.c, d$sd.c,
                       sm = if (is.na(sm)) "MD" else sm), common_args)),
  generic = do.call(metagen, c(list(d$TE, d$seTE, sm = if (is.na(sm)) "" else sm), common_args)),
  # GLMM in meta: ML tau^2 only, plain HK (no ad hoc correction); report as such in Methods.
  proportion = do.call(metaprop, c(list(d$event, d$n, method = "GLMM",
                       sm = if (is.na(sm)) "PLOGIT" else sm),
                       modifyList(common_args, list(method.tau = "ML", adhoc.hakn.ci = "")))))

est <- data.frame(model = c("common", "random"),
                  TE = c(m$TE.common, m$TE.random),
                  lower = c(m$lower.common, m$lower.random),
                  upper = c(m$upper.common, m$upper.random),
                  pi.lower = c(NA, m$lower.predict), pi.upper = c(NA, m$upper.predict),
                  tau2 = m$tau2, I2 = m$I2, Q = m$Q, pval.Q = m$pval.Q, k = m$k, sm = m$sm)
write.csv(est, file.path(outdir, "estimates.csv"), row.names = FALSE)

lines <- capture.output(print(summary(m)))
if (m$k >= 10) {
  # Egger is invalid for SMD (use Pustejovsky) and for GLMM proportions (no test run; funnel is descriptive only)
  bias <- if (type == "binary") "Harbord" else if (m$sm == "SMD") "Pustejovsky" else if (type == "proportion") NA else "Egger"
  lines <- c(lines, "", if (is.na(bias)) "Small-study test not run for proportions (Egger invalid); funnel plot is descriptive only."
                        else tryCatch(capture.output(print(metabias(m, method.bias = bias, k.min = 10))),
                                      error = function(e) paste("Small-study test", bias, "failed:", conditionMessage(e))))
  png_out("funnel.png", funnel(m, contour.levels = c(0.9, 0.95, 0.99),
                               col.contour = c("grey75", "grey85", "grey95")), height = 2400)
} else {
  lines <- c(lines, "", sprintf("Small-study effects: not tested (k = %d < 10).", m$k))
}
writeLines(lines, file.path(outdir, "summary.txt"))
png_out("forest.png", forest(m, prediction = TRUE, print.tau2 = TRUE), width = 3200)
cat(type, "meta-analysis done:", m$k, "studies ->", outdir, "\n")
