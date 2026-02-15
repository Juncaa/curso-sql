-- Qual dia da semana quem mais pedidos em 2025?
SELECT strftime('%w', substr(DtCriacao,1,10)) AS diaSemana,
       count(*) AS Qtd

FROM transacoes

WHERE substr(DtCriacao,1,4) = '2025'

GROUP BY diaSemana