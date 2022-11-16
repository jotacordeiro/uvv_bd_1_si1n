/* PROJETO_BD_UVV DESDE A CRIAÇÃO DO BANCO DE DADOS ATÉ A FINALIZAÇÃO COM INSERÇÃO DE DADOS: */

/* CRIANDO BANCO DE DADOS 'UVV' */

CREATE DATABASE uvv CHARACTER SET = 'UTF8';

/* CRIANDO O USUÁRIO: */

CREATE USER jv_cordeiro@localhost;

/* CONECTANDO AO BANCO DE DADOS: */

USE uvv;


/* CRIANDO AS TABELAS: */

CREATE TABLE IF NOT EXISTS cargo
(
    id_cargo_pk character varying(10) NOT NULL,
    cargo character varying(35) NOT NULL,
    salario_minimo numeric(8,2),
    salario_maximo numeric(8,2),
    CONSTRAINT cargo_pk PRIMARY KEY (id_cargo_pk),
    CONSTRAINT ak_cargo UNIQUE (cargo)
);


CREATE TABLE IF NOT EXISTS regioes
(
    id_regiao integer NOT NULL,
    nome character varying(25),
    CONSTRAINT id_regiao_pk PRIMARY KEY (id_regiao),
    CONSTRAINT ak_regiao UNIQUE (nome)
);


CREATE TABLE IF NOT EXISTS paises
(
    id_pais character(2) NOT NULL,
    id_regiao integer,
    nome character varying(50),
    CONSTRAINT id_pais_pk PRIMARY KEY (id_pais),
    CONSTRAINT ak_pais UNIQUE (nome)
);



CREATE TABLE IF NOT EXISTS localizacoes
(
    id_localizacoes_pk integer NOT NULL,
    id_pais character(2),
    endereco character varying(50),
    cep character varying(12),
    cidade character varying(50)  NOT NULL,
    uf character varying(25),
    CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacoes_pk)
);


CREATE TABLE IF NOT EXISTS departamentos
(
    id_departamentos integer NOT NULL,
    id_gerente integer,
    nome character varying(50) NOT NULL,
    id_localizacao integer,    
    CONSTRAINT id_departamentos_pk PRIMARY KEY (id_departamentos),
    CONSTRAINT ak_departamento UNIQUE (nome)
);

 


CREATE TABLE IF NOT EXISTS empregados
(
    id_empregado integer NOT NULL,
    nome character varying(75) NOT NULL,
    email character varying(35) NOT NULL,
    telefone character varying(20),
    data_contratacao date NOT NULL,
    id_cargo character varying(10),
    salario numeric(8,2),
    comissao numeric(4,2),
    id_departamentos integer,
    id_supervisor integer,
    CONSTRAINT id_empregados_pk PRIMARY KEY (id_empregado),
    CONSTRAINT ak_email UNIQUE (email),
);
	



CREATE TABLE IF NOT EXISTS historico_cargos
(
    id_empregado_1 integer NOT NULL,
    id_departamentos integer,
    data_inicial date NOT NULL,
    data_final date NOT NULL,
    id_cargo character varying(10) NOT NULL,
    CONSTRAINT id_empregado_data_inicial_pk PRIMARY KEY (id_empregado_1, data_inicial)
);



-- INSERINDO DADOS NAS TABELAS


INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(IT, 1000, '1297 Via Cola di Rie', 'Roma',
 '00989', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(IT, 1100, '93091 Calle della Testa', 'Venice',
 '10934', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(JP, 1200, '2017 Shinjuku-ku', 'Tokyo',
 '1689', 'Tokyo Prefecture');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(JP, 1300, '9450 Kamiya-cho', 'Hiroshima',
 '6823', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(US, 1400, '2014 Jabberwocky Rd', 'Southlake',
 '26192', 'Texas');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(US, 1500, '2011 Interiors Blvd', 'South San Francisco',
 '99236', 'California');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(US, 1600, '2007 Zagora St', 'South Brunswick',
 '50090', 'New Jersey');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(US, 1700, '2004 Charade Rd', 'Seattle',
 '98199', 'Washington');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(CA, 1800, '147 Spadina Ave', 'Toronto',
 'M5V 2L7', 'Ontario');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(CA, 1900, '6092 Boxwood St', 'Whitehorse',
 'YSW 9T2', 'Yukon');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(CN, 2000, '40-5-12 Laogianggen', 'Beijing',
 '190518', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(IN, 2100, '1298 Vileparle (E)', 'Bombay',
 '490231', 'Maharashtra');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(AU, 2200, '12-98 Victoria Street', 'Sydney',
 '2901', 'New South Wales');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(SG, 2300, '198 Clementi North', 'Singapore',
 '540198', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(UK, 2400, '8204 Arthur St', 'London',
 '', '');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(UK, 2500, 'Magdalen Centre, The Oxford Science Park', 'Oxford',
 'OX9 9ZB', 'Oxford');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(UK, 2600, '9702 Chester Road', 'Stretford',
 '09629850293', 'Manchester');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(DE, 2700, 'Schwanthalerstr. 7031', 'Munich',
 '80925', 'Bavaria');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(BR, 2800, 'Rua Frei Caneca 1360 ', 'Sao Paulo',
 '01307-002', 'Sao Paulo');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(CH, 2900, '20 Rue des Corps-Saints', 'Geneva',
 '1730', 'Geneve');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(CH, 3000, 'Murtenstrasse 921', 'Bern',
 '3095', 'BE');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(NL, 3100, 'Pieter Breughelstraat 837', 'Utrecht',
 '3029SK', 'Utrecht');
INSERT INTO localizacoes (id_pais, id_localizacoes_pk, endereco, cidade, cep, uf) VALUES
(MX, 3200, 'Mariano Escobedo 9991', 'Mexico City',
 '11932', 'Distrito Federal,');

INSERT INTO cargo (id_cargo_pk, cargo, salario_minimo, salario_maximo) VALUES
('AD_PRES', 'President', 20080,40000 ),
('AD_VP', 'Administration Vice President', 15000,30000 ),
('AD_ASST', 'Administration Assistant', 3000,6000 ),
('FI_MGR', 'Finance Manager', 8200,16000 ),
('FI_ACCOUNT', 'Accountant', 4200,9000 ),
('AC_MGR', 'Accounting Manager', 8200,16000 ),
('AC_ACCOUNT', 'Public Accountant', 4200,9000 ),
('SA_MAN', 'Sales Manager', 10000,20080 ),
('SA_REP', 'Sales Representative', 6000,12008 ),
('PU_MAN', 'Purchasing Manager', 8000,15000 ),
('PU_CLERK', 'Purchasing Clerk', 2500,5500 ),
('ST_MAN', 'Stock Manager', 5500,8500 ),
('ST_CLERK', 'Stock Clerk', 2008,5000 ),
('SH_CLERK', 'Shipping Clerk', 2500,5500 ),
('IT_PROG', 'Programmer', 4000,10000 ),
('MK_MAN', 'Marketing Manager', 9000,15000 ),
('MK_REP', 'Marketing Representative', 4000,9000 ),
('HR_REP', 'Human Resources Representative', 4000,9000 ),
('PR_REP', 'Public Relations Representative', 4500,10500 );


INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(102, '60' , IT_PROG , '2001-01-13', '2006-07-24');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(101, '110' , AC_ACCOUNT , '1997-09-21', '2001-10-27');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(101, '110' , AC_MGR , '2001-10-28', '2005-03-15');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(201, '20' , MK_REP , '2004-02-17', '2007-12-19');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(114, '50' , ST_CLERK , '2006-03-24', '2007-12-31');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(122, '50' , ST_CLERK , '2007-01-01', '2007-12-31');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(200, '90' , AD_ASST , '1995-09-17', '2001-06-17');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(176, '80' , SA_REP , '2006-03-24', '2006-12-31');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(176, '80' , SA_MAN , '2007-01-01', '2007-12-31');
INSERT INTO historico_cargos (id_empregado_1, id_departamento, id_cargo, data_inicial, data_final) VALUES
(200, '90' , AC_ACCOUNT , '2002-07-01', '2006-12-31');

INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(10, 200, 1700, 'Administration');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(20, 201, 1800, 'Marketing');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(30, 114, 1700, 'Purchasing');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(40, 203, 2400, 'Human Resources');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(50, 121, 1500, 'Shipping');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(60, 103, 1400, 'IT');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(70, 204, 2700, 'Public Relations');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(80, 145, 2500, 'Sales');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(90, 100, 1700, 'Executive');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(100, 108, 1700, 'Finance');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(110, 205, 1700, 'Accounting');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(120, , 1700, 'Treasury');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(130, , 1700, 'Corporate Tax');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(140, , 1700, 'Control And Credit');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(150, , 1700, 'Shareholder Services');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(160, , 1700, 'Benefits');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(170, , 1700, 'Manufacturing');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(180, , 1700, 'Construction');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(190, , 1700, 'Contracting');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(200, , 1700, 'Operations');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(210, , 1700, 'IT Support');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(220, , 1700, 'NOC');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(230, , 1700, 'IT Helpdesk');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(240, , 1700, 'Government Sales');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(250, , 1700, 'Retail Sales');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(260, , 1700, 'Recruiting');
INSERT INTO departamentos (id_departamentos, id_gerente, id_localizacao, nome) VALUES
(270, , 1700, 'Payroll');

INSERT INTO regioes (id_regiao, nome) VALUES
(1, 'Europe');
INSERT INTO regioes (id_regiao, nome) VALUES
(2, 'Americas');
INSERT INTO regioes (id_regiao, nome) VALUES
(3, 'Asia');
INSERT INTO regioes (id_regiao, nome) VALUES
(4, 'Middle East and Africa');

INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(AR, '2', 'Argentina');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(AU, '3', 'Australia');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(BE, '1', 'Belgium');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(BR, '2', 'Brazil');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(CA, '2', 'Canada');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(CH, '1', 'Switzerland');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(CN, '3', 'China');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(DE, '1', 'Germany');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(DK, '1', 'Denmark');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(EG, '4', 'Egypt');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(FR, '1', 'France');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(IL, '4', 'Israel');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(IN, '3', 'India');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(IT, '1', 'Italy');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(JP, '3', 'Japan');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(KW, '4', 'Kuwait');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(ML, '3', 'Malaysia');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(MX, '2', 'Mexico');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(NG, '4', 'Nigeria');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(NL, '1', 'Netherlands');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(SG, '3', 'Singapore');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(UK, '1', 'United Kingdom');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(US, '2', 'United States of America');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(ZM, '4', 'Zambia');
INSERT INTO paises (id_pais,id_regiao, nome) VALUES
(ZW, '4', 'Zimbabwe');

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, null, null, 90);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, null, 100, 90);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, null, 100, 90);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, null, 102, 60);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, null, 103, 60);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, null, 103, 60);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, null, 103, 60);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, null, 103, 60);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(108, 'Nancy Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008, null, 101, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, null, 108, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, null, 108, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, null, 108, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, null, 108, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, null, 108, 100);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(114, 'Den Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000, null, 100, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, null, 114, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, null, 114, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, null, 114, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, null, 114, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, null, 114, 30);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, null, 100, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, null, 100, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, null, 100, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, null, 100, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, null, 100, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(145, 'John Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000, .4, 100, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, .3, 100, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(147, 'Alberto Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000, .3, 100, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(148, 'Gerald Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000, .3, 100, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(149, 'Eleni Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500, .2, 100, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(150, 'Peter Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000, .3, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(151, 'David Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500, .25, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(152, 'Peter Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000, .25, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(153, 'Christopher Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000, .2, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(154, 'Nanette Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500, .2, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(155, 'Oliver Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000, .15, 145, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(156, 'Janette King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000, .35, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(157, 'Patrick Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500, .35, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(158, 'Allan McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000, .35, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(159, 'Lindsey Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000, .3, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(160, 'Louise Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500, .3, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(161, 'Sarath Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000, .25, 146, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(162, 'Clara Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500, .25, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(163, 'Danielle Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500, .15, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(164, 'Mattea Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200, .1, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(165, 'David Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800, .1, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(166, 'Sundar Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400, .1, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(167, 'Amit Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200, .1, 147, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(168, 'Lisa Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500, .25, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(169, 'Harrison Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000, .2, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(170, 'Tayler Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600, .2, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(171, 'William Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400, .15, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(172, 'Elizabeth Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300, .15, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(173, 'Sundita Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100, .1, 148, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(174, 'Ellen Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000, .3, 149, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(175, 'Alyssa Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800, .25, 149, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(176, 'Jonathon Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600, .2, 149, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(177, 'Jack Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400, .2, 149, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(178, 'Kimberely Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000, .15, 149, null);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(179, 'Charles Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200, .1, 149, 80);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(180, 'Winston Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(181, 'Jean Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(182, 'Martha Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(183, 'Girard Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800, null, 120, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(184, 'Nandita Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(185, 'Alexis Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(186, 'Julia Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(187, 'Anthony Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000, null, 121, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(188, 'Kelly Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(189, 'Jennifer Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(190, 'Timothy Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(191, 'Randall Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500, null, 122, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(192, 'Sarah Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(193, 'Britney Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(194, 'Samuel McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(195, 'Vance Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800, null, 123, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(196, 'Alana Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(197, 'Kevin Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(198, 'Donald OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(199, 'Douglas Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600, null, 124, 50);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(200, 'Jennifer Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400, null, 101, 10);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(201, 'Michael Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000, null, 100, 20);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(202, 'Pat Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000, null, 201, 20);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(203, 'Susan Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500, null, 101, 40);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(204, 'Hermann Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000, null, 101, 70);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(205, 'Shelley Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008, null, 101, 110);

INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamentos) VALUES
(206, 'William Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300, null, 205, 110);
