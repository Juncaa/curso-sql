-- Qual o produto com mais pontos transacionados?
SELECT IdProduto, 
       sum(vlProduto * QtdeProduto) AS TotalPontos

FROM transacao_produto

GROUP BY IdProduto

ORDER BY sum(vlProduto) DESC