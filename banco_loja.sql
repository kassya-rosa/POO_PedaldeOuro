create database bco_loja;
use bco_loja;
/*******************************************************************************/
/*********************************** TABELAS ***********************************/
/*******************************************************************************/
 
-- create table endereco_logradouro (
-- 	id_endereco int(3) not null auto_increment primary key,
--     cep_logradouro varchar(10) not null,
--     cidade_logradouro varchar(100) not null,
--     uf_logradouro varchar(50) not null,
--     numero_logradouro int(10) not null,
--     complemento_logradouro varchar(100),
--     bairro_logradouro varchar(100) not null
-- );

create table comprador (
	nome_cliente varchar(50) not null,
    senha_funci int(6) not null,
	CPF_CNPJ varchar(20) not null primary key
);

create table vendedor (
	CPF_CNPJ varchar(20) not null primary key,
    nome_cliente varchar(50) not null,
    id_endereco int(3),
    dt_nasc date not null,
    tp_pessoa tinyint(1) not null
);

create table administrador (
	CPF varchar(20) not null primary key,
    nome_funcionario varchar(50) not null
);

create table pecas (
	id_peca int(3) not null auto_increment primary key,
    CPF_CNPJ varchar(20)not null,
    qtd_peca int(3) not null,
    nome_peca varchar(50) not null,
    vl_ref decimal(15,2) not null,
    vl_venda decimal(15,2) not null,
    constraint fk_fornecedor foreign key (CPF_CNPJ) references vendedor(CPF_CNPJ)
);

create table categoria (
	id_peca int(3) not null auto_increment primary key,
    nome_cat varchar(50) not null,
    constraint fk_peca_cat foreign key (id_peca) references pecas(id_peca)
);

create table compra (
	id_venda int(3) not null auto_increment primary key,
    id_peca int(3),
    preco_venda float(5,2) not null,
    qtd_venda int(3) not null,
    CPF_CNPJ varchar(20) not null,
    constraint fk_comprador foreign key (CPF_CNPJ) references comprador(CPF_CNPJ),
    constraint fk_peca_vendida foreign key (id_peca) references pecas(id_peca)
);

create table finalizar_compra (
    id_venda int(3) not null,
    id_peca int(3) not null,
    CPF_CNPJ varchar(20) not null,
    qtd_venda int(3) not null,
    constraint fk_peca_comprada foreign key (id_peca) references compra(id_peca),
    constraint fk_id_venda foreign key (id_venda) references compra(id_venda),
    constraint fk_CPF_compra foreign key (CPF_CNPJ) references compra(CPF_CNPJ)
);

create table login_adm(
	CPF varchar(20) not null,
    senha_funci int(6) not null,
    constraint fk_cpf_funci foreign key (CPF) references administrador(CPF)
);

create table login_comprador(
	CPF_CNPJ varchar(20) not null,
    senha_funci int(6) not null,
    constraint fk_cpf_comprador foreign key (CPF_CNPJ) references comprador(CPF_CNPJ)
);

create table login_vendedor(
	CPF_CNPJ varchar(20) not null,
    senha_funci int(6) not null,
    constraint fk_cpf_vendedor foreign key (CPF_CNPJ) references vendedor(CPF_CNPJ)
);

create table favoritos(
	id_peca int(3) not null,
    CPF_CNPJ varchar(20) not null,
    marca_favorito tinyint(1) not null,
    constraint fk_id_cliente_fav foreign key (CPF_CNPJ) references comprador(CPF_CNPJ),
    constraint fk_peca_fav foreign key (id_peca) references pecas(id_peca)
);

/*******************************************************************************/
/********************************* POPULAÇÃO ***********************************/
/*******************************************************************************/

-- insert into endereco_logradouro values (0,"70700-250", "Brasilia", "DF", 2355, "Bloco A ap 110", "Asa Sul");
-- insert into endereco_logradouro values (0,"72350-150", "Brasilia", "DF", 530, null, "Pirapora");
-- insert into endereco_logradouro values (0,"71945-230", "Brasilia", "DF", 3155, "ap 203", "Águas Claras");
-- insert into endereco_logradouro values (0,"70742-110", "Brasilia", "DF", 5500, "Bloco B ap 45", "Asa Sul");
-- insert into endereco_logradouro values (0,"73586-250", "Brasilia", "DF", 75, null, "Pirapora");
-- insert into endereco_logradouro values (0,"71930-200", "Brasilia", "DF", 410, "ap 1004 bl C", "Águas Claras");
-- insert into endereco_logradouro values (0,"72410-150", "Brasilia", "DF", 670, null, "Pirapora");
-- insert into endereco_logradouro values (0,"70750-000", "Brasilia", "DF", 190, "Bloco H ap 76", "Asa Norte");
-- insert into endereco_logradouro values (0,"72700-002", "Brasilia", "DF", 735, null, "Pirapora");
-- insert into endereco_logradouro values (0,"73700-050", "Brasilia", "DF", 684, null, "Pirapora");

