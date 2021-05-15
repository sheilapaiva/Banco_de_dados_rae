--Banco de Dados para uma Seguradora de Automóveis

--Questões 1 e 2

--Cria a tabela Automóvel
CREATE TABLE automovel(
    montadora_automovel VARCHAR(20),
    modelo_automovel VARCHAR(20),
    placa_automovel CHAR(7),
    chassi_automovel CHAR(17),
    ano_automovel CHAR(4),
    cor_automovel VARCHAR(20)
);

--Cria a tabela Segurado
CREATE TABLE segurado(
    nome_segurado VARCHAR(100),
    cpf_segurado CHAR(11),
    rg_segurado VARCHAR(12),
    telefone_segurado CHAR(11),
    cnh_segurado CHAR(12),
    endereco_segurado VARCHAR(100)
);

--Cria a tabela Perito
CREATE TABLE perito(
    nome_perito VARCHAR(100),
    cpf_perito CHAR(11),
    rg_perito VARCHAR(12),
    telefone_perito CHAR(11)
);

--Cria a tabela Oficina
CREATE TABLE oficina(
    nome_oficina VARCHAR(100),
    cnpj_oficina CHAR(14),
    telefone_oficina VARCHAR(11),
    endereco_oficina VARCHAR(100) 
);

--Cria a tabela Seguro
CREATE TABLE seguro (
    id_seguro CHAR(6),
    apolice_seguro VARCHAR(180),
    data_inicio DATE,
    data_fim DATE
);

--Cria a tabela Sinistro
CREATE TABLE sinistro (
    id_sinistro CHAR(6),
    descrição_sinistro VARCHAR(180),
    data_sinistro DATE
);

--Cria a tabela Pericia
CREATE TABLE pericia(
    id_pericia CHAR(6),
    descrição_pericia VARCHAR(180),
    data_pericia DATE
);

--Cria a tabela Reparo
CREATE TABLE reparo(
    id_reparo CHAR(6),
    descrição_reparo VARCHAR(180),
    custo_reparo NUMERIC,
    data_reparo DATE
);

--Questão 3

--Define a chave primária da tabela automovel
ALTER TABLE automovel ADD PRIMARY KEY(placa_automovel);

--Define a chave primária da tabela segurado
ALTER TABLE segurado ADD PRIMARY KEY(cpf_segurado);

--Define a chave primária da tabela perito
ALTER TABLE perito ADD PRIMARY KEY(cpf_perito);

--Define a chave primária da tabela oficina
ALTER TABLE oficina ADD PRIMARY KEY(cnpj_oficina);

--Define a chave primária da tabela seguro
ALTER TABLE seguro ADD PRIMARY KEY(id_seguro);

--Define a chave primária da tabela sinistro
ALTER TABLE sinistro ADD PRIMARY KEY(id_sinistro);

--Define a chave primária da tabela pericia
ALTER TABLE pericia ADD PRIMARY KEY(id_pericia);

--Define a chave primária da tabela reparo
ALTER TABLE reparo ADD PRIMARY KEY(id_reparo);

--Questão 4

--Define a chave estrangeira da tabela automovel
ALTER TABLE automovel ADD CONSTRAINT automovel_segurado
FOREIGN KEY (chassi_automovel) REFERENCES segurado(cpf_segurado);

--Define a chave estrangeira da tabela seguro
ALTER TABLE seguro ADD CONSTRAINT seguro_automovel
FOREIGN KEY (id_seguro) REFERENCES automovel(placa_automovel);

--Define a chave estrangeira da tabela sinistro
ALTER TABLE sinistro ADD CONSTRAINT sinistro_automovel
FOREIGN KEY (id_sinistro) REFERENCES automovel(placa_automovel);

--Define a chave estrangeira da tabela pericia
ALTER TABLE pericia ADD CONSTRAINT pericia_sinistro
FOREIGN KEY (id_pericia) REFERENCES sinistro(id_sinistro);

--Define a chave estrangeira da tabela reparo
ALTER TABLE reparo ADD CONSTRAINT reparo_pericia
FOREIGN KEY (id_reparo) REFERENCES pericia(id_pericia);

--Questão 5

