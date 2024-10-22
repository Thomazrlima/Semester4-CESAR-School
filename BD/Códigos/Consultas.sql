-- 1
select nomeMarinheiro, idade
from Marinheiro;

-- 2
select *
from Marinheiro
where avaliacao = "bom";

-- 3
select m.nomeMarinheiro
from marinheiro m, barco b, reserva r 
where m.idMarinheiro = r.idMarinheiro and 
b.idBarco = r.idBarco and 
b.idBarco = 103;

select m.nomeMarinheiro
from marinheiro m
join reserva r on m.idMarinheiro = r.idMarinheiro 
join barco b on b.idBarco = r.idBarco 
where b.idBarco = 103;

-- 4
select r.idMarinheiro
from reserva r 
join barco b on r.idBarco = b.idBarco 
where b.cor = "vermelho";

-- 5
select distinct m.nomeMarinheiro
from reserva r
join marinheiro m on m.idMarinheiro = r.idMarinheiro
join barco b on r.idBarco = b.idBarco 
where b.cor = "vermelho";

-- 6

select distinct b.cor
from barco b 
join reserva r on b.idBarco = r.idBarco 
join marinheiro m on m.idMarinheiro = r.idMarinheiro 
where m.nomeMarinheiro = "Lubber";

-- 7

select m.nomeMarinheiro
from marinheiro m 
join reserva r on r.idMarinheiro = m.idMarinheiro;

-- 8
select m.nomeMarinheiro
from marinheiro m 
where m.nomeMarinheiro like 'B__%' or m.nomeMarinheiro like '%__B'

-- 9
select avg(idade)
from marinheiro;

-- 10
select avg(idade) 
from marinheiro
where idade > 27;

-- 11
select count(*) from marinheiro;

-- 12
select count(distinct (nomeMarinheiro)) from marinheiro; 

-- 13
select avaliacao, min(idade)
from marinheiro
group by avaliacao;

-- 14
select  avaliacao, min(idade) as minIdade
from marinheiro
where idade >= 18
group by avaliacao 
having count(*) > 1; 

-- 15
select r.idBarco, b.cor, count(r.idBarco) 
from barco b join reserva r 
on b.idBarco = r.idBarco 
and b.cor ='vermelho'
group by r.idBarco;

-- 16
select avaliacao, avg(idade)
from marinheiro m 
group by avaliacao 
having count(*) > 1;

-- 17
select m.idMarinheiro
from marinheiro m 
where idade > (select avg(m2.idade)
				from marinheiro m2);

