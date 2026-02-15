-- Qual mês tivemos mais lista de presença assinada?
SELECT strftime('%m', date(substr(DtCriacao,1,10))) AS Month,
       count(DISTINCT t1.IdTransacao) AS Qtd

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DescNomeProduto = 'Lista de presença'

GROUP BY Month