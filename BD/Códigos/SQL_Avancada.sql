-- 1
create function creditos(matricula int)
returns int
deterministic
begin
    declare total_creditos int;

    set total_creditos = (
        (select count(*) * 5 from aluno_turma where matricula_aluno = matricula) +
        (select count(distinct codigo_projeto) * 1 from aluno_turma where matricula_aluno = matricula and codigo_projeto is not null) +
        (select count(*) * 2 from monitoria where matricula_aluno = matricula)
    );

    return total_creditos;
end;

select creditos(1717);

-- 2
create procedure exibir_projeto(in titulo_projeto varchar(200))
begin
    select *
    from projeto proj
    where proj.titulo = titulo_projeto;
end;

call exibir_projeto('TeleMundo');

-- 3
create view resultado_selecao as
select p.nome as nome_aluno, a.nota_vestibular
from aluno a
join pessoa p on a.matricula_aluno = p.matricula_pessoa;

select * from resultado_selecao;

-- 4
create trigger validar_nota_vestibular
before insert on aluno
for each row
begin
    if new.nota_vestibular < 0 or new.nota_vestibular > 10 then
        signal sqlstate '45000'
        set message_text = 'Nota Errada';
    end if;
end;

insert into pessoa (matricula_pessoa, nome, sexo) values (1001, 'Aluno Teste 1', 'H');
insert into pessoa (matricula_pessoa, nome, sexo) values (1002, 'Aluno Teste 2', 'M');
insert into pessoa (matricula_pessoa, nome, sexo) values (1003, 'Aluno Teste 3', 'H');
insert into aluno (matricula_aluno, nota_vestibular, codigo_curso) values (1001, -1, 101);  -- Falha
insert into aluno (matricula_aluno, nota_vestibular, codigo_curso) values (1002, 11, 101);  -- Falha
insert into aluno (matricula_aluno, nota_vestibular, codigo_curso) values (1003, 8.5, 101);  -- Ok

-- 5
create table log_ementa (
    codigo_disciplina int,
    ementa_antiga varchar(50),
    data_atualizacao datetime
);

create trigger log_atualizacao_ementa
before update on disciplina
for each row
begin
    if old.ementa <> new.ementa then
        insert into log_ementa (codigo_disciplina, ementa_antiga, data_atualizacao)
        values (old.codigo_disciplina, old.ementa, now());
    end if;
end;

update disciplina set ementa = 'Teste' where codigo_disciplina = 2;
select * from log_ementa;
