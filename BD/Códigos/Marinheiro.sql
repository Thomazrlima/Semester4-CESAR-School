CREATE DATABASE MARINHATT;
USE MARINHATT;

CREATE TABLE barco (
  idBarco integer,
  nomeBarco varchar(45),
  cor varchar(45),
  PRIMARY KEY (idBarco)
);

INSERT INTO barco VALUES (101,'Interlake','azul'),(102,'Interlake','vermelho'),(103,'Clipper','verde'),(104,'Marine','vermelho');


CREATE TABLE Marinheiro (
  idMarinheiro integer,
  nomeMarinheiro varchar(100),
  avaliacao varchar(45),
  idade integer,
  PRIMARY KEY (idMarinheiro)
);

INSERT INTO Marinheiro VALUES (22,'Dustin',"ótimo",45),(29,'Brutus',"ótimo",33),(31,'Lubber',"bom",55),(32,'Andy',"bom",25),(58,'Rusty',"ótimo",35),(64,'Horatio',"ótimo",35),(71,'Zorba',"ótimo",16),(74,'Horatio',"bom",35),(85,'Art',"ótimo",25),(95,'Bob',"ótimo",63);


CREATE TABLE Reserva (
  idMarinheiro integer,
  idBarco integer,
  dataReserva date,
  PRIMARY KEY(idMarinheiro, idBarco),
  CONSTRAINT fk_barco FOREIGN KEY (idBarco) REFERENCES barco (idbarco),
  CONSTRAINT fk_marinheiro FOREIGN KEY (idMarinheiro) REFERENCES marinheiro (idmarinheiro)
) ;

INSERT INTO Reserva VALUES (22,101,'1998-10-09'),(22,102,'1998-10-10'),(22,103,'1998-08-10'),(22,104,'1998-07-10'),(31,102,'1998-10-11'),(31,103,'1998-11-06'),(31,104,'1998-11-12'),(64,101,'1998-05-09'),(64,102,'1998-05-09'),(74,103,'1998-06-09');


