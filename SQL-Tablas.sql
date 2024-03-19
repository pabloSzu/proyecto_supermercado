-- Tabla de proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    id_ranking INT,
    FOREIGN KEY (id_ranking) REFERENCES Ranking(id_ranking),
);

-- Tabla de productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_barra VARCHAR(255),
    nombre VARCHAR(255),
);

-- Tabla de precios por proveedor y producto
CREATE TABLE Precios (
    id_precio INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    id_producto INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
);

-- Tabla de pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fechaPedido DATE,
    estado ENUM('Pendiente', 'En proceso', 'Enviado', 'Entregado'),
    fecha_entrega_prevista DATE,
    fechaEntrega_real DATE,
    evaluacion_proveedor INT,
    FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
);

-- Tabla de detalle de pedido
CREATE TABLE DetallePedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
);

-- Tabla de tipos de rankings
CREATE TABLE Ranking (
    id_ranking INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    valor_min INT,
    valor_max INT,
);