# Risk-of-bias figures: robvis (McGuinness & Higgins 2021) where it has a template,
# a small ggplot2 equivalent for ROBINS-E.
# Usage: Rscript rob_plot.R <rob.csv> <tool> <outdir>
#   tool: ROB2 | ROBINS-I | QUADAS-2 | ROB1 | ROBINS-E
#   rob.csv: Study, D1..Dn, Overall[, Weight] – see assets/rob_template.csv.
#   Keep Study labels short (robvis rotates and truncates long names).
#   Judgements: ROB2      "Low" / "Some concerns" / "High"  ("No information" is not valid: robvis then greys out every "Some concerns")
#               ROBINS-I  "Low" / "Moderate" / "Serious" / "Critical" / "No information"
#               ROBINS-E  "Low" / "Some concerns" / "High" / "Very high" / "No information"
#               QUADAS-2  "Low" / "High" / "Unclear"
# Writes rob_traffic_light.png and rob_summary.png.
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
suppressPackageStartupMessages({ library(robvis); library(ggplot2) })
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 3) stop("Usage: Rscript rob_plot.R <rob.csv> <tool> <outdir>")
csv <- args[1]; tool <- args[2]; outdir <- args[3]
if (!file.exists(csv)) stop("RoB file not found: ", csv)
d <- read.csv(csv, check.names = FALSE, stringsAsFactors = FALSE)
if (!all(c("Study", "Overall") %in% names(d))) stop("rob.csv needs `Study` and `Overall` columns")
ok <- list(ROB2 = c("Low", "Some concerns", "High"), `QUADAS-2` = c("Low", "High", "Unclear"),
           ROB1 = c("Low", "High", "Unclear"),
           `ROBINS-I` = c("Low", "Moderate", "Serious", "Critical", "No information"))
if (!is.null(ok[[tool]])) {
  bad <- setdiff(unlist(d[setdiff(names(d), c("Study", "Weight"))]), ok[[tool]])
  if (length(bad)) stop("Invalid ", tool, " judgement(s): ", paste(unique(bad), collapse = ", "),
                        ". Allowed: ", paste(ok[[tool]], collapse = " / "))
}
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
h <- 2 + 0.35 * nrow(d)

if (tool == "ROBINS-E") {
  # ponytail: CRAN robvis 0.3.1 has no ROBINS-E template; drop this branch once it does.
  lv <- c("Low", "Some concerns", "High", "Very high", "No information")
  cols <- c("#02C100", "#E2DF07", "#BF0000", "#820000", "#4EA1F7")
  doms <- setdiff(names(d), c("Study", "Weight"))
  bad <- setdiff(unlist(d[doms]), lv)
  if (length(bad)) stop("Unknown ROBINS-E judgements: ", paste(unique(bad), collapse = ", "))
  long <- data.frame(Study = rep(d$Study, length(doms)),
                     Domain = factor(rep(doms, each = nrow(d)), levels = doms),
                     J = factor(unlist(d[doms]), levels = lv))
  long$Study <- factor(long$Study, levels = rev(d$Study))
  tl <- ggplot(long, aes(Domain, Study, colour = J)) + geom_point(size = 7) +
    scale_colour_manual(values = setNames(cols, lv), drop = FALSE, name = "Judgement") +
    scale_x_discrete(position = "top") + labs(x = NULL, y = NULL,
      caption = "ROBINS-E (launch version, 2024). D1 confounding; D2 exposure measurement; D3 selection; D4 post-exposure interventions; D5 missing data; D6 outcome measurement; D7 selection of reported result.") +
    theme_minimal() + theme(panel.grid = element_blank(), plot.caption = element_text(hjust = 0, size = 6))
  w <- if ("Weight" %in% names(d)) d$Weight else rep(1, nrow(d))
  long$w <- rep(w, length(doms))
  sm <- ggplot(long, aes(y = factor(Domain, levels = rev(doms)), x = w, fill = J)) +
    geom_col(position = "fill") + scale_x_continuous(labels = scales::percent) +
    scale_fill_manual(values = setNames(cols, lv), drop = FALSE, name = "Judgement") +
    labs(x = NULL, y = NULL) + theme_minimal()
} else {
  tl <- rob_traffic_light(d, tool = tool, psize = 8)
  sm <- rob_summary(d, tool = tool, weighted = "Weight" %in% names(d), overall = TRUE)
}
ggsave(file.path(outdir, "rob_traffic_light.png"), tl, width = 8, height = h, dpi = 300, bg = "white")
ggsave(file.path(outdir, "rob_summary.png"), sm, width = 8, height = 3, dpi = 300, bg = "white")
cat("RoB plots written to", outdir, "\n")
