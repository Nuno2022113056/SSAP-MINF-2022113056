# Prepara o conjunto de analise dos filmes -> data/processed/filmes.rds
# source("scripts/02_preparar_dados.R")

library(readr)
library(dplyr)

min_votos <- 1000  # remove titulos com medias instaveis

ratings <- read_tsv(
  "data/raw/title.ratings.tsv.gz", na = "\\N",
  col_types = cols(tconst = col_character(),
                   averageRating = col_double(),
                   numVotes = col_integer()))

basics <- read_tsv(
  "data/raw/title.basics.tsv.gz", na = "\\N",
  col_select = c(tconst, titleType, primaryTitle, startYear, runtimeMinutes, genres),
  col_types = cols(tconst = col_character(), titleType = col_character(),
                   primaryTitle = col_character(), startYear = col_integer(),
                   runtimeMinutes = col_integer(), genres = col_character()))

filmes <- basics %>%
  filter(titleType == "movie", !is.na(startYear)) %>%
  inner_join(ratings, by = "tconst") %>%
  filter(numVotes >= min_votos) %>%
  mutate(decada = (startYear %/% 10) * 10,
         genero_principal = sub(",.*", "", genres))

rm(basics); gc()

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
saveRDS(filmes, "data/processed/filmes.rds")

message("Linhas: ", nrow(filmes), " | guardado em data/processed/filmes.rds")
