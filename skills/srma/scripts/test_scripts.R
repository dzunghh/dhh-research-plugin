# Self-check for srma's R scripts. Run:
#   "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" test_scripts.R
# Exits non-zero on the first failed assertion.
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
here <- dirname(normalizePath(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])))
assets <- file.path(dirname(here), "assets")
rscript <- file.path(R.home("bin"), "Rscript")
out <- file.path(tempdir(), "srma-test")
unlink(out, recursive = TRUE); dir.create(out)

run <- function(script, ...) {
  res <- system2(rscript, c(shQuote(file.path(here, script)), shQuote(c(...))),
                 stdout = TRUE, stderr = TRUE)
  status <- attr(res, "status")
  if (!is.null(status) && status != 0) {
    cat(res, sep = "\n"); stop(script, " exited with status ", status)
  }
  invisible(res)
}
exists_nonempty <- function(f) file.exists(f) && file.size(f) > 0
check <- function(ok, msg) { if (!isTRUE(ok)) stop("FAIL: ", msg); cat("ok  ", msg, "\n") }

# 1. Generic inverse-variance on metafor's BCG data must match the textbook REML estimate.
bcg <- metafor::escalc("RR", ai = tpos, bi = tneg, ci = cpos, di = cneg, data = metadat::dat.bcg)
gen <- data.frame(study = paste(bcg$author, bcg$year), TE = bcg$yi, seTE = sqrt(bcg$vi))
write.csv(gen, file.path(out, "bcg.csv"), row.names = FALSE)
run("meta_analysis.R", file.path(out, "bcg.csv"), "generic", file.path(out, "bcg"), "RR")
est <- read.csv(file.path(out, "bcg", "estimates.csv"))
re <- est[est$model == "random", ]
check(abs(re$TE - (-0.7145)) < 0.001, "BCG REML log RR = -0.7145")
check(re$k == 13, "BCG k = 13")
check(exists_nonempty(file.path(out, "bcg", "funnel.png")), "funnel drawn when k >= 10")

# 2. Every data type runs on its asset template and writes forest + summary.
for (type in c("binary", "continuous", "generic", "proportion", "dta")) {
  dir <- file.path(out, type)
  run("meta_analysis.R", file.path(assets, paste0("extract_", type, ".csv")), type, dir)
  check(exists_nonempty(file.path(dir, "forest.png")), paste(type, "forest.png"))
  check(exists_nonempty(file.path(dir, "summary.txt")), paste(type, "summary.txt"))
}
check(!file.exists(file.path(out, "binary", "funnel.png")), "funnel skipped when k < 10")
check(exists_nonempty(file.path(out, "dta", "sroc.png")), "dta sroc.png")

# 2b. Small-study tests chosen by data type when k >= 10: no Egger on GLMM proportions, Pustejovsky for SMD.
set.seed(1)
pr <- data.frame(study = paste("S", 1:12), event = rbinom(12, 200, 0.3), n = 200)
write.csv(pr, file.path(out, "pr12.csv"), row.names = FALSE)
run("meta_analysis.R", file.path(out, "pr12.csv"), "proportion", file.path(out, "pr12"))
txt <- paste(readLines(file.path(out, "pr12", "summary.txt")), collapse = "
")
check(grepl("not run for proportions", txt) && !grepl("Linear regression test", txt), "no Egger test on proportions")
ct <- data.frame(study = paste("S", 1:12), mean.e = rnorm(12, 5, .3), sd.e = runif(12, 1.5, 2.5), n.e = sample(30:120, 12),
                 mean.c = rnorm(12, 4.5, .3), sd.c = runif(12, 1.5, 2.5), n.c = sample(30:120, 12))
write.csv(ct, file.path(out, "ct12.csv"), row.names = FALSE)
run("meta_analysis.R", file.path(out, "ct12.csv"), "continuous", file.path(out, "ct12"), "SMD")
txt <- paste(readLines(file.path(out, "ct12", "summary.txt")), collapse = "
")
check(grepl("Pustejovsky", txt), "SMD uses Pustejovsky small-study test")

# 3. PRISMA flow diagram from key-value counts, all output formats.
for (ext in c("html", "png", "svg", "pdf")) {
  f <- file.path(out, paste0("prisma.", ext))
  run("prisma_flow.R", file.path(assets, "prisma_counts.csv"), f)
  check(exists_nonempty(f), paste("prisma", ext))
}
# Counts that don't reconcile must be reported.
bad <- read.csv(file.path(assets, "prisma_counts.csv"), colClasses = "character")
bad$n[bad$data == "records_screened"] <- "1"
write.csv(bad, file.path(out, "bad_counts.csv"), row.names = FALSE)
msg <- run("prisma_flow.R", file.path(out, "bad_counts.csv"), file.path(out, "bad.png"))
check(any(grepl("records_screened", msg)), "reconciliation warning names the bad box")

# 4. Risk-of-bias plots.
run("rob_plot.R", file.path(assets, "rob_template.csv"), "ROB2", file.path(out, "rob"))
check(exists_nonempty(file.path(out, "rob", "rob_traffic_light.png")), "rob traffic light")
badrob <- read.csv(file.path(assets, "rob_template.csv"), check.names = FALSE); badrob$D5[1] <- "No information"
write.csv(badrob, file.path(out, "badrob.csv"), row.names = FALSE)
res <- suppressWarnings(system2(rscript, c(shQuote(file.path(here, "rob_plot.R")), shQuote(c(file.path(out, "badrob.csv"), "ROB2", file.path(out, "badrob")))), stdout = TRUE, stderr = TRUE))
check(!is.null(attr(res, "status")) && any(grepl("Invalid ROB2", res)), "ROB2 rejects 'No information' instead of greying out Some concerns")
check(exists_nonempty(file.path(out, "rob", "rob_summary.png")), "rob summary")
robe <- data.frame(Study = c("Cohort A", "Cohort B"), D1 = c("Some concerns", "Very high"),
                   D2 = "Low", D3 = "Low", D4 = "Low", D5 = c("High", "Low"), D6 = "Low",
                   D7 = "Low", Overall = c("High", "Very high"), check.names = FALSE)
write.csv(robe, file.path(out, "robe.csv"), row.names = FALSE)
run("rob_plot.R", file.path(out, "robe.csv"), "ROBINS-E", file.path(out, "robe"))
check(exists_nonempty(file.path(out, "robe", "rob_traffic_light.png")), "ROBINS-E traffic light")

# 5. HKSJ interval is never narrower than the classic random-effects interval.
bin <- read.csv(file.path(out, "binary", "estimates.csv"))
check(with(bin[bin$model == "random", ], upper - lower) >=
      with(bin[bin$model == "common", ], upper - lower) - 1e-8,
      "HKSJ CI not narrower than common-effect CI for homogeneous trials")

cat("\nAll srma script checks passed.\n")
