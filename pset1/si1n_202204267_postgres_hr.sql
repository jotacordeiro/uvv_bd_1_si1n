-- PROJETO_BD_UVV_HR

-- CRIANDO USUÁRIO:

 Role: jv_cordeiro
 DROP ROLE IF EXISTS jv_cordeiro;

CREATE ROLE jv_cordeiro WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;

-- CRIANDO BD:

 Database: uvv

 DROP DATABASE IF EXISTS uvv;

CREATE DATABASE uvv
    WITH 
    OWNER = jv_cordeiro
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- CONECTANDO AO BD UVV E AO USUÁRIO:

\c uvv jv_cordeiro;


-- CRIANDO ESQUEMA: 

CREATE SCHEMA IF NOT EXISTS hr
    AUTHORIZATION jv_cordeiro;
	
ALTER ROLE jv_cordeiro SET search_path TO hr, "$user", public;

-- CRIANDO TABELAS


CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                CONSTRAINT id_cargo_pk PRIMARY KEY (id_cargo)
);


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);


CREATE UNIQUE INDEX regioes_idx
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR NOT NULL,
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT id_pais_pk PRIMARY KEY (id_pais)
);


CREATE UNIQUE INDEX paises_idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                id_pais CHAR NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                CONSTRAINT id_localizacao_pk PRIMARY KEY (id_localizacao)
);


CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                CONSTRAINT id_departamento_pk PRIMARY KEY (id_departamento)
);


CREATE UNIQUE INDEX departamentos_idx
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(4,2),
                id_supervisor INTEGER,
                CONSTRAINT id_empregado_pk_1 PRIMARY KEY (id_empregado)
);


CREATE UNIQUE INDEX empregados_idx
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                CONSTRAINT id_empregado_pk PRIMARY KEY (id_empregado, id_departamento)
);


ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- INSERINDO DADOS NAS TABELAS


INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(100, 'Steven King', '515.123.4567', 'SKING', '2003-06-17', 'AD_PRES', 24000, null, null, 90);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(101, 'Neena Kochhar', '515.123.4568', 'NKOCHHAR', '2005-09-21', 'AD_VP', 17000, null, 100, 90);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(102, 'Lex De Haan', '515.123.4569', 'LDEHAAN', '2001-01-13', 'AD_VP', 17000, null, 100, 90);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(103, 'Alexander Hunold', '590.423.4567', 'AHUNOLD', '2006-01-03', 'IT_PROG', 9000, null, 102, 60);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(104, 'Bruce Ernst', '590.423.4568', 'BERNST', '2007-05-21', 'IT_PROG', 6000, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(105, 'David Austin', '590.423.4569', 'DAUSTIN', '2005-06-25', 'IT_PROG', 4800, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(106, 'Valli Pataballa', '590.423.4560', 'VPATABAL', '2006-02-05', 'IT_PROG', 4800, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(107, 'Diana Lorentz', '590.423.5567', 'DLORENTZ', '2007-02-07', 'IT_PROG', 4200, null, 103, 60);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(108, 'Nancy Greenberg', '515.124.4569', 'NGREENBE', '2002-08-17', 'FI_MGR', 12008, null, 101, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(109, 'Daniel Faviet', '515.124.4169', 'DFAVIET', '2002-08-16', 'FI_ACCOUNT', 9000, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(110, 'John Chen', '515.124.4269', 'JCHEN', '2005-09-28', 'FI_ACCOUNT', 8200, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(111, 'Ismael Sciarra', '515.124.4369', 'ISCIARRA', '2005-09-30', 'FI_ACCOUNT', 7700, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(112, 'Jose Manuel Urman', '515.124.4469', 'JMURMAN', '2006-03-07', 'FI_ACCOUNT', 7800, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(113, 'Luis Popp', '515.124.4567', 'LPOPP', '2007-12-07', 'FI_ACCOUNT', 6900, null, 108, 100);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(114, 'Den Raphaely', '515.127.4561', 'DRAPHEAL', '2002-12-07', 'PU_MAN', 11000, null, 100, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(115, 'Alexander Khoo', '515.127.4562', 'AKHOO', '2003-05-18', 'PU_CLERK', 3100, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(116, 'Shelli Baida', '515.127.4563', 'SBAIDA', '2005-12-24', 'PU_CLERK', 2900, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(117, 'Sigal Tobias', '515.127.4564', 'STOBIAS', '2005-07-24', 'PU_CLERK', 2800, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(118, 'Guy Himuro', '515.127.4565', 'GHIMURO', '2006-11-15', 'PU_CLERK', 2600, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(119, 'Karen Colmenares', '515.127.4566', 'KCOLMENA', '2007-08-10', 'PU_CLERK', 2500, null, 114, 30);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(120, 'Matthew Weiss', '650.123.1234', 'MWEISS', '2004-07-18', 'ST_MAN', 8000, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(121, 'Adam Fripp', '650.123.2234', 'AFRIPP', '2005-04-10', 'ST_MAN', 8200, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(122, 'Payam Kaufling', '650.123.3234', 'PKAUFLIN', '2003-05-01', 'ST_MAN', 7900, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(123, 'Shanta Vollman', '650.123.4234', 'SVOLLMAN', '2005-10-10', 'ST_MAN', 6500, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(124, 'Kevin Mourgos', '650.123.5234', 'KMOURGOS', '2007-11-16', 'ST_MAN', 5800, null, 100, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(125, 'Julia Nayer', '650.124.1214', 'JNAYER', '2005-07-16', 'ST_CLERK', 3200, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(126, 'Irene Mikkilineni', '650.124.1224', 'IMIKKILI', '2006-09-28', 'ST_CLERK', 2700, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(127, 'James Landry', '650.124.1334', 'JLANDRY', '2007-01-14', 'ST_CLERK', 2400, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(128, 'Steven Markle', '650.124.1434', 'SMARKLE', '2008-03-08', 'ST_CLERK', 2200, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(129, 'Laura Bissot', '650.124.5234', 'LBISSOT', '2005-08-20', 'ST_CLERK', 3300, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(130, 'Mozhe Atkinson', '650.124.6234', 'MATKINSO', '2005-10-30', 'ST_CLERK', 2800, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(131, 'James Marlow', '650.124.7234', 'JAMRLOW', '2005-02-16', 'ST_CLERK', 2500, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(132, 'TJ Olson', '650.124.8234', 'TJOLSON', '2007-04-10', 'ST_CLERK', 2100, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(133, 'Jason Mallin', '650.127.1934', 'JMALLIN', '2004-06-14', 'ST_CLERK', 3300, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(134, 'Michael Rogers', '650.127.1834', 'MROGERS', '2006-08-26', 'ST_CLERK', 2900, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(135, 'Ki Gee', '650.127.1734', 'KGEE', '2007-12-12', 'ST_CLERK', 2400, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(136, 'Hazel Philtanker', '650.127.1634', 'HPHILTAN', '2008-02-06', 'ST_CLERK', 2200, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(137, 'Renske Ladwig', '650.121.1234', 'RLADWIG', '2003-07-14', 'ST_CLERK', 3600, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(138, 'Stephen Stiles', '650.121.2034', 'SSTILES', '2005-10-26', 'ST_CLERK', 3200, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(139, 'John Seo', '650.121.2019', 'JSEO', '2006-02-12', 'ST_CLERK', 2700, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(140, 'Joshua Patel', '650.121.1834', 'JPATEL', '2006-04-06', 'ST_CLERK', 2500, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(141, 'Trenna Rajs', '650.121.8009', 'TRAJS', '2003-10-17', 'ST_CLERK', 3500, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(142, 'Curtis Davies', '650.121.2994', 'CDAVIES', '2005-01-29', 'ST_CLERK', 3100, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(143, 'Randall Matos', '650.121.2874', 'RMATOS', '2006-03-15', 'ST_CLERK', 2600, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(144, 'Peter Vargas', '650.121.2004', 'PVARGAS', '2006-07-09', 'ST_CLERK', 2500, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(145, 'John Russell', '011.44.1344.429268', 'JRUSSEL', '2004-10-01', 'SA_MAN', 14000, .4, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(146, 'Karen Partners', '011.44.1344.467268', 'KPARTNER', '2005-01-05', 'SA_MAN', 13500, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(147, 'Alberto Errazuriz', '011.44.1344.429278', 'AERRAZUR', '2005-03-10', 'SA_MAN', 12000, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(148, 'Gerald Cambrault', '011.44.1344.619268', 'GCAMBRAU', '2007-10-15', 'SA_MAN', 11000, .3, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(149, 'Eleni Zlotkey', '011.44.1344.429018', 'EZLOTKEY', '2008-01-29', 'SA_MAN', 10500, .2, 100, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(150, 'Peter Tucker', '011.44.1344.129268', 'PTUCKER', '2005-01-30', 'SA_REP', 10000, .3, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(151, 'David Bernstein', '011.44.1344.345268', 'DBERNSTE', '2005-03-24', 'SA_REP', 9500, .25, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(152, 'Peter Hall', '011.44.1344.478968', 'PHALL', '2005-08-20', 'SA_REP', 9000, .25, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(153, 'Christopher Olsen', '011.44.1344.498718', 'COLSEN', '2006-03-30', 'SA_REP', 8000, .2, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(154, 'Nanette Cambrault', '011.44.1344.987668', 'NCAMBRAU', '2006-12-09', 'SA_REP', 7500, .2, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(155, 'Oliver Tuvault', '011.44.1344.486508', 'OTUVAULT', '2007-11-23', 'SA_REP', 7000, .15, 145, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(156, 'Janette King', '011.44.1345.429268', 'JKING', '2004-01-30', 'SA_REP', 10000, .35, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(157, 'Patrick Sully', '011.44.1345.929268', 'PSULLY', '2004-03-04', 'SA_REP', 9500, .35, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(158, 'Allan McEwen', '011.44.1345.829268', 'AMCEWEN', '2004-08-01', 'SA_REP', 9000, .35, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(159, 'Lindsey Smith', '011.44.1345.729268', 'LSMITH', '2005-03-10', 'SA_REP', 8000, .3, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(160, 'Louise Doran', '011.44.1345.629268', 'LDORAN', '2005-12-15', 'SA_REP', 7500, .3, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(161, 'Sarath Sewall', '011.44.1345.529268', 'SSEWALL', '2006-11-03', 'SA_REP', 7000, .25, 146, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(162, 'Clara Vishney', '011.44.1346.129268', 'CVISHNEY', '2005-11-11', 'SA_REP', 10500, .25, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(163, 'Danielle Greene', '011.44.1346.229268', 'DGREENE', '2007-03-19', 'SA_REP', 9500, .15, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(164, 'Mattea Marvins', '011.44.1346.329268', 'MMARVINS', '2008-01-24', 'SA_REP', 7200, .1, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(165, 'David Lee', '011.44.1346.529268', 'DLEE', '2008-02-23', 'SA_REP', 6800, .1, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(166, 'Sundar Ande', '011.44.1346.629268', 'SANDE', '2008-03-24', 'SA_REP', 6400, .1, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(167, 'Amit Banda', '011.44.1346.729268', 'ABANDA', '2008-04-21', 'SA_REP', 6200, .1, 147, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(168, 'Lisa Ozer', '011.44.1343.929268', 'LOZER', '2005-03-11', 'SA_REP', 11500, .25, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(169, 'Harrison Bloom', '011.44.1343.829268', 'HBLOOM', '2006-03-23', 'SA_REP', 10000, .2, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(170, 'Tayler Fox', '011.44.1343.729268', 'TFOX', '2006-01-24', 'SA_REP', 9600, .2, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(171, 'William Smith', '011.44.1343.629268', 'WSMITH', '2007-02-23', 'SA_REP', 7400, .15, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(172, 'Elizabeth Bates', '011.44.1343.529268', 'EBATES', '2007-03-24', 'SA_REP', 7300, .15, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(173, 'Sundita Kumar', '011.44.1343.329268', 'SKUMAR', '2008-04-21', 'SA_REP', 6100, .1, 148, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(174, 'Ellen Abel', '011.44.1644.429267', 'EABEL', '2004-05-11', 'SA_REP', 11000, .3, 149, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(175, 'Alyssa Hutton', '011.44.1644.429266', 'AHUTTON', '2005-03-19', 'SA_REP', 8800, .25, 149, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(176, 'Jonathon Taylor', '011.44.1644.429265', 'JTAYLOR', '2006-03-24', 'SA_REP', 8600, .2, 149, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(177, 'Jack Livingston', '011.44.1644.429264', 'JLIVINGS', '2006-04-23', 'SA_REP', 8400, .2, 149, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(178, 'Kimberely Grant', '011.44.1644.429263', 'KGRANT', '2007-05-24', 'SA_REP', 7000, .15, 149, null);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(179, 'Charles Johnson', '011.44.1644.429262', 'CJOHNSON', '2008-01-04', 'SA_REP', 6200, .1, 149, 80);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(180, 'Winston Taylor', '650.507.9876', 'WTAYLOR', '2006-01-24', 'SH_CLERK', 3200, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(181, 'Jean Fleaur', '650.507.9877', 'JFLEAUR', '2006-02-23', 'SH_CLERK', 3100, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(182, 'Martha Sullivan', '650.507.9878', 'MSULLIVA', '2007-06-21', 'SH_CLERK', 2500, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(183, 'Girard Geoni', '650.507.9879', 'GGEONI', '2008-02-03', 'SH_CLERK', 2800, null, 120, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(184, 'Nandita Sarchand', '650.509.1876', 'NSARCHAN', '2004-01-27', 'SH_CLERK', 4200, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(185, 'Alexis Bull', '650.509.2876', 'ABULL', '2005-02-20', 'SH_CLERK', 4100, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(186, 'Julia Dellinger', '650.509.3876', 'JDELLING', '2006-06-24', 'SH_CLERK', 3400, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(187, 'Anthony Cabrio', '650.509.4876', 'ACABRIO', '2007-02-07', 'SH_CLERK', 3000, null, 121, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(188, 'Kelly Chung', '650.505.1876', 'KCHUNG', '2005-06-14', 'SH_CLERK', 3800, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(189, 'Jennifer Dilly', '650.505.2876', 'JDILLY', '2005-08-13', 'SH_CLERK', 3600, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(190, 'Timothy Gates', '650.505.3876', 'TGATES', '2006-07-11', 'SH_CLERK', 2900, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(191, 'Randall Perkins', '650.505.4876', 'RPERKINS', '2007-12-19', 'SH_CLERK', 2500, null, 122, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(192, 'Sarah Bell', '650.501.1876', 'SBELL', '2004-02-04', 'SH_CLERK', 4000, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(193, 'Britney Everett', '650.501.2876', 'BEVERETT', '2005-03-03', 'SH_CLERK', 3900, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(194, 'Samuel McCain', '650.501.3876', 'SMCCAIN', '2006-07-01', 'SH_CLERK', 3200, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(195, 'Vance Jones', '650.501.4876', 'VJONES', '2007-03-17', 'SH_CLERK', 2800, null, 123, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(196, 'Alana Walsh', '650.507.9811', 'AWALSH', '2006-04-24', 'SH_CLERK', 3100, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(197, 'Kevin Feeney', '650.507.9822', 'KFEENEY', '2006-05-23', 'SH_CLERK', 3000, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(198, 'Donald OConnell', '650.507.9833', 'DOCONNEL', '2007-06-21', 'SH_CLERK', 2600, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(199, 'Douglas Grant', '650.507.9844', 'DGRANT', '2008-01-13', 'SH_CLERK', 2600, null, 124, 50);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(200, 'Jennifer Whalen', '515.123.4444', 'JWHALEN', '2003-09-17', 'AD_ASST', 4400, null, 101, 10);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(201, 'Michael Hartstein', '515.123.5555', 'MHARTSTE', '2004-02-17', 'MK_MAN', 13000, null, 100, 20);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(202, 'Pat Fay', '603.123.6666', 'PFAY', '2005-08-17', 'MK_REP', 6000, null, 201, 20);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(203, 'Susan Mavris', '515.123.7777', 'SMAVRIS', '2002-06-07', 'HR_REP', 6500, null, 101, 40);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(204, 'Hermann Baer', '515.123.8888', 'HBAER', '2002-06-07', 'PR_REP', 10000, null, 101, 70);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(205, 'Shelley Higgins', '515.123.8080', 'SHIGGINS', '2002-06-07', 'AC_MGR', 12008, null, 101, 110);
INSERT INTO hr.empregados (id_empregado, nome, telefone,
email, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(206, 'William Gietz', '515.123.8181', 'WGIETZ', '2002-06-07', 'AC_ACCOUNT', 8300, null, 205, 110);

INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(IT, 1000, '1297 Via Cola di Rie', 'Roma',
 '00989', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(IT, 1100, '93091 Calle della Testa', 'Venice',
 '10934', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(JP, 1200, '2017 Shinjuku-ku', 'Tokyo',
 '1689', 'Tokyo Prefecture');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(JP, 1300, '9450 Kamiya-cho', 'Hiroshima',
 '6823', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(US, 1400, '2014 Jabberwocky Rd', 'Southlake',
 '26192', 'Texas');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(US, 1500, '2011 Interiors Blvd', 'South San Francisco',
 '99236', 'California');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(US, 1600, '2007 Zagora St', 'South Brunswick',
 '50090', 'New Jersey');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(US, 1700, '2004 Charade Rd', 'Seattle',
 '98199', 'Washington');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(CA, 1800, '147 Spadina Ave', 'Toronto',
 'M5V 2L7', 'Ontario');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(CA, 1900, '6092 Boxwood St', 'Whitehorse',
 'YSW 9T2', 'Yukon');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(CN, 2000, '40-5-12 Laogianggen', 'Beijing',
 '190518', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(IN, 2100, '1298 Vileparle (E)', 'Bombay',
 '490231', 'Maharashtra');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(AU, 2200, '12-98 Victoria Street', 'Sydney',
 '2901', 'New South Wales');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(SG, 2300, '198 Clementi North', 'Singapore',
 '540198', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(UK, 2400, '8204 Arthur St', 'London',
 '', '');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(UK, 2500, 'Magdalen Centre, The Oxford Science Park', 'Oxford',
 'OX9 9ZB', 'Oxford');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(UK, 2600, '9702 Chester Road', 'Stretford',
 '09629850293', 'Manchester');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(DE, 2700, 'Schwanthalerstr. 7031', 'Munich',
 '80925', 'Bavaria');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(BR, 2800, 'Rua Frei Caneca 1360 ', 'Sao Paulo',
 '01307-002', 'Sao Paulo');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(CH, 2900, '20 Rue des Corps-Saints', 'Geneva',
 '1730', 'Geneve');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(CH, 3000, 'Murtenstrasse 921', 'Bern',
 '3095', 'BE');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(NL, 3100, 'Pieter Breughelstraat 837', 'Utrecht',
 '3029SK', 'Utrecht');
INSERT INTO hr.localizacoes (id_pais, id_localizacao, endereco, cidade, cep, uf) VALUES
(MX, 3200, 'Mariano Escobedo 9991', 'Mexico City',
 '11932', 'Distrito Federal,');

INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('President', 'AD_PRES', 20080, 40000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Administration Vice President', 'AD_VP', 15000, 30000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Administration Assistant', 'AD_ASST', 3000, 6000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Finance Manager', 'FI_MGR', 8200, 16000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Accountant', 'FI_ACCOUNT', 4200, 9000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Accounting Manager', 'AC_MGR', 8200, 16000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Public Accountant', 'AC_ACCOUNT', 4200, 9000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Sales Manager', 'SA_MAN', 10000, 20080);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Sales Representative', 'SA_REP', 6000, 12008);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Purchasing Manager', 'PU_MAN', 8000, 15000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Purchasing Clerk', 'PU_CLERK', 2500, 5500);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Stock Manager', 'ST_MAN', 5500, 8500);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Stock Clerk', 'ST_CLERK', 2008, 5000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Shipping Clerk', 'SH_CLERK', 2500, 5500);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Programmer', 'IT_PROG', 4000, 10000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Marketing Manager', 'MK_MAN', 9000, 15000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Marketing Representative', 'MK_REP', 4000, 9000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Human Resources Representative', 'HR_REP', 4000, 9000);
INSERT INTO hr.cargos (cargo, id_cargo, salario_minimo, salario_maximo) VALUES
('Public Relations Representative', 'PR_REP', 4500, 10500);

INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(102, '60' , IT_PROG , '2001-01-13', '2006-07-24');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(101, '110' , AC_ACCOUNT , '1997-09-21', '2001-10-27');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(101, '110' , AC_MGR , '2001-10-28', '2005-03-15');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(201, '20' , MK_REP , '2004-02-17', '2007-12-19');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(114, '50' , ST_CLERK , '2006-03-24', '2007-12-31');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(122, '50' , ST_CLERK , '2007-01-01', '2007-12-31');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(200, '90' , AD_ASST , '1995-09-17', '2001-06-17');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(176, '80' , SA_REP , '2006-03-24', '2006-12-31');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(176, '80' , SA_MAN , '2007-01-01', '2007-12-31');
INSERT INTO hr.historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(200, '90' , AC_ACCOUNT , '2002-07-01', '2006-12-31');

INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(10, 200, 1700, 'Administration');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(20, 201, 1800, 'Marketing');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(30, 114, 1700, 'Purchasing');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(40, 203, 2400, 'Human Resources');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(50, 121, 1500, 'Shipping');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(60, 103, 1400, 'IT');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(70, 204, 2700, 'Public Relations');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(80, 145, 2500, 'Sales');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(90, 100, 1700, 'Executive');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(100, 108, 1700, 'Finance');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(110, 205, 1700, 'Accounting');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(120, , 1700, 'Treasury');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(130, , 1700, 'Corporate Tax');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(140, , 1700, 'Control And Credit');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(150, , 1700, 'Shareholder Services');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(160, , 1700, 'Benefits');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(170, , 1700, 'Manufacturing');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(180, , 1700, 'Construction');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(190, , 1700, 'Contracting');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(200, , 1700, 'Operations');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(210, , 1700, 'IT Support');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(220, , 1700, 'NOC');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(230, , 1700, 'IT Helpdesk');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(240, , 1700, 'Government Sales');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(250, , 1700, 'Retail Sales');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(260, , 1700, 'Recruiting');
INSERT INTO hr.departamentos (id_departamento, id_gerente, id_localizacao, nome) VALUES
(270, , 1700, 'Payroll');

INSERT INTO hr.regioes (id_regiao, nome) VALUES
(1, 'Europe');
INSERT INTO hr.regioes (id_regiao, nome) VALUES
(2, 'Americas');
INSERT INTO hr.regioes (id_regiao, nome) VALUES
(3, 'Asia');
INSERT INTO hr.regioes (id_regiao, nome) VALUES
(4, 'Middle East and Africa');

INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(AR, '2', 'Argentina');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(AU, '3', 'Australia');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(BE, '1', 'Belgium');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(BR, '2', 'Brazil');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(CA, '2', 'Canada');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(CH, '1', 'Switzerland');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(CN, '3', 'China');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(DE, '1', 'Germany');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(DK, '1', 'Denmark');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(EG, '4', 'Egypt');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(FR, '1', 'France');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(IL, '4', 'Israel');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(IN, '3', 'India');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(IT, '1', 'Italy');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(JP, '3', 'Japan');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(KW, '4', 'Kuwait');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(ML, '3', 'Malaysia');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(MX, '2', 'Mexico');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(NG, '4', 'Nigeria');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(NL, '1', 'Netherlands');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(SG, '3', 'Singapore');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(UK, '1', 'United Kingdom');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(US, '2', 'United States of America');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(ZM, '4', 'Zambia');
INSERT INTO hr.paises (id_paises,id_regiao, nome) VALUES
(ZW, '4', 'Zimbabwe');
