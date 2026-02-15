-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

DROP TABLE IF EXISTS relatorio_mensal;

CREATE TABLE IF NOT EXISTS relatorio_mensal AS

WITH tb_usuarioMes AS (
    SELECT substr(DtCriacao,1,7) AS dtMes,
        count(*) AS freqAbs

    FROM clientes

    GROUP BY dtMes
),

tb_freqAcum AS (
    SELECT *,
            sum(freqAbs) OVER (ORDER BY dtMes) AS freqAcum

    FROM tb_usuarioMes
)

SELECT *
FROM tb_freqAcum
;