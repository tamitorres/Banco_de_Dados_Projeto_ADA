-- Quais os clientes que mais fizeram pedidos?

select  c.nome_cliente, COUNT(p.id_pedido) AS numero_de_pedidos
FROM
    Cliente c join   Pedido p ON c.id_cliente = p.id_cliente
GROUP by    c.nome_cliente
ORDER by    numero_de_pedidos DESC
LIMIT 3;

-- Quais os maiores clientes com base no valor do pedido?

select    c.nome_cliente,  SUM(p.total) AS valor_de_pedidos
FROM
    Cliente c join   Pedido p ON c.id_cliente = p.id_cliente
GROUP by   c.nome_cliente
ORDER by   valor_de_pedidos DESC
LIMIT 3;

-- Qual o vendedor que mais vendeu?

select   v.nome_vendedor,   r.nome_revenda,   COUNT(p.id_pedido) AS numero_de_pedidos
from    Vendedor v
join   Revenda r ON v.id_revenda = r.id_revenda
join   Pedido p ON v.id_vendedor = p.id_vendedor
GROUP by   v.nome_vendedor, r.nome_revenda
ORDER by   numero_de_pedidos DESC
LIMIT 3;

-- Qual o valor total por cliente?

SELECT
    nome_mes,
    ano,
    SUM(total) AS valor_total_do_pedido
FROM (
    SELECT
        EXTRACT(MONTH FROM data_pedido) AS mes,
        TO_CHAR(data_pedido, 'Month') AS nome_mes,
        EXTRACT(YEAR FROM data_pedido) AS ano,
        total
    FROM
        Pedido
) AS subquery
GROUP BY
    ano, mes, nome_mes
ORDER BY
    ano, mes;
   
/*-- Seleciona o nome do "pivo" e o valor total dos pedidos para cada "pivo"
SELECT
    pivo_nome,                      -- Campo que representa o "pivo"
    SUM(total) AS valor_total_do_pedido -- Soma dos totais dos pedidos para cada "pivo"
FROM (
    -- Subconsulta para selecionar os campos necessários da tabela Pedido
    SELECT
        pivo_nome,                  -- Campo que representa o "pivo"
        total                       -- Total do pedido
    FROM
        Pedido
) AS subquery
-- Agrupa os resultados pelo campo "pivo_nome"
GROUP BY
    pivo_nome
-- Ordena os resultados em ordem decrescente pelo valor total do pedido
ORDER BY
    valor_total_do_pedido DESC
-- Limita o resultado a apenas um registro, que será o "pivo" com o maior valor total
LIMIT 1;
/*

-- Soma de todos os valores dos pedidos e cálculo da média
SELECT
    SUM(total) AS valor_total_pedidos,        -- Soma de todos os valores dos pedidos
    AVG(total) AS media_valor_pedidos          -- Média dos valores dos pedidos
FROM Pedido;



