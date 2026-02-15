-- Quais clientes mais perderam pontos por Lover?
SELECT idCliente,
       sum(vlProduto) AS PontosPerdidos

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE DescCategoriaProduto = 'lovers'

GROUP BY IdCliente

ORDER BY PontosPerdidos