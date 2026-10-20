# Descarrega os dados do IMDb para data/raw/
# source("scripts/01_download_dados.R")

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

base_url <- "https://datasets.imdbws.com/"
ficheiros <- c("title.basics.tsv.gz", "title.ratings.tsv.gz", "title.episode.tsv.gz")

options(timeout = max(600, getOption("timeout")))

for (f in ficheiros) {
  destino <- file.path("data/raw", f)
  if (file.exists(destino)) next
  message("A descarregar: ", f)
  download.file(paste0(base_url, f), destino, mode = "wb")
}
message("Concluido.")
