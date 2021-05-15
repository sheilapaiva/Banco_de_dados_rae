-- Roteiro 3 - Banco de Dados I
-- Banco: Rede de Farmácias

-- Requisito 19
--CREATE TYPE UF AS ENUM (
--    'AL',
--    'BA',
--    'CE',
--    'MA',
--    'PB',
--    'PE',
--    'PI',
--    'RN',
--    'SE'
--);

--CREATE TABLE farmacias(
--	id_farmacia INTEGER NOT NULL,
--	nome_farmacia VARCHAR(30) NOT NULL,
--	tipo_farmacia VARCHAR(6) NOT NULL, -- Requisito 1
--	endereco_farmacia VARCHAR(50) NOT NULL,
--	estado_farmacia UF NOT NULL, -- Requisito 19
--	tipo_gerente VARCHAR(15), -- Requisito 16
--	fk_gerente_farmacia INTEGER, -- Requisito 4
--	-- Requisito 1
--	CONSTRAINT ck_tipo_farmacias CHECK ((tipo_farmacia = 'sede') OR (tipo_farmacia = 'filial')),
--	-- Requisito 16
--  CONSTRAINT tipo_gerente CHECK ((tipo_gerente= 'administrador') OR (tipo_gerente = 'farmacêutico'))
--);

--CREATE TABLE funcionarios(
--	cpf_func INTEGER PRIMARY KEY,
--	nome_func VARCHAR(50) NOT NULL,
--	cargo_func VARCHAR(15) NOT NULL, -- Requisito 2
--	fk_farmacia INTEGER, -- Requisito 3, 5
--	CONSTRAINT func_alocado CHECK (fk_farmacia IS NOT NULL),
--  -- Requisito 2
--	CONSTRAINT cargo_funcionario CHECK ((cargo_func = 'farmacêutico') OR (cargo_func = 'vendedor') OR (cargo_func = 'entregador') OR (cargo_func = 'caixa') OR (cargo_func = 'administrador'))
--);

--CREATE TABLE medicamentos(
--	id_medicamento INTEGER PRIMARY KEY,
--	nome VARCHAR(50) NOT NULL,
--	preco NUMERIC NOT NULL,
--	caracteristica VARCHAR(30), -- Requisito 8
--	fk_farmacia INTEGER,
--	CONSTRAINT caracteristica_constraint CHECK ((caracteristica = 'venda exclusiva com receita') OR (caracteristica = NULL))
--);

--CREATE TABLE vendas(
--	id_venda INTEGER PRIMARY KEY,
--	valor_venda NUMERIC NOT NULL,
--	data_venda DATE NOT NULL,
--	fk_medicamento INTEGER,
--	carac_medicamento VARCHAR(30), -- Requisito 17
--	cargo_func VARCHAR(15) NOT NULL, -- Requisito 18
--	fk_func INTEGER,
--  fk_farmacia INTEGER,
--	fk_cliente INTEGER, -- Requisito 10
--	CONSTRAINT ck_carac_medicamento CHECK ((carac_medicamento = 'venda exclusiva com receita' AND 
--	fk_cliente IS NOT NULL) OR carac_medicamento = NULL AND fk_cliente = NULL), -- Requisito 17
--	CONSTRAINT ck_cargo CHECK (cargo_func = 'vendedor') -- Requisito 18
--);

--CREATE TABLE entregas(
--	id_entrega INTEGER PRIMARY KEY,
--	fk_cliente CHAR(11) NOT NULL, -- Requisito 9
--	fk_venda INTEGER NOT NULL
--);

--CREATE TABLE clientes(
--	id_cliente INTEGER PRIMARY KEY,
--	nome VARCHAR(30) NOT NULL,
--	idade INTEGER NOT NULL, -- Requisito 13
--	-- Requisito 6, 7
--	endereco_residencia VARCHAR(50),
--	endereco_trabalho VARCHAR(50),
--	endereco_outro VARCHAR(50),
--	-- Requisito 13
--  CONSTRAINT ck_idade_client CHECK (idade >= 18),
--	-- Requisito 9
--	CONSTRAINT ck_endereco CHECK (endereco_residencia IS NOT NULL OR endereco_trabalho IS NOT NULL OR endereco_outro IS NOT NULL)
--);

