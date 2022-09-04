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

INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAÍ', 1);
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',3);
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAU', 3);

SELECT * FROM cidade;
-- alterando uma tabela, adicionando a coluna "regiao" nela
ALTER TABLE estado ADD COLUMN regiao INT;
-- alterando o tipo da coluna adicionada
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(255);
/**não é possível adicionar a regra para o valor não ser nulo uma vez que já existem registros com valores de "regiao" nulo
ALTER TABLE estado MODIFY COLUMN region VARCHAR(255) NOT NULL;
Para adicionar a regra NOT NULL é possivel eliminar a coluna e recria-la da maneira correta, ou trocar os valores nulos de 
cada registro*/
ALTER TABLE estado DROP COLUMN regiao;
ALTER TABLE estado ADD COLUMN regiao VARCHAR(255) NOT NULL DEFAULT 'VALOR NÂO INFORMADO';
-- alterando a posição da coluna na tabela
ALTER TABLE estado DROP COLUMN regiao;
ALTER TABLE estado ADD COLUMN regiao VARCHAR(255) NOT NULL DEFAULT 'VALOR NÂO INFORMADO' AFTER id;
-- Mudando o nome da coluna
ALTER TABLE estado CHANGE regiao regiao_estado VARCHAR(255) NOT NULL;
DESCRIBE estado;
-- simplificando o constraint
ALTER TABLE estado DROP CONSTRAINT estado_ativo_deve_ser_S_ou_N;
ALTER TABLE estado MODIFY COLUMN ativo ENUM('S', 'N') NOT NULL;
-- verificando se a coluna ativo ENUM recusa valores errados
-- INSERT INTO estado (nome, sigla, ativo) VALUES ('RIO DE JANEIRO', 'RJ', 'E')
