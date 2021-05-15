-- Roteiro 3 - Banco de Dados I
-- Banco: Rede de Farmácias

-- Requisito 19
CREATE TYPE UF AS ENUM (
    'AL',
    'BA',
    'CE',
    'MA',
    'PB',
    'PE',
    'PI',
    'RN',
    'SE'
);

CREATE TABLE farmacias(
	id_farmacia INTEGER NOT NULL,
	nome_farmacia VARCHAR(30) NOT NULL,
	tipo_farmacia VARCHAR(6) NOT NULL, -- Requisito 1
	endereco_farmacia VARCHAR(50) NOT NULL,
	estado_farmacia UF NOT NULL, -- Requisito 19
	tipo_gerente VARCHAR(15), -- Requisito 16
	fk_gerente_farmacia INTEGER, -- Requisito 4
	-- Requisito 1
	CONSTRAINT ck_tipo_farmacias CHECK ((tipo_farmacia = 'sede') OR (tipo_farmacia = 'filial')),
	-- Requisito 16
    CONSTRAINT tipo_gerente CHECK ((tipo_gerente= 'administrador') OR (tipo_gerente = 'farmacêutico'))
);


CREATE TABLE funcionarios(
	cpf_func INTEGER PRIMARY KEY,
	nome_func VARCHAR(50) NOT NULL,
	cargo_func VARCHAR(15) NOT NULL, -- Requisito 2
	fk_farmacia INTEGER, -- Requisito 3, 5
	CONSTRAINT func_alocado CHECK (fk_farmacia IS NOT NULL),
    -- Requisito 2
	CONSTRAINT cargo_funcionario CHECK ((cargo_func = 'farmacêutico') OR (cargo_func = 'vendedor') OR (cargo_func = 'entregador') OR (cargo_func = 'caixa') OR (cargo_func = 'administrador'))
);


CREATE TABLE medicamentos(
	id_medicamento INTEGER PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	preco NUMERIC NOT NULL,
	caracteristica VARCHAR(30), -- Requisito 8
	fk_farmacia INTEGER,
	CONSTRAINT caracteristica_constraint CHECK ((caracteristica = 'venda exclusiva com receita') OR (caracteristica = NULL))
);

CREATE TABLE vendas(
	id_venda INTEGER PRIMARY KEY,
	valor_venda NUMERIC NOT NULL,
	data_venda DATE NOT NULL,
	fk_medicamento INTEGER,
	carac_medicamento VARCHAR(30), -- Requisito 17
	cargo_func VARCHAR(15) NOT NULL, -- Requisito 18
	fk_func INTEGER,
    fk_farmacia INTEGER,
	fk_cliente INTEGER, -- Requisito 10
	CONSTRAINT ck_carac_medicamento CHECK ((carac_medicamento = 'venda exclusiva com receita' AND 
	fk_cliente IS NOT NULL) OR carac_medicamento = NULL AND fk_cliente = NULL), -- Requisito 17
	CONSTRAINT ck_cargo CHECK (cargo_func = 'vendedor') -- Requisito 18
);

CREATE TABLE entregas(
	id_entrega INTEGER PRIMARY KEY,
	fk_cliente CHAR(11) NOT NULL, -- Requisito 9
	fk_venda INTEGER NOT NULL
);

CREATE TABLE clientes(
	id_cliente INTEGER PRIMARY KEY,
	nome VARCHAR(30) NOT NULL,
	idade INTEGER NOT NULL, -- Requisito 13
	-- Requisito 6, 7
	endereco_residencia VARCHAR(50),
	endereco_trabalho VARCHAR(50),
	endereco_outro VARCHAR(50),
	-- Requisito 13
    CONSTRAINT ck_idade_client CHECK (idade >= 18),
	-- Requisito 9
	CONSTRAINT ck_endereco CHECK (endereco_residencia IS NOT NULL OR endereco_trabalho IS NOT NULL OR endereco_outro IS NOT NULL)
);

-- DEVE SER EXECUTADO COM SUCESSO
INSERT INTO farmacias VALUES (1, 'Drogaria silva', 'filial', 'bela vista - campina grande','PB', 'farmacêutico', 234567);
INSERT INTO farmacias VALUES (3, 'FTB', 'filial', 'catole - campina grande', 'PB', NULL, NULL);
INSERT INTO farmacias VALUES (4, 'Rede Dias', 'filial', 'ze pinheiro - campina grande', 'PB', NULL, NULL);
INSERT INTO farmacias VALUES (2, 'Menor preço', 'sede', 'centro - campina grande', 'PB', 'administrador', 134567);
INSERT INTO farmacias VALUES (5, 'RedePharma', 'filial', 'centro - joao pessoa','PB', NULL, NULL);
INSERT INTO farmacias VALUES (6, 'Farmacia Nordeste', 'filial', 'centro - Salvador', 'BA', NULL, NULL);
INSERT INTO farmacias VALUES (7, 'Drogasil', 'filial', 'centro - Sergipe', 'SE', NULL, NULL);

