WITH tb_transacoes AS (
    SELECT IdTransacao,
        idCliente, 
        qtdePontos,
        datetime(DtCriacao) AS dtData,
        round(julianday('now') - julianday(DtCriacao),1) AS diffDate,
        CAST(strftime('%H', DtCriacao) AS INT) AS dtHora

    FROM transacoes 
),

tb_clientes AS (
    SELECT idCliente, 
        date(DtCriacao),
        round(julianday('now') - julianday(DtCriacao),1) AS idadeBase

    FROM clientes
),

tb_sumario_transacoes AS (
    SELECT idCliente, 
        count(*) AS Qtdetransacoes,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtdetransacoesD7,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtdetransacoesD14,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtdetransacoesD28,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtdetransacoesD56, 

        round(min(diffDate),1) AS diasUltimaTransacao,

        sum(qtdePontos) AS SaldoPontos, 

        sum(CASE WHEN qtdePontos > 0 THEN qtdePontos END) AS qtdePontosPos,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 7 THEN qtdePontos ELSE 0 END) AS qtdePontosPosD7,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS qtdePontosPosD14,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS qtdePontosPosD28,
        sum(CASE WHEN qtdePontos > 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS qtdePontosPosD56,

        sum(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtdePontosNeg,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 7 THEN qtdePontos ELSE 0 END) AS qtdePontosNegD7,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS qtdePontosNegD14,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS qtdePontosNegD28,
        sum(CASE WHEN qtdePontos < 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS qtdePontosNegD56

    FROM tb_transacoes

    GROUP BY idCliente
),

tb_transacao_produto AS (
    SELECT t1.*,
        t3.DescNomeProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (
    SELECT IdCliente, 
        DescNomeProduto,
        count(*) AS qtdVida,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtd7,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtd14,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtd28,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtd56
    
    FROM tb_transacao_produto

    GROUP BY IdCliente, DescNomeProduto
),

tb_cliente_produto_rn AS (
    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdVida DESC) AS rnVida,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtd7 DESC) AS rn7,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtd14 DESC) AS rn14,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtd28 DESC) AS rn28,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtd56 DESC) AS rn56

    FROM tb_cliente_produto
),

tb_cliente_dia AS (
    SELECT IdCliente,
        strftime('%w',dtData) AS diaSemana,
        count(*) AS qtdTransacaoDia

    FROM tb_transacoes

    WHERE diffDate <= 28

    GROUP BY IdCliente, diaSemana
),

tb_cliente_dia_rn AS (
    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdTransacaoDia DESC) AS rnDia

    FROM tb_cliente_dia
),

tb_cliente_periodo AS (
    SELECT idCliente,
        CASE
            WHEN dtHora BETWEEN 7 AND 11 THEN 'Manhã'
            WHEN dtHora BETWEEN 12 AND 17 THEN 'Tarde'
            WHEN dtHora BETWEEN 18 AND 23 THEN 'Noite'
            ELSE 'Madrugada'
            END AS periodo,
            count(*) AS qtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1,2
),

tb_cliente_periodo_rn AS (
    SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo
    FROM tb_cliente_periodo

),

tb_join AS (
    SELECT t1.*,
        t2.idadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto7,
        t5.DescNomeProduto AS produto14,
        t6.DescNomeProduto AS produto28,
        t7.DescNomeProduto AS produto56,
        COALESCE(CASE
            WHEN diaSemana = '0' THEN 'Domingo'
            WHEN diaSemana = '1' THEN 'Segunda-Feira'
            WHEN diaSemana = '2' THEN 'Terça-Feira'
            WHEN diaSemana = '3' THEN 'Quarta-Feira'
            WHEN diaSemana = '4' THEN 'Quinta-Feira'
            WHEN diaSemana = '5' THEN 'Sexta-Feira'
            WHEN diaSemana = '6' THEN 'Sábado'
            END, -1) AS diaMaisAtivo28,
        COALESCE(t9.periodo, 'NoInfo') AS periodo28

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_clientes AS t2
    ON t1.idCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.idCliente = t3.idCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.idCliente = t4.idCliente
    AND t4.rn7 = 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.idCliente = t5.idCliente
    AND t5.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.idCliente = t6.idCliente
    AND t6.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.idCliente = t7.idCliente
    AND t7.rn56 = 1

    LEFT JOIN tb_cliente_dia_rn AS t8
    ON t1.idCliente = t8.idCliente
    AND t8.rnDia = 1

    LEFT JOIN tb_cliente_periodo_rn AS t9
    ON t1.idCliente = t9.idCliente
    AND t9.rnPeriodo = 1
)

SELECT *,
    round(1. * QtdetransacoesD28 / Qtdetransacoes,2) AS engajamento28Vida

FROM tb_join