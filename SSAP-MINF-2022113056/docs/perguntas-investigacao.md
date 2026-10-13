# Perguntas de investigação

Projeto SSA — análise de filmes e séries com dados do IMDb
Nuno Silva (2022113056)

O problema é suficientemente abrangente para gerar quatro perguntas distintas. Nenhuma se
responde por simples somas ou contagens: todas exigem **cruzamento de variáveis, agregação,
comparação entre grupos ou modelação**.

---

### P1 — Que características de um filme explicam a sua avaliação média?

Até que ponto o **género**, a **duração**, a **década de lançamento** e o **número de votos**
explicam a **nota média** de um filme?

- **Variáveis:** `genres`, `runtimeMinutes`, `startYear` (→ década), `numVotes`, `averageRating`.
- **Técnica:** regressão linear múltipla; interpretação do peso relativo de cada preditor.
- **Porque não é trivial:** exige modelar vários fatores em simultâneo e distinguir o efeito
  de cada um, não basta uma média.

### P2 — A avaliação das séries evolui ao longo das temporadas?

À medida que uma série avança, a sua avaliação por temporada **mantém-se, melhora ou piora**?

- **Variáveis:** `parentTconst`, `seasonNumber`, `episodeNumber` (de `title.episode`) cruzadas
  com `averageRating` (de `title.ratings`).
- **Técnica:** junção (*join*) episódio → série, agregação da nota média por temporada, análise
  da tendência.
- **Porque não é trivial:** exige ligar cada episódio à série-mãe, agregar por temporada e
  avaliar a direção da mudança ao longo do tempo.

### P3 — Popularidade e qualidade estão relacionadas, e varia por género?

Existe relação entre a **popularidade** (número de votos) e a **qualidade percebida** (nota
média)? Essa relação é diferente consoante o **género**?

- **Variáveis:** `numVotes`, `averageRating`, `genres`.
- **Técnica:** correlação entre votos e nota, segmentada e comparada entre géneros.
- **Porque não é trivial:** exige segmentar por género e comparar a força da relação entre
  grupos, não é uma contagem.

### P4 — Como evoluíram a duração e os géneros ao longo das décadas?

Como mudaram a **duração média** dos filmes e o **peso relativo de cada género** ao longo das
décadas?

- **Variáveis:** `startYear` (→ década), `runtimeMinutes`, `genres`.
- **Técnica:** agregação temporal por década, análise da proporção de cada género ao longo do
  tempo, visualização.
- **Porque não é trivial:** exige derivar a década, separar a lista de géneros e analisar
  proporções ao longo do tempo.

---

## Nota sobre a dimensão e tipologia dos dados

Após juntar `title.basics` com `title.ratings` e filtrar por tipo de título e por um número
mínimo de votos, o conjunto de análise tem **muito acima de 1000 linhas** (centenas de milhares
de títulos) e **8+ variáveis relevantes** — numéricas contínuas (`averageRating`), discretas
(`numVotes`, `runtimeMinutes`, `startYear`), categóricas (`titleType`, `genres`) e temporais
(`startYear`). Cumpre, assim, os critérios de dimensão e tipologia do guião.
