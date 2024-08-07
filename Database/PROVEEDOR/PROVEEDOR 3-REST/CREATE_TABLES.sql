IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PROVEEDOR1')
    CREATE DATABASE PROVEEDOR3;
GO
USE PROVEEDOR3
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DETALLE_PEDIDO')
    DROP TABLE DETALLE_PEDIDO;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PRODUCTOS')
    DROP TABLE PRODUCTOS;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MOVIMIENTO_PEDIDO')
    DROP TABLE MOVIMIENTO_PEDIDO;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PEDIDOS')
    DROP TABLE PEDIDOS;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CONFIGURACION')
    DROP TABLE CONFIGURACION;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RANKING')
    DROP TABLE RANKING;
  
--///////////////////////////////////////////////////////////////////////////////////////////////   



-- Tabla RANKING
CREATE TABLE RANKING (
    evaluacion VARCHAR(50)
);

-- Tabla CONFIGURACION
CREATE TABLE CONFIGURACION (
    nombre_url VARCHAR(50),
    nombre VARCHAR(50),
    cuil VARCHAR(150),
    mail VARCHAR(150),
    token VARCHAR(150),    
);

-- Tabla PEDIDOS
CREATE TABLE PEDIDOS (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    codigo_estado VARCHAR(20) CHECK (codigo_estado IN ('CANCELADO','PENDIENTE', 'EN_PROCESO', 'ENVIADO', 'ENTREGADO')),
    fecha_entrega_prevista DATETIME,
    fecha_entrega_real DATETIME,
    fecha_pedido DATETIME,
    evaluacion VARCHAR(50),
    total INT,
    codigo_seguimiento VARCHAR(150)
);

-- Tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    codigo_barra VARCHAR(150) PRIMARY KEY,
    nombre VARCHAR(150),
    precio INT,
    fecha_actualizacion_precio DATETIME,
);

-- Tabla DETALLE_PEDIDO
CREATE TABLE DETALLE_PEDIDO (
    id_pedido INT,
    codigo_barra VARCHAR(150),
    cantidad INT,
    precio_unitario INT,
    PRIMARY KEY (id_pedido, codigo_barra),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDOS(id_pedido),
    FOREIGN KEY (codigo_barra) REFERENCES PRODUCTOS(codigo_barra)
);
GO


-- TRIGGER para actualizar la fecha_entrega_real cuando se marca el pedido como ENTREGADO
CREATE TRIGGER trg_update_fecha_entrega_real
ON PEDIDOS
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PEDIDOS
    SET fecha_entrega_real = GETDATE()
    FROM inserted i
    WHERE PEDIDOS.id_pedido = i.id_pedido
      AND i.codigo_estado = 'ENTREGADO'
      AND (PEDIDOS.fecha_entrega_real IS NULL OR PEDIDOS.fecha_entrega_real <> GETDATE());
END;
GO