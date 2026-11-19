-- ============================================================
-- EXERCÍCIO 2 - JOINs, ORDER BY, GROUP BY, COUNT(*)
-- Parte A: script de exemplo (escola)
-- Parte B: exercício próprio (biblioteca)
-- ============================================================

-- ------------------------- PARTE A -------------------------
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

## INNER JOIN (sintaxe antiga e sintaxe moderna)
SELECT * FROM professores p, enderecos e
 WHERE p.cod_endereco = e.cod_endereco;
SELECT * FROM professores p INNER JOIN enderecos e
    ON p.cod_endereco = e.cod_endereco;
## RIGHT JOIN
SELECT * FROM professores p RIGHT JOIN enderecos e
    ON p.cod_endereco = e.cod_endereco;
## LEFT JOIN
SELECT * FROM professores p LEFT JOIN enderecos e
    ON p.cod_endereco = e.cod_endereco;

-- ORDER BY / GROUP BY / COUNT
SELECT COUNT(*) FROM enderecos;
SELECT * FROM enderecos ORDER BY cod_endereco;
SELECT * FROM enderecos ORDER BY cod_endereco DESC;
SELECT * FROM enderecos ORDER BY bairro;
SELECT * FROM enderecos ORDER BY cidade;
SELECT estado, COUNT(*) FROM enderecos GROUP BY estado;

-- ------------------------- PARTE B -------------------------
/*
EXERCÍCIO
- Criar um database
- Usar esse database
- Criar 2 tabelas
- Fazer Insert em cada uma das tabelas - pelo menos 10 registros em cada tabela
- Montar um select com: INNER JOIN, LEFT JOIN e RIGHT JOIN
- Montar ALGUNS selects com: ORDER BY, GROUP BY e COUNT (*)
*/
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autores
(
  id_autor int not null PRIMARY KEY,
  nome varchar(200) not null,
  pais varchar(100) not null
);
CREATE TABLE livros
(
  id_livro int not null PRIMARY KEY,
  titulo varchar(300) not null,
  genero varchar(100) not null,
  ano_publicacao int not null,
  preco decimal(20,2) not null,
  id_autor int null,
  FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

INSERT INTO autores (id_autor, nome, pais) VALUES
(1,  'Machado de Assis',      'Brasil'),
(2,  'Clarice Lispector',     'Brasil'),
(3,  'Jorge Amado',           'Brasil'),
(4,  'George Orwell',         'Reino Unido'),
(5,  'Gabriel Garcia Marquez','Colombia'),
(6,  'Jane Austen',           'Reino Unido'),
(7,  'Franz Kafka',           'Republica Tcheca'),
(8,  'Agatha Christie',       'Reino Unido'),
(9,  'Haruki Murakami',       'Japao'),
(10, 'Autor Sem Livros',      'Brasil');

INSERT INTO livros (id_livro, titulo, genero, ano_publicacao, preco, id_autor) VALUES
(1,  'Dom Casmurro',                 'Romance',  1899, 39.90, 1),
(2,  'Memorias Postumas de Bras Cubas','Romance',1881, 42.50, 1),
(3,  'A Hora da Estrela',            'Romance',  1977, 35.00, 2),
(4,  'Gabriela, Cravo e Canela',     'Romance',  1958, 54.90, 3),
(5,  '1984',                         'Distopia', 1949, 49.90, 4),
(6,  'A Revolucao dos Bichos',       'Fabula',   1945, 29.90, 4),
(7,  'Cem Anos de Solidao',          'Realismo Magico', 1967, 69.90, 5),
(8,  'Orgulho e Preconceito',        'Romance',  1813, 44.90, 6),
(9,  'A Metamorfose',                'Ficcao',   1915, 25.00, 7),
(10, 'Assassinato no Expresso do Oriente','Misterio',1934, 38.00, 8),
(11, 'Livro Sem Autor Cadastrado',   'Diversos', 2020, 19.90, NULL),
(12, 'Kafka a Beira-Mar',            'Ficcao',   2002, 59.90, 9);

SELECT * FROM autores;
SELECT * FROM livros;

-- INNER JOIN: somente livros que possuem autor
SELECT l.titulo, a.nome AS autor, a.pais
  FROM livros l INNER JOIN autores a ON l.id_autor = a.id_autor;
-- LEFT JOIN: todos os livros (inclusive sem autor)
SELECT l.titulo, a.nome AS autor
  FROM livros l LEFT JOIN autores a ON l.id_autor = a.id_autor;
-- RIGHT JOIN: todos os autores (inclusive sem livros)
SELECT a.nome AS autor, l.titulo
  FROM livros l RIGHT JOIN autores a ON l.id_autor = a.id_autor;

-- ORDER BY
SELECT * FROM livros ORDER BY preco DESC;
SELECT * FROM livros ORDER BY ano_publicacao;
SELECT * FROM autores ORDER BY pais, nome;
-- COUNT(*)
SELECT COUNT(*) AS total_livros FROM livros;
SELECT COUNT(*) AS total_autores FROM autores;
-- GROUP BY
SELECT genero, COUNT(*) AS qtd FROM livros GROUP BY genero;
SELECT pais, COUNT(*) AS qtd_autores FROM autores GROUP BY pais ORDER BY qtd_autores DESC;
SELECT a.nome, COUNT(l.id_livro) AS qtd_livros
  FROM autores a LEFT JOIN livros l ON a.id_autor = l.id_autor
 GROUP BY a.nome ORDER BY qtd_livros DESC;
