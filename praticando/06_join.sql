-- Em 2024, quantas transações de Lovers tivemos?
SELECT DescNomeProduto, 
       count(DescNomeProduto) AS Qtd

FROM transacao_produto as t1

LEFT JOIN produtos as t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes as t3
ON t1.IdTransacao = t3.IdTransacao

WHERE DescNomeProduto LIKE '%lover%'
AND DtCriacao >= '2024-01-01'
AND DtCriacao < '2025-01-01'

GROUP BY DescNomeProduto