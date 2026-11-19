-- ============================================================
-- EXERCÍCIO 4 - Functions (funções criadas pelo usuário)
-- Parte A: calculaFaturamento (exemplo) | Parte B: aumento de salário
-- ============================================================

-- ------------------------- PARTE A -------------------------
DROP DATABASE IF EXISTS BD_Pedidos;
CREATE DATABASE BD_Pedidos;
USE BD_Pedidos;

# Criar a Tabela de Pedidos
DROP TABLE IF EXISTS Pedidos;
CREATE TABLE Pedidos
(
  id_pedido int not null PRIMARY KEY,
  data_venda datetime not null,
  qtd_vendida decimal (20,2) not null default '0',
  preco_unit decimal (20,2) not null default '0'
);

INSERT INTO Pedidos
(id_pedido, data_venda, qtd_vendida, preco_unit)
VALUES
(1, '2024-05-06 20:30:35', '10', '8.50'),
(2, '2025-08-18 20:30:35', '100', '10.50'),
(3, '2022-05-20 20:30:35', '1', '234.80'),
(4, '2021-06-30 20:30:35', '5', '453.60'),
(5, '2020-01-02 20:30:35', '50', '234.50'),
(6, '2022-05-25 20:30:35', '1000', '45.90'),
(7, '2023-05-01 20:30:35', '345', '567.70'),
(8, '2024-05-28 20:30:35', '456', '234.00');

select * from pedidos;

# Criacao da funcao (faturamento = preço x quantidade)
DROP FUNCTION IF EXISTS calculaFaturamento;
delimiter //
CREATE FUNCTION calculaFaturamento(preco decimal(20,2), quantidade decimal(20,2))
RETURNS decimal(20,2)
DETERMINISTIC
BEGIN
    RETURN preco * quantidade;
END
//
delimiter ;

select calculaFaturamento(100, 10);
select calculaFaturamento(200, 10);

Select id_pedido, data_venda, qtd_vendida,
preco_unit,
calculaFaturamento(preco_unit, qtd_vendida)
as faturamento_venda
from pedidos;

-- ------------------------- PARTE B -------------------------
/*
EXERCICIO
- Criar um database de funcionarios
- Criar uma tabela de funcionarios
- Usar a tabela de funcionarios
- Inserir pelo menos 10 registros
- Criar uma funcao para calcular o aumento dos salários dos funcionários no mês
- Esta funcao devera ter 2 parâmetros de entrada: salario_func e percentual_de_aumento
- Esta funcao devera calcular: salario_func * percentual_de_aumento
- Executar a funcao passando os 2 parâmetros
- Exibir os resultados
- montar um select chamando a funcao com os devidos parametros
*/
DROP DATABASE IF EXISTS BD_Funcionarios;
CREATE DATABASE BD_Funcionarios;
USE BD_Funcionarios;

DROP TABLE IF EXISTS funcionarios;
CREATE TABLE funcionarios
(
  id_funcionario int not null PRIMARY KEY,
  nome varchar(200) not null,
  cargo varchar(100) not null,
  salario_func decimal(20,2) not null,
  data_admissao date not null
);

INSERT INTO funcionarios (id_funcionario, nome, cargo, salario_func, data_admissao) VALUES
(1,  'Ana Paula',       'Analista',      5500.00, '2021-03-01'),
(2,  'Bruno Cardoso',   'Desenvolvedor', 7200.00, '2020-07-15'),
(3,  'Camila Ferreira', 'Gerente',      12000.00, '2018-01-10'),
(4,  'Diego Martins',   'Estagiario',    1800.00, '2025-02-03'),
(5,  'Elaine Ribeiro',  'Analista',      5800.00, '2022-09-12'),
(6,  'Fabio Oliveira',  'Designer',      4800.00, '2023-04-20'),
(7,  'Giovana Lima',    'Desenvolvedor', 7600.00, '2019-11-05'),
(8,  'Henrique Souza',  'Suporte',       3200.00, '2024-01-08'),
(9,  'Iara Campos',     'RH',            4500.00, '2021-06-30'),
(10, 'Julio Pereira',   'Financeiro',    6100.00, '2020-10-19');

SELECT * FROM funcionarios;

# percentual_de_aumento informado em pontos percentuais (10 = 10%)
DROP FUNCTION IF EXISTS calculaAumento;
delimiter //
CREATE FUNCTION calculaAumento(salario_func decimal(20,2), percentual_de_aumento decimal(10,2))
RETURNS decimal(20,2)
DETERMINISTIC
BEGIN
    RETURN salario_func * (percentual_de_aumento / 100);
END
//
delimiter ;

# Executando a função passando os 2 parâmetros
SELECT calculaAumento(5000, 10) AS aumento_de_10_porcento;
SELECT calculaAumento(3200, 5)  AS aumento_de_5_porcento;

# Select chamando a função para cada funcionário (aumento de 8%)
SELECT id_funcionario, nome, salario_func,
       calculaAumento(salario_func, 8) AS valor_do_aumento,
       salario_func + calculaAumento(salario_func, 8) AS novo_salario
  FROM funcionarios;
