# O que explica a avaliação de filmes e séries? Uma análise com dados do IMDb

Projeto individual da unidade curricular **Seminário de Sistemas e Aplicações (SSA)**
— Mestrado em Engenharia Informática, Universidade Fernando Pessoa.

- **Autor:** Nuno Silva (n.º 2022113056)
- **Email:** 2022113056@ufp.edu.pt
- **Docente:** Luís Borges Gouveia
- **Ano letivo:** 2026 · **Domínio:** Ciência dos Dados · **Ferramentas:** R, RStudio, Quarto, Git

---

## Problema

Uma nota alta no IMDb reflete **qualidade** ou apenas **popularidade**? E porque é que
tantas séries parecem perder qualidade nas últimas temporadas? Este projeto analisa, em R,
os dados públicos do IMDb para perceber **que características de um título (género, duração,
época, popularidade) estão associadas à sua avaliação**, e como esses padrões evoluíram ao
longo do tempo.

As perguntas de investigação completas estão em [`docs/perguntas-investigacao.md`](docs/perguntas-investigacao.md).

## Dados

**Fonte:** [IMDb Non-Commercial Datasets](https://developer.imdb.com/non-commercial-datasets/)
— ficheiros TSV comprimidos, de acesso livre para uso pessoal e não comercial, atualizados
diariamente, descarregados de <https://datasets.imdbws.com/>.

O **dicionário de dados** (ficheiros, variáveis, tipos e notas de qualidade) está em
[`docs/dicionario-de-dados.md`](docs/dicionario-de-dados.md).

> **Nota:** os ficheiros brutos do IMDb são muito grandes (o `title.basics` ultrapassa 1 GB
> descomprimido) e **não são versionados** neste repositório — ver `.gitignore`. São obtidos
> através do script de download abaixo, garantindo a reprodutibilidade sem poluir o histórico Git.

## Como reproduzir

```bash
# 1. Clonar o repositório
git clone https://github.com/<utilizador>/SSAP-MINF-2022113056.git
cd SSAP-MINF-2022113056
```

```r
# 2. A partir da raiz do projeto, em R/RStudio, descarregar os dados:
source("scripts/01_download_dados.R")
# Os ficheiros ficam em data/raw/
```

Todo o código usa **caminhos relativos** à raiz do projeto, para correr em qualquer máquina.

## Estrutura do repositório

```
SSAP-MINF-2022113056/
├── README.md                     Este ficheiro
├── .gitignore
├── data/
│   ├── raw/                      Dados brutos do IMDb (não versionados)
│   └── README.md
├── docs/
│   ├── perguntas-investigacao.md Perguntas de investigação (M2)
│   └── dicionario-de-dados.md    Dicionário de dados (M2)
└── scripts/
    └── 01_download_dados.R       Download reprodutível dos dados
```

(A análise em Quarto/R Markdown e os restantes scripts de limpeza e modelação serão adicionados no Momento 3.)

## Momentos de avaliação

| Momento | Descrição | Estado |
|--------|-----------|--------|
| M1 | Introdução do projeto (*pitch*) | Concluído |
| M2 | Apresentação do problema, perguntas, dicionário de dados e repositório | Em curso |
| M3 | Preparação (*wrangling*) e análise exploratória (EDA) | A fazer |
| M4 | Apresentação final e defesa | A fazer |

## Licença dos dados

Os dados pertencem ao IMDb e são usados ao abrigo da licença não comercial do IMDb.
Ver os [termos de utilização](https://developer.imdb.com/non-commercial-datasets/).
Este repositório contém apenas código e documentação, não os dados.