-- DEVE SER EXECUTADO COM SUCESSO
--INSERT INTO farmacias VALUES (1, 'Drogaria silva', 'filial', 'bela vista - campina grande','PB', 'farmacêutico', 234567);
--INSERT INTO farmacias VALUES (3, 'FTB', 'filial', 'catole - campina grande', 'PB', NULL, NULL);
--INSERT INTO farmacias VALUES (4, 'Rede Dias', 'filial', 'ze pinheiro - campina grande', 'PB', NULL, NULL);
--INSERT INTO farmacias VALUES (2, 'Menor preço', 'sede', 'centro - campina grande', 'PB', 'administrador', 134567);
--INSERT INTO farmacias VALUES (5, 'RedePharma', 'filial', 'centro - joao pessoa','PB', NULL, NULL);
--INSERT INTO farmacias VALUES (6, 'Farmacia Nordeste', 'filial', 'centro - Salvador', 'BA', NULL, NULL);
--INSERT INTO farmacias VALUES (7, 'Drogasil', 'filial', 'centro - Sergipe', 'SE', NULL, NULL);

--INSERT INTO funcionarios VALUES (323432, 'Jose Santos', 'entregador', 7);
--INSERT INTO funcionarios VALUES (545465, 'Jose Silva', 'caixa', 7);
--INSERT INTO funcionarios VALUES (234567, 'Sandra Cavalcante', 'farmacêutico', 1);
--INSERT INTO funcionarios VALUES (789543, 'Carlos Andrade', 'vendedor', 2);
--INSERT INTO funcionarios VALUES (789542, 'Antonio Santos', 'vendedor', 1);
--INSERT INTO funcionarios VALUES (134567, 'Bruno Silva', 'administrador', 2);
--INSERT INTO funcionarios VALUES (121547, 'Ester Dantas', 'administrador', 2);

--INSERT INTO clientes VALUES (11, 'Joao Carlos', 21, 'residencial Silva','centro', NULL);
--INSERT INTO clientes VALUES (12, 'Marcos Bruno', 22, 'Rua Brotas', NULL, 'praça do trabalho');
--INSERT INTO clientes VALUES (13, 'Zé Alfredo', 23, NULL, 'residencial Carlos', NULL);
--INSERT INTO clientes VALUES (14, 'Ana Maria', 19, 'rua silvana', NULL, NULL);

--INSERT INTO medicamentos VALUES (1, 'Paracetamol', 5.50, NULL, 1);
--INSERT INTO medicamentos VALUES (2, 'Dipirona', 2.50, NULL, 2);
--INSERT INTO medicamentos VALUES (3, 'Torsilax', 12.00, NULL, 2);
--INSERT INTO medicamentos VALUES (4, 'Amoxilina', 22.00, 'venda exclusiva com receita', 2);

--INSERT INTO vendas VALUES (1, 5.50, '2020-03-26', 1, NULL, 'vendedor', 789543, 1, 11);
--INSERT INTO vendas VALUES (2, 2.50, '2020-03-26', 2, NULL, 'vendedor', 789543, 2, 12);
--INSERT INTO vendas VALUES (3, 12.00, '2020-03-26', 3, NULL, 'vendedor', 789543, 2, 13);
--INSERT INTO vendas VALUES (4, 22.00, '2020-03-26', 4, 'venda exclusiva com receita', 'vendedor', 789543, 2, 14);

-- Requisito 14
--ALTER TABLE farmacias ADD CONSTRAINT endereco_constraint UNIQUE (endereco_farmacia);

--ALTER TABLE farmacias ADD CONSTRAINT unique_func_gerente UNIQUE (fk_gerente_farmacia, tipo_gerente);

--ALTER TABLE farmacias ADD CONSTRAINT pk_farmacias PRIMARY KEY (id_farmacia);

-- Requisito 2
--ALTER TABLE funcionarios ADD CONSTRAINT unique_funcionarios_cpf_cargo UNIQUE (cpf_func, cargo_func);

-- Requisito 15
--ALTER TABLE farmacias ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo_farmacia WITH =) WHERE (tipo_farmacia = 'sede');

--
-- FOREIGN KEY:
--
--ALTER TABLE farmacias ADD CONSTRAINT fk_gerente FOREIGN KEY (fk_gerente_farmacia) REFERENCES funcionarios(cpf_func);

--ALTER TABLE funcionarios ADD CONSTRAINT fk_farmacia_func FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

--ALTER TABLE medicamentos ADD CONSTRAINT fk_farmacias FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

--ALTER TABLE vendas ADD CONSTRAINT fk_func FOREIGN KEY (fk_func) REFERENCES funcionarios(cpf_func);

