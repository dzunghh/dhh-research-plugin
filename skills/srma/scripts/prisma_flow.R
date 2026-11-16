# PRISMA 2020 flow diagram via the PRISMA2020 package (Haddaway et al. 2022, doi:10.1002/cl2.1230).
# Usage: Rscript prisma_flow.R <counts.csv> <out.html|png|svg|pdf>
# counts.csv is either the full PRISMA2020 template (assets/prisma_template.csv) or a short
# two-column file `data,n` naming only the boxes you have (see assets/prisma_counts.csv).
# Missing boxes default to 0. "Previous studies" and "other methods" arms are drawn only when
# they have non-zero counts. Counts that don't reconcile are reported as warnings.
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
suppressPackageStartupMessages(library(PRISMA2020))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) stop("Usage: Rscript prisma_flow.R <counts.csv> <out.html|png|svg|pdf>")
csv <- args[1]; out <- args[2]
ext <- tolower(tools::file_ext(out))
if (!ext %in% c("html", "png", "svg", "pdf")) stop("Output must end in .html, .png, .svg or .pdf")
if (!file.exists(csv)) stop("Counts file not found: ", csv)

here <- dirname(normalizePath(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])))
tpl <- read.csv(file.path(dirname(here), "assets", "prisma_template.csv"),
                stringsAsFactors = FALSE, colClasses = "character")
user <- read.csv(csv, stringsAsFactors = FALSE, colClasses = "character")
if (!all(c("data", "n") %in% names(user))) stop("counts.csv needs columns `data` and `n`")
unknown <- setdiff(user$data[!is.na(user$data) & user$data != ""], tpl$data)
if (length(unknown)) stop("Unknown box names: ", paste(unknown, collapse = ", "),
                          "\nValid names: ", paste(na.omit(tpl$data), collapse = ", "))

# Start from a zeroed template so unspecified boxes don't show placeholder text.
is_box <- !is.na(tpl$data) & tpl$data != ""
tpl$n[is_box] <- "0"
idx <- match(user$data, tpl$data)
tpl$n[idx[!is.na(idx)]] <- user$n[!is.na(idx)]

num <- function(key) suppressWarnings(as.numeric(tpl$n[match(key, tpl$data)]))
# "Reason, 12; Reason, 3" -> 15; plain numbers pass through.
total <- function(key) {
  v <- tpl$n[match(key, tpl$data)]
  if (grepl(",", v)) sum(as.numeric(sub(".*,\\s*", "", strsplit(v, ";")[[1]]))) else as.numeric(v)
}
db_total <- num("database_results") + num("register_results")
checks <- list(
  records_screened = c(num("records_screened"),
    db_total - num("duplicates") - num("excluded_automatic") - num("excluded_other")),
  dbr_sought_reports = c(num("dbr_sought_reports"), num("records_screened") - num("records_excluded")),
  dbr_assessed = c(num("dbr_assessed"), num("dbr_sought_reports") - num("dbr_notretrieved_reports")),
  other_assessed = c(num("other_assessed"),
    num("other_sought_reports") - num("other_notretrieved_reports")),
  new_reports = c(num("new_reports"), num("dbr_assessed") - total("dbr_excluded") +
    num("other_assessed") - total("other_excluded")))
for (box in names(checks)) {
  v <- checks[[box]]
  if (!any(is.na(v)) && v[1] != v[2])
    message(sprintf("WARNING: %s = %s but upstream boxes imply %s", box, v[1], v[2]))
}
if (num("new_studies") > num("new_reports"))
  message("WARNING: new_studies exceeds new_reports (each study has >= 1 report)")

nonzero <- function(keys) any(vapply(keys, function(k) {
  v <- tpl$n[match(k, tpl$data)]; !is.na(v) && v != "0" && v != ""
}, logical(1)))
dat <- PRISMA_data(tpl)
plot <- PRISMA_flowdiagram(dat,
  interactive = ext == "html",
  previous = nonzero(c("previous_studies", "previous_reports")),
  other = nonzero(c("website_results", "organisation_results", "citations_results")),
  detail_databases = nonzero("database_specific_results"),
  detail_registers = nonzero("register_specific_results"),
  meta_analysis = nonzero(c("total_studies_ma", "total_reports_ma")),
  fontsize = 10)
out <- normalizePath(out, mustWork = FALSE)
dir.create(dirname(out), showWarnings = FALSE, recursive = TRUE)
# PRISMA_save() needs pandoc for every format (self-contained HTML). Without pandoc, use the
# package's own SVG step (PRISMA2020:::PRISMA_gen_tmp_svg_, MIT) with a non-self-contained widget.
svg_of <- function(obj) {
  html <- tempfile(fileext = ".html")
  htmlwidgets::saveWidget(obj, html, selfcontained = FALSE)
  js <- xml2::xml_text(xml2::xml_find_first(xml2::read_html(html),
    "//div[contains(@class, \"grViz\")]//following-sibling::script"))
  svg <- xml2::read_xml(DiagrammeRsvg::export_svg(obj))
  ns <- xml2::xml_ns(svg)
  # Rotate the side labels (Identification / Screening / Included) as the package does.
  nodes <- stringr::str_split(stringr::str_remove_all(
    stringr::str_match(js, "const nodeMap = new Map\\(\\[(.*)\\]\\);")[1, 2], "\\[|\"|]"),
    ",\\s", simplify = TRUE)
  for (nd in nodes) {
    kv <- stringr::str_split_fixed(nd, ",", 2)
    t <- xml2::xml_find_first(svg, sprintf("//d1:g[@id=\"%s\"]//d1:text", kv[, 1]), ns)
    x <- xml2::xml_attr(t, "x"); y <- xml2::xml_attr(t, "y")
    xml2::xml_attr(t, "x") <- -as.double(y)
    xml2::xml_attr(t, "y") <- as.double(x) + 2
    xml2::xml_attr(t, "transform") <- "rotate(-90)"
    xml2::xml_text(t) <- kv[, 2]
  }
  f <- tempfile(fileext = ".svg"); xml2::write_xml(svg, f); f
}
if (rmarkdown::pandoc_available()) {
  PRISMA_save(plot, filename = out, filetype = toupper(ext), overwrite = TRUE)
} else if (ext == "html") {
  # ponytail: HTML plus a sibling _files folder; install pandoc for a single file.
  htmlwidgets::saveWidget(plot, out, selfcontained = FALSE, title = "PRISMA 2020 flow diagram")
} else {
  svg <- svg_of(plot)
  switch(ext, svg = file.copy(svg, out, overwrite = TRUE),
         png = rsvg::rsvg_png(svg, out, width = 2400), pdf = rsvg::rsvg_pdf(svg, out))
}
cat("PRISMA flow diagram written:", out, "\n")
