-- Selecione todos clientes com mais de 500 pontos
SELECT idCliente, qtdePontos

FROM clientes 

WHERE QtdePontos > 500

ORDER BY QtdePontos DESC