-- ============================================================
-- EXERCÍCIO 6 - Stored Procedures (exemplos dos materiais)
-- ============================================================
DROP DATABASE IF EXISTS BD_Usuario;
CREATE DATABASE BD_Usuario;
USE BD_Usuario;

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario
(
  cpf varchar(100) not null PRIMARY KEY,
  nome varchar(300) not null,
  email varchar(100) not null,
  dt_cadastro datetime
);

-- ---------------- INSERT ----------------
DROP PROCEDURE IF EXISTS sp_InsereUsuario;
delimiter //
create procedure sp_InsereUsuario(v_CPF varchar(100), v_nome varchar(300), v_email varchar(50), v_dt_cadastro datetime)
begin
    if (v_cpf is not null and v_nome is not null and v_email is not null and v_dt_cadastro is not null) then
        begin
            insert into usuario (cpf,nome, email,dt_cadastro) values (v_CPF, v_nome, v_email, v_dt_cadastro);
            select 'Os registros foram inseridos com sucesso';
        end;
    else
        begin
            select 'Parametros inadequados';
        end;
    end if;
end
//
delimiter ;

CALL sp_InsereUsuario ('12345678901', 'Roger de Almeida JR', 'rogeralmeida@gmail.com', '2024-05-06 20:30:35');
SELECT * FROM usuario;

-- ---------------- SELECT ----------------
DROP PROCEDURE IF EXISTS sp_consultaUsuario;
delimiter //
create procedure sp_consultaUsuario(v_CPF varchar(100))
begin
    if (v_cpf is not null) then
        Select cpf, nome, email, dt_cadastro from usuario where cpf = v_cpf;
    else
        Select cpf, nome, email, dt_cadastro from usuario;
    end if;
end
//
delimiter ;

CALL sp_consultaUsuario ('12345678901');
CALL sp_consultaUsuario ('123456789012');

-- ---------------- DELETE ----------------
DROP PROCEDURE IF EXISTS sp_deleteUsuario;
delimiter //
create procedure sp_deleteUsuario(v_CPF varchar(100))
begin
    if (v_cpf is not null) then
        delete from usuario where cpf = v_cpf;
    else
        delete from usuario;
    end if;
end
//
delimiter ;

CALL sp_deleteUsuario ('12345678901');
CALL sp_deleteUsuario ('123456789012');
SELECT * FROM usuario;

-- ------------------- Tabela locais -------------------
DROP TABLE IF EXISTS locais;
CREATE TABLE locais
(
  id_locais int not null PRIMARY KEY,
  cidade varchar(300) not null,
  estado varchar(300) not null,
  regiao varchar(300) not null
);

DROP PROCEDURE IF EXISTS insere_locais;
delimiter //
create procedure insere_locais(i int, c varchar(300), e varchar(300), r varchar(300))
begin
  insert into locais (id_locais, cidade, estado, regiao)
  values (i, c, e, r);
  select * from locais;
end
//
delimiter ;

call insere_locais(1, 'Santos', 'SP', 'Sudeste');
call insere_locais(2, 'Sao Paulo', 'SP', 'Sudeste');

DROP PROCEDURE IF EXISTS exclui_locais;
delimiter //
create procedure exclui_locais(i int)
begin
  delete from locais
  where id_locais = i;
  select * from locais;
end
//
delimiter ;

call exclui_locais(1);
call exclui_locais(2);
