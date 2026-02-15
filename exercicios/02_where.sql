-- Lista de pedidos realizados no fim de semana
SELECT idTransacao,
        datetime(substr(DtCriacao,1,19)) AS Data,
        strftime('%w', datetime(substr(DtCriacao,1,19))) as diaSemana

FROM transacoes

WHERE diaSemana IN ('0', '6')