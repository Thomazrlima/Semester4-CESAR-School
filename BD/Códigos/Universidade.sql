-- SCRIPT CRIAÇÃO
CREATE DATABASE UNIVERSIDADE2;
USE UNIVERSIDADE2; 

CREATE TABLE curso (
	codigo_curso INT,
	nome VARCHAR(200) NOT NULL,
	CONSTRAINT curso_pk PRIMARY KEY (codigo_curso)
);

CREATE TABLE projeto (
	codigo_projeto INT,
	titulo VARCHAR(30) NOT NULL,
	conceito VARCHAR(7),
	hp VARCHAR(50),
	CONSTRAINT projeto_pk PRIMARY KEY (codigo_projeto),
	CONSTRAINT projeto_conceito_ck CHECK (conceito IN ('BOM', 'RUIM', 'REGULAR'))
);

CREATE TABLE pessoa (
	matricula_pessoa INT,
	nome VARCHAR(50) NOT NULL,
	sexo CHAR(1) NOT NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (matricula_pessoa)
);

CREATE TABLE professor (
	matricula_professor INT,
	data_admissao DATE NOT NULL,
	matricula_lider INT,
	CONSTRAINT professor_pk PRIMARY KEY (matricula_professor),
	CONSTRAINT professor_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT professor_matricula_lider_fk FOREIGN KEY (matricula_lider) REFERENCES professor (matricula_professor)
);

CREATE TABLE disciplina (
	codigo_disciplina INT,
	ementa VARCHAR(50) NOT NULL,
	conteudo_programatico VARCHAR(100) NOT NULL,
	matricula_professor INT NOT NULL,
	CONSTRAINT disciplina_pk PRIMARY KEY (codigo_disciplina),
	CONSTRAINT disciplina_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);


CREATE TABLE turma (
	codigo_disciplina INT,
	codigo_curso INT,
	ano_semestre VARCHAR(6),
	CONSTRAINT turma_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo_disciplina),
	CONSTRAINT turma_codigo_curso_fk FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso),
	CONSTRAINT turma_ano_semestre_ck CHECK (ano_semestre LIKE '____._')
);

CREATE TABLE ministra (
	codigo_disciplina INT,
	codigo_curso INT,
	ano_semestre VARCHAR(6),
	matricula_professor INT,
	CONSTRAINT ministra_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor),
	CONSTRAINT ministra_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT ministra_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);

CREATE TABLE aluno (
	matricula_aluno INT,
	nota_vestibular DECIMAL(5,3) NOT NULL,
	codigo_curso INT NOT NULL,
	CONSTRAINT aluno_pk PRIMARY KEY (matricula_aluno),
	CONSTRAINT aluno_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT aluno_codigo_curso_fk FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso)
);

CREATE TABLE aluno_turma (
	codigo_disciplina INT,
	codigo_curso INT,
	ano_semestre VARCHAR(6),
	matricula_aluno INT,
	codigo_projeto INT,
	CONSTRAINT aluno_turma_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno),
	CONSTRAINT aluno_turma_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT aluno_turma_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT aluno_turma_codigo_projeto_fk FOREIGN KEY (codigo_projeto) REFERENCES projeto (codigo_projeto)
);

CREATE TABLE prova (
	codigo_disciplina INT,
	codigo_curso INT,
	ano_semestre VARCHAR(6),
	matricula_aluno INT,
	descricao VARCHAR(10),
	nota DECIMAL(3,1) NOT NULL,
	CONSTRAINT prova_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao),
	CONSTRAINT prova_aluno_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno) REFERENCES aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno)
);

CREATE TABLE monitoria (
	codigo_disciplina INT,
	codigo_curso INT,
	ano_semestre VARCHAR(6),
	matricula_aluno INT,
	matricula_professor INT NOT NULL,
	CONSTRAINT monitoria_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno),
	CONSTRAINT monitoria_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT monitoria_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT monitoria_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);


-- SCRIPT INSERÇÃO
-- INSERINDO CURSOS

INSERT INTO curso (codigo_curso, nome) VALUES (1,'Engeharia da Computacao');
INSERT INTO curso (codigo_curso, nome) VALUES (2,'Ciencia da Computacao');
INSERT INTO curso (codigo_curso, nome) VALUES (3,'Sistemas de Informacao');
INSERT INTO curso (codigo_curso, nome) VALUES (4,'Estatistica');
INSERT INTO curso (codigo_curso, nome) VALUES (5,'Matematica');


-- INSERINDO PROJETOS

INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (2,'TeleMundo','BOM', null);
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (3,'Plano B','REGULAR',null);
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (4,'Conceito 2','BOM','www.conceito2.com.br');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (5,'Stroleer','REGULAR','www.stroller.net');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (7,'Disco Player','REGULAR','www.discoplayer.com');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (9,'AlerTorr','REGULAR','www.alertorr.edu.br');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (10,'Koleira Chips Caninos','BOM','www.ufpe.br/koleira');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (11,'Mega Site Promocoes','BOM','www.megasite.com.br');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (12,'Algema','RUIM','www.algema.com');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (14,'SiGRH','RUIM','www.dti.ufrj.br/~sihr');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (17,'CasaAzul Editor','BOM','www.casaazul.com');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (18,'Piloto Automatico','RUIM','www.cti.ufmg.br/~pilotoautomatico');
INSERT INTO projeto (codigo_projeto,titulo,conceito,hp) VALUES (19,'IAX 40F','RUIM',null);
 
 
-- INSERINDO PESSOAS

INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1111,'Jose Alcantara','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2222,'Ricardo Nassau','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (3333,'Maria das Dores','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (4444,'Sirenio Arruda','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (5555,'Alexandra Almeida','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (6666,'Lindalva Silva','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (7777,'Rosa Pereira','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (8888,'Joao Custodia','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (9999,'Fabiana Murer','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1010,'Olavo Ferreira','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1212,'Augustus Kilter','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1313,'Mery dos Santos','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1414,'Kildery Ramos','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1515,'Valentina Oliveira','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1616,'Ofeliana Araujo','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1717,'Dezembrina Carneiro','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1818,'Oristides Melo','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (1919,'Carlos Chagas','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2020,'Gusmao Alencar','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2121,'Luis Mario Moraes','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2323,'Glenda Amorin','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2424,'Pompeu de Toledo','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2525,'Hortencia Maria','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2626,'Amelia Lima','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2727,'Kelly Desarlinas','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2828,'Raphael Queiroga','H');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (2929,'Carmelita Santos','M');
INSERT INTO pessoa (matricula_pessoa,nome,sexo) VALUES (3030,'Helena Nunes','M');




-- INSERINDO PROFESSORES

INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (1111,'2000-11-02',NULL);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (3333,'1972-07-15',NULL);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (2222,'1984-02-27',1111);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (4444,'2001-01-06',1111);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (5555,'2006-12-29',4444);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (6666,'2006-03-16',3333);
INSERT INTO professor (matricula_professor,data_admissao,matricula_lider) VALUES (7777,'1999-07-11',3333);



-- INSERINDO DISCIPLINAS

INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (1,'E1', 'C1',1111);
INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (2,'E2', 'C2',2222);
INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (3,'E3', 'C3',3333);
INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (4,'E4', 'C4',4444);
INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (5,'E5', 'C5',5555);
INSERT INTO disciplina (codigo_disciplina,ementa,conteudo_programatico,matricula_professor) VALUES (6,'E6', 'C6',6666);


-- INSERINDO TURMA


INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,1,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,1,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (4,1,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (5,4,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (6,4,'2008.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,2,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,2,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,2,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (4,2,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (5,4,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (6,4,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2008.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,1,'2009.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,1,'2009.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2009.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,1,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,1,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,3,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,3,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,2,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2009.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,1,'2010.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,2,'2010.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (4,5,'2010.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2010.1');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (4,4,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (5,4,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,1,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (6,5,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (1,2,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (2,3,'2010.2');
INSERT INTO turma (codigo_disciplina,codigo_curso,ano_semestre) VALUES (3,3,'2010.2');



-- INSERINDO MINISTRA

INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2008.2',6666);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2008.2',1111);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2008.2',2222);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2009.1',1111);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,1,'2008.1',1111);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (3,1,'2008.1',1111);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,2,'2008.2',2222);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,2,'2008.2',3333);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,2,'2008.2',2222);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,3,'2009.2',2222);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,3,'2010.2',3333);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (6,4,'2008.1',3333);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (6,5,'2010.2',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,1,'2009.2',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (3,1,'2009.2',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2009.2',7777);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2009.2',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (4,5,'2010.1',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (3,3,'2010.2',5555);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (4,4,'2010.2',5555);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,3,'2010.2',7777);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,3,'2010.2',6666);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (3,1,'2009.1',6666);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (5,4,'2010.2',1111);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (2,1,'2010.1',2222);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,3,'2009.2',3333);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2010.2',4444);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2010.2',5555);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (1,1,'2010.2',7777);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (3,2,'2008.2',5555);
INSERT INTO ministra (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor) VALUES (4,2,'2008.2',6666);


-- INSERINDO ALUNOS

INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (8888,5.392,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (9999,7.652,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1010,8.206,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1212,6.653,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1313,4.932,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1414,9.803,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1515,6.480,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1616,9.304,2);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1717,8.630,2);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1818,7.620,2);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (1919,6.305,2);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2020,5.034,2);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2121,4.320,3);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2323,3.204,3);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2424,8.205,3);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2525,7.205,5);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2626,7.320,4);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2727,6.046,4);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2828,5.024,5);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (2929,6.320,1);
INSERT INTO aluno (matricula_aluno,nota_vestibular,codigo_curso) VALUES (3030,4.300,4);