/*select * from endereco_logradouro;*/

insert into comprador values ("Maria Eduarda dos Santos", 123456, "001.555.333-75");
insert into comprador values ("José dos Santos", 234567 ,"100.666.444-57");

select * from comprador;

insert into vendedor values ("12.754.862/0001-01", "Bike aventura", 10, "2018-02-25", 2);
insert into vendedor values ("23.258.654/0001-01", "Outdoor em duas rodas", 7, "2000-10-10", 2);

/*select * from vendedor;*/

insert into administrador values ("112.667.441-41", "Márcio Souza");
insert into administrador values ("001.555.336-75", "João dos Santos");

/*select * from administrador;*/

insert into pecas values (0, "12.754.862/0001-01", 215, "Correia dentada", 20.15, 30.00);
insert into pecas values (0, "12.754.862/0001-01", 215, "Farol de bicicleta elétrica", 60.15, 90.00);
insert into pecas values (0, "12.754.862/0001-01", 215, "Chave de contato/ ignição", 120.15, 130.00);
insert into pecas values (0, "12.754.862/0001-01", 215, "Kit de ferramentas", 20.15, 30.00);
insert into pecas values (0, "23.258.654/0001-01", 215, "Correia dentada", 10.15, 13.00);
insert into pecas values (0, "23.258.654/0001-01", 215, "Motor 350w 48v", 520.00, 600.00);
insert into pecas values (0, "23.258.654/0001-01", 215, "Tanque 3l", 130.10, 160.00);
insert into pecas values (0, "23.258.654/0001-01", 215, "Cadeirinha", 120.30, 150.00);
insert into pecas values (0, "23.258.654/0001-01", 215, "Jogo de chaves alien", 10.10, 15.00);
insert into pecas values (0, "12.754.862/0001-01", 215, "Kit espátula pneu", 13.00, 20.00);

/*select * from pecas;*/

insert into categoria values (1, "bicicleta elétrica");
insert into categoria values (2, "bicicleta elétrica");
insert into categoria values (3, "bicicleta elétrica");
insert into categoria values (4, "acessórios");
insert into categoria values (5, "bicicleta manual");
insert into categoria values (6, "acessórios");
insert into categoria values (7, "acessórios");
insert into categoria values (8, "acessórios");
insert into categoria values (9, "acessórios");
insert into categoria values (10, "acessórios");

/*select * from categoria;*/

insert into compra values (0, 5, 12.85, 5, "001.555.333-75");
insert into compra values (0, 10, 11.85, 2, "001.555.333-75");
insert into compra values (0, 2, 60.85, 5, "100.666.444-57");
insert into compra values (0, 1, 61.00, 2, "100.666.444-57");

select * from compra;

insert into finalizar_compra values (2, 5, "001.555.333-75", 5);
insert into finalizar_compra values (3, 10, "001.555.333-75", 2);
insert into finalizar_compra values (4, 2, "100.666.444-57", 5);
insert into finalizar_compra values (5, 1, "100.666.444-57", 2);

/*select * from finalizar_compra;*/

insert into login_adm values ("112.667.441-41", 123456);
insert into login_adm values ("001.555.336-75", 456789);

/*select * from login_adm;*/

insert into login_comprador values ("001.555.333-75", 147258);
insert into login_comprador values ("100.666.444-57", 258369);

/*select * from login_comprador;*/

insert into login_vendedor values ("12.754.862/0001-01", 963852);
insert into login_vendedor values ("23.258.654/0001-01", 741852);

/*select * from login_vendedor;*/

insert into favoritos values (2,"001.555.333-75",1);
insert into favoritos values (3,"001.555.333-75",1);
insert into favoritos values (5,"100.666.444-57",1);
insert into favoritos values (4,"100.666.444-57",1);

/*select * from favoritos;*/
