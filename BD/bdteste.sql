create database IMBOBILIARIA;

create table pessoa(
cpf int primary key,
nome varchar(50) not null,
telefone1 int,
telefone2 int
);

create table imovel (
codigo  int primary key,
numero int,
cep int not null,
bairro varchar(50)not null,
rua varchar(50) not null,
construtora varchar(50) unique not null,
fk_dono varchar(50),
constraint fk_proprietario foreign key(fk_dono) references pessoa(cpf)
);

create table casa(
qtd_quartos int not null,
fk_imovel_codigo varchar(50),
foreign key(fk_imovel_codigo) references imovel (codigo)
);

create table predio(
qtd_andares int not null,
fk_imovel_codigo varchar(50),
foreign key(fk_imovel_codigo) references imovel (codigo)
);

create table apartamento(
numero int primary key,
qtd_quartos int not null,
vagas_garagem int default 0,
fk_predio_fkimovel_codigo varchar(50),
foreign key(fk_predio_fkimovel_codigo) references predio (fk_imovel_codigo)
);

create table aluga(
data_inicio date,
tempo_locacao_meses int not null,
fk_pessoa_cpf varchar(50),
fk_imovel_codigo varchar(50),
foreign key(fk_pessoa_cpf) references pessoa (cpf),
foreign key(fk_imovel_codigo) references imovel (codigo)
);
