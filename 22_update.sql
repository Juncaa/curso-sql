-- Se não utilizar o WHERE, vai simplesmente atualizar todas as linhas
SELECT *

FROM relatorio_mensal;

UPDATE relatorio_mensal
SET freqAbs = 3535353535
WHERE dtMes > '2025-12';

SELECT *

FROM relatorio_mensal;