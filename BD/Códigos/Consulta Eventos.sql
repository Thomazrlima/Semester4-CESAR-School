-- 1
select * 
from evento 
where data between '2018-01-01' and '2018-06-30';

-- 2
select nome 
from cliente 
where nome like 'A%' or nome like '%A';

-- 3
select bairro, count(*) as numero_de_clientes 
from cliente 
group by bairro;

-- 4
select * 
from cliente 
where complemento is null;

-- 5
select descricao, horario, valor 
from evento 
where data = '2018-09-12';

-- 6
select * 
from local_evento 
where cod_local not in (
  select local_cod_local1 
  from evento
  inner join reserva 
  on evento.cod_evento = reserva.evento_cod_evento
);

-- 7
select c.nome 
from cliente c
inner join evento e 
  on c.cod_cliente = e.cliente_cod_cliente
inner join local_evento l 
  on e.local_cod_local1 = l.cod_local
where e.valor > 2000 
  and l.nome_local = 'Parque de Exposições';

-- 8
select nome, telefone 
from cliente 
where cod_cliente not in (
  select cliente_cod_cliente 
  from reserva
);

-- 9
select c.nome, c.telefone 
from cliente c
inner join reserva r 
  on c.cod_cliente = r.cliente_cod_cliente
inner join evento e 
  on r.evento_cod_evento = e.cod_evento
inner join local_evento l 
  on e.local_cod_local1 = l.cod_local
where r.data = '2018-11-27' 
  and l.nome_local = 'Downtown';

-- 10
select count(distinct r.cliente_cod_cliente) as num_clientes 
from reserva r
inner join evento e 
  on r.evento_cod_evento = e.cod_evento
inner join local_evento l 
  on e.local_cod_local1 = l.cod_local
where l.nome_local = 'Centro de Eventos';

-- 11
select c.nome, c.bairro
from cliente c
inner join reserva r 
  on c.cod_cliente = r.cliente_cod_cliente
inner join evento e 
  on r.evento_cod_evento = e.cod_evento
inner join local_evento l 
  on e.local_cod_local1 = l.cod_local
where l.nome_local = 'Parque Dona Lindu'
group by c.nome, c.bairro
having count(r.cod_reserva) > 1;

-- 12
select l.nome_local, count(e.cod_evento) as num_eventos
from local_evento l
left join evento e 
  on l.cod_local = e.local_cod_local1
group by l.nome_local;

-- 13
select e.descricao, e.valor
from evento e
left join reserva r 
  on e.cod_evento = r.evento_cod_evento
group by e.cod_evento
having count(r.cod_reserva) < 2;

-- 14
select c.nome 
from cliente c
inner join evento e 
  on c.cod_cliente = e.cliente_cod_cliente
group by c.nome
having sum(e.valor) > 200;

-- 15
select distinct c.nome 
from cliente c
inner join reserva r 
  on c.cod_cliente = r.cliente_cod_cliente
inner join evento e 
  on r.evento_cod_evento = e.cod_evento
inner join local_evento l 
  on e.local_cod_local1 = l.cod_local
where (r.data = '2018-07-07' and l.nome_local = 'Parque Dona Lindu')
   or (e.data = '2018-09-01' and l.nome_local = 'Parque de Exposições');

-- 16
select e.descricao, sum(e.valor) as total_arrecadado
from evento e
inner join reserva r 
  on e.cod_evento = r.evento_cod_evento
group by e.cod_evento
having count(r.cod_reserva) > 3;

-- 17
select descricao 
from evento 
where valor > (select avg(valor) from evento);

-- 18
select l.nome_local 
from local_evento l
where l.cod_local not in (
  select e.local_cod_local1 
  from evento e 
  where year(e.data) = 2018
);

-- 19
select l.nome_local 
from local_evento l
where l.cod_local in (
  select e.local_cod_local1 
  from evento e 
  group by e.local_cod_local1
  having count(e.cod_evento) >= 2
);

-- 20
select e.descricao
from evento e
where (select count(r.cod_reserva) 
       from reserva r 
       where r.evento_cod_evento = e.cod_evento) > 
      (select avg(sub.count_reservas) 
       from (select count(r2.cod_reserva) as count_reservas 
             from reserva r2 
             group by r2.evento_cod_evento) sub);
