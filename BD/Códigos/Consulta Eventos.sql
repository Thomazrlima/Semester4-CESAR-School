-- 1
SELECT * 
FROM Evento 
WHERE data BETWEEN '2018-01-01' AND '2018-06-30';

-- 2
SELECT nome 
FROM Cliente 
WHERE nome LIKE 'A%' OR nome LIKE '%A';

-- 3
SELECT bairro, COUNT(*) AS numero_de_clientes 
FROM Cliente 
GROUP BY bairro;

-- 4
SELECT * 
FROM Cliente 
WHERE complemento IS NULL;