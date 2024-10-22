CREATE DATABASE EVENTO;-- CRIAÇÃO DO BANCO DE DADOS
USE EVENTO; -- SETANDO O BANCO QUE SERÁ UTILIZADO A PARTIR DAQUI

-- CRIAÇÃO DAS TABELAS
CREATE TABLE Cliente (
  cod_cliente INT ,
  nome VARCHAR(45) ,
  telefone VARCHAR(45) ,
  rua VARCHAR(45) ,
  bairro VARCHAR(45) ,
  numero VARCHAR(45) ,
  complemento VARCHAR(45) ,
  CEP VARCHAR(45) ,
  PRIMARY KEY (cod_cliente));

CREATE TABLE local_evento (
  cod_local INT ,
  nome_local VARCHAR(45) ,
  descricao VARCHAR(45) ,
  PRIMARY KEY (cod_local));

CREATE TABLE Evento(
  cod_evento INT,
  descricao VARCHAR(45) ,
  data DATE,
  horario VARCHAR(45) ,
  valor FLOAT,
  Local_cod_Local1 INT,
  Cliente_cod_cliente INT ,
  PRIMARY KEY (cod_evento),
  CONSTRAINT fk_Evento_Local
    FOREIGN KEY (Local_cod_local1)
    REFERENCES local_evento (cod_local)
    ON DELETE NO ACTION -- Rejeita a atualização/exclusão de um registro da tabela pai, se tiverem registros na tabela filha
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Evento_Cliente1
    FOREIGN KEY (Cliente_cod_cliente)
    REFERENCES Cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE  Reserva (
  cod_reserva INT,
  data DATE ,
  horario VARCHAR(45),
  Cliente_cod_cliente INT ,
  Evento_cod_Evento INT ,
  PRIMARY KEY (cod_reserva),
  CONSTRAINT fk_Reserva_Cliente1
    FOREIGN KEY (Cliente_cod_cliente)
    REFERENCES Cliente (cod_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Reserva_Evento
    FOREIGN KEY (Evento_cod_Evento)
    REFERENCES Evento (cod_evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- INSERÇÕES NO BANCO DE DADOS DE EVENTO
insert into cliente values(1, 'Pedro', '88281911', 'Rua 1', 'bairro 1', '232', 'casa', '233-23321');
insert into cliente values(2, 'Maria', '83829192', 'Rua 2', 'bairro 2', '232', 'casa', '233-23321');
insert into cliente values(3, 'João', '77488282', 'Rua da Luz', 'centro', '5944', 'sobrado', '233-23321');
insert into cliente values(4, 'José', '32090933', 'Rua Santo Antônio', 'Santo amaro', '1222', 'apto 302', '234-23321');
insert into cliente values(5, 'Severina', '99201011', 'Rua Dom Pedro', 'Nazaré', '2332', 'apto 90', '984-00911');
insert into cliente values(6, 'Antônio', '89282823', 'Rua José Alencar', 'cidade alta', '2002', null, '884-23321');
insert into cliente values(7, 'Paulo', '898998223', 'Rua São Paulo', 'jardim irene', '0032', 'casa', '903-39922');
insert into cliente values(8, 'Ana', '88292922', 'Rua Rio de Janeiro', 'iputinga', '232', null, '233-23321');
insert into cliente values(9, 'Luzia', '79292993', 'Rua Amazonas', 'cidade universitária', '232', 'casa', '230-34421');
insert into cliente values(10, 'Vitor', '32262727', 'Rua Pará', 'casa amarela', '232', 'apto 605', '402-22910');

insert into local_evento values(1, 'Parque de Exposições', 'descrição');
insert into local_evento values(2, 'Parque Dona Lindu', 'parque a céu aberto');
insert into local_evento values(3, 'Centro de Eventos', 'Local com área aberta e fechada');
insert into local_evento values(4, 'Downtown', 'Bar fechado');
insert into local_evento values(5, 'Pier', 'Pier no Marco zero');

insert into evento values(1, 'evento de rock direcionado a público jovem', '2018/08/03', '22hr', '2993.33', 1, 5);
insert into evento values(2, 'dia da saúde- exercicios', '2018/03/23', '09hr', '29.33', 5, 2);
insert into evento values(3, 'banda cover ac/dc', '2018/02/10', '23hr', '35.00', 4, 4);
insert into evento values(4, 'show da Shakira', '2018/09/12', '23:30hr', '70.00', 3, 3);
insert into evento values(5, 'Exposição de animais', '2019/01/03', '08hr', '10.00', 2, 1);
insert into evento values(6, 'Evento de musica', '2019/08/09', '18hr', '150.00', 4, 1);

insert into Reserva values(1, '2018/09/02', '17hrs', 2, 5);
insert into Reserva values(2, '2018/10/22', '17hrs', 2, 5);
insert into Reserva values(3, '2018/09/06', '17hrs', 2, 5);
insert into Reserva values(4, '2018/03/12', '17hrs', 2, 5);
insert into Reserva values(5, '2018/12/12', '17hrs', 2, 5);
insert into Reserva values(6, '2018/05/10', '17hrs', 2, 5);
insert into Reserva values(7, '2018/09/01', '17hrs', 2, 5);
insert into Reserva values(8, '2018/02/04', '17hrs', 2, 5);
insert into Reserva values(9, '2018/12/12', '17hrs', 2, 5);
insert into Reserva values(10, '2018/11/27', '17hrs', 2, 5);
insert into Reserva values(11, '2018/07/07', '17hrs', 2, 5);
insert into Reserva values(12, '2018/09/01', '10hrs', 4, 1);
insert into Reserva values(13, '2018/02/04', '23hrs', 1, 4);
insert into Reserva values(14, '2018/12/12', '22hrs', 1, 4);
insert into Reserva values(15, '2018/11/27', '23hrs', 3, 3);
insert into Reserva values(16, '2018/07/07', '11hrs', 4, 2);

-- FIM DO SCRIPT DE CRIAÇÃO E POPULAÇÃO