--Atributos que poderiam ser NOT NULL:
--Automovel: montadora_automovel, modelo_automovel, placa_automovel, chassi_automovel, ano_automovel, cor_automovel;
--Segurado: nome_segurado, cpf_segurado, rg_segurado, telefone_segurado, cnh_segurado, endereco_segurado; 
--Perito: nome_perito, cpf_perito, rg_perito, telefone_perito;
--Oficina: nome_oficina, cnpj_oficina, telefone_oficina, endereco_oficina;
--Seguro: id_seguro, apolice_seguro, data_inicio, data_fim;
--Sinistro: id_sinistro, descrição_sinistro, data_sinistro;
--Pericia: id_pericia, descrição_pericia, data_pericia; 
--Reparo: id_reparo, descrição_reparo, custo_reparo, data_reparo;

--Questão 6

DROP TABLE automovel, segurado, perito, oficina, seguro, sinistro, pericia, reparo;

--Questão 7 e 8

--Cria a tabela Segurado
CREATE TABLE segurado(
    nome_segurado VARCHAR(100) NOT NULL,
    cpf_segurado CHAR(11) PRIMARY KEY,
    rg_segurado VARCHAR(12) NOT NULL,
    telefone_segurado CHAR(11) NOT NULL,
    cnh_segurado CHAR(12) NOT NULL,
    endereco_segurado VARCHAR(100) NOT NULL
);

--Cria a tabela Automóvel
CREATE TABLE automovel(
    montadora_automovel VARCHAR(20) NOT NULL,
    modelo_automovel VARCHAR(20) NOT NULL,
    placa_automovel CHAR(7) PRIMARY KEY,
    chassi_automovel CHAR(17) NOT NULL,
    ano_automovel CHAR(4) NOT NULL,
    cor_automovel VARCHAR(20) NOT NULL,
    FOREIGN KEY (chassi_automovel) REFERENCES segurado(cpf_segurado)
);

--Cria a tabela Perito
CREATE TABLE perito(
    nome_perito VARCHAR(100) NOT NULL,
    cpf_perito CHAR(11) PRIMARY KEY,
    rg_perito VARCHAR(12) NOT NULL,
    telefone_perito CHAR(11) NOT NULL
);

--Cria a tabela Seguro
CREATE TABLE seguro (
    id_seguro CHAR(6) PRIMARY KEY,
    apolice_seguro VARCHAR(180) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    FOREIGN KEY (id_seguro) REFERENCES automovel(placa_automovel)
);

--Cria a tabela Sinistro
CREATE TABLE sinistro (
    id_sinistro CHAR(6) PRIMARY KEY,
    descrição_sinistro VARCHAR(180) NOT NULL,
    data_sinistro DATE NOT NULL,
    FOREIGN KEY (id_sinistro) REFERENCES automovel(placa_automovel)
);

--Cria a tabela Pericia
CREATE TABLE pericia(
    id_pericia CHAR(6) PRIMARY KEY,
    descrição_pericia VARCHAR(180) NOT NULL,
    data_pericia DATE NOT NULL,
    FOREIGN KEY (id_pericia) REFERENCES sinistro(id_sinistro)
);

--Cria a tabela Reparo
CREATE TABLE reparo(
    id_reparo CHAR(6) PRIMARY KEY,
    descrição_reparo VARCHAR(180) NOT NULL,
    custo_reparo NUMERIC NOT NULL,
    data_reparo DATE NOT NULL,
    FOREIGN KEY (id_reparo) REFERENCES pericia(id_pericia)
);

--Cria a tabela Oficina
CREATE TABLE oficina(
    nome_oficina VARCHAR(100) NOT NULL,
    cnpj_oficina CHAR(14) PRIMARY KEY,
    telefone_oficina VARCHAR(11) NOT NULL,
    endereco_oficina VARCHAR(100) NOT NULL,
    FOREIGN KEY (cnpj_oficina) REFERENCES reparo(id_reparo) 
);

--Questão 9
--Observação: As remoções não podem acontecer em qualquer ordem,
--por exemplo, a tabela segurado n,ao pode ser removida antes da tabela
--automovel, pois a tabela automovel tem uma depende da tebela segurado. 
DROP TABLE automovel, segurado, perito, oficina, seguro, sinistro, pericia, reparo;

--Questão 10
--Não.
