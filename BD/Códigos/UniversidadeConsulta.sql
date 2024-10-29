-- 1
select p.nome, p2.nota 
from pessoa p, aluno a, prova p2 
where p.matricula_pessoa = a.matricula_aluno 
  and p2.matricula_aluno = a.matricula_aluno 
  and p2.ano_semestre = '2010.2' 
  and p2.descricao = 'FINAL' 
  and p2.nota > (select avg(pr.nota)
                 from prova pr
                 where pr.ano_semestre = '2010.2')
order by p2.nota desc;

-- 2
select p.nome, count(m.codigo_disciplina) as total_disciplinas
from ministra m
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa p on prof.matricula_professor = p.matricula_pessoa
group by p.nome
order by total_disciplinas desc
limit 1;

-- 3
select p.nome
from professor prof
join pessoa p on prof.matricula_professor = p.matricula_pessoa
left join monitoria m on prof.matricula_professor = m.matricula_professor
where m.matricula_professor is null;

-- 4
select matricula_aluno
from aluno
where nota_vestibular > (select avg(nota_vestibular) from aluno);

-- 5
select p.nome, p.sexo
from ministra m
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa p on prof.matricula_professor = p.matricula_pessoa
group by p.nome, p.sexo
having count(*) > 1;

-- 6
select c.nome as nome_curso, p.sexo, avg(pr.nota) as media_nota
from prova pr
join aluno a on pr.matricula_aluno = a.matricula_aluno
join curso c on a.codigo_curso = c.codigo_curso
join pessoa p on a.matricula_aluno = p.matricula_pessoa
where pr.ano_semestre = '2010.2' and pr.descricao = 'p2'
group by c.nome, p.sexo
order by c.nome;


-- 7
select p.nome, prof.data_admissao
from ministra m
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa p on prof.matricula_professor = p.matricula_pessoa
group by p.nome, prof.data_admissao
having COUNT(m.codigo_disciplina) > 4;

