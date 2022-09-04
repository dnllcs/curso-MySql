/*
AGORA É A SUA VEZ!!!! Para que você aprenda, é muito importante que não copie e cole, digite os comandos e mentalize o que está fazendo na medida que digita cada comando. Uma dica importante é que você digite primeiro no bloco de notas, com intuito de testar se realmente consegue digitar os comandos sem a ajuda do IDE – depois teste os comandos.
9.	Escreva o comando para alterar o valor de uma coluna de um único registro de uma tabela utilizando como filtro, o Primary Key.
10.	Refaça o exercício anterior alterando os dados de mais que uma coluna de um único registro sem utilizar como filtro a chave primária. A escolha da coluna do filtro é muito importante – TOME CUIDADO.
11.	Alter o valor de uma coluna de todos os registros.
12.	Exclua um único registro de uma tabela sem utilizar como filtro, a chave primária.
13.	Escreva todos os comandos necessários para excluir o cliente com o id “38”.
**/
DROP DATABASE IF EXISTS curso_sql_modulo1;
CREATE DATABASE curso_sql_modulo1;
USE curso_sql_modulo1;

CREATE TABLE estado (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY -- constraint in line
,nome VARCHAR(255) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N')) -- constraint out of line
);

INSERT INTO estado (nome, sigla) VALUES ('PARANÁ', 'PR');
INSERT INTO estado (nome, sigla) VALUES ('SÂO PAULO', 'SP');
INSERT INTO estado (nome, sigla) VALUES ('SANTA CATARINA', 'SC');

SELECT * FROM estado;

CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
,nome VARCHAR(255) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo in ('S', 'N'))
,CONSTRAINT cidade_unica UNIQUE (nome, estado_id)
);

INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAi', 1);
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',3);
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAU', 3);

-- 9.
UPDATE cidade SET nome = 'PARANAVAÍ' WHERE id = 1;

-- 10.
UPDATE cidade SET
nome = 'CASCAVEL'
, ativo = 'N'
WHERE nome = 'PARANAVAÍ';

-- 11.
UPDATE cidade SET ativo = 'S';

-- 12.
DELETE FROM cidade WHERE nome = 'CASCAVEL';

-- 13. Eliminando primeiramente a cidade relacionada com o estado antes de excluilo
DELETE FROM cidade WHERE cidade_id = 23;
DELETE FROM estado WHERE id = 1;
