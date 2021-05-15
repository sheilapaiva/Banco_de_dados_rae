--Roteiro 2

-- Questão 1: 
CREATE TABLE tarefas(
	id_tarefa INTEGER,
	descricao_tarefa VARCHAR(50),
	cpf_funcionario CHAR(11),
	prioridade_tarefa INTEGER,
	status_tarefa CHAR(1)
);

-- As inserções abaixo devem ser executadas com sucessso
INSERT INTO tarefas VALUES (2147483646, 'limpar chão do corredor central', 
'98765432111', 0, 'F');

INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', 
'98765432122', 1, 'F');

INSERT INTO tarefas VALUES (null, null, null, null, null);

-- As inserções abaixo não devem ter a execução autorizada
-- ERROR:  value too long for type character(11)
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', 
'987654323211', 0, 'F');

INSERT INTO tarefas VALUES (2147483643, 'limpar chão do corredor superior', 
'98765432321', 0, 'FF');

-- Questão 2:
-- ERROR:  integer out of range
ALTER TABLE tarefas ALTER COLUMN id_tarefa type bigint;

INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', 
'32323232955', 4, 'A');

-- Questão 3:

ALTER TABLE tarefas ALTER COLUMN prioridade_tarefa type smallint;

-- As inserções abaixo não devem ter a execução autorizada
--ERROR:  smallint out of range
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', 
'32322525199', 32768, 'A');

INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', 
'32333233288', 32769, 'A');

-- As inserções abaixo devem ser executadas com sucessso

INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar', 
'32323232911', 32767, 'A');

INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', 
'32323232911', 32766, 'A');

-- Questão 4:
DELETE from tarefas WHERE id_tarefa ISNULL;

ALTER TABLE tarefas RENAME COLUMN id_tarefa to id;

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN descricao_tarefa TO descricao;

ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN cpf_funcionario TO func_resp_cpf;

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN prioridade_tarefa TO prioridade;

ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN status_tarefa TO status;

ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Questão 5:
ALTER TABLE tarefas ADD PRIMARY KEY (id);

-- A inserção abaixo deve ser executada com sucessso
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', 
'32323232911', 2, 'A');

-- A inserção abaixo não deve ter a execução autorizada
-- ERROR:  duplicate key value violates unique constraint "tarefas_pkey"
-- DETAIL:  Key (id)=(2147483653) already exists.
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', 
'32323232911', 3, 'A');

-- Questão 6.A:
ALTER TABLE tarefas ADD CONSTRAINT cpf_constraint CHECK(CHARACTER_LENGTH(func_resp_cpf) = 11);

-- As inserções abaixo não devem ser executadas com sucessso
-- ERROR:  new row for relation "tarefas" violates check constraint "cpf_constraint"
INSERT INTO tarefas VALUES (2147483654, 'limpar o banheiro do 1o andar', 
'3232323291', 4, 'A');

-- ERROR:  value too long for type character(11)
INSERT INTO tarefas VALUES (2147483655, 'limpar o banheiro do 2o andar', 
'323232329111', 4, 'A');

-- Questão 6.B:

UPDATE tarefas SET status = 'P' WHERE status = 'A';

UPDATE tarefas SET status = 'E' WHERE status = 'R';

UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT ck_status CHECK(status = 'P' OR status = 'E'  OR status = 'C');

-- Questão 7:
UPDATE tarefas SET prioridade = 5 WHERE (prioridade != 0 or prioridade != 1 or prioridade != 2 or prioridade != 3 or prioridade != 4 or prioridade != 5);

ALTER TABLE tarefas ADD CONSTRAINT ck_prioridade CHECK(prioridade = 0 or prioridade = 1 or prioridade = 2 or prioridade = 3 or prioridade = 4 or prioridade = 5);

-- Questão 8:

CREATE TABLE funcionario(
	cpf CHAR(11) PRIMARY KEY,
	data_nasc DATE NOT NULL,
	nome VARCHAR(50) NOT NULL,
	funcao VARCHAR(11),
	nivel CHAR(1) NOT NULL,
	superior_cpf CHAR(11) REFERENCES funcionario(cpf),
	CONSTRAINT ck_nivel CHECK(nivel = 'J' OR nivel = 'P' or nivel = 'S'),
	CONSTRAINT ck_funcao CHECK((funcao = 'LIMPEZA' AND (superior_cpf <> '' AND superior_cpf IS NOT NULL)) OR funcao = 'SUP_LIMPEZA')	
);

-- As inserções abaixo devem ser executadas com sucessso
INSERT INTO funcionario VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- As inserções abaixo não devem ter a execução autorizada
-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678913, 1980-04-09, joao da Silva, LIMPEZA, J, null).

INSERT INTO funcionario VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', NULL);

-- Questão 9:

-- As inserções abaixo devem ser executadas com sucessso

