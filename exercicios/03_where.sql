-- Lista de clientes com 0 (zero) pontos;

SELECT idCliente, 
        qtdePontos

FROM clientes

WHERE QtdePontos = 0