-- Qual o valor médio de pontos positivos por dia?
SELECT sum(qtdePontos) AS totalPontos,
       count(DISTINCT substr(DtCriacao,1,10)) AS DiasUnicos,
       sum(qtdePontos) / count(DISTINCT substr(DtCriacao,1,10)) AS MédiaDia

FROM transacoes

WHERE QtdePontos > 0