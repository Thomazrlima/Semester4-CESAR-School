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
having count(m.codigo_disciplina) > 4;

-- 8
select m.matricula_aluno, p.nome, m.ano_semestre,
       avg(pr.nota) as nota_final
from monitoria m
join pessoa p on m.matricula_aluno = p.matricula_pessoa
join prova pr on pr.matricula_aluno = m.matricula_aluno and pr.codigo_disciplina = m.codigo_disciplina
where m.codigo_disciplina = 3
group by m.matricula_aluno, p.nome, m.ano_semestre;

-- 9
select count(distinct matricula_aluno) as qtd_alunos
from aluno_turma
where ano_semestre = '2010.1' and codigo_projeto is not null;

-- 10
select matricula_aluno, count(*) as qtd_monitorias
from monitoria
group by matricula_aluno;

-- 11
select a.matricula_aluno, p.nome, proj.titulo as nome_projeto
from aluno_turma at
join aluno a on at.matricula_aluno = a.matricula_aluno
join pessoa p on a.matricula_aluno = p.matricula_pessoa
join projeto proj on at.codigo_projeto = proj.codigo_projeto
where proj.conceito = 'regular';

-- 12
select distinct pa.nome as nome_aluno, pp.nome as nome_professor
from prova pr
join pessoa pa on pr.matricula_aluno = pa.matricula_pessoa
join ministra m on pr.codigo_disciplina = m.codigo_disciplina and pr.codigo_curso = m.codigo_curso and pr.ano_semestre = m.ano_semestre
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa pp on prof.matricula_professor = pp.matricula_pessoa
where pr.descricao = 'final';

-- 13
select ano_semestre, count(*) as qtd_alunos
from aluno_turma
where codigo_disciplina = 2
group by ano_semestre;

-- 14
select c.nome
from curso c
left join aluno_turma at on c.codigo_curso = at.codigo_curso and at.codigo_projeto is not null
where at.codigo_projeto is null;

-- 15
select ano_semestre, count(distinct matricula_aluno) as qtd_alunos
from aluno_turma
group by ano_semestre;

-- 16
select p.nome
from aluno a
join pessoa p on a.matricula_aluno = p.matricula_pessoa
join aluno_turma at on a.matricula_aluno = at.matricula_aluno
join disciplina d on at.codigo_disciplina = d.codigo_disciplina
where p.sexo = 'f' and d.ementa like '%estatística%';

-- 17
select pp.nome as nome_professor, count(distinct m.matricula_aluno) as qtd_monitores
from monitoria m
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa pp on prof.matricula_professor = pp.matricula_pessoa
join disciplina d on m.codigo_disciplina = d.codigo_disciplina
where d.ementa like '%matemática%'
group by pp.nome;

-- 18
select prof.matricula_professor, p.nome, prof.data_admissao, count(distinct m.codigo_disciplina) as qtd_disciplinas
from ministra m
join professor prof on m.matricula_professor = prof.matricula_professor
join pessoa p on prof.matricula_professor = p.matricula_pessoa
where m.ano_semestre like '2009.%'
group by prof.matricula_professor, p.nome, prof.data_admissao
having count(distinct m.codigo_disciplina) > 1;

-- 19
select distinct a.matricula_aluno, p.nome
from monitoria m
join aluno a on m.matricula_aluno = a.matricula_aluno
join pessoa p on a.matricula_aluno = p.matricula_pessoa;

-- 20
select c.nome as nome_curso, a.matricula_aluno, a.nota_vestibular
from aluno a
join curso c on a.codigo_curso = c.codigo_curso
where (a.codigo_curso, a.nota_vestibular) in (
    select codigo_curso, max(nota_vestibular)
    from aluno
    group by codigo_curso
);

-- 21
select p.nome, m.matricula_professor
from monitoria m
join pessoa p on m.matricula_aluno = p.matricula_pessoa
where p.nome like 'A%';