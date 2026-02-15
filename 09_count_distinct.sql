SELECT 
        count(*) AS 'QtdTransações',
        count(DISTINCT idCliente) AS 'QtdClientes'

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'