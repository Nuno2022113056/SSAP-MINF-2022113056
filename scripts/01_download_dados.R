# Pasta de destino
destino_dir <- file.path("data", "raw")
dir.create(destino_dir, recursive = TRUE, showWarnings = FALSE)

# URL base e ficheiros a descarregar
base_url <- "https://datasets.imdbws.com/"

# Ficheiros centrais da analise
ficheiros <- c(
  "title.basics.tsv.gz",   # titulos: tipo, ano, duracao, generos
  "title.ratings.tsv.gz",  # avaliacoes: nota media e n.o de votos
  "title.episode.tsv.gz"   # ligacao episodio -> serie, temporada
)

# Os ficheiros sao grandes: aumentar o tempo-limite de download
options(timeout = max(600, getOption("timeout")))

for (f in ficheiros) {
  destino <- file.path(destino_dir, f)
  if (file.exists(destino)) {
    message("Ja existe, a saltar: ", f)
    next
  }
  message("A descarregar: ", f, " ...")
  download.file(
    url      = paste0(base_url, f),
    destfile = destino,
    mode     = "wb"   # binario (essencial em Windows)
  )
}

message("\nConcluido. Ficheiros disponiveis em: ", normalizePath(destino_dir))
