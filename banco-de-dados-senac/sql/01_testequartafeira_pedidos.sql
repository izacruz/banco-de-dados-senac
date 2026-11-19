-- ============================================================
-- EXERCÍCIO 1 - Tabela de pedidos + todas as combinações de SELECT
-- ============================================================
DROP DATABASE IF EXISTS testequartafeira;
CREATE DATABASE testequartafeira;
USE testequartafeira;

# Criação de Tabela - Primeiro lado 1 da cardinalidade
# Só tenho chaves primárias
DROP TABLE IF EXISTS pedidos;
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

# Primeiro lado 1 da minha cardinalidade
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

SELECT * FROM enderecos;

# Lado N da cardinalidade: um endereço pode ter vários pedidos
CREATE TABLE pedidos
(
  cod_pedido int not null PRIMARY KEY,
  cliente varchar(200) not null,
  cod_endereco int null,
  produto varchar(200) not null,
  categoria varchar(100) not null,
  quantidade int not null default 1,
  valor_unitario decimal(20,2) not null default 0,
  data_pedido datetime not null,
  status_pedido enum ('Aberto','Pago','Enviado','Entregue','Cancelado') not null,
  forma_pagamento varchar(50) null,
  FOREIGN KEY (cod_endereco) REFERENCES enderecos(cod_endereco)
);

INSERT INTO pedidos
(cod_pedido, cliente, cod_endereco, produto, categoria, quantidade, valor_unitario, data_pedido, status_pedido, forma_pagamento)
VALUES
(1,  'Ana Souza',       1,    'Notebook',            'Informatica', 1, 3500.00, '2026-01-05 10:15:00', 'Entregue',  'Cartao'),
(2,  'Bruno Lima',      2,    'Mouse',               'Informatica', 2,   45.90, '2026-01-12 14:20:00', 'Entregue',  'Pix'),
(3,  'Carla Dias',      3,    'Teclado',             'Informatica', 1,  120.00, '2026-01-20 09:00:00', 'Entregue',  'Boleto'),
(4,  'Daniel Rocha',    4,    'Monitor',             'Informatica', 2,  890.00, '2026-02-02 16:45:00', 'Enviado',   'Cartao'),
(5,  'Eduarda Melo',    5,    'Cadeira Gamer',       'Moveis',      1, 1250.00, '2026-02-10 11:30:00', 'Pago',      'Pix'),
(6,  'Felipe Nunes',    6,    'Mesa de Escritorio',  'Moveis',      1,  780.00, '2026-02-15 13:10:00', 'Entregue',  'Cartao'),
(7,  'Gabriela Pires',  7,    'Headset',             'Informatica', 3,  199.90, '2026-02-28 18:00:00', 'Cancelado', 'Cartao'),
(8,  'Hugo Alves',      8,    'Smartphone',          'Celulares',   1, 2800.00, '2026-03-03 08:40:00', 'Entregue',  'Pix'),
(9,  'Isabela Costa',   9,    'Capa para Celular',   'Celulares',   5,   29.90, '2026-03-08 12:00:00', 'Entregue',  'Pix'),
(10, 'Joao Mendes',     10,   'Carregador',          'Celulares',   4,   59.90, '2026-03-14 15:25:00', 'Enviado',   'Boleto'),
(11, 'Karina Teixeira', 1,    'Webcam',              'Informatica', 1,  250.00, '2026-03-21 10:05:00', 'Pago',      'Cartao'),
(12, 'Leonardo Faria',  2,    'Impressora',          'Informatica', 1,  650.00, '2026-04-01 17:30:00', 'Aberto',    NULL),
(13, 'Mariana Lopes',   3,    'Estante',             'Moveis',      2,  340.00, '2026-04-09 09:50:00', 'Entregue',  'Boleto'),
(14, 'Nelson Prado',    NULL, 'Tablet',              'Celulares',   1, 1900.00, '2026-04-18 14:00:00', 'Aberto',    NULL),
(15, 'Olivia Santos',   4,    'Fone Bluetooth',      'Celulares',   2,  149.90, '2026-05-02 19:15:00', 'Entregue',  'Pix'),
(16, 'Paulo Ribeiro',   5,    'SSD 1TB',             'Informatica', 2,  480.00, '2026-05-11 11:11:00', 'Pago',      'Cartao'),
(17, 'Quiteria Barros', NULL, 'Luminaria de Mesa',   'Moveis',      3,   89.90, '2026-05-20 16:20:00', 'Cancelado', 'Boleto'),
(18, 'Rafael Gomes',    6,    'Roteador',            'Informatica', 1,  320.00, '2026-06-04 08:30:00', 'Entregue',  'Pix'),
(19, 'Sabrina Moura',   7,    'Smartwatch',          'Celulares',   1,  720.00, '2026-06-15 13:45:00', 'Enviado',   'Cartao'),
(20, 'Thiago Araujo',   8,    'Gaveteiro',           'Moveis',      1,  410.00, '2026-07-01 10:00:00', 'Aberto',    NULL),
(21, 'Ana Souza',       1,    'Pen Drive',           'Informatica', 5,   39.90, '2026-07-10 15:00:00', 'Entregue',  'Pix'),
(22, 'Bruno Lima',      2,    'Hub USB',             'Informatica', 2,   79.90, '2026-07-22 09:30:00', 'Pago',      'Cartao');

