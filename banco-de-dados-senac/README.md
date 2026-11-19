# Trabalhos de Banco de Dados - SENAC

Repositório com os scripts SQL (MySQL) e o trabalho de banco de dados não relacional (MongoDB).

## Estrutura

```
.
├── sql/
│   ├── 01_testequartafeira_pedidos.sql      # Tabela de pedidos (22 registros) + todas as combinações de SELECT
│   ├── 02_escola_joins.sql                  # INNER/LEFT/RIGHT JOIN, ORDER BY, GROUP BY, COUNT(*) + exercício (biblioteca)
│   ├── 03_funcoes_agregadas.sql             # COUNT, AVG, MAX, MIN, SUM + exercício (mercado)
│   ├── 04_functions.sql                     # Functions: calculaFaturamento e calculaAumento (funcionários)
│   ├── 05_views.sql                         # Exemplos de views + 5 views novas
│   ├── 06_stored_procedures_exemplos.sql    # Stored procedures dos materiais (usuário e locais)
│   ├── 07_stored_procedures_exercicios.sql  # CRUD (4 procedures), calculadora e média de 4 notas
│   └── 08_triggers.sql                      # 3 triggers BEFORE e 3 triggers AFTER
└── nao-relacional/
    ├── mongodb_script.js                    # 2 databases, 5 collections cada, 5 documentos por collection
    └── README.md
```

## Como executar os scripts SQL

Cada arquivo é independente (cria e recria o próprio database). No MySQL Workbench: abrir o arquivo
e executar tudo (raio ⚡) ou, pelo terminal:

```bash
mysql -u root -p < sql/01_testequartafeira_pedidos.sql
```

Observação: nos scripts de enunciado o ENUM de estados tinha `'RE'`; foi usado `'PE'` (Pernambuco),
como no segundo exemplo do material.

## Como executar o trabalho não relacional

```bash
mongosh --file nao-relacional/mongodb_script.js
```
