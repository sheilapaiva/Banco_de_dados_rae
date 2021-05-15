-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-11-05 16:16:32.16

-- tables
-- Table: Jogador
CREATE TABLE jogador (
    cpf char(11) NOT NULL,
    nome varchar(50) NOT NULL,
    posicao_origem varchar(20) NOT NULL,
    time_id int NOT NULL,
    CONSTRAINT jogador_pk PRIMARY KEY (cpf)
);

-- Table: Jogador_Jogo
CREATE TABLE jogador_jogo (
    gols_jogador int NOT NULL,
    cartao_amarelo boolean NOT NULL,
    cartao_vermelho boolean NOT NULL,
    posicao_jogador varchar(20) NOT NULL,
    jogador_cpf char(11) NOT NULL,
    jogo_id int NOT NULL,
    id int NOT NULL,
    CONSTRAINT jogador_jogo_pk PRIMARY KEY (id)
);

-- Table: Jogo
CREATE TABLE jogo (
    id int  NOT NULL,
    data_jogo timestamp NOT NULL,
    juiz varchar(30) NOT NULL,
    bandeirinha1 varchar(30) NOT NULL,
    bandeirinha2 varchar(30) NOT NULL,
    CONSTRAINT jogo_pk PRIMARY KEY (id)
);

-- Table: Time
CREATE TABLE time (
    id int NOT NULL,
    nome varchar(30) NOT NULL,
    treinador varchar(30) NOT NULL,
    nacionalidade char(2) NOT NULL,
    CONSTRAINT time_pk PRIMARY KEY (id)
);

-- Table: Time_Jogo
CREATE TABLE time_jogo (
    gols_time int NOT NULL,
    cartoes_time int NOT NULL,
    time_id int NOT NULL,
    jogo_id int NOT NULL,
    id int NOT NULL,
    CONSTRAINT time_jogo_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Jogador_Jogo_Jogador (table: Jogador_Jogo)
ALTER TABLE jogador_jogo ADD CONSTRAINT jogador_jogo_jogador
    FOREIGN KEY (jogador_cpf)
    REFERENCES jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogador_Jogo_Jogo (table: Jogador_Jogo)
ALTER TABLE jogador_jogo ADD CONSTRAINT jogador_jogo_jogo
    FOREIGN KEY (jogo_id)
    REFERENCES jogo (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogador_Time (table: Jogador)
ALTER TABLE jogador ADD CONSTRAINT jogador_time
    FOREIGN KEY (time_id)
    REFERENCES time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Time_Jogo_Jogo (table: Time_Jogo)
ALTER TABLE time_jogo ADD CONSTRAINT time_jogo_jogo
    FOREIGN KEY (jogo_id)
    REFERENCES jogo (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Time_Jogo_Time (table: Time_Jogo)
ALTER TABLE time_jogo ADD CONSTRAINT time_jogo_time
    FOREIGN KEY (time_id)
    REFERENCES Time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Inserir Times
INSERT INTO time VALUES (1, 'Clube de Regatas do Flamengo', 'Domènec Torrent', 'BR');
INSERT INTO time VALUES (2, 'Sociedade Esportiva Palmeiras', 'Vanderlei', 'BR');
INSERT INTO time VALUES (3, 'Santos Futebol Clube', 'Cuca', 'BR');

-- Inserir Jogadores
INSERT INTO jogador VALUES ('12345678911', 'Bruno Henrique', 'atacante', 1);
INSERT INTO jogador VALUES ('12345678912', 'Diego Alves', 'goleiro', 1);
INSERT INTO jogador VALUES ('12345678913', 'Diego Ribas', 'meia', 1);
INSERT INTO jogador VALUES ('12345678914', 'Rodrigo Caio', 'defensor', 1);
INSERT INTO jogador VALUES ('12345678915', 'Gabriel Barbosa', 'atacante', 1);

INSERT INTO jogador VALUES ('12345678916', 'Patrick', 'meia', 2);
INSERT INTO jogador VALUES ('12345678917', 'Rony', 'atacante', 2);
INSERT INTO jogador VALUES ('12345678918', 'Gustavo Gómez', 'defensor', 2);
INSERT INTO jogador VALUES ('12345678919', 'Gabriel Veron', 'atacante', 2);
INSERT INTO jogador VALUES ('12345678920', 'Jailson', 'goleiro', 2);

INSERT INTO jogador VALUES ('12345678921', 'Vladimir', 'goleiro', 3);
INSERT INTO jogador VALUES ('12345678922', 'Lucas Braga', 'atacante', 3);
INSERT INTO jogador VALUES ('12345678923', 'Diego Pituca', 'meia', 3);
INSERT INTO jogador VALUES ('12345678924', 'Felipe Jonatan', 'defensor', 3);
INSERT INTO jogador VALUES ('12345678925', 'Kaio Jorge', 'atacante', 3);

-- Inserir Jogo
INSERT INTO jogo VALUES (1, '2020-10-18 16:30:00', 'Braulio da Silva', 'Kleber Lucio', 'Neuza Ines');
INSERT INTO jogo VALUES (2, '2020-10-19 20:00:00', 'Flavio Rodrigues', 'Alex Ang', 'Tatiane Sacilotti');
INSERT INTO jogo VALUES (3, '2020-10-20 16:00:00', 'Rodrigo Carvalhaes', 'Rodrigo Figueiredo', 'Michael Correia');

-- Inserir Jogador_Jogo
INSERT INTO jogador_jogo VALUES (1, TRUE, FALSE, 'lateral direito', '12345678911', 1, 1);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'goleiro', '12345678912', 1, 2);
INSERT INTO jogador_jogo VALUES (1, TRUE, FALSE, 'meia', '12345678913', 1, 3);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'atacante', '12345678916', 1, 4);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'goleiro', '12345678920', 1, 5);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'defensor', '12345678918', 1, 6);

