# Dicionário de dados

Projeto SSA — análise de filmes e séries com dados do IMDb
Nuno Silva (2022113056)

## Fonte e formato

- **Origem:** IMDb Non-Commercial Datasets — <https://datasets.imdbws.com/>
- **Documentação oficial:** <https://developer.imdb.com/non-commercial-datasets/>
- **Formato:** ficheiros TSV (separados por tabulações), comprimidos em `.gz`, em UTF-8.
- **Valores em falta:** representados pela string `\N` (não como `NA`) — exigem conversão
  explícita na importação.
- **Chaves de ligação:** `tconst` identifica um título; `nconst` identifica uma pessoa.

As tabelas seguintes descrevem os ficheiros que o projeto vai usar. Os tipos indicados são os
tipos **após limpeza** (no ficheiro bruto, campos numéricos com `\N` chegam como texto).

---

## Ficheiros centrais

### `title.basics.tsv.gz` — informação base de cada título

| Variável | Tipo | Descrição | Exemplo | Notas |
|----------|------|-----------|---------|-------|
| `tconst` | string | Identificador único do título (chave) | `tt0111161` | chave para junções |
| `titleType` | categórica | Tipo/formato do título | `movie`, `tvSeries`, `tvEpisode`, `short` | filtrar para a análise |
| `primaryTitle` | string | Título mais popular / promocional | `The Shawshank Redemption` | |
| `originalTitle` | string | Título original, na língua original | `The Shawshank Redemption` | |
| `isAdult` | booleana (0/1) | 0: não-adulto; 1: adulto | `0` | |
| `startYear` | inteiro (AAAA) | Ano de lançamento (séries: ano de início) | `1994` | base para a *década* |
| `endYear` | inteiro (AAAA) | Ano de fim da série; `\N` nos restantes | `\N` | muitos omissos (esperado) |
| `runtimeMinutes` | inteiro | Duração em minutos | `142` | texto no bruto; *outliers* possíveis |
| `genres` | lista (texto) | Até 3 géneros, separados por vírgula | `Drama,Crime` | precisa de ser separada |

### `title.ratings.tsv.gz` — avaliações agregadas

| Variável | Tipo | Descrição | Exemplo | Notas |
|----------|------|-----------|---------|-------|
| `tconst` | string | Identificador do título (chave) | `tt0111161` | junta com `title.basics` |
| `averageRating` | numérica (contínua) | Média ponderada das avaliações dos utilizadores (1–10) | `9.3` | variável-resposta principal |
| `numVotes` | inteiro | Número de votos recebidos | `2900000` | medida de popularidade; filtrar mínimo |

### `title.episode.tsv.gz` — ligação episódio → série

| Variável | Tipo | Descrição | Exemplo | Notas |
|----------|------|-----------|---------|-------|
| `tconst` | string | Identificador do episódio | `tt0959621` | |
| `parentTconst` | string | Identificador da série-mãe | `tt0903747` | junta episódios à série |
| `seasonNumber` | inteiro | Número da temporada | `1` | omissos possíveis |
| `episodeNumber` | inteiro | Número do episódio na temporada | `1` | omissos possíveis |

---

## Ficheiros opcionais (extensão sobre realizadores)

Usados apenas se a análise for estendida a realizadores; não são centrais às quatro perguntas.

### `title.crew.tsv.gz`

| Variável | Tipo | Descrição | Notas |
|----------|------|-----------|-------|
| `tconst` | string | Identificador do título (chave) | |
| `directors` | lista de `nconst` | Realizador(es) | lista separada por vírgula |
| `writers` | lista de `nconst` | Argumentista(s) | lista separada por vírgula |

### `name.basics.tsv.gz`

| Variável | Tipo | Descrição | Notas |
|----------|------|-----------|-------|
| `nconst` | string | Identificador único da pessoa (chave) | |
| `primaryName` | string | Nome pelo qual é mais creditada | |
| `birthYear` | inteiro (AAAA) | Ano de nascimento | omissos como `\N` |
| `deathYear` | inteiro (AAAA) | Ano de morte, se aplicável | omissos como `\N` |
| `primaryProfession` | lista (texto) | Top-3 profissões | |
| `knownForTitles` | lista de `tconst` | Títulos pelos quais é conhecida | |

---

## Conjunto de análise (após junções e limpeza)

A análise principal resulta de juntar `title.basics` + `title.ratings` por `tconst`, filtrar
por `titleType` e por um número mínimo de votos. Variáveis derivadas a construir no M3:

| Variável derivada | Origem | Descrição |
|-------------------|--------|-----------|
| `decada` | `startYear` | Década de lançamento (ex.: 1990, 2000) |
| `genero_principal` | `genres` | Primeiro género da lista |
| `duracao_min` | `runtimeMinutes` | Duração convertida para numérico |
| `faixa_votos` | `numVotes` | Categorização da popularidade (ex.: baixa/média/alta) |
| `media_temporada` | `title.episode` + `title.ratings` | Nota média por temporada de uma série |

---

## Notas de qualidade dos dados (validação)

Problemas a tratar na fase de preparação (*wrangling*), no M3:

- **Omissos como `\N`:** convertê-los para `NA` na importação (`na = "\\N"`).
- **Campos numéricos como texto:** `runtimeMinutes`, `startYear` e `endYear` chegam como texto
  por causa do `\N`; exigem conversão de tipo.
- **`genres` é uma lista numa só coluna:** `"Drama,Crime"` tem de ser separada para análise.
- **Tipos de título misturados:** `movie`, `short`, `tvSeries`, `tvEpisode`, `video`,
  `videoGame`, etc.; é preciso filtrar os tipos relevantes para cada pergunta.
- **Títulos com muito poucos votos:** enviesam as médias; aplicar um limiar mínimo de `numVotes`.
- **Outliers de duração:** valores absurdos de `runtimeMinutes` a inspecionar e tratar.
- **Dimensão:** os ficheiros têm milhões de linhas; a análise corre sobre um subconjunto
  filtrado para ser viável num computador pessoal.
