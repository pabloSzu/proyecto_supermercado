
USE supermercado; 
-- Tabla de tipos de rankings
CREATE TABLE Ranking (
    id_ranking INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    valor_min INT,
    valor_max INT
);

-- Tabla de proveedores
CREATE TABLE Proveedores (
    id_proveedor INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(255),
    id_ranking INT,
    FOREIGN KEY (id_ranking) REFERENCES Ranking(id_ranking)
);

-- Tabla de productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY,
    codigo_barra VARCHAR(255),
    nombre VARCHAR(255)
);

-- Tabla de precios por proveedor y producto
CREATE TABLE Precios (
    id_precio INT PRIMARY KEY IDENTITY,
    id_proveedor INT,
    id_producto INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla de pedidos
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY IDENTITY,
    id_proveedor INT,
    fechaPedido DATE,
    estado VARCHAR(20), -- Cambiado a VARCHAR ya que SQL Server no soporta ENUM directamente
    fecha_entrega_prevista DATE,
    fechaEntrega_real DATE,
    evaluacion_proveedor INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);

-- Tabla de detalle de pedido
CREATE TABLE DetallePedido (
    id_detalle INT PRIMARY KEY IDENTITY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
