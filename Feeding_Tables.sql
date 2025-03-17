USE Ecommerce;

INSERT INTO Cliente (idCliente, Nome, Tipo, Email, Endereco, Telefone)
    VALUES
      (1, 'João Silva', 'PF', 'joao.silva@example.com', 'Rua A, 123', '1234-5678'),
      (2, 'Empresa XYZ', 'PJ', 'contato@xyz.com', 'Av. B, 456', '8765-4321'),
      (3, 'Janaina da Silva', 'PF', 'jana.silva@example.com', 'Rua Z, 567', '1256-5478'),
      (4, 'Francisco Ronaldo', 'PF', 'Roanldo.Francisco@example.com', 'Rua 7, 589', '0054-7892');

INSERT INTO Cliente_PF (idCliente_PF, CPF, Nome, DataNascimento, Cliente_idCliente) 
   VALUES
      (1, '123.456.789-00', 'João Silva', '1990-01-01', 1),
      (2, '455.123.776-00', 'Janaina da Silva', '1999-06-14', 3),
      (3, '673.421.789-00', 'Francisco Ronaldo', '1985-10-04', 4);
      

INSERT INTO Cliente_PJ (idCliente_PJ, CNPJ, Razao_Social, Nome, Cliente_idCliente) 
   VALUES
     (8, '10.345.678/0001-99', 'Empresa XYZ Ltda', 'Empresa XYZ', 2);

INSERT INTO Produto (idProduto, Categoria, Descricao, Valor)
  VALUES
	(1, 'Eletrônicos', 'Smartphone', 1500.00),
    (2, 'Livros', 'Livro de SQL', 100.00);
    
    -- Criar uma entrega
INSERT INTO Entrega (idEntrega, Status_Entrega, Codigo_Rastreamento, Data_Entrega)
  VALUES
   (1, 'Em processamento', 'ABC123', '2023-10-10');

INSERT INTO Pedido (idPedido, Status_Pedido, Descricao, Cliente_idCliente, Frete, Data_Pedido, Periodo_Carencia, Entrega_idEntrega) 
 VALUES
    (1, 'Processando', 'Pedido de João', 1, 15.00, '2023-10-01', 30, 1);

INSERT INTO Produto_Pedido (Pedido_idPedido, Produto_idProduto, Quantidade, Preco_Venda) 
   VALUES
    (1, 1, 1, 1500.00);