-- INSERINDO ALUNO_TURMA

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2009.1',8888,19);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2009.1',9999,19);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2009.1',1010,19);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,1,'2009.1',8888,18);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,1,'2009.1',9999,18);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,1,'2009.1',1010,18);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,1,'2009.1',1212,18);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2009.1',2323,14);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2009.1',2424,14);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2009.1',2828,17);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2009.2',2020,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2009.2',2121,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2010.1',2323,12);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2010.1',2424,12);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2010.1',2525,12);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2010.1',2626,12);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,1,'2010.1',2727,12);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,2,'2010.1',1919,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,2,'2010.1',1818,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,2,'2010.1',1717,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,2,'2010.1',1616,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',8888,11);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',2020,11);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',2121,11);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',2323,11);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',2424,11);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.1',2525,11);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (4,4,'2010.2',3030,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (4,4,'2010.2',2929,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (4,4,'2010.2',2828,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (5,4,'2010.2',8888,10);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (5,4,'2010.2',9999,10);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (5,4,'2010.2',1010,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',1313,7);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',1414,7);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',1515,7);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',1818,9);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',1919,9);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,1,'2010.2',2020,9);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (6,5,'2010.2',3030,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (6,5,'2010.2',2929,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (6,5,'2010.2',2828,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (6,5,'2010.2',2727,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (6,5,'2010.2',2626,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',8888,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',9999,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1010,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1212,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1313,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1414,5);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1818,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',1919,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',2020,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (1,2,'2010.2',2121,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2020,3);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2121,3);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2323,3);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2424,3);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2525,3);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2626,4);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2727,4);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2828,4);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',2929,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (2,3,'2010.2',3030,NULL);

INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',1515,2);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',1414,2);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',1313,2);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',1212,2);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',1010,2);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',9999,NULL);
INSERT INTO aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,codigo_projeto) VALUES (3,3,'2010.2',8888,NULL);




-- INSERINDO PROVAS

INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1515,'P2',3.7); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1515,'FINAL',10); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1414,'P1',9); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1414,'P2',9.7); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1313,'P1',2.4); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1313,'P2',7.1); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1313,'FINAL',6.2); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1212,'P1',5.6); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1212,'P2',8.9); -- ok
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1010,'P1',2.4);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1010,'P2',5.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',1010,'FINAL',9.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',9999,'P1',2.4);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',9999,'P2',1.6);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',8888,'P1',3.8);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',8888,'P2',0.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (3,3,'2010.2',8888,'FINAL',2.1); -- ok ate aqui


INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2020,'P2',2.9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2020,'P3',4.8);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2121,'P1',3.5);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2121,'P2',7.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2121,'P3',9.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2323,'P1',7.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2323,'P2',9.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2323,'P3',6.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2424,'P1',7.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2424,'P2',7.8);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2424,'P3',6.9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2525,'P1',3.4);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2525,'P2',4.5);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2525,'P3',7.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2525,'FINAL',9.5);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2626,'P1',2.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2626,'P2',2.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2626,'P3',0.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2626,'FINAL',4.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2727,'P1',6.8);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2727,'P2',8.9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2727,'P3',9.0);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2828,'P1',9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2828,'P2',7.9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2828,'P3',8.9);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2929,'P1',10);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2929,'P2',9.5);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',2929,'P3',9.8);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',3030,'P1',6.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (2,3,'2010.2',3030,'FINAL',7.4);

INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',8888,'P1',8.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',8888,'P2',6.7);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1010,'P1',5.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1010,'P2',9.0);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1212,'P1',7.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1212,'P2',7.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1313,'P1',2.4);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1313,'P2',9.0);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1313,'FINAL',10);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1414,'P1',5.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1414,'P2',5.5);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1414,'FINAL',6.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1818,'P1',8.4);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1818,'P2',7.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1919,'P1',7.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',1919,'P2',9.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',2020,'P1',5.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',2020,'P2',9.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',2121,'P1',8.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,2,'2010.2',2121,'P2',8.9);

INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1313,'P1',8.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1313,'P2',9.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1414,'P1',7.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1414,'P2',7.1);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1515,'P1',9.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1515,'P2',9.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1818,'P1',9.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1818,'P2',7.2);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',1919,'P1',8.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',2020,'P1',9.3);
INSERT INTO prova (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao,nota) VALUES (1,1,'2010.2',2020,'P2',7.2);


-- INSERINDO MONITORIA

INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (1,1,'2008.2',3030,1111);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (1,1,'2009.1',1919,1111);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,1,'2008.1',3030,1111);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (3,1,'2008.1',1212,1111);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (1,2,'2008.2',8888,2222);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,2,'2008.2',2323,3333);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,3,'2009.2',2323,2222);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,3,'2010.2',2525,3333);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (6,4,'2008.1',9999,3333);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (6,5,'2010.2',1010,4444);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,1,'2009.2',8888,4444);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (3,1,'2009.2',8888,4444);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (1,1,'2009.2',1313,7777);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (4,5,'2010.1',1313,4444);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (3,3,'2010.2',1818,5555);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (5,4,'2010.2',8888,1111);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (2,1,'2010.1',8888,2222);
INSERT INTO monitoria (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,matricula_professor) VALUES (1,1,'2010.2',8888,4444);