INSERT INTO funcionarios VALUES (323432, 'Jose Santos', 'entregador', 7);
INSERT INTO funcionarios VALUES (545465, 'Jose Silva', 'caixa', 7);
INSERT INTO funcionarios VALUES (234567, 'Sandra Cavalcante', 'farmacêutico', 1);
INSERT INTO funcionarios VALUES (789543, 'Carlos Andrade', 'vendedor', 2);
INSERT INTO funcionarios VALUES (789542, 'Antonio Santos', 'vendedor', 1);
INSERT INTO funcionarios VALUES (134567, 'Bruno Silva', 'administrador', 2);
INSERT INTO funcionarios VALUES (121547, 'Ester Dantas', 'administrador', 2);


INSERT INTO clientes VALUES (11, 'Joao Carlos', 21, 'residencial Silva','centro', NULL);
INSERT INTO clientes VALUES (12, 'Marcos Bruno', 22, 'Rua Brotas', NULL, 'praça do trabalho');
INSERT INTO clientes VALUES (13, 'Zé Alfredo', 23, NULL, 'residencial Carlos', NULL);
INSERT INTO clientes VALUES (14, 'Ana Maria', 19, 'rua silvana', NULL, NULL);

INSERT INTO medicamentos VALUES (1, 'Paracetamol', 5.50, NULL, 1);
INSERT INTO medicamentos VALUES (2, 'Dipirona', 2.50, NULL, 2);
INSERT INTO medicamentos VALUES (3, 'Torsilax', 12.00, NULL, 2);
INSERT INTO medicamentos VALUES (4, 'Amoxilina', 22.00, 'venda exclusiva com receita', 2);

INSERT INTO vendas VALUES (1, 5.50, '2020-03-26', 1, NULL, 'vendedor', 789543, 1, 11);
INSERT INTO vendas VALUES (2, 2.50, '2020-03-26', 2, NULL, 'vendedor', 789543, 2, 12);
INSERT INTO vendas VALUES (3, 12.00, '2020-03-26', 3, NULL, 'vendedor', 789543, 2, 13);
INSERT INTO vendas VALUES (4, 22.00, '2020-03-26', 4, 'venda exclusiva com receita', 'vendedor', 789543, 2, 14);

-- Requisito 14
ALTER TABLE farmacias ADD CONSTRAINT endereco_constraint 
UNIQUE (endereco_farmacia);


ALTER TABLE farmacias ADD CONSTRAINT unique_func_gerente
UNIQUE (fk_gerente_farmacia, tipo_gerente);


ALTER TABLE farmacias ADD CONSTRAINT pk_farmacias PRIMARY KEY (id_farmacia);

-- Requisito 2
ALTER TABLE funcionarios ADD CONSTRAINT unique_funcionarios_cpf_cargo 
UNIQUE (cpf_func, cargo_func);

-- Requisito 15
ALTER TABLE farmacias ADD CONSTRAINT sede_unica 
EXCLUDE USING gist (tipo_farmacia WITH =) WHERE (tipo_farmacia = 'sede');

--
-- FOREIGN KEY:
--
ALTER TABLE farmacias ADD CONSTRAINT fk_gerente 
FOREIGN KEY (fk_gerente_farmacia) REFERENCES funcionarios(cpf_func);

ALTER TABLE funcionarios ADD CONSTRAINT fk_farmacia_func
FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

ALTER TABLE medicamentos ADD CONSTRAINT fk_farmacias
FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

ALTER TABLE vendas ADD CONSTRAINT fk_func
FOREIGN KEY (fk_func) REFERENCES funcionarios(cpf_func);

ALTER TABLE vendas ADD CONSTRAINT fk_medicamento
FOREIGN KEY (fk_medicamento) REFERENCES medicamentos(id_medicamento);

ALTER TABLE vendas ADD CONSTRAINT fk_farmacia_vendas
FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

ALTER TABLE vendas ADD CONSTRAINT fk_cliente
FOREIGN KEY (fk_cliente) REFERENCES clientes(id_cliente);

