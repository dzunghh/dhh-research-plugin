# One-time install of the R packages srma's scripts need.
# Run: "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" setup.R
pkgs <- c("PRISMA2020", "meta", "metafor", "robvis", "mada",
          "DiagrammeR", "DiagrammeRsvg", "rsvg", "htmlwidgets")
lib <- Sys.getenv("R_LIBS_USER")
if (!dir.exists(lib)) dir.create(lib, recursive = TRUE)
.libPaths(c(lib, .libPaths()))
missing <- setdiff(pkgs, rownames(installed.packages()))
if (length(missing)) {
  install.packages(missing, lib = lib, repos = "https://cloud.r-project.org")
}
# Upgrade any outdated dependency (e.g. rlang) into the user library – an old copy in the
# system library otherwise blocks `meta` from loading.
repos <- "https://cloud.r-project.org"
deps <- unique(unlist(tools::package_dependencies(pkgs, db = available.packages(repos = repos),
                                                  recursive = TRUE)))
old <- old.packages(repos = repos)
stale <- intersect(rownames(old), c(pkgs, deps))
if (length(stale)) install.packages(stale, lib = lib, repos = repos)
# Check loading in a fresh process: this session may hold old namespaces (e.g. rlang).
code <- sprintf(".libPaths(c('%s', .libPaths())); ok <- vapply(c(%s), requireNamespace, logical(1), quietly = TRUE); print(ok); cat(all(ok))",
                normalizePath(lib, "/"), paste0("'", pkgs, "'", collapse = ","))
res <- system2(file.path(R.home("bin"), "Rscript"), c("-e", shQuote(code)), stdout = TRUE)
cat(res, sep = "\n")
ok <- grepl("TRUE$", tail(res, 1))
if (!ok) stop("Some packages failed to load – see FALSE entries above")
cat("srma setup complete\n")
