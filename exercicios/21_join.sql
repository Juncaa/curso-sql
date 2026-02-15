-- Clientes mais antigos, tem mais frequência de transação?
SELECT t1.IdCliente, 
       julianday('now') - julianday(substr(t1.DtCriacao,1,10)) AS idadeBase,
       count(IdTransacao) as QtdTransacoes

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t1.IdCliente, idadeBase

ORDER BY idadeBase DESC