--
ALTER TABLE entregas ADD CONSTRAINT fk_cliente_entregas
FOREIGN KEY (fk_clientes) REFERENCES clientes(id_cliente);

ALTER TABLE entregas ADD CONSTRAINT fk_entregas_vendas
FOREIGN KEY (fk_venda) REFERENCES vendas(id_venda);

-- Requisito 11
ALTER TABLE vendas ADD CONSTRAINT constraint_funcionario_venda
FOREIGN KEY (fk_func) REFERENCES funcionarios(cpf_func) ON DELETE RESTRICT;

-- Requisito 12
ALTER TABLE vendas ADD CONSTRAINT constraint_medicamento_venda 
FOREIGN KEY (fk_medicamento) REFERENCES medicamentos(id_medicamento) ON DELETE RESTRICT;

--
-- COMANDOS ADICIONAIS
--

-- DEVE SER EXECUTADO COM SUCESSO
INSERT INTO farmacias VALUES (18, 'Drogaria Barbosa', 'filial', 'bancarios - joão pessoa','PB', 'administrador', 121547);
INSERT INTO funcionarios VALUES (652147, 'Juliana Sodre', 'caixa', 18);
INSERT INTO funcionarios VALUES (652149, 'Julian Sodre', 'vendedor', 18);
INSERT INTO clientes VALUES (22, 'Damião Bastos', 62, 'Rua Rodigues Alves', NULL, NULL);
INSERT INTO medicamentos VALUES (18, 'Ibuprofeno', 15.50, NULL, 18);
INSERT INTO vendas VALUES (19, 15.50, '2020-03-27', 18, NULL, 'vendedor', 789543, 18, 22);
INSERT INTO vendas VALUES (20, 15.50, '2020-03-27', 18, NULL, 'vendedor', 789543, 18, NULL);


-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT ck_tipo_farmacias, UMA VEZ QUE não pode ter outro tipo de farmacia
INSERT INTO farmacias VALUES(8, 'Drogaria silva', 'parceira', 'palmeiras - campina grande', 'PB', 'administrador', 134567);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT ck_tipo_farmacias, UMA VEZ QUE não pode ter duas sedes da mesma farmacia
INSERT INTO farmacias VALUES(8, 'Menor preço', 'sede', 'palmeiras - campina grande', 'PB', 'administrador', 134567);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT endereco_constraint, UMA VEZ QUE não pode ter duas farmacias no mesmo bairro
INSERT INTO farmacias VALUES (9, 'FTB', 'filial', 'catole - campina grande', 'PB', NULL, NULL);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT tipo_gerente, UMA VEZ QUE o gerente só pode ser do tipo administrador ou farmacêutico
INSERT INTO farmacias VALUES (10, 'Drogasil', 'filial', 'São Cristovão - Sergipe','vendedor', 323432, 'SE');

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT cargo_funcionario, UMA VEZ QUE não pode ter outros cargos além dos permitidos
INSERT INTO funcionarios VALUES(124467, 'Julia Pires', 'empacotador', NULL, NULL);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT constraint_medicamento_venda, UMA VEZ QUE não pode deletar um medicamento vinculado a uma venda
DELETE FROM medicamentos WHERE id_medicamento = 1;

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT constraint_funcionario_venda, UMA VEZ QUE não pode deletar um funcionario vinculado a uma venda
DELETE FROM funcionario WHERE cpf_func = 789543;

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT ck_idade_client, UMA VEZ QUE o cliente não pode ter menos de 18 anos
INSERT INTO clientes VALUES (15, 'Valmir Carvalho', 15, 'rua Afonso Fernandes', NULL, NULL);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT tipo UF, UMA VEZ QUE o estado só pode ser do nordeste
INSERT INTO farmacias VALUES (10, 'Rede Nacional', 'filial', 'centro - Goiania','GO', NULL, NULL);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT ck_carac_medicamento, UMA VEZ QUE um medicamento de venda exclusiva não pode ser vendido para clientes não cadastrados
INSERT INTO vendas VALUES (30, 22.00, '2020-03-26', 4, 'venda exclusiva com receita', 'vendedor', 789543, 2, NULL);

-- DEVE RETORNAR ERRO POR VIOLAR A CONSTRAINT ck_endereco , UMA VEZ QUE um cliente não pode ser cadastrado sem nenhum endereço valido
INSERT INTO clientes VALUES (19, 'Valdir Valença', 30, NULL, NULL, NULL);
