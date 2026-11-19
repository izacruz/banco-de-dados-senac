-- ============================================================
-- EXERCÍCIO 5 - Views
-- 1) Executar todos os exemplos dos materiais
-- 2) Criar e executar pelo menos 5 views diferentes das vistas em sala
-- ============================================================

-- ------------------- EXEMPLO 1 (escola) --------------------
DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;
USE escola;

DROP TABLE IF EXISTS professores;
DROP TABLE IF EXISTS enderecos;
CREATE TABLE enderecos
(
  cod_endereco int not null PRIMARY KEY,
  logradouro varchar(400) not null,
  numero int,
  complemento varchar(400),
  bairro varchar(400) not null,
  cidade varchar(400) not null,
  estado enum ('SP', 'RJ', 'MG', 'AL', 'PE', 'DF')
);
CREATE TABLE professores
(
  id_professor int PRIMARY KEY,
  nome varchar(200) not null,
  data_de_nascimento datetime,
  cod_endereco int null,
  FOREIGN KEY (cod_endereco) REFERENCES enderecos(cod_endereco)
);

INSERT INTO enderecos
(cod_endereco, logradouro, numero, complemento, bairro, cidade, estado)
VALUES
(1, 'Rua X', 36, 'ALA A', 'Socorro', 'SP', 'SP'),
(2, 'Rua Y', 23, 'Bloco 1', 'Socorro', 'SP', 'SP'),
(3, 'Rua C', 53, 'Bloco 2', 'Lapa', 'SP', 'SP'),
(4, 'Rua D', 64, 'Bloco 4', 'Morumbi', 'SP', 'SP'),
(5, 'Rua E', 55, '25 and', 'Paraiso', 'RJ', 'RJ'),
(6, 'Rua F', 49, null, 'Copacabana', 'RJ', 'RJ'),
(7, 'Rua G', 33, null, 'Leblon', 'RJ', 'RJ'),
(8, 'Rua H', 77, null, 'Pajuçara', 'AL', 'AL'),
(9, 'Rua I', 88, null, 'Ponta Verde', 'AL', 'AL'),
(10, 'Rua J', 897, null, 'Centro', 'MG', 'MG');

INSERT INTO professores
(id_professor, nome, data_de_nascimento, cod_endereco)
VALUES
(1, 'Alberto Silva', '2024-05-06 19:47:35', 1),
(2, 'Joao Abreu', '2000-05-08 19:47:35', 1),
(3, 'Cristina Santos', '1999-05-06 19:47:35', 2),
(4, 'Zagalo Oliveira', '1980-05-06 19:47:35', 2),
(5, 'Jose Luiz', '1900-05-06 19:47:35', null),
(6, 'Fernando Zaskowiski', '2001-05-06 19:47:35', null),
(7, 'Fernanda Zaskowiski', '2022-05-06 19:47:35', null),
(8, 'Zenaide Zenoide', '2024-05-06 19:47:35', null);

SELECT * FROM enderecos;
SELECT * FROM professores;

CREATE VIEW VW_Join_Professores_e_alunos AS
SELECT p.id_professor, p.nome FROM professores p INNER JOIN enderecos e
    ON p.cod_endereco = e.cod_endereco;
SELECT * FROM VW_Join_Professores_e_alunos;

CREATE VIEW VW_RightJoin_Professores_e_alunos AS
SELECT p.id_professor, p.nome FROM professores p RIGHT JOIN enderecos e
ON p.cod_endereco = e.cod_endereco;
SELECT * FROM VW_RightJoin_Professores_e_alunos;

CREATE VIEW VW_LeftJoin_Professores_e_alunos AS
SELECT p.id_professor, p.nome FROM professores p LEFT JOIN enderecos e
    ON p.cod_endereco = e.cod_endereco;
SELECT * FROM VW_LeftJoin_Professores_e_alunos;

-- ------------------- EXEMPLO 2 (produto) -------------------
DROP DATABASE IF EXISTS PRODUTO;
CREATE DATABASE PRODUTO;
USE PRODUTO;

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(20, 2),
    estoque INT
);

CREATE VIEW vw_produtos AS
SELECT id, nome, preco, estoque
FROM produtos;

# Inserindo dados ATRAVÉS da view (view simples = atualizável)
INSERT INTO vw_produtos (ID, nome, preco, estoque) VALUES (1, 'Produto A', 10.99, 100);
INSERT INTO vw_produtos (ID, nome, preco, estoque) VALUES (2, 'Produto B', 29.50, 200);
INSERT INTO vw_produtos (ID, nome, preco, estoque) VALUES (3, 'Produto C', 55.22, 5000);

SELECT * FROM produtos;
SELECT * FROM vw_produtos;

-- ============================================================
-- EXERCÍCIO 2: 5 VIEWS NOVAS (diferentes das vistas em sala)
-- Banco: escola
-- ============================================================
USE escola;

-- View 1: professores que moram em São Paulo (filtro com WHERE + JOIN)
CREATE OR REPLACE VIEW vw_professores_sp AS
SELECT p.id_professor, p.nome, e.bairro, e.estado
  FROM professores p
  INNER JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 WHERE e.estado = 'SP';
SELECT * FROM vw_professores_sp;

-- View 2: quantidade de endereços por estado (GROUP BY + COUNT)
CREATE OR REPLACE VIEW vw_enderecos_por_estado AS
SELECT estado, COUNT(*) AS qtd_enderecos
  FROM enderecos
 GROUP BY estado;
SELECT * FROM vw_enderecos_por_estado;

-- View 3: professores sem endereço cadastrado (LEFT JOIN + IS NULL)
CREATE OR REPLACE VIEW vw_professores_sem_endereco AS
SELECT p.id_professor, p.nome, p.data_de_nascimento
  FROM professores p
  LEFT JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 WHERE p.cod_endereco IS NULL;
SELECT * FROM vw_professores_sem_endereco;

-- View 4: endereço completo formatado (CONCAT)
CREATE OR REPLACE VIEW vw_endereco_completo AS
SELECT cod_endereco,
       CONCAT(logradouro, ', ', IFNULL(numero, 's/n'), ' - ', bairro, ' - ', cidade, '/', estado) AS endereco_completo
  FROM enderecos;
SELECT * FROM vw_endereco_completo;

-- View 5: professores com idade calculada, ordenados do mais velho (função de data + ORDER BY)
CREATE OR REPLACE VIEW vw_professores_idade AS
SELECT id_professor, nome, TIMESTAMPDIFF(YEAR, data_de_nascimento, CURDATE()) AS idade
  FROM professores
 ORDER BY idade DESC;
SELECT * FROM vw_professores_idade;

-- View 6 (bônus): produtos caros, atualizável, com CHECK OPTION
USE PRODUTO;
CREATE OR REPLACE VIEW vw_produtos_caros AS
SELECT id, nome, preco, estoque FROM produtos WHERE preco > 20
WITH CHECK OPTION;
SELECT * FROM vw_produtos_caros;

SHOW FULL TABLES IN escola WHERE TABLE_TYPE = 'VIEW';