INSERT INTO jogador_jogo VALUES (2, FALSE, FALSE, 'atacante', '12345678916', 2, 7);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'goleiro', '12345678920', 2, 8);
INSERT INTO jogador_jogo VALUES (0, TRUE, FALSE, 'defensor', '12345678918', 2, 9);
INSERT INTO jogador_jogo VALUES (1, TRUE, FALSE, 'atacante', '12345678922', 2, 10);
INSERT INTO jogador_jogo VALUES (0, FALSE, FALSE, 'goleiro', '12345678921', 2, 11);
INSERT INTO jogador_jogo VALUES (0, TRUE, FALSE, 'defensor', '12345678924', 2, 12);

-- Inserir Time_Jogo
INSERT INTO time_jogo VALUES (2, 2, 1, 1, 1);
INSERT INTO time_jogo VALUES (0, 0, 2, 1, 2);
INSERT INTO time_jogo VALUES (2, 1, 2, 2, 3);
INSERT INTO time_jogo VALUES (1, 2, 3, 2, 4);

SELECT  nome, posicao_origem, posicao_jogador, gols_jogador, cartao_amarelo, cartao_vermelho
FROM jogador_jogo AS jj, jogador AS j
WHERE jj.jogador_cpf = j.cpf AND jj.posicao_jogador != j.posicao_origem;

-- A quantidade de gols marcados por todos os atacantes nas partidas
SELECT COUNT(gols_jogador) as quantidade_gols_atacantes
FROM jogador_jogo AS j
WHERE j.posicao_jogador = 'atacante';

-- A média de cartões por partida
SELECT juiz, COUNT(*)
FROM jogo AS j, time_jogo AS tj1 JOIN time_jogo AS tj2 ON tj1.jogo_id = tj2.jogo_id
WHERE j.id = tj1.jogo_id AND j.id = tj2.jogo_id
GROUP BY juiz;

SELECT jogo id, COUNT(tj.cartoes_time)
FROM jogo AS j, time_jogo AS tj
GROUP BY jogo_id;

--Q12
SELECT pno AS num_proj, COUNT AS qtd_func
FROM (
    SELECT pno, COUNT(*)
    FROM employee AS e LEFT OUTER JOIN works_on AS w ON (w.essn = e.ssn) 
    GROUP BY pno) AS resul
WHERE resul.count < 5
ORDER BY qtd_func;

SELECT juiz, cartoes_timeA, cartoes_timeB
FROM jogo AS j, time_jogo AS tj
WHERE j.id = tj.jogo_id;

-- End of file.