INSERT INTO funcionario VALUES ('12345678914', '1978-05-27', 'Maria da Silva', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario VALUES ('12345678915', '1979-03-09', 'Carla Medeiros', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario VALUES ('12345678916', '1980-10-17', 'Antonio Oliveira', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario VALUES ('12345678917', '1983-09-20', 'Carmen da Silva', 'LIMPEZA', 'J', '12345678914');

INSERT INTO funcionario VALUES ('12345678918', '1989-11-23', 'Gabriel Araujo', 'LIMPEZA', 'P', '12345678914');

INSERT INTO funcionario VALUES ('12345678919', '1987-08-21', 'Joao de Paula', 'LIMPEZA', 'J', '12345678915');

INSERT INTO funcionario VALUES ('12345678920', '1988-10-23', 'Gabriela Coelho', 'LIMPEZA', 'P', '12345678915');

INSERT INTO funcionario VALUES ('12345678921', '1973-12-21', 'Fatima Souza', 'LIMPEZA', 'P', '12345678916');

INSERT INTO funcionario VALUES ('12345678922', '1986-06-24', 'Claudio Medeiros', 'LIMPEZA', 'P', '12345678916');

INSERT INTO funcionario VALUES ('12345678923', '1990-09-27', 'Marcos Silva', 'LIMPEZA', 'P', '12345678916');

-- As inserções abaixo não devem ter a execução autorizada
-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678923, 1984-05-10, Ana da Silva, LIMPEZA, J, null).
INSERT INTO funcionario VALUES ('12345678923', '1984-05-10', 'Ana da Silva', 'LIMPEZA', 'J', NULL);

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_nivel"
-- DETAIL:  Failing row contains (12345678924, 1985-07-12, Ana Paula da Silva, LIMPEZA, B, 12345678914).
INSERT INTO funcionario VALUES ('12345678924', '1985-07-12', 'Ana Paula da Silva', 'LIMPEZA', 'B', '12345678914');

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678925, 1977-12-13, Fabio Costa, LIMPEZA, H, null).
INSERT INTO funcionario VALUES ('12345678925', '1977-12-13', 'Fabio Costa', 'LIMPEZA', 'H', NULL);

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678926, 1990-06-01, Fabiola Batista, SUP-LIMPEZA, B, 12345678914).
INSERT INTO funcionario VALUES ('12345678926', '1990-06-01', 'Fabiola Batista', 'SUP-LIMPEZA', 'B', '12345678914');

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678927, 1980-06-17, Ana dos Santos, LIMPEZA, A, null).
INSERT INTO funcionario VALUES ('12345678927', '1980-06-17', 'Ana dos Santos', 'LIMPEZA', 'A', NULL);

--ERROR:  value too long for type character(1)
INSERT INTO funcionario VALUES ('12345678928', '1986-08-12', 'Sofia Silva', 'LIMPEZA', 'CA', '12345678915');

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678929, 1991-11-14, Raquel Fernandes, SUP-LIMPEZA, H, 12345678915).
INSERT INTO funcionario VALUES ('12345678929', '1991-11-14', 'Raquel Fernandes', 'SUP-LIMPEZA', 'H', '12345678915');

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678930, 1990-01-01, Larissa Dourado, SUP-LIMPEZA, B, null).
INSERT INTO funcionario VALUES ('12345678930', '1990-01-01', 'Larissa Dourado', 'SUP-LIMPEZA', 'B', NULL);

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678931, 1987-04-23, Sonia Sodre, LIMPEZA, S, null).
INSERT INTO funcionario VALUES ('12345678931', '1987-04-23', 'Sonia Sodre', 'LIMPEZA', 'S', NULL);

-- ERROR:  new row for relation "funcionario" violates check constraint "ck_funcao"
-- DETAIL:  Failing row contains (12345678932, 1993-10-15, Hannah Bernardo, SUP-LIMPEZA, S, 12345678915).
INSERT INTO funcionario VALUES ('12345678932', '1993-10-15', 'Hannah Bernardo', 'SUP-LIMPEZA', 'S', '12345678915');

-- Questão 10:

INSERT INTO funcionario VALUES ('32323232955', '1976-02-28', 'Marta Costa da Silva', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario VALUES ('98765432111', '1970-03-08', 'Marilia Oliveira', 'LIMPEZA', 'S', '12345678916');

INSERT INTO funcionario VALUES ('98765432122', '1970-03-08', 'Maria José', 'LIMPEZA', 'S', '12345678916');

INSERT INTO funcionario VALUES ('32323232911', '1991-05-28', 'Mario Carvalho', 'SUP_LIMPEZA', 'S', NULL);

--Opção 1
ALTER TABLE tarefas ADD CONSTRAINT cascade_constraint FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;

-- Foi possivel deletar
DELETE FROM funcionario WHERE cpf = '12345678911';

ALTER TABLE tarefas DROP CONSTRAINT cascade_constraint;

-- Opção 2:
ALTER TABLE tarefas ADD CONSTRAINT cascade_restrict FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;

--Não foi possivel deletar, pois viola a constraint
DELETE FROM funcionario WHERE cpf = '32323232911';
-- ERROR:  update or delete on table "funcionario" violates foreign key constraint "cascade_restrict" on table "tarefas"
-- DETAIL:  Key (cpf)=(32323232911) is still referenced from table "tarefas".


-- Questão 11:

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;

ALTER TABLE tarefas ADD CONSTRAINT ck_func_null CHECK(status = 'P' OR status = 'C' OR (status = 'E' AND (func_resp_cpf <> '' AND func_resp_cpf IS NOT NULL)));

-- As inserções abaixo devem ser executadas com sucessso

INSERT INTO tarefas VALUES (2147483663, 'limpar portas do 2o andar', '32323232911', 2, 'E');

INSERT INTO tarefas VALUES (2147483664, 'limpar portas do 2o andar', NULL, 2, 'P');

INSERT INTO tarefas VALUES (2147483665, 'limpar portas do 2o andar', NULL, 2, 'C');

