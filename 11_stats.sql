SELECT round(avg(qtdePontos),2) AS MédiaPontos,
       sum(qtdePontos) AS SomaPontos,
       min(qtdePontos) AS MinPontos,
       max(qtdePontos) AS MaxPontos,
       count(idCliente) AS TotalClientes,
       sum(flTwitch) AS ClientesTwitch

FROM clientes