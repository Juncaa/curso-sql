-- Qual o produto mais transacionado?
SELECT IdProduto,
       count(*) AS QtdTransacoes

FROM transacao_produto

GROUP BY IdProduto

ORDER BY QtdTransacoes DESC