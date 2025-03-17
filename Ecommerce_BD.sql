create database Ecommerce;
use Ecommerce;

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Tipo ENUM('PF', 'PJ') NOT NULL,
    Email VARCHAR(60) NOT NULL UNIQUE, -- Email deve ser único
    Endereco VARCHAR(70) NOT NULL,
    Telefone VARCHAR(14) NOT NULL
);

CREATE TABLE Cliente_PF (
    idCliente_PF INT PRIMARY KEY AUTO_INCREMENT,
    CPF VARCHAR(14) NOT NULL UNIQUE, -- CPF deve ser único
    Nome VARCHAR(60) NOT NULL,
    DataNascimento DATE NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Cliente_PJ (
    idCliente_PJ INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ VARCHAR(18) NOT NULL UNIQUE, -- CNPJ deve ser único
    Razao_Social VARCHAR(80) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    Categoria VARCHAR(45) NOT NULL,
    Descricao VARCHAR(45) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL CHECK (Valor >= 0) -- Valor não pode ser negativo
);

CREATE TABLE Terceiro_Vendedor (
    idTerceiro_Vendedor INT PRIMARY KEY AUTO_INCREMENT,
    Razao_Social VARCHAR(45) NOT NULL,
    Local VARCHAR(45) NOT NULL,
    Contato VARCHAR(45) NOT NULL,
    UNIQUE (Razao_Social) -- Garante que a Razão Social seja única
);

CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY AUTO_INCREMENT,
    Status_Entrega VARCHAR(45) NOT NULL,
    Codigo_Rastreamento VARCHAR(45) NOT NULL UNIQUE, -- Código de rastreamento deve ser único
    Data_Entrega DATE
);

CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    Local VARCHAR(45) NOT NULL
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    Status_Pedido VARCHAR(45) NOT NULL,
    Descricao VARCHAR(45),
    Cliente_idCliente INT NOT NULL,
    Frete FLOAT NOT NULL CHECK (Frete >= 0), -- Frete não pode ser negativo
    Data_Pedido DATE NOT NULL DEFAULT (CURDATE()), -- Data padrão é a data atual
    Periodo_Carencia INT NOT NULL CHECK (Periodo_Carencia >= 0), -- Período de carência não pode ser negativo
    Entrega_idEntrega INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Entrega_idEntrega) REFERENCES Entrega(idEntrega)
);

CREATE TABLE Produto_Por_Vendedor (
    Terceiro_Vendedor_idTerceiro_Vendedor INT NOT NULL,
    Produto_idProduto INT NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade >= 0), -- Quantidade não pode ser negativa
    PRIMARY KEY (Terceiro_Vendedor_idTerceiro_Vendedor, Produto_idProduto),
    FOREIGN KEY (Terceiro_Vendedor_idTerceiro_Vendedor) REFERENCES Terceiro_Vendedor(idTerceiro_Vendedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Disponibiliza_Produto (
    Fornecedor_idFornecedor INT NOT NULL,
    Produto_idProduto INT NOT NULL,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Produto_has_Estoque (
    Produto_idProduto INT NOT NULL,
    Estoque_idEstoque INT NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade >= 0), -- Quantidade não pode ser negativa
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Produto_Pedido (
    Pedido_idPedido INT NOT NULL,
    Produto_idProduto INT NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade >= 0), -- Quantidade não pode ser negativa
    Preco_Venda DECIMAL(10,2) NOT NULL CHECK (Preco_Venda >= 0), -- Preço de venda não pode ser negativo
    PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