--ALTER TABLE vendas ADD CONSTRAINT fk_medicamento FOREIGN KEY (fk_medicamento) REFERENCES medicamentos(id_medicamento);

--ALTER TABLE vendas ADD CONSTRAINT fk_farmacia_vendas FOREIGN KEY (fk_farmacia) REFERENCES farmacias(id_farmacia);

--ALTER TABLE vendas ADD CONSTRAINT fk_cliente FOREIGN KEY (fk_cliente) REFERENCES clientes(id_cliente);

--ALTER TABLE entregas ADD CONSTRAINT fk_cliente_entregas FOREIGN KEY (fk_clientes) REFERENCES clientes(id_cliente);

--ALTER TABLE entregas ADD CONSTRAINT fk_entregas_vendas FOREIGN KEY (fk_venda) REFERENCES vendas(id_venda);

-- Requisito 11
--ALTER TABLE vendas ADD CONSTRAINT constraint_funcionario_venda FOREIGN KEY (fk_func) REFERENCES funcionarios(cpf_func) ON DELETE RESTRICT;

-- Requisito 12
--ALTER TABLE vendas ADD CONSTRAINT constraint_medicamento_venda FOREIGN KEY (fk_medicamento) REFERENCES medicamentos(id_medicamento) ON DELETE RESTRICT;


--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.23
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_medicamento;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT fk_gerente;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_func;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT fk_farmacias;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_farmacia_vendas;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT fk_farmacia_func;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT fk_entregas_vendas;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_cliente;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT constraint_medicamento_venda;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT constraint_funcionario_venda;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT unique_funcionarios_cpf_cargo;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT unique_func_gerente;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT sede_unica;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT pk_farmacias;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT endereco_constraint;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
DROP TABLE public.vendas;
DROP TABLE public.medicamentos;
DROP TABLE public.funcionarios;
DROP TABLE public.farmacias;
DROP TABLE public.entregas;
DROP TABLE public.clientes;
DROP TYPE public.uf;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: uf; Type: TYPE; Schema: public; Owner: sheilammp
--

CREATE TYPE public.uf AS ENUM (
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


ALTER TYPE public.uf OWNER TO sheilammp;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nome character varying(30) NOT NULL,
    idade integer NOT NULL,
    endereco_residencia character varying(50),
    endereco_trabalho character varying(50),
    endereco_outro character varying(50),
    CONSTRAINT ck_endereco CHECK (((endereco_residencia IS NOT NULL) OR (endereco_trabalho IS NOT NULL) OR (endereco_outro IS NOT NULL))),
    CONSTRAINT ck_idade_client CHECK ((idade >= 18))
);


ALTER TABLE public.clientes OWNER TO sheilammp;

--
-- Name: entregas; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.entregas (
    id_entrega integer NOT NULL,
    fk_cliente character(11) NOT NULL,
    fk_venda integer NOT NULL
);


ALTER TABLE public.entregas OWNER TO sheilammp;

--
-- Name: farmacias; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.farmacias (
    id_farmacia integer NOT NULL,
    nome_farmacia character varying(30) NOT NULL,
    tipo_farmacia character varying(6) NOT NULL,
    endereco_farmacia character varying(50) NOT NULL,
    estado_farmacia public.uf NOT NULL,
    tipo_gerente character varying(15),
    fk_gerente_farmacia integer,
    CONSTRAINT ck_tipo_farmacias CHECK ((((tipo_farmacia)::text = 'sede'::text) OR ((tipo_farmacia)::text = 'filial'::text))),
    CONSTRAINT tipo_gerente CHECK ((((tipo_gerente)::text = 'administrador'::text) OR ((tipo_gerente)::text = 'farmacêutico'::text)))
);


ALTER TABLE public.farmacias OWNER TO sheilammp;

--
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.funcionarios (
    cpf_func integer NOT NULL,
    nome_func character varying(50) NOT NULL,
    cargo_func character varying(15) NOT NULL,
    fk_farmacia integer,
    CONSTRAINT cargo_funcionario CHECK ((((cargo_func)::text = 'farmacêutico'::text) OR ((cargo_func)::text = 'vendedor'::text) OR ((cargo_func)::text = 'entregador'::text) OR ((cargo_func)::text = 'caixa'::text) OR ((cargo_func)::text = 'administrador'::text))),
    CONSTRAINT func_alocado CHECK ((fk_farmacia IS NOT NULL))
);


ALTER TABLE public.funcionarios OWNER TO sheilammp;

