-- Quais clientes assinaram a lista de presença no dia 2025/08/25?
SELECT IdCliente,
       DescNomeProduto,
       substr(DtCriacao,1,10)

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE DescNomeProduto LIKE 'Lista%'
AND substr(DtCriacao,1,10) = '2025-08-25'