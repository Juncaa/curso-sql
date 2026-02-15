-- Qual cliente juntou mais pontos positivos em 2025-05
SELECT IdCliente,
       sum(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS QtdPontosPositivos

FROM transacoes

WHERE DtCriacao >= '2025-05-01'
AND DtCriacao < '2025-06-01'

GROUP BY IdCliente

ORDER BY QtdPontosPositivos DESC

LIMIT 1