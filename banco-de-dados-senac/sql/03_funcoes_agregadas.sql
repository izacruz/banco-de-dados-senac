-- ============================================================
-- EXERCÍCIO 3 - Funções agregadas: COUNT(*), AVG, MAX, MIN, SUM
-- Parte A: script de exemplo | Parte B: exercício próprio
-- ============================================================

-- ------------------------- PARTE A -------------------------
DROP DATABASE IF EXISTS PBD_senac_2_semestre_2026;
CREATE DATABASE PBD_senac_2_semestre_2026;
USE PBD_senac_2_semestre_2026;

DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos
(
  id_produto int not null PRIMARY KEY,
  descricao_produto varchar(300) not null,
  embalagem varchar(300) not null,
  preco decimal (20,2) not null default '0',
  sabor varchar(300) not null
);

INSERT INTO produtos
(id_produto, descricao_produto, embalagem, preco, sabor)
VALUES
(1, 'Frescor do Verão - Uva', 'Garrafa', '8.50', 'Uva'),
(2, 'Linha Refrescante - Laranja', 'PET', '10.00', 'Laranja'),
(3, 'Festival de Sabores - Maracuja', 'Garrafa', '9.50', 'Maracuja'),
(4, 'Frescor do Verão - Laranja', 'Lata', '5.00', 'Laranja'),
(5, 'Festival de Sabores - Maracuja', 'Lata', '6.00', 'Maracuja'),
(6, 'Linha Refrescante - Manga', 'PET', '9.00', 'Manga');

SELECT * FROM produtos;
SELECT embalagem, COUNT(*) as contagem FROM produtos GROUP BY embalagem;
SELECT embalagem, AVG(preco) as media FROM produtos GROUP BY embalagem;
SELECT embalagem, MAX(preco) as Maximo, MIN(preco) as Minimo FROM produtos GROUP BY embalagem;
SELECT embalagem, SUM(preco) as Soma FROM produtos GROUP BY embalagem;
SELECT SUM(preco) as Soma FROM produtos;
SELECT embalagem FROM produtos GROUP BY embalagem;

-- ------------------------- PARTE B -------------------------
/*
Exercício
- Criar um database
- Usar este database
- Criar pelo menos 1 tabela com algumas colunas
- Inserir pelo 10 registros
- Utilizar select com as funcoes agregadas: COUNT(*), AVG, MAX, MIN, SUM
*/
DROP DATABASE IF EXISTS mercado;
CREATE DATABASE mercado;
USE mercado;

CREATE TABLE itens
(
  id_item int not null PRIMARY KEY,
  nome_item varchar(200) not null,
  setor varchar(100) not null,
  preco decimal(20,2) not null,
  estoque int not null
);

INSERT INTO itens (id_item, nome_item, setor, preco, estoque) VALUES
(1,  'Arroz 5kg',         'Mercearia',  27.90, 120),
(2,  'Feijao 1kg',        'Mercearia',   8.50, 200),
(3,  'Leite Integral 1L', 'Laticinios',  5.20, 300),
(4,  'Queijo Mussarela',  'Laticinios', 42.00,  60),
(5,  'Iogurte Natural',   'Laticinios',  3.90, 150),
(6,  'Detergente',        'Limpeza',     2.60, 400),
(7,  'Sabao em Po 1kg',   'Limpeza',    14.90,  90),
(8,  'Desinfetante',      'Limpeza',     7.80, 110),
(9,  'Maca kg',           'Hortifruti',  9.90,  80),
(10, 'Banana kg',         'Hortifruti',  6.50, 130),
(11, 'Tomate kg',         'Hortifruti',  8.90,  70),
(12, 'Macarrao 500g',     'Mercearia',   5.40, 250);

SELECT * FROM itens;
SELECT COUNT(*) AS total_itens FROM itens;
SELECT AVG(preco) AS preco_medio FROM itens;
SELECT MAX(preco) AS mais_caro FROM itens;
SELECT MIN(preco) AS mais_barato FROM itens;
SELECT SUM(estoque) AS estoque_total FROM itens;
SELECT SUM(preco * estoque) AS valor_total_estoque FROM itens;

-- Todas as funções juntas
SELECT COUNT(*) AS qtd, AVG(preco) AS media, MAX(preco) AS maximo,
       MIN(preco) AS minimo, SUM(preco) AS soma
  FROM itens;

-- Agregadas com GROUP BY
SELECT setor, COUNT(*) AS qtd FROM itens GROUP BY setor;
SELECT setor, ROUND(AVG(preco), 2) AS media FROM itens GROUP BY setor;
SELECT setor, MAX(preco) AS maximo, MIN(preco) AS minimo FROM itens GROUP BY setor;
SELECT setor, SUM(estoque) AS estoque_setor FROM itens GROUP BY setor;
SELECT setor, SUM(preco * estoque) AS valor_estoque FROM itens GROUP BY setor ORDER BY valor_estoque DESC;
-- Com HAVING
SELECT setor, COUNT(*) AS qtd FROM itens GROUP BY setor HAVING COUNT(*) > 3;
