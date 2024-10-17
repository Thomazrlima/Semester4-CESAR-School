create database if not exists IMOBILIARIA;

use IMOBILIARIA;

create table if not exists pessoa(
    cpf int primary key,
    nome varchar(50) not null,
    telefone1 int,
    telefone2 int
);

create table if not exists imovel (
    codigo  int primary key,
    numero int,
    cep int not null,
    bairro varchar(50) not null,
    rua varchar(50) not null,
    construtora varchar(50) unique not null,
    fk_dono int,
    constraint fk_proprietario foreign key(fk_dono) references pessoa(cpf)
);

create table if not exists casa(
    qtd_quartos int not null,
    fk_imovel_codigo int,
    foreign key(fk_imovel_codigo) references imovel(codigo)
);

create table if not exists predio(
    qtd_andares int not null,
    fk_imovel_codigo int unique,
    foreign key(fk_imovel_codigo) references imovel(codigo)
);

create table if not exists apartamento(
    numero int primary key,
    qtd_quartos int not null,
    vagas_garagem int default 0,
    fk_predio_fkimovel_codigo int,
    foreign key(fk_predio_fkimovel_codigo) references predio(fk_imovel_codigo)
);

create table if not exists aluga(
    data_inicio date,
    tempo_locacao_meses int not null,
    fk_pessoa_cpf int,
    fk_imovel_codigo int,
    primary key (data_inicio, fk_pessoa_cpf, fk_imovel_codigo),
    foreign key (fk_pessoa_cpf) references pessoa(cpf),
    foreign key (fk_imovel_codigo) references imovel(codigo)
);



insert into pessoa(cpf, nome, telefone1) values (090, 'Sofia', '81999696593')
insert into pessoa(cpf, nome, telefone1) values (080, 'Thomaz', '81996037453')
insert into pessoa(cpf, nome, telefone1) values (070, 'Evaldo', '81998090909');
insert into pessoa(cpf, nome, telefone1) values (060, 'Pedro', '81998090922');
insert into pessoa(cpf, nome, telefone1) values (050, 'André', '81998090933');


INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora) 
VALUES (1, 101, 50060230, 'Boa Vista', 'Rua da Aurora', 'Construtora A');

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora) 
VALUES (2, 202, 51020300, 'Pina', 'Avenida Boa Viagem', 'Construtora B');

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora) 
VALUES (3, 303, 52060400, 'Casa Forte', 'Rua Santana', 'Construtora C');

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora) 
VALUES (4, 404, 53010230, 'Olinda', 'Rua do Sol', 'Construtora D');

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora) 
VALUES (5, 505, 50710000, 'Madalena', 'Rua Benfica', 'Construtora E');

DELETE FROM imovel;

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (1, 101, 50060230, 'Boa Vista', 'Rua da Aurora', 'Construtora A', 090);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (2, 202, 51020300, 'Pina', 'Avenida Boa Viagem', 'Construtora B', 080);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (3, 303, 52060400, 'Casa Forte', 'Rua Santana', 'Construtora C', 070);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (4, 404, 53010230, 'Olinda', 'Rua do Sol', 'Construtora D', 060);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (5, 505, 50710000, 'Madalena', 'Rua Benfica', 'Construtora E', 050);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (6, 606, 51020400, 'Graças', 'Rua das Flores', 'Construtora F', 090);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (7, 707, 50060500, 'Afogados', 'Avenida das Acácias', 'Construtora G', 080);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (8, 808, 52060500, 'Espinheiro', 'Rua do Parque', 'Construtora H', 070);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (9, 909, 53010300, 'Jardim São Paulo', 'Rua das Palmeiras', 'Construtora I', 060);

INSERT INTO imovel (codigo, numero, cep, bairro, rua, construtora, fk_dono) 
VALUES (10, 1010, 50720000, 'Bandeira', 'Rua do Comércio', 'Construtora J', 050);

INSERT INTO predio (qtd_andares, fk_imovel_codigo) 
VALUES (11, 1);

INSERT INTO predio (qtd_andares, fk_imovel_codigo) 
VALUES (5, 2);

INSERT INTO predio (qtd_andares, fk_imovel_codigo) 
VALUES (8, 3);

INSERT INTO predio (qtd_andares, fk_imovel_codigo) 
VALUES (2, 4);

INSERT INTO predio (qtd_andares, fk_imovel_codigo) 
VALUES (2, 5);

INSERT INTO casa (qtd_quartos, fk_imovel_codigo) 
VALUES (2, 6);

INSERT INTO casa (qtd_quartos, fk_imovel_codigo) 
VALUES (5, 7);

INSERT INTO casa (qtd_quartos, fk_imovel_codigo) 
VALUES (3, 8);

INSERT INTO casa (qtd_quartos, fk_imovel_codigo) 
VALUES (1, 9);

INSERT INTO casa (qtd_quartos, fk_imovel_codigo) 
VALUES (0, 10);

INSERT INTO aluga (data_inicio, tempo_locacao_meses, fk_pessoa_cpf, fk_imovel_codigo) 
VALUES ('2024-01-01', 12, 090, 6);

INSERT INTO aluga (data_inicio, tempo_locacao_meses, fk_pessoa_cpf, fk_imovel_codigo) 
VALUES ('2024-02-01', 6, 080, 7);

INSERT INTO aluga (data_inicio, tempo_locacao_meses, fk_pessoa_cpf, fk_imovel_codigo) 
VALUES ('2024-03-01', 24, 070, 8);

INSERT INTO aluga (data_inicio, tempo_locacao_meses, fk_pessoa_cpf, fk_imovel_codigo) 
VALUES ('2024-04-01', 18, 060, 9);

INSERT INTO aluga (data_inicio, tempo_locacao_meses, fk_pessoa_cpf, fk_imovel_codigo) 
VALUES ('2024-05-01', 12, 050, 10);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (1, 2, 1, 1);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (2, 3, 2, 1);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (5, 1, 0, 2);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (9, 2, 1, 2);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (10, 2, 1, 3);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (11, 2, 1, 3);

INSERT INTO apartamento (numero, qtd_quartos, vagas_garagem, fk_predio_fkimovel_codigo) 
VALUES (12, 2, 1, 3);

DELETE FROM apartamento 
WHERE numero > 10;

DELETE FROM apartamento 
WHERE numero < 1;

UPDATE apartamento
SET numero = CASE 
    WHEN numero = 5 THEN 55
    WHEN numero = 6 THEN 616
END
WHERE numero IN (5, 6);


