SELECT idCliente, 
       sum(QtdePontos) AS PontosJulho,
       count(idTransacao) AS qtdTransacao

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY idCliente 
HAVING sum(QtdePontos) >= 3000

ORDER BY sum(QtdePontos) DESC