-- Como foi a curva de Churn do Curso de SQL?
WITH tb_clientes_d1 AS (
    SELECT DISTINCT idCliente
    FROM transacoes

    WHERE substr(DtCriacao,1,10) = '2025-08-25'
    GROUP BY idCliente
),

tb_join AS (
    SELECT substr(DtCriacao,1,10) AS qtDia,
        count(DISTINCT t1.idCliente) AS qtCliente,
        1 - 1. * count(DISTINCT t1.idCliente) / (SELECT count (*) FROM tb_clientes_d1) AS pctChurn

    FROM tb_clientes_d1 AS t1

    LEFT JOIN transacoes AS t2
    ON t1.idCliente = t2.idCliente

    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao,1,10) < '2025-08-30'

    GROUP BY qtDia
)

SELECT * FROM tb_join