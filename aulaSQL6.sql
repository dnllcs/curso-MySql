-- Verificando se o banco de dados já existe, usando DROP caso sim e o criando novamente
DROP DATABASE IF EXISTS curso_sql_modulo1;
CREATE DATABASE curso_sql_modulo1;
USE curso_sql_modulo1;
-- ATIVIDADE A PARTIR DA LINHA 70
/*
Por padrão, @@lower_case_table_names é 1, oque significa que letras maiúsculas serão reconhecidas como minúsculas em relação 
ao nome das tabelas(@@lower_case_table_names sendo 0 no linux, o uso letras maiúsculas é reconhecido)
logo, não haverá diferença entre a execução dos seguintes comandos(no Windows)
SELECT * FROM ESTADO;
SELECT * FROM EstaDO;
SELECT * FROM Estado;
Isso também significa que não é passível o uso de camelCase, sendo usado snake_case
**/
CREATE TABLE pais (
id INT NOT NULL AUTO_INCREMENT 
,nome VARCHAR(255) NOT NULL
,capital VARCHAR(255) NOT NULL
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_pais PRIMARY KEY (id)
,CONSTRAINT pais_ativo_deve_ser_S_ou_N CHECK (ativo in ('S', 'N'))
);
-- Omitindo DEFAULT no INSERT
-- INSERT INTO pais (id, nome, capital, data_cadastro, ativo) VALUES (DEFAULT, 'BRASIL', 'BRASÍLIA', DEFAULT, DEFAULT);
INSERT INTO pais (nome, capital) VALUES ('BRASIL', 'BRASÍLIA');
-- também sendo possível fazer da seguinte maneira
INSERT INTO pais (nome, capital) VALUES ('ARGENTINA', 'BUENOS AIRES'), ('CHILE', 'SANTIAGO');

CREATE TABLE estado (
id INT NOT NULL AUTO_INCREMENT -- constraint in line
,nome VARCHAR(255) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,pais_id INT NOT NULL
,CONSTRAINT pk_estado PRIMARY KEY (id)
,CONSTRAINT fK_estado_pais FOREIGN KEY (pais_id) REFERENCES pais (id)
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N')) -- constraint out of line
);

INSERT INTO estado (nome, sigla, pais_id) VALUES ('PARANÁ', 'PR', 1);
INSERT INTO estado (nome, sigla, pais_id) VALUES ('SÂO PAULO', 'SP', 1);
INSERT INTO estado (nome, sigla, pais_id) VALUES ('SANTA CATARINA', 'SC', 1);
INSERT INTO estado (nome, sigla, pais_id) VALUES ('CÓRDOBA', 'CB', 2);
INSERT INTO estado (nome, sigla, pais_id) VALUES ('VALPARAÍSO', 'VS', 3);

SELECT * FROM estado;
SELECT * FROM pais;
CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo in ('S', 'N'))
,CONSTRAINT cidade_unica UNIQUE (nome, estado_id)
);

INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAÍ', 1);
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',3);
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAU', 3);
INSERT INTO cidade (nome, estado_id, data_cadastro) VALUES ('CURITIBA', 3, 2022-01-03);

SELECT * FROM cidade;
-- UPDATE
UPDATE cidade SET estado_id = 2 WHERE id = 4;
UPDATE cidade SET estado_id = 1, ativo = 'N' WHERE id = 4;
UPDATE cidade SET data_cadastro = CURRENT_TIMESTAMP WHERE id = 4;
UPDATE cidade SET ativo = 'S' WHERE estado_id = 1;

DELETE FROM cidade WHERE estado_id = 1;