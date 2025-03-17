USE Ecommerce;
-- Recuperações ------
SELECT * FROM Cliente;
-- Recuperar Todos os Pedidos de um Cliente Específico
SELECT p.idPedido, p.Status_Pedido, p.Data_Pedido, c.Nome
FROM Pedido p
JOIN Cliente c ON p.Cliente_idCliente = c.idCliente
WHERE c.Nome = 'João Silva';

-- Filtros com WHERE
SELECT * FROM Produto WHERE Valor > 1000;

-- Expressões para Gerar Atributos Derivados
SELECT Nome, YEAR(CURDATE()) - YEAR(DataNascimento) AS Idade FROM Cliente_PF;

-- Ordenações com ORDER BY
SELECT * FROM Produto ORDER BY Valor DESC;

-- Filtros com HAVING
SELECT Cliente_idCliente, COUNT(*) AS TotalPedidos FROM Pedido GROUP BY Cliente_idCliente HAVING TotalPedidos > 1;

-- Junções entre Tabelas
SELECT c.Nome, p.Descricao, pp.Quantidade, pp.Preco_Venda
FROM Cliente c
JOIN Pedido pd ON c.idCliente = pd.Cliente_idCliente
JOIN Produto_Pedido pp ON pd.idPedido = pp.Pedido_idPedido
JOIN Produto p ON pp.Produto_idProduto = p.idProduto;

-- Listar Todos os Pedidos com Período de Carência Acima de 30 Dias
SELECT idPedido, Data_Pedido, Periodo_Carencia
FROM Pedido
WHERE Periodo_Carencia > 30;

-- Recuperar o Total de Produtos em Cada Estoque
SELECT e.Local, SUM(pe.Quantidade) AS Total_Produtos
FROM Produto_has_Estoque pe
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque
GROUP BY e.Local;

-- Recuperar o Número de Pedidos por Status
SELECT Status_Pedido, COUNT(*) AS Total_Pedidos
FROM Pedido
GROUP BY Status_Pedido;

-- Listar Todos os Clientes que São Pessoas Físicas e Fizeram Pedidos
SELECT c.Nome, cp.CPF
FROM Cliente c
JOIN Cliente_PF cp ON c.idCliente = cp.Cliente_idCliente
JOIN Pedido p ON c.idCliente = p.Cliente_idCliente;

-- Listar Todos os Produtos Disponíveis em um Estoque Específico
SELECT pr.Descricao, pe.Quantidade, e.Local
FROM Produto_has_Estoque pe
JOIN Produto pr ON pe.Produto_idProduto = pr.idProduto
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque
WHERE e.Local = 'Armazém Central';

-- Calcular o Valor Total de um Pedido
SELECT pp.Pedido_idPedido, SUM(pp.Quantidade * pp.Preco_Venda) AS Valor_Total
FROM Produto_Pedido pp
WHERE pp.Pedido_idPedido = 1
GROUP BY pp.Pedido_idPedido;
