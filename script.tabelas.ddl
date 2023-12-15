-- Criação das tabelas
-- As tabelas possuem chaves primárias autoincrementada
-- A tabela pedido_lances possui chave  primaria composta por id_pedido e id_lance

-- TABELA DE CLIENTES
-- A tabela cliente possui relacionamento com a tabela pedido.
-- Um cliente pode ter vários pedidos, mas um pedido está associado a um único cliente.

CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(255) NOT NULL,
    municipio_cliente VARCHAR(255)
);

-- TABELA DE FORNECEDORES
-- A tabela fornecedor possui relacionamento com as tabelas torre e lance
-- Um fornecedor pode fornecer vários itens de torre e lance, mas um item de torre ou lance está associado a um único fornecedor.

CREATE TABLE Fornecedor (
    id_fornecedor SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(255) NOT NULL,
    tipo_fornecedor VARCHAR(50) not NULL
);

ALTER TABLE Fornecedor
ALTER COLUMN tipo_fornecedor type VARCHAR(255);

-- TABELA DE REVENDA
-- A tabela revenda possui relacionamento com a tabela vendedor
-- Uma revenda pode ter vários vendedores, mas um vendedor está associado a uma única revenda.
-- A coluna situacao_revenda só pode ter valores A - Ativa ou I - Inativa

CREATE TABLE Revenda (
    id_revenda SERIAL PRIMARY KEY,
    nome_revenda VARCHAR(255),
    local_revenda VARCHAR(255),
    situacao_revenda CHAR(1) CHECK (situacao_revenda IN ('A', 'I'))
);

-- TABELA DE VENDEDOR
-- A tabela vendedor possui relacionamento com as tabelas revenda e pedido.
-- Um vendedor está associado a uma única revenda.
-- Um vendedor pode ter vários pedidos, mas um pedido está associado a um único vendedor.

CREATE TABLE Vendedor (
    id_vendedor SERIAL PRIMARY KEY,
    id_revenda INT NOT NULL,
    nome_vendedor VARCHAR(255),
    FOREIGN KEY (id_revenda) REFERENCES Revenda(id_revenda)
);

-- TABELA DOS ITENS DA TORRE PIVÔ
CREATE TABLE Torre (
    id_torre SERIAL PRIMARY KEY,
    painel_controle VARCHAR(255),
    tubo_aco_zincado VARCHAR(255),
    estrutura_apoio INT,
    curva_aco_zincado VARCHAR(255),
    cabo_eletrico VARCHAR(255),
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

ALTER TABLE Torre
ALTER COLUMN estrutura_apoio TYPE VARCHAR(255);

ALTER TABLE Torre
ALTER COLUMN id_fornecedor int default NULL;

-- TABELA DOS ITENS DO LANCE PIVÔ
CREATE TABLE Lance (
    id_lance SERIAL PRIMARY KEY,
    tubo_aco_zincado VARCHAR(255),
    spray VARCHAR(255)  NOT NULL,
    mangueira VARCHAR(255) NOT NULL,
    parafuso VARCHAR(255) NOT NULL,
    motoredutor VARCHAR(255) NOT NULL,
    roda_pneu VARCHAR(255) NOT NULL,
    estrutura_apoio INT,
    estrutura_equilibrio INT,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

ALTER TABLE Lance
ALTER COLUMN estrutura_apoio TYPE VARCHAR(255);

ALTER TABLE Lance
ALTER COLUMN estrutura_equilibrio TYPE VARCHAR(255);

-- TABELA PIVÔ
CREATE TABLE Pivo (
    id_pivo SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    id_torre INT,
    id_lance INT,
    FOREIGN KEY (id_torre) REFERENCES Torre(id_torre),
    FOREIGN KEY (id_lance) REFERENCES Lance(id_lance)
);

-- TABELA DE PEDIDOS
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_torre INT NOT NULL,
    area NUMERIC(10,2) NOT NULL,
    total NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    FOREIGN KEY (id_torre) REFERENCES Torre(id_torre)
);

ALTER TABLE Pedido
ADD COLUMN data_pedido DATE NULL;

-- TABELA DE PEDIDO_LANCES
CREATE TABLE Pedido_Lances (
    id_pedido INT NOT NULL,
    id_lance INT NOT NULL,
    PRIMARY KEY (id_pedido, id_lance),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_lance) REFERENCES Lance(id_lance)
);