-- ------------------------------------------------------------
-- 1) SELECT básico
-- ------------------------------------------------------------
SELECT * FROM pedidos;
SELECT cliente, produto, valor_unitario FROM pedidos;
SELECT cliente AS nome_cliente, produto AS item FROM pedidos;       -- alias
SELECT DISTINCT categoria FROM pedidos;                              -- sem repetição
SELECT DISTINCT status_pedido, forma_pagamento FROM pedidos;
SELECT cod_pedido, quantidade * valor_unitario AS valor_total FROM pedidos;  -- coluna calculada

-- ------------------------------------------------------------
-- 2) WHERE e operadores
-- ------------------------------------------------------------
SELECT * FROM pedidos WHERE categoria = 'Moveis';
SELECT * FROM pedidos WHERE categoria <> 'Informatica';
SELECT * FROM pedidos WHERE valor_unitario > 1000;
SELECT * FROM pedidos WHERE valor_unitario <= 100;
SELECT * FROM pedidos WHERE categoria = 'Informatica' AND status_pedido = 'Entregue';
SELECT * FROM pedidos WHERE status_pedido = 'Aberto' OR status_pedido = 'Pago';
SELECT * FROM pedidos WHERE NOT status_pedido = 'Cancelado';
SELECT * FROM pedidos WHERE status_pedido IN ('Aberto', 'Enviado');
SELECT * FROM pedidos WHERE status_pedido NOT IN ('Cancelado', 'Entregue');
SELECT * FROM pedidos WHERE valor_unitario BETWEEN 100 AND 500;
SELECT * FROM pedidos WHERE data_pedido BETWEEN '2026-03-01' AND '2026-05-31';
SELECT * FROM pedidos WHERE cliente LIKE 'A%';
SELECT * FROM pedidos WHERE cliente LIKE '%Souza';
SELECT * FROM pedidos WHERE produto LIKE '%o%';
SELECT * FROM pedidos WHERE produto LIKE '_ouse';
SELECT * FROM pedidos WHERE forma_pagamento IS NULL;
SELECT * FROM pedidos WHERE cod_endereco IS NOT NULL;
SELECT * FROM pedidos WHERE (categoria = 'Celulares' OR categoria = 'Moveis') AND valor_unitario > 500;

-- ------------------------------------------------------------
-- 3) ORDER BY e LIMIT
-- ------------------------------------------------------------
SELECT * FROM pedidos ORDER BY valor_unitario;
SELECT * FROM pedidos ORDER BY valor_unitario DESC;
SELECT * FROM pedidos ORDER BY categoria, valor_unitario DESC;
SELECT * FROM pedidos ORDER BY data_pedido DESC LIMIT 5;
SELECT * FROM pedidos ORDER BY cod_pedido LIMIT 5 OFFSET 5;
SELECT produto, valor_unitario FROM pedidos ORDER BY valor_unitario DESC LIMIT 3;

-- ------------------------------------------------------------
-- 4) Funções agregadas
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_pedidos FROM pedidos;
SELECT COUNT(forma_pagamento) AS com_pagamento_definido FROM pedidos;  -- ignora NULL
SELECT COUNT(DISTINCT cliente) AS clientes_distintos FROM pedidos;
SELECT SUM(quantidade * valor_unitario) AS faturamento_total FROM pedidos;
SELECT AVG(valor_unitario) AS media_preco FROM pedidos;
SELECT MAX(valor_unitario) AS maior, MIN(valor_unitario) AS menor FROM pedidos;
SELECT ROUND(AVG(valor_unitario), 2) AS media_arredondada FROM pedidos;

-- ------------------------------------------------------------
-- 5) GROUP BY e HAVING
-- ------------------------------------------------------------
SELECT categoria, COUNT(*) AS qtd_pedidos FROM pedidos GROUP BY categoria;
SELECT status_pedido, COUNT(*) AS qtd FROM pedidos GROUP BY status_pedido;
SELECT categoria, SUM(quantidade * valor_unitario) AS faturamento
  FROM pedidos GROUP BY categoria;
