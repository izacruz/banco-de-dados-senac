# Trabalho de Banco de Dados Não Relacional (MongoDB)

**Enunciado**
1. Criar 2 Databases
2. Criar 5 collections em cada Database
3. Inserir pelo menos 5 documentos em cada collection

## Resolução

| Database       | Collections                                                  | Documentos por collection |
|----------------|--------------------------------------------------------------|---------------------------|
| `loja_virtual` | clientes, produtos, pedidos, categorias, avaliacoes          | 5                         |
| `escola_mongo` | alunos, professores, cursos, disciplinas, matriculas         | 5                         |

Total: 2 databases, 10 collections e 50 documentos.

## Como executar

Com o MongoDB e o `mongosh` instalados:

```bash
mongosh --file mongodb_script.js
```

O script apaga e recria os databases a cada execução, então pode ser rodado várias vezes.
No final de cada database há consultas de teste (`find`, filtros, `aggregate` e `$lookup`)
para conferir que os dados foram inseridos corretamente.
