-- Transações de cada cliente por dia + freq acumulada + lag do curso de sql
WITH tb_cliente_dia AS (
    SELECT idCliente,
           substr(DtCriacao,1,10) AS dtDia,
           count(*) AS Qtd

    FROM transacoes

    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao,1,10) < '2025-08-30'

    GROUP BY idCliente, dtDia
),

tb_lag AS (
    SELECT *,
        sum(Qtd) OVER (PARTITION BY idCliente ORDER BY dtDia) AS QtdAcum,
        lag(Qtd) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lag

    FROM tb_cliente_dia
)

SELECT *, 
        1. * Qtd / lag

FROM tb_lag