create database novo_bd;

create table cliente(
id int primary key,
nome varchar(50) unique,
dt_nascimento date
);

INSERT INTO cliente VALUES
(2, 'Emanuel', '2002-11-09'),
(3, 'André', '2004-06-07'),
(4, 'Sofia', '2004-03-19');

select * from cliente where nome like 'E%'