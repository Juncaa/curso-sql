-- Qual o dia da semana mais ativo de cada usuário?
WITH tb_base AS (
    SELECT idCliente,
        strftime('%w',DtCriacao) AS diaSemana,
        count(*) AS qtdeTransacoes

    FROM transacoes

    GROUP BY idCliente, diaSemana
),

tb_rn AS (
    SELECT *,
        CASE
            WHEN diaSemana = '0' THEN 'Domingo'
            WHEN diaSemana = '1' THEN 'Segunda-Feira'
            WHEN diaSemana = '2' THEN 'Terça-Feira'
            WHEN diaSemana = '3' THEN 'Quarta-Feira'
            WHEN diaSemana = '4' THEN 'Quinta-Feira'
            WHEN diaSemana = '5' THEN 'Sexta-Feira'
            WHEN diaSemana = '6' THEN 'Sábado'
            END AS descDiaSemana,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdeTransacoes DESC) AS rn

    FROM tb_base
)

SELECT * 
FROM tb_rn
WHERE rn = 1