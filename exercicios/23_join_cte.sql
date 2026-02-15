-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?
WITH clientesJaneiro AS (
    SELECT idCliente 
    FROM clientes
    
    WHERE substr(DtCriacao,1,10) >= '2025-01-01'
    AND substr(DtCriacao,1,10) < '2025-02-01'
),

AssistiuCurso AS (
    SELECT DISTINCT idCliente
    FROM transacoes

    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao,1,10) < '2025-08-30'
),

tb_join AS (
    SELECT t1.idCliente
    FROM clientesJaneiro AS t1

    INNER JOIN AssistiuCurso AS t2
    ON t1.idCliente = t2.idCliente

    GROUP BY t1.idCliente
)

SELECT count(*) AS QtdCursoSQL 

FROM tb_join
