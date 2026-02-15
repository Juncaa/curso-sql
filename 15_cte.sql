-- Todos clientes que fizeram transações no dia 25/08/2025 e no dia 29/08/2025 dessa vez com CTEs
WITH tb_clientes_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(dtCriacao,1,10) = '2025-08-25'
),

tb_clientes_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(dtCriacao,1,10) = '2025-08-29'
),

tb_join AS (
    SELECT t1.idCliente AS primCliente,
           t2.idCliente AS ultCliente 
    FROM tb_clientes_primeiro_dia AS t1
    
    LEFT JOIN tb_clientes_ultimo_dia AS t2
    ON t1.idCliente = t2.idCliente
) 

SELECT count(primCliente),
       count(ultCliente),
       1. * count(ultCliente) / count(primCliente)

FROM tb_join