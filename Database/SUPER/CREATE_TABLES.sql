IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SUPER')
    CREATE DATABASE SUPER;
GO
USE SUPER
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DETALLE_PEDIDO')
    DROP TABLE DETALLE_PEDIDO;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PRODUCTO_PROVEEDOR')
    DROP TABLE PRODUCTO_PROVEEDOR;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PRODUCTOS')
    DROP TABLE PRODUCTOS;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MOVIMIENTO_PEDIDO')
    DROP TABLE MOVIMIENTO_PEDIDO;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PEDIDOS')
    DROP TABLE PEDIDOS;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PONDERACION')
    DROP TABLE PONDERACION;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RANKING')
    DROP TABLE RANKING;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PROVEEDORES')
    DROP TABLE PROVEEDORES;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'USUARIOS')
    DROP TABLE USUARIOS;


--///////////////////////////////////////////////////////////////////////////////////////////////   



-- Crear la tabla USUARIOS
CREATE TABLE USUARIOS (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    usuario VARCHAR(50),
    clave VARCHAR(50)
);

-- Insertar un ejemplo en la tabla USUARIOS

-- Tabla PROVEEDOR
CREATE TABLE PROVEEDORES (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    cuil VARCHAR(150),
    mail VARCHAR(150),
    nombre_url VARCHAR(150),
    token VARCHAR(150),
    puntaje FLOAT,
    habilitado BIT DEFAULT 0,
);


-- Tabla RANKING
CREATE TABLE RANKING (
    id_ranking INT IDENTITY(1,1) PRIMARY KEY ,
    id_proveedor INT,
    evaluacion VARCHAR(50),      --es el valor del ranking que nos pasa el proveedor (ej: Bueno)
    ponderacion INT,        --es la ponderacion (puntaje) que le ponemos al valor del ranking que nos pasa el proveedor (ej: 6) -> le asignamos un 6 a "Bueno"
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor)
);


-- Tabla PEDIDOS
CREATE TABLE PEDIDOS (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_proveedor INT,
    codigo_estado VARCHAR(20) CHECK (codigo_estado IN ('NO_REALIZADO', 'PENDIENTE', 'EN_PROCESO', 'ENVIADO', 'ENTREGADO', 'CANCELADO')),
    fecha_entrega_prevista DATETIME,
    fecha_entrega_real DATETIME,
    fecha_pedido DATETIME,
    evaluacion VARCHAR(50),      --es el valor del ranking que nos pasa el proveedor (ej: Bueno)
	ponderacion INT,        --es la ponderacion (puntaje) que le ponemos al valor del ranking que nos pasa el proveedor (ej: 6) -> le asignamos un 6 a "Bueno"
    total INT,
    codigo_seguimiento VARCHAR(150),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor)
);

-- Tabla MOVIMIENTO_PEDIDO
CREATE TABLE MOVIMIENTO_PEDIDO (
    id_pedido INT PRIMARY KEY,
    codigo_estado VARCHAR(20) DEFAULT 'NO_REALIZADO' CHECK (codigo_estado IN ('NO_REALIZADO', 'PENDIENTE', 'EN_PROCESO', 'ENVIADO', 'ENTREGADO', 'CANCELADO')),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDOS(id_pedido)
);

-- Tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    codigo_barra VARCHAR(150) PRIMARY KEY,
    nombre VARCHAR(150),
    imagen_nombre VARCHAR(150),
    imagen_contenido VARBINARY(MAX),
    imagen_extension VARCHAR(5),
    stock_actual INT,
    stock_optimo INT,
);

-- Tabla PRODUCTO_PROVEEDOR
CREATE TABLE PRODUCTO_PROVEEDOR (
    codigo_barra VARCHAR(150),
    id_proveedor INT,
    nombre VARCHAR(150),
    precio INT,
    fecha_actualizacion_precio DATETIME
    PRIMARY KEY (codigo_barra, id_proveedor),
    FOREIGN KEY (codigo_barra) REFERENCES PRODUCTOS(codigo_barra),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor)
);

-- Tabla DETALLE_PEDIDO
CREATE TABLE DETALLE_PEDIDO (
    id_pedido INT,
    codigo_barra VARCHAR(150),
    cantidad INT,
    precio_unitario INT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pedido, codigo_barra),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDOS(id_pedido),
    FOREIGN KEY (codigo_barra) REFERENCES PRODUCTOS(codigo_barra)
);


 
		