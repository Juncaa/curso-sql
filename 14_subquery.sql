-- Todos clientes que fizeram transações no dia 25/08/2025 e no dia 29/08/2025
SELECT count(DISTINCT IdCliente)
FROM transacoes AS t1

WHERE t1.IdCliente IN (
    SELECT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
)

AND substr(DtCriacao,1,10) = '2025-08-29'