--
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.medicamentos (
    id_medicamento integer NOT NULL,
    nome character varying(50) NOT NULL,
    preco numeric NOT NULL,
    caracteristica character varying(30),
    fk_farmacia integer,
    CONSTRAINT caracteristica_constraint CHECK ((((caracteristica)::text = 'venda exclusiva com receita'::text) OR ((caracteristica)::text = NULL::text)))
);


ALTER TABLE public.medicamentos OWNER TO sheilammp;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: sheilammp
--

CREATE TABLE public.vendas (
    id_venda integer NOT NULL,
    valor_venda numeric NOT NULL,
    data_venda date NOT NULL,
    fk_medicamento integer,
    carac_medicamento character varying(30),
    cargo_func character varying(15) NOT NULL,
    fk_func integer,
    fk_farmacia integer,
    fk_cliente integer,
    CONSTRAINT ck_carac_medicamento CHECK (((((carac_medicamento)::text = 'venda exclusiva com receita'::text) AND (fk_cliente IS NOT NULL)) OR (((carac_medicamento)::text = NULL::text) AND (fk_cliente = NULL::integer)))),
    CONSTRAINT ck_cargo CHECK (((cargo_func)::text = 'vendedor'::text))
);


ALTER TABLE public.vendas OWNER TO sheilammp;

--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: sheilammp
--

INSERT INTO public.clientes (id_cliente, nome, idade, endereco_residencia, endereco_trabalho, endereco_outro) VALUES (11, 'Joao Carlos', 21, 'residencial Silva', 'centro', NULL);
INSERT INTO public.clientes (id_cliente, nome, idade, endereco_residencia, endereco_trabalho, endereco_outro) VALUES (12, 'Marcos Bruno', 22, 'Rua Brotas', NULL, 'praça do trabalho');
INSERT INTO public.clientes (id_cliente, nome, idade, endereco_residencia, endereco_trabalho, endereco_outro) VALUES (13, 'Zé Alfredo', 23, NULL, 'residencial Carlos', NULL);
INSERT INTO public.clientes (id_cliente, nome, idade, endereco_residencia, endereco_trabalho, endereco_outro) VALUES (14, 'Ana Maria', 19, 'rua silvana', NULL, NULL);
INSERT INTO public.clientes (id_cliente, nome, idade, endereco_residencia, endereco_trabalho, endereco_outro) VALUES (22, 'Damião Bastos', 62, 'Rua Rodigues Alves', NULL, NULL);


--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: sheilammp
--



--
-- Data for Name: farmacias; Type: TABLE DATA; Schema: public; Owner: sheilammp
--

INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (1, 'Drogaria silva', 'filial', 'bela vista - campina grande', 'PB', 'farmacêutico', 234567);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (3, 'FTB', 'filial', 'catole - campina grande', 'PB', NULL, NULL);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (4, 'Rede Dias', 'filial', 'ze pinheiro - campina grande', 'PB', NULL, NULL);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (2, 'Menor preço', 'sede', 'centro - campina grande', 'PB', 'administrador', 134567);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (5, 'RedePharma', 'filial', 'centro - joao pessoa', 'PB', NULL, NULL);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (6, 'Farmacia Nordeste', 'filial', 'centro - Salvador', 'BA', NULL, NULL);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (7, 'Drogasil', 'filial', 'centro - Sergipe', 'SE', NULL, NULL);
INSERT INTO public.farmacias (id_farmacia, nome_farmacia, tipo_farmacia, endereco_farmacia, estado_farmacia, tipo_gerente, fk_gerente_farmacia) VALUES (18, 'Drogaria Barbosa', 'filial', 'bancarios - joão pessoa', 'PB', 'administrador', 121547);


--
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: sheilammp
--

INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (323432, 'Jose Santos', 'entregador', 7);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (545465, 'Jose Silva', 'caixa', 7);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (234567, 'Sandra Cavalcante', 'farmacêutico', 1);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (789543, 'Carlos Andrade', 'vendedor', 2);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (789542, 'Antonio Santos', 'vendedor', 1);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (134567, 'Bruno Silva', 'administrador', 2);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (121547, 'Ester Dantas', 'administrador', 2);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (652147, 'Juliana Sodre', 'caixa', 18);
INSERT INTO public.funcionarios (cpf_func, nome_func, cargo_func, fk_farmacia) VALUES (652149, 'Julian Sodre', 'vendedor', 18);


--
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: sheilammp
--

