# Pasta de dados

Os dados brutos do IMDb **não são versionados** neste repositório por serem demasiado
grandes (o `title.basics.tsv.gz` ultrapassa 1 GB descomprimido e excede o limite do GitHub).

Para os obter, corre a partir da raiz do projeto, em R:

```r
source("scripts/01_download_dados.R")
```

Os ficheiros `.tsv.gz` ficam em `data/raw/`. A pasta mantém-se no repositório através do
ficheiro `.gitkeep`, mas o seu conteúdo é ignorado pelo Git (ver `.gitignore`).

**Fonte:** <https://datasets.imdbws.com/> · documentação em
<https://developer.imdb.com/non-commercial-datasets/>
