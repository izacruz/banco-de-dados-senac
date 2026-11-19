-- ============================================================
-- EXERCÍCIO 7 - Stored Procedures
--   A) CRUD: Select, Insert, Update, Delete
--   B) Calculadora
--   C) Média de 4 notas
-- ============================================================

-- ======================= A) CRUD =============================
DROP DATABASE IF EXISTS BD_Clientes;
CREATE DATABASE BD_Clientes;
USE BD_Clientes;

CREATE TABLE clientes
(
  id_cliente int not null PRIMARY KEY,
  nome varchar(200) not null,
  email varchar(150) not null,
  cidade varchar(100)
);

-- 1) INSERT
DROP PROCEDURE IF EXISTS sp_insere_cliente;
delimiter //
create procedure sp_insere_cliente(p_id int, p_nome varchar(200), p_email varchar(150), p_cidade varchar(100))
begin
    if (p_id is not null and p_nome is not null and p_email is not null) then
        insert into clientes (id_cliente, nome, email, cidade) values (p_id, p_nome, p_email, p_cidade);
        select 'Cliente inserido com sucesso' as mensagem;
    else
        select 'Parametros inadequados' as mensagem;
    end if;
end
//
delimiter ;

-- 2) SELECT (id nulo = lista todos)
DROP PROCEDURE IF EXISTS sp_consulta_cliente;
delimiter //
create procedure sp_consulta_cliente(p_id int)
begin
    if (p_id is not null) then
        select id_cliente, nome, email, cidade from clientes where id_cliente = p_id;
    else
        select id_cliente, nome, email, cidade from clientes;
    end if;
end
//
delimiter ;

-- 3) UPDATE
DROP PROCEDURE IF EXISTS sp_atualiza_cliente;
delimiter //
create procedure sp_atualiza_cliente(p_id int, p_nome varchar(200), p_email varchar(150), p_cidade varchar(100))
begin
    if (p_id is not null) then
        update clientes
           set nome = p_nome, email = p_email, cidade = p_cidade
         where id_cliente = p_id;
        if (row_count() > 0) then
            select 'Cliente atualizado com sucesso' as mensagem;
        else
            select 'Cliente nao encontrado' as mensagem;
        end if;
    else
        select 'Parametros inadequados' as mensagem;
    end if;
end
//
delimiter ;

-- 4) DELETE
DROP PROCEDURE IF EXISTS sp_deleta_cliente;
delimiter //
create procedure sp_deleta_cliente(p_id int)
begin
    if (p_id is not null) then
        delete from clientes where id_cliente = p_id;
        if (row_count() > 0) then
            select 'Cliente excluido com sucesso' as mensagem;
        else
            select 'Cliente nao encontrado' as mensagem;
        end if;
    else
        select 'Parametros inadequados' as mensagem;
    end if;
end
//
delimiter ;

-- ----------- Testes -----------
CALL sp_insere_cliente(1, 'Maria Silva',  'maria@email.com',  'Sao Paulo');
CALL sp_insere_cliente(2, 'Joao Santos',  'joao@email.com',   'Santos');
CALL sp_insere_cliente(3, 'Paula Costa',  'paula@email.com',  'Campinas');
CALL sp_insere_cliente(NULL, 'Sem Id',    'x@email.com',      'Nenhuma');   -- parametros inadequados
CALL sp_consulta_cliente(NULL);                                            -- todos
CALL sp_consulta_cliente(2);                                               -- um
CALL sp_atualiza_cliente(2, 'Joao Santos Filho', 'joao.novo@email.com', 'Guaruja');
CALL sp_atualiza_cliente(99, 'Inexistente', 'x@x.com', 'X');               -- nao encontrado
CALL sp_consulta_cliente(NULL);
CALL sp_deleta_cliente(3);
CALL sp_deleta_cliente(99);                                                -- nao encontrado
CALL sp_consulta_cliente(NULL);

-- ===================== B) CALCULADORA ========================
DROP DATABASE IF EXISTS BD_Calculadora;
CREATE DATABASE BD_Calculadora;
USE BD_Calculadora;

DROP PROCEDURE IF EXISTS sp_calculadora;
delimiter //
create procedure sp_calculadora(p_operacao varchar(1), p_numero1 decimal(20,4), p_numero2 decimal(20,4))
begin
    declare v_resultado decimal(30,4);

    if (p_operacao = '+') then
        set v_resultado = p_numero1 + p_numero2;
        select p_numero1 as numero1, p_operacao as operacao, p_numero2 as numero2, v_resultado as resultado;
    elseif (p_operacao = '-') then
        set v_resultado = p_numero1 - p_numero2;
        select p_numero1 as numero1, p_operacao as operacao, p_numero2 as numero2, v_resultado as resultado;
    elseif (p_operacao = '*') then
        set v_resultado = p_numero1 * p_numero2;
        select p_numero1 as numero1, p_operacao as operacao, p_numero2 as numero2, v_resultado as resultado;
    elseif (p_operacao = '/') then
        if (p_numero2 = 0) then
            select 'Erro: divisao por zero' as resultado;
        else
            set v_resultado = p_numero1 / p_numero2;
            select p_numero1 as numero1, p_operacao as operacao, p_numero2 as numero2, v_resultado as resultado;
        end if;
    else
        select 'Operacao invalida. Use + - * ou /' as resultado;
    end if;
end
//
delimiter ;

CALL sp_calculadora('+', 10, 5);
CALL sp_calculadora('-', 10, 5);
CALL sp_calculadora('*', 10, 5);
CALL sp_calculadora('/', 10, 4);
CALL sp_calculadora('/', 10, 0);   -- divisao por zero
CALL sp_calculadora('%', 10, 5);   -- operacao invalida

-- ================== C) MEDIA DE 4 NOTAS ======================
DROP DATABASE IF EXISTS BD_Alunos;
CREATE DATABASE BD_Alunos;
USE BD_Alunos;

DROP PROCEDURE IF EXISTS sp_media_alunos;
delimiter //
create procedure sp_media_alunos(p_nota1 decimal(4,2), p_nota2 decimal(4,2), p_nota3 decimal(4,2), p_nota4 decimal(4,2))
begin
    declare v_media decimal(4,2);

    if (p_nota1 is null or p_nota2 is null or p_nota3 is null or p_nota4 is null) then
        select 'Erro: informe as 4 notas' as resultado;
    elseif (p_nota1 not between 0 and 10 or p_nota2 not between 0 and 10
         or p_nota3 not between 0 and 10 or p_nota4 not between 0 and 10) then
        select 'Erro: as notas devem estar entre 0 e 10' as resultado;
    else
        set v_media = (p_nota1 + p_nota2 + p_nota3 + p_nota4) / 4;
        select p_nota1 as nota1, p_nota2 as nota2, p_nota3 as nota3, p_nota4 as nota4,
               v_media as media_final,
               case when v_media >= 6 then 'Aprovado' else 'Reprovado' end as situacao;
    end if;
end
//
delimiter ;

CALL sp_media_alunos(8, 7, 9, 10);
CALL sp_media_alunos(5, 4, 6, 3);
CALL sp_media_alunos(10, 10, 10, 11);   -- nota fora do range
CALL sp_media_alunos(8, NULL, 9, 10);   -- nota ausente
