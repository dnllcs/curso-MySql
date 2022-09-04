-- Verificando se o banco de dados já existe, usando DROP caso sim e o criando novamente
DROP DATABASE IF EXISTS curso_sql_modulo1;
CREATE DATABASE curso_sql_modulo1;
USE curso_sql_modulo1;
-- ATIVIDADE A PARTIR DA LINHA 77
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

SELECT * FROM cidade;

/**
AGORA É A SUA VEZ!!!! Para que você aprenda, é muito importante que não copie e cole,  digite os comandos e mentalize o que está fazendo na medida que digita cada comando. Uma dica  importante é que você digite primeiro no bloco de notas, com intuito de testar se realmente  consegue digitar os comandos sem a ajuda do IDE – depois teste os comandos. 
5. Escreva o comando para inserir 3 registros da tabela estado com todas as colunas. 
6. Escreva o comando para inserir 2 registros da tabela estado, definindo todos os dados, exceto a chave  primária que é auto incremento. 
7. Escreva o comando para inserir 2 registros da tabela estado, definindo somente os dados necessários. 
8. Escreva o comando para inserir registros da tabela cidade das 3 formas apresentadas nos exercícios  anteriores.  
9. Faça a inserção de 2 registros de cliente.  
10. DESAFIO!!! Tente fazer todas as inserções necessárias para que se tenha um item de caixa. Na medida  que esteja digitando o código, tente associar os dados inseridos com o contexto real.
*/
-- 5.
INSERT INTO estado (id, nome, sigla, ativo, data_cadastro, pais_id) VALUES (6, 'MATO GROSSO', 'MT', 'S', DEFAULT, 1);
INSERT INTO estado (id, nome, sigla, ativo, data_cadastro, pais_id) VALUES (7, 'BAHIA', 'BA', 'S', DEFAULT, 1);
INSERT INTO estado (id, nome, sigla, ativo, data_cadastro, pais_id) VALUES (8, 'MINAS GERAIS', 'MG', 'S', DEFAULT, 1);
SELECT * FROM estado;
-- 6.
INSERT INTO estado (nome, sigla, ativo, data_cadastro, pais_id) VALUES ('BAHIA', 'BA', 'S', DEFAULT, 1);
INSERT INTO estado (nome, sigla, ativo, data_cadastro, pais_id) VALUES ('MINAS GERAIS', 'MG', 'S', DEFAULT, 1);
-- 7.
INSERT INTO estado (nome, sigla, ativo, data_cadastro, pais_id) VALUES ('BAHIA', 'BA', 1);
INSERT INTO estado (nome, sigla, ativo, data_cadastro, pais_id) VALUES ('MINAS GERAIS', 'MG', 1);
-- 8.
INSERT INTO cidade (id, nome, ativo, data_cadastro, estado_id) VALUES (4, 'BELO HORIZONTE', 'S', DEFAULT, 6);
INSERT INTO cidade (nome, ativo, data_cadastro, estado_id) VALUES ('UBERLANDIA', 'S', DEFAULT, 6);
INSERT INTO cidade (nome, estado_id) VALUES ('CONTAGEM', 6);