SELECT sum(QtdePontos) AS TotalPontos,
       sum(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS TotalPontosPositivos,

        sum(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS TotalPontosNegativos

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'