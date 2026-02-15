SELECT IdCliente,
        QtdePontos,
        QtdePontos +10 AS 'PontosPlus10',
        QtdePontos *2 AS 'PontosDouble',
        
        datetime(substr(DtCriacao,1,19)) AS Data,
        strftime('%w', datetime(substr(DtCriacao,1,19))) AS diaSemana


FROM clientes