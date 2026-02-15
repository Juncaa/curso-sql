-- Quantos produtos são de rpg?
SELECT DescCategoriaProduto,
       count (*) AS Qtd

FROM produtos

GROUP BY DescCategoriaProduto