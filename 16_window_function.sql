-- Transações por dia + freq acumulada do curso de sql
WITH tb_sumario_dias AS (
    SELECT substr(DtCriacao,1,10) AS dtDia,
            count(*) AS Qtd

    FROM transacoes

    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao,1,10) < '2025-08-30'

    GROUP BY substr(DtCriacao,1,10)
)

SELECT *,
       sum(Qtd) OVER (ORDER BY dtDia) AS QtdAcum

FROM tb_sumario_dias