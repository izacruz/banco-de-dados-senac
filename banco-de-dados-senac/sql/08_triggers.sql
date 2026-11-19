-- ============================================================
-- EXERCÍCIO 8 - Triggers
--   3 BEFORE (Insert, Update, Delete) e 3 AFTER (Insert, Update, Delete)
-- ============================================================
DROP DATABASE IF EXISTS BD_Triggers;
CREATE DATABASE BD_Triggers;
USE BD_Triggers;

DROP TABLE IF EXISTS log_auditoria;
DROP TABLE IF EXISTS produtos;

CREATE TABLE produtos
(
  id_produto int not null PRIMARY KEY,
  nome varchar(200) not null,
  preco decimal(20,2) not null default 0,
  estoque int not null default 0
);

CREATE TABLE log_auditoria
(
  id_log int not null AUTO_INCREMENT PRIMARY KEY,
  tabela varchar(100) not null,
  operacao varchar(20) not null,
  id_registro int,
  descricao varchar(500),
  data_hora datetime not null default current_timestamp
);

-- ===================== BEFORE ================================

-- 1) BEFORE INSERT: padroniza o nome em maiúsculas e corrige valores negativos
DROP TRIGGER IF EXISTS trg_before_insert_produtos;
delimiter //
create trigger trg_before_insert_produtos
before insert on produtos
for each row
begin
    set NEW.nome = UPPER(NEW.nome);
    if (NEW.preco < 0) then
        set NEW.preco = 0;
    end if;
    if (NEW.estoque < 0) then
        set NEW.estoque = 0;
    end if;
end
//
delimiter ;

-- 2) BEFORE UPDATE: impede preço negativo
DROP TRIGGER IF EXISTS trg_before_update_produtos;
delimiter //
create trigger trg_before_update_produtos
before update on produtos
for each row
begin
    if (NEW.preco < 0) then
        signal sqlstate '45000'
        set message_text = 'Erro: o preco nao pode ser negativo';
    end if;
end
//
delimiter ;

-- 3) BEFORE DELETE: impede exclusão de produto que ainda tem estoque
DROP TRIGGER IF EXISTS trg_before_delete_produtos;
delimiter //
create trigger trg_before_delete_produtos
before delete on produtos
for each row
begin
    if (OLD.estoque > 0) then
        signal sqlstate '45000'
        set message_text = 'Erro: nao e possivel excluir produto com estoque';
    end if;
end
//
delimiter ;

-- ===================== AFTER =================================

-- 4) AFTER INSERT: registra a inclusão no log
DROP TRIGGER IF EXISTS trg_after_insert_produtos;
delimiter //
create trigger trg_after_insert_produtos
after insert on produtos
for each row
begin
    insert into log_auditoria (tabela, operacao, id_registro, descricao)
    values ('produtos', 'INSERT', NEW.id_produto,
            concat('Produto inserido: ', NEW.nome, ' | preco: ', NEW.preco, ' | estoque: ', NEW.estoque));
end
//
delimiter ;

-- 5) AFTER UPDATE: registra valores antigos e novos
DROP TRIGGER IF EXISTS trg_after_update_produtos;
delimiter //
create trigger trg_after_update_produtos
after update on produtos
for each row
begin
    insert into log_auditoria (tabela, operacao, id_registro, descricao)
    values ('produtos', 'UPDATE', NEW.id_produto,
            concat('Preco: ', OLD.preco, ' -> ', NEW.preco, ' | Estoque: ', OLD.estoque, ' -> ', NEW.estoque));
end
//
delimiter ;

-- 6) AFTER DELETE: registra a exclusão
DROP TRIGGER IF EXISTS trg_after_delete_produtos;
delimiter //
create trigger trg_after_delete_produtos
after delete on produtos
for each row
begin
    insert into log_auditoria (tabela, operacao, id_registro, descricao)
    values ('produtos', 'DELETE', OLD.id_produto, concat('Produto excluido: ', OLD.nome));
end
//
delimiter ;

-- ===================== TESTES ================================
SHOW TRIGGERS;

-- Teste BEFORE INSERT / AFTER INSERT (nome vira maiúsculo; preço negativo vira 0)
INSERT INTO produtos (id_produto, nome, preco, estoque) VALUES (1, 'caneta azul', 2.50, 100);
INSERT INTO produtos (id_produto, nome, preco, estoque) VALUES (2, 'caderno',    18.90, 50);
INSERT INTO produtos (id_produto, nome, preco, estoque) VALUES (3, 'borracha',   -1.00, 0);
SELECT * FROM produtos;
SELECT * FROM log_auditoria;

-- Teste BEFORE UPDATE / AFTER UPDATE
UPDATE produtos SET preco = 3.00, estoque = 90 WHERE id_produto = 1;
SELECT * FROM produtos;
-- Esta instrução DEVE gerar erro (preço negativo bloqueado):
-- UPDATE produtos SET preco = -5 WHERE id_produto = 1;

-- Teste BEFORE DELETE / AFTER DELETE
-- Esta instrução DEVE gerar erro (produto 2 tem estoque):
-- DELETE FROM produtos WHERE id_produto = 2;
-- Esta funciona (produto 3 tem estoque 0):
DELETE FROM produtos WHERE id_produto = 3;
SELECT * FROM produtos;

-- Resultado final da auditoria
SELECT * FROM log_auditoria ORDER BY id_log;
