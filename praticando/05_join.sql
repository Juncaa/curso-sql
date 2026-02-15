-- Qual categoria tem mais produtos
SELECT t2.DescCategoriaProduto,
       count(DISTINCT t1.IdTransacao) AS QtdVendida

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

GROUP BY DescCategoriaProduto

ORDER BY QtdVendida DESC