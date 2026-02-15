-- Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?
SELECT count(idCliente) AS TotalAssinaturas,
       count(DISTINCT idCliente) AS AssinaturasDistintas

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE DescNomeProduto LIKE 'Lista%'
AND substr(DtCriacao,1,10) >= '2025-08-25'
AND substr(DtCriacao,1,10) < '2025-08-30'