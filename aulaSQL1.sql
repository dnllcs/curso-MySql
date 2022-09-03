-- Verificando se o banco de dados já existe, usando DROP caso sim e o criando novamente
DROP DATABASE IF EXISTS curso_sql_modulo1;
CREATE DATABASE curso_sql_modulo1;
USE curso_sql_modulo1;
-- Verificando se a tabela já existe, usando DROP caso sim e a criando novamente
DROP TABLE IF EXISTS estado;

CREATE TABLE estado (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY -- constraint in line
,nome VARCHAR(255) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N')) -- constraint out of line
);


-- INSERT INTO estado (id, nome, sigla, ativo, data_cadastro) VALUES (1, 'PARANÁ', 'PR', 'S', '2022-09-03');
-- Utilizando DEFAULT e AUTO_INCREMENT é possível padronizar a inserção de dados de certas colunas
INSERT INTO estado (nome, sigla) VALUES ('PARANÁ', 'PR');
INSERT INTO estado (nome, sigla) VALUES ('SÂO PAULO', 'SP');
INSERT INTO estado (nome, sigla) VALUES ('SANTA CATARINA', 'SC');

SELECT * FROM estado;


