SELECT idCliente, 
       QtdePontos,
       CASE
            WHEN QtdePontos <= 500 THEN 'Ruim'
            WHEN QtdePontos <= 1000 THEN 'Baixo'
            WHEN QtdePontos <= 5000 THEN 'Médio'
            WHEN QtdePontos <= 10000 THEN 'Bom'
            ELSE 'Ótimo'
       END AS Classificação

-- Da pra usar mais de um case

FROM clientes

ORDER BY QtdePontos DESC