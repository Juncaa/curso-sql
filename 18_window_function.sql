-- Quanto tempo as pessoas demoram pra voltar a consumir o produto
WITH cliente_dia AS (
    SELECT DISTINCT idCliente,
        substr(DtCriacao,1,10) AS dtDia

    FROM transacoes

    WHERE substr(DtCriacao,1,4) = '2025'
    ORDER BY IdCliente, dtDia
),

tb_lag AS (
    SELECT *,
        lag(dtDia) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS lagDia

    FROM cliente_dia
),

tb_diff AS (
    SELECT *,
        julianday(dtDia) - julianday(lagDia) AS DtDiff

    FROM tb_lag
),

avg_cliente AS (
    SELECT idCliente, 
        round(avg(DtDiff),2) AS AvgDia

    FROM tb_diff
    GROUP BY idCliente
)

SELECT round(avg(AvgDia),2) AS AvgAll

FROM avg_cliente