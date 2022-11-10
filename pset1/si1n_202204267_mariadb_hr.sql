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
    id_departamentos integer,
    nome character varying(75) NOT NULL,
    email character varying(35) NOT NULL,
    telefone character varying(20),
    data_contratacao date NOT NULL,
    id_cargo character varying(10),
    salario numeric(8,2),
    comissao numeric(4,2),
    id_supervisor integer,
    CONSTRAINT id_empregados_pk PRIMARY KEY (id_empregado),
    CONSTRAINT ak_email UNIQUE (email),
    CONSTRAINT salario_check CHECK (salario >= 0)
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



