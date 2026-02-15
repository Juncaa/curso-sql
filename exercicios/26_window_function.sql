-- Quantidade de transações Acumuladas ao longo do tempo?
WITH tb_transacaoDia AS (
    SELECT substr(DtCriacao,1,10) AS dtData,
        count(*) AS qtdeTransacao

    FROM transacoes

    GROUP BY dtData
),

tb_freq_acum AS (
    SELECT *,
        sum(qtdeTransacao) OVER (ORDER BY dtData) AS qtdeTransacaoAcum

    FROM tb_transacaoDia
)

SELECT * 
FROM tb_freq_acum