SELECT forma_pagamento, COUNT(*) AS qtd, AVG(valor_unitario) AS media
  FROM pedidos GROUP BY forma_pagamento;
SELECT categoria, MAX(valor_unitario) AS maximo, MIN(valor_unitario) AS minimo
  FROM pedidos GROUP BY categoria;
SELECT categoria, COUNT(*) AS qtd FROM pedidos
  GROUP BY categoria HAVING COUNT(*) > 6;
SELECT cliente, SUM(quantidade * valor_unitario) AS total_cliente
  FROM pedidos GROUP BY cliente HAVING total_cliente > 1000 ORDER BY total_cliente DESC;
SELECT categoria, status_pedido, COUNT(*) AS qtd
  FROM pedidos WHERE status_pedido <> 'Cancelado'
  GROUP BY categoria, status_pedido ORDER BY categoria;

-- ------------------------------------------------------------
-- 6) Funções de data, texto e condicionais
-- ------------------------------------------------------------
SELECT cod_pedido, YEAR(data_pedido) AS ano, MONTH(data_pedido) AS mes FROM pedidos;
SELECT MONTH(data_pedido) AS mes, COUNT(*) AS qtd FROM pedidos GROUP BY MONTH(data_pedido) ORDER BY mes;
SELECT cod_pedido, DATE_FORMAT(data_pedido, '%d/%m/%Y') AS data_br FROM pedidos;
SELECT UPPER(cliente) AS cliente_maiusculo, LENGTH(cliente) AS tamanho FROM pedidos;
SELECT CONCAT(cliente, ' - ', produto) AS descricao FROM pedidos;
SELECT cod_pedido, IFNULL(forma_pagamento, 'Não informado') AS pagamento FROM pedidos;
SELECT cod_pedido, COALESCE(forma_pagamento, 'Pendente') AS pagamento FROM pedidos;
SELECT cod_pedido, produto, valor_unitario,
  CASE
    WHEN valor_unitario >= 1000 THEN 'Alto valor'
    WHEN valor_unitario >= 200  THEN 'Médio valor'
    ELSE 'Baixo valor'
  END AS faixa_preco
FROM pedidos;

-- ------------------------------------------------------------
-- 6.1) UNION
-- ------------------------------------------------------------
SELECT cliente AS nome FROM pedidos WHERE categoria = 'Moveis'
UNION
SELECT cliente FROM pedidos WHERE categoria = 'Celulares';

-- ------------------------------------------------------------
-- 7) Subselects
-- ------------------------------------------------------------
SELECT * FROM pedidos WHERE valor_unitario > (SELECT AVG(valor_unitario) FROM pedidos);
SELECT * FROM pedidos WHERE valor_unitario = (SELECT MAX(valor_unitario) FROM pedidos);
SELECT * FROM pedidos WHERE cliente IN (SELECT cliente FROM pedidos WHERE status_pedido = 'Cancelado');
SELECT * FROM pedidos p
 WHERE EXISTS (SELECT 1 FROM enderecos e WHERE e.cod_endereco = p.cod_endereco AND e.estado = 'SP');

-- ------------------------------------------------------------
-- 8) JOINs com a tabela de endereços
-- ------------------------------------------------------------
SELECT * FROM pedidos p, enderecos e WHERE p.cod_endereco = e.cod_endereco;
SELECT p.cod_pedido, p.cliente, p.produto, e.logradouro, e.bairro, e.estado
  FROM pedidos p INNER JOIN enderecos e ON p.cod_endereco = e.cod_endereco;
SELECT p.cod_pedido, p.cliente, e.bairro, e.estado
  FROM pedidos p LEFT JOIN enderecos e ON p.cod_endereco = e.cod_endereco;
SELECT p.cod_pedido, p.cliente, e.cod_endereco, e.bairro
  FROM pedidos p RIGHT JOIN enderecos e ON p.cod_endereco = e.cod_endereco;
-- Pedidos SEM endereço (LEFT JOIN + IS NULL)
SELECT p.* FROM pedidos p LEFT JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 WHERE e.cod_endereco IS NULL;
-- Endereços SEM pedidos (RIGHT JOIN + IS NULL)
SELECT e.* FROM pedidos p RIGHT JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 WHERE p.cod_pedido IS NULL;
-- JOIN + GROUP BY + ORDER BY
SELECT e.estado, COUNT(*) AS qtd_pedidos, SUM(p.quantidade * p.valor_unitario) AS faturamento
  FROM pedidos p INNER JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 GROUP BY e.estado ORDER BY faturamento DESC;
SELECT e.bairro, COUNT(*) AS qtd FROM pedidos p
  INNER JOIN enderecos e ON p.cod_endereco = e.cod_endereco
 GROUP BY e.bairro HAVING COUNT(*) >= 2 ORDER BY qtd DESC;