INSERT INTO public.medicamentos (id_medicamento, nome, preco, caracteristica, fk_farmacia) VALUES (1, 'Paracetamol', 5.50, NULL, 1);
INSERT INTO public.medicamentos (id_medicamento, nome, preco, caracteristica, fk_farmacia) VALUES (2, 'Dipirona', 2.50, NULL, 2);
INSERT INTO public.medicamentos (id_medicamento, nome, preco, caracteristica, fk_farmacia) VALUES (3, 'Torsilax', 12.00, NULL, 2);
INSERT INTO public.medicamentos (id_medicamento, nome, preco, caracteristica, fk_farmacia) VALUES (4, 'Amoxilina', 22.00, 'venda exclusiva com receita', 2);
INSERT INTO public.medicamentos (id_medicamento, nome, preco, caracteristica, fk_farmacia) VALUES (18, 'Ibuprofeno', 15.50, NULL, 18);


--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: sheilammp
--

INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (1, 5.50, '2020-03-26', 1, NULL, 'vendedor', 789543, 1, 11);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (2, 2.50, '2020-03-26', 2, NULL, 'vendedor', 789543, 2, 12);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (3, 12.00, '2020-03-26', 3, NULL, 'vendedor', 789543, 2, 13);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (4, 22.00, '2020-03-26', 4, 'venda exclusiva com receita', 'vendedor', 789543, 2, 14);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (19, 15.50, '2020-03-27', 18, NULL, 'vendedor', 789543, 18, 22);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (20, 15.50, '2020-03-27', 18, NULL, 'vendedor', 789543, 18, NULL);
INSERT INTO public.vendas (id_venda, valor_venda, data_venda, fk_medicamento, carac_medicamento, cargo_func, fk_func, fk_farmacia, fk_cliente) VALUES (30, 22.00, '2020-03-26', 4, 'venda exclusiva com receita', 'vendedor', 789543, 2, NULL);


--
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- Name: endereco_constraint; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT endereco_constraint UNIQUE (endereco_farmacia);


--
-- Name: entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_pkey PRIMARY KEY (id_entrega);


--
-- Name: funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf_func);


--
-- Name: medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id_medicamento);


--
-- Name: pk_farmacias; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT pk_farmacias PRIMARY KEY (id_farmacia);


--
-- Name: sede_unica; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo_farmacia WITH =) WHERE (((tipo_farmacia)::text = 'sede'::text));


--
-- Name: unique_func_gerente; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT unique_func_gerente UNIQUE (fk_gerente_farmacia, tipo_gerente);


--
-- Name: unique_funcionarios_cpf_cargo; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT unique_funcionarios_cpf_cargo UNIQUE (cpf_func, cargo_func);


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id_venda);


--
-- Name: constraint_funcionario_venda; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT constraint_funcionario_venda FOREIGN KEY (fk_func) REFERENCES public.funcionarios(cpf_func) ON DELETE RESTRICT;


--
-- Name: constraint_medicamento_venda; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT constraint_medicamento_venda FOREIGN KEY (fk_medicamento) REFERENCES public.medicamentos(id_medicamento) ON DELETE RESTRICT;


--
-- Name: fk_cliente; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_cliente FOREIGN KEY (fk_cliente) REFERENCES public.clientes(id_cliente);


--
-- Name: fk_entregas_vendas; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT fk_entregas_vendas FOREIGN KEY (fk_venda) REFERENCES public.vendas(id_venda);


--
-- Name: fk_farmacia_func; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT fk_farmacia_func FOREIGN KEY (fk_farmacia) REFERENCES public.farmacias(id_farmacia);


--
-- Name: fk_farmacia_vendas; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_farmacia_vendas FOREIGN KEY (fk_farmacia) REFERENCES public.farmacias(id_farmacia);


--
-- Name: fk_farmacias; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT fk_farmacias FOREIGN KEY (fk_farmacia) REFERENCES public.farmacias(id_farmacia);


--
-- Name: fk_func; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_func FOREIGN KEY (fk_func) REFERENCES public.funcionarios(cpf_func);


--
-- Name: fk_gerente; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT fk_gerente FOREIGN KEY (fk_gerente_farmacia) REFERENCES public.funcionarios(cpf_func);


--
-- Name: fk_medicamento; Type: FK CONSTRAINT; Schema: public; Owner: sheilammp
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_medicamento FOREIGN KEY (fk_medicamento) REFERENCES public.medicamentos(id_medicamento);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


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
