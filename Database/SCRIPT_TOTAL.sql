IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PROVEEDOR1')
    CREATE DATABASE PROVEEDOR1;
GO
USE PROVEEDOR1
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

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PROVEEDOR2')
    CREATE DATABASE PROVEEDOR2;
GO
USE PROVEEDOR2
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
    nombre_url VARCHAR(150),
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

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PROVEEDOR3')
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

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PROVEEDOR4')
    CREATE DATABASE PROVEEDOR4;
GO
USE PROVEEDOR4
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
    nombre_url VARCHAR(150),
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
    imagen_contenido VARBINARY(MAX),
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


 
		








GO
CREATE OR ALTER TRIGGER tr_UpdateStockOnPedidoEntregado
ON PEDIDOS
AFTER UPDATE
AS
BEGIN
    -- Verifica si el estado del pedido se actualizó a 'ENTREGADO'
    IF UPDATE(codigo_estado)
    BEGIN
        -- Declara las variables necesarias
        DECLARE @id_pedido INT;
        DECLARE @codigo_estado VARCHAR(20);

        -- Selecciona los pedidos que fueron actualizados a 'ENTREGADO'
        SELECT @id_pedido = i.id_pedido, @codigo_estado = i.codigo_estado
        FROM INSERTED i
        WHERE i.codigo_estado = 'ENTREGADO';

        -- Actualiza el stock_actual en la tabla PRODUCTOS basándose en el DETALLE_PEDIDO
        IF @codigo_estado = 'ENTREGADO'
        BEGIN
            UPDATE p
            SET p.stock_actual = p.stock_actual + dp.cantidad
            FROM PRODUCTOS p
            INNER JOIN DETALLE_PEDIDO dp ON p.codigo_barra = dp.codigo_barra
            WHERE dp.id_pedido = @id_pedido;
        END
    END
END;
GO


--PROCEDIMIENTOS PROVEEDOR

USE PROVEEDOR1
GO






--//////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER CONFIGURACION
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_CONFIGURACION]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM CONFIGURACION 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Configuracion;
	END;
GO

USE PROVEEDOR1
EXECUTE OBTENER_CONFIGURACION
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PRODUCTOS]
AS
BEGIN
DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM PRODUCTOS 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Productos;
END;
GO
EXECUTE OBTENER_PRODUCTOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER RANKING
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_RANKING]
AS
BEGIN
  DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM RANKING 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Ranking;
END;
GO
EXECUTE OBTENER_RANKING
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDO] @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
BEGIN

DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PEDIDOS
    SELECT @jsonResult = (
        SELECT * 
        FROM PEDIDOS 
		WHERE codigo_seguimiento = @codigo_seguimiento
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedido;
	END;
GO
EXECUTE OBTENER_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENGO TODOS LOS PEDIDOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDOS]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * FROM PEDIDOS ORDER BY 
    fecha_pedido DESC,
    CASE codigo_estado
        WHEN 'PENDIENTE' THEN 1
        WHEN 'EN_PROCESO' THEN 2
        WHEN 'ENVIADO' THEN 3
        WHEN 'ENTREGADO' THEN 4
        WHEN 'CANCELADO' THEN 5
        ELSE 6
		END
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos
	END;
	GO
EXECUTE OBTENER_PEDIDOS 
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--////////////////////////////////////////////////////////////////////////////////////////////////////////////////CANCELAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER     PROCEDURE [dbo].[CANCELAR_PEDIDO]
    @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
DECLARE @jsonResult NVARCHAR(MAX);
BEGIN

	IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado IN ('PENDIENTE'))
    BEGIN
        -- Si el codigo_estado es 'PENDIENTE' , lo cambia a CANCELADO  
		UPDATE PEDIDOS
	    SET codigo_estado = 'CANCELADO'
		WHERE codigo_seguimiento = @codigo_seguimiento

		 SELECT @jsonResult = (
            SELECT *
            FROM PEDIDOS
            WHERE codigo_seguimiento = @codigo_seguimiento
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
    ELSE
    BEGIN
        -- Si no es 'PENDIENTE', lanzar un error o mensaje informativo
        RAISERROR('El pedido no está en estado PENDIENTE o no EXISTE. No se puede cancelar.', 16, 1);
    END	
END;
GO
/*
EXECUTE CANCELAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////PUNTUAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[EVALUAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @codigo_seguimiento VARCHAR(150);
    DECLARE @evaluacion VARCHAR(150);

    -- Extraer valores del JSON
    SELECT
        @codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento'),
        @evaluacion = JSON_VALUE(@json, '$.evaluacion');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Verificar si el pedido está en estado 'ENTREGADO'
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado = 'ENTREGADO')
    BEGIN
        -- Verificar si la evaluación está en la tabla RANKING
        IF EXISTS (SELECT 1 FROM RANKING WHERE evaluacion = @evaluacion)
        BEGIN
            -- Actualizar la evaluación del pedido
            UPDATE PEDIDOS
            SET evaluacion = @evaluacion
            WHERE codigo_seguimiento = @codigo_seguimiento;

            -- Seleccionar el pedido actualizado y convertirlo a JSON
            SELECT @jsonResult = (
                SELECT *
                FROM PEDIDOS
                WHERE codigo_seguimiento = @codigo_seguimiento
                FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
            );

            -- Devolver el JSON con un nombre de columna específico
            SELECT @jsonResult AS Pedido;
        END
        ELSE
        BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('La evaluación no es válida. No se puede puntuar.', 16, 1);
        END
    END
    ELSE
    BEGIN
        -- Lanzar un error si el pedido no está en estado ENTREGADO
        RAISERROR('El pedido no está en estado ENTREGADO. No se puede puntuar.', 16, 1);
    END
END;
GO
/*
EXECUTE EVALUAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456","evaluacion":"Regular"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--/////////////////////////////////////////////////////////////////////////INSERTAR_PEDIDO 
-- Procedimiento para insertar un nuevo pedido
CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_PEDIDO]
    @id_pedido INT OUTPUT
AS
BEGIN
    DECLARE @fecha_actual DATETIME = GETDATE();
    DECLARE @codigo_seguimiento VARCHAR(150) = CONCAT('ABCD', FLOOR(RAND() * (999999 - 1) + 1));
    DECLARE @nuevo_id_pedido TABLE (id_pedido INT);

    -- Insertar el nuevo pedido y capturar el id_pedido generado
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento) 
    OUTPUT inserted.id_pedido INTO @nuevo_id_pedido
    VALUES (
        'PENDIENTE',
        DATEADD(DAY, 3, @fecha_actual),
        NULL,
        @fecha_actual,
        NULL,
        0,
        @codigo_seguimiento
    );

    -- Asignar el id_pedido generado al parámetro de salida
    SELECT @id_pedido = id_pedido FROM @nuevo_id_pedido;
END;
GO


CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_DETALLE]
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @id_pedido INT;
    DECLARE @total DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio
    SET @total = 0;

    -- Llamar al procedimiento para insertar un nuevo pedido y obtener el id_pedido
    EXEC INSERTAR_PEDIDO @id_pedido OUTPUT;

    -- Verificar si el pedido fue insertado correctamente
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se pudo insertar el pedido.', 16, 1);
        RETURN;
    END

    -- Procesar el JSON y recorrer los elementos
    DECLARE @json_table TABLE (
        codigo_barra NVARCHAR(150),
        cantidad INT
    );

    INSERT INTO @json_table (codigo_barra, cantidad)
    SELECT codigo_barra, cantidad
    FROM OPENJSON(@json)
    WITH (
        codigo_barra NVARCHAR(150) '$.codigo_barra',
        cantidad INT '$.cantidad'
    );

    -- Insertar los detalles del pedido
    DECLARE @codigo_barra NVARCHAR(150);
    DECLARE @cantidad INT;
    DECLARE @precio_unitario DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio

    DECLARE detalle_cursor CURSOR FOR
    SELECT codigo_barra, cantidad FROM @json_table;

    OPEN detalle_cursor;
    FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener el precio del producto
        SELECT @precio_unitario = precio
        FROM PRODUCTOS
        WHERE codigo_barra = @codigo_barra;

        -- Verificar si el precio fue encontrado
        IF @precio_unitario IS NULL
        BEGIN
            RAISERROR('No se encontró el precio para el código de barra: %s', 16, 1, @codigo_barra);
            CLOSE detalle_cursor;
            DEALLOCATE detalle_cursor;
            RETURN;
        END

        -- Calcular el total
        SET @total = @total + (@precio_unitario * @cantidad);

        -- Insertar en DETALLE_PEDIDO
        INSERT INTO DETALLE_PEDIDO (
            id_pedido,
            codigo_barra,
            cantidad,
            precio_unitario
        ) VALUES (
            @id_pedido,
            @codigo_barra,
            @cantidad,
            @precio_unitario
        );

        FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;
    END;

    CLOSE detalle_cursor;
    DEALLOCATE detalle_cursor;

    -- Actualizar el total en la tabla PEDIDOS
    UPDATE PEDIDOS
    SET total = @total
    WHERE id_pedido = @id_pedido;

    -- Devolver el código de seguimiento como JSON con nombre de columna "Pedido"
    DECLARE @jsonResult NVARCHAR(MAX);

    SELECT @jsonResult = (SELECT TOP 1 p.codigo_seguimiento
                          FROM PEDIDOS p
                          WHERE p.id_pedido = @id_pedido 
                          FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER);

    -- Mostrar el resultado final
    SELECT @jsonResult AS Pedido;

END;
GO





GO
/*
DECLARE @json NVARCHAR(MAX) = '[{"codigo_barra":"005005","cantidad":8},{"codigo_barra":"005005","cantidad":15}]';
EXEC INSERTAR_DETALLE @json;
*/
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_DETALLES_ULTIMO_PEDIDO]
AS
BEGIN
    DECLARE @id_pedido INT;

    -- Obtener el ID del último pedido (el más grande)
    SELECT @id_pedido = MAX(id_pedido) FROM PEDIDOS;

    -- Verificar si se encontró un pedido
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se encontraron pedidos.', 16, 1);
        RETURN;
    END

    -- Datos del pedido
    DECLARE @pedido NVARCHAR(MAX);
    SELECT @pedido = (SELECT p.id_pedido, p.codigo_estado, p.fecha_entrega_prevista, p.fecha_entrega_real, p.fecha_pedido, p.evaluacion, p.total, p.codigo_seguimiento
                      FROM PEDIDOS p
                      WHERE p.id_pedido = @id_pedido
                      FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    -- Datos del detalle del pedido
    DECLARE @detalles NVARCHAR(MAX);
    SELECT @detalles = (SELECT dp.codigo_barra, dp.cantidad, dp.precio_unitario
                        FROM DETALLE_PEDIDO dp
                        WHERE dp.id_pedido = @id_pedido
                        FOR JSON PATH);

    -- Combinar ambos resultados en un solo JSON
    DECLARE @jsonResult NVARCHAR(MAX);
    SET @jsonResult = CONCAT('[{"Pedido":', @pedido, ', "Detalles":', @detalles, '}]');

    -- Devolver el resultado final
    SELECT @jsonResult AS Resultado;
END;
GO

EXEC OBTENER_DETALLES_ULTIMO_PEDIDO
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




--PROCEDIMIENTOS PROVEEDOR

USE PROVEEDOR2
GO






--//////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER CONFIGURACION
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_CONFIGURACION]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM CONFIGURACION 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Configuracion;
	END;
GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PRODUCTOS]
AS
BEGIN
DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM PRODUCTOS 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Productos;
END;
GO
EXECUTE OBTENER_PRODUCTOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER RANKING
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_RANKING]
AS
BEGIN
  DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM RANKING 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Ranking;
END;
GO
EXECUTE OBTENER_RANKING
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDO] @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
BEGIN

DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PEDIDOS
    SELECT @jsonResult = (
        SELECT * 
        FROM PEDIDOS 
		WHERE codigo_seguimiento = @codigo_seguimiento
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedido;
	END;
GO
EXECUTE OBTENER_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENGO TODOS LOS PEDIDOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDOS]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * FROM PEDIDOS ORDER BY 
    fecha_pedido DESC,
    CASE codigo_estado
        WHEN 'PENDIENTE' THEN 1
        WHEN 'EN_PROCESO' THEN 2
        WHEN 'ENVIADO' THEN 3
        WHEN 'ENTREGADO' THEN 4
        WHEN 'CANCELADO' THEN 5
        ELSE 6
		END
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos
	END;
	GO
EXECUTE OBTENER_PEDIDOS 
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--////////////////////////////////////////////////////////////////////////////////////////////////////////////////CANCELAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER     PROCEDURE [dbo].[CANCELAR_PEDIDO]
    @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
DECLARE @jsonResult NVARCHAR(MAX);
BEGIN

	IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado IN ('PENDIENTE'))
    BEGIN
        -- Si el codigo_estado es 'PENDIENTE' , lo cambia a CANCELADO  
		UPDATE PEDIDOS
	    SET codigo_estado = 'CANCELADO'
		WHERE codigo_seguimiento = @codigo_seguimiento

		 SELECT @jsonResult = (
            SELECT *
            FROM PEDIDOS
            WHERE codigo_seguimiento = @codigo_seguimiento
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
    ELSE
    BEGIN
        -- Si no es 'PENDIENTE', lanzar un error o mensaje informativo
        RAISERROR('El pedido no está en estado PENDIENTE o no EXISTE. No se puede cancelar.', 16, 1);
    END	
END;
GO
/*
EXECUTE CANCELAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////PUNTUAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[EVALUAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @codigo_seguimiento VARCHAR(150);
    DECLARE @evaluacion VARCHAR(150);

    -- Extraer valores del JSON
    SELECT
        @codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento'),
        @evaluacion = JSON_VALUE(@json, '$.evaluacion');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Verificar si el pedido está en estado 'ENTREGADO'
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado = 'ENTREGADO')
    BEGIN
        -- Verificar si la evaluación está en la tabla RANKING
        IF EXISTS (SELECT 1 FROM RANKING WHERE evaluacion = @evaluacion)
        BEGIN
            -- Actualizar la evaluación del pedido
            UPDATE PEDIDOS
            SET evaluacion = @evaluacion
            WHERE codigo_seguimiento = @codigo_seguimiento;

            -- Seleccionar el pedido actualizado y convertirlo a JSON
            SELECT @jsonResult = (
                SELECT *
                FROM PEDIDOS
                WHERE codigo_seguimiento = @codigo_seguimiento
                FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
            );

            -- Devolver el JSON con un nombre de columna específico
            SELECT @jsonResult AS Pedido;
        END
        ELSE
        BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('La evaluación no es válida. No se puede puntuar.', 16, 1);
        END
    END
    ELSE
    BEGIN
        -- Lanzar un error si el pedido no está en estado ENTREGADO
        RAISERROR('El pedido no está en estado ENTREGADO. No se puede puntuar.', 16, 1);
    END
END;
GO
/*
EXECUTE EVALUAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456","evaluacion":"Regular"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--/////////////////////////////////////////////////////////////////////////INSERTAR_PEDIDO 
-- Procedimiento para insertar un nuevo pedido
CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_PEDIDO]
    @id_pedido INT OUTPUT
AS
BEGIN
    DECLARE @fecha_actual DATETIME = GETDATE();
    DECLARE @codigo_seguimiento VARCHAR(150) = CONCAT('ABCD', FLOOR(RAND() * (999999 - 1) + 1));
    DECLARE @nuevo_id_pedido TABLE (id_pedido INT);

    -- Insertar el nuevo pedido y capturar el id_pedido generado
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento) 
    OUTPUT inserted.id_pedido INTO @nuevo_id_pedido
    VALUES (
        'PENDIENTE',
        DATEADD(DAY, 3, @fecha_actual),
        NULL,
        @fecha_actual,
        NULL,
        0,
        @codigo_seguimiento
    );

    -- Asignar el id_pedido generado al parámetro de salida
    SELECT @id_pedido = id_pedido FROM @nuevo_id_pedido;
END;
GO


CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_DETALLE]
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @id_pedido INT;
    DECLARE @total DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio
    SET @total = 0;

    -- Llamar al procedimiento para insertar un nuevo pedido y obtener el id_pedido
    EXEC INSERTAR_PEDIDO @id_pedido OUTPUT;

    -- Verificar si el pedido fue insertado correctamente
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se pudo insertar el pedido.', 16, 1);
        RETURN;
    END

    -- Procesar el JSON y recorrer los elementos
    DECLARE @json_table TABLE (
        codigo_barra NVARCHAR(150),
        cantidad INT
    );

    INSERT INTO @json_table (codigo_barra, cantidad)
    SELECT codigo_barra, cantidad
    FROM OPENJSON(@json)
    WITH (
        codigo_barra NVARCHAR(150) '$.codigo_barra',
        cantidad INT '$.cantidad'
    );

    -- Insertar los detalles del pedido
    DECLARE @codigo_barra NVARCHAR(150);
    DECLARE @cantidad INT;
    DECLARE @precio_unitario DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio

    DECLARE detalle_cursor CURSOR FOR
    SELECT codigo_barra, cantidad FROM @json_table;

    OPEN detalle_cursor;
    FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener el precio del producto
        SELECT @precio_unitario = precio
        FROM PRODUCTOS
        WHERE codigo_barra = @codigo_barra;

        -- Verificar si el precio fue encontrado
        IF @precio_unitario IS NULL
        BEGIN
            RAISERROR('No se encontró el precio para el código de barra: %s', 16, 1, @codigo_barra);
            CLOSE detalle_cursor;
            DEALLOCATE detalle_cursor;
            RETURN;
        END

        -- Calcular el total
        SET @total = @total + (@precio_unitario * @cantidad);

        -- Insertar en DETALLE_PEDIDO
        INSERT INTO DETALLE_PEDIDO (
            id_pedido,
            codigo_barra,
            cantidad,
            precio_unitario
        ) VALUES (
            @id_pedido,
            @codigo_barra,
            @cantidad,
            @precio_unitario
        );

        FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;
    END;

    CLOSE detalle_cursor;
    DEALLOCATE detalle_cursor;

    -- Actualizar el total en la tabla PEDIDOS
    UPDATE PEDIDOS
    SET total = @total
    WHERE id_pedido = @id_pedido;

    -- Devolver el código de seguimiento como JSON con nombre de columna "Pedido"
    DECLARE @jsonResult NVARCHAR(MAX);

    SELECT @jsonResult = (SELECT TOP 1 p.codigo_seguimiento
                          FROM PEDIDOS p
                          WHERE p.id_pedido = @id_pedido 
                          FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER);

    -- Mostrar el resultado final
    SELECT @jsonResult AS Pedido;

END;
GO





GO
/*
DECLARE @json NVARCHAR(MAX) = '[{"codigo_barra":"005005","cantidad":8},{"codigo_barra":"005005","cantidad":15}]';
EXEC INSERTAR_DETALLE @json;
*/
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_DETALLES_ULTIMO_PEDIDO]
AS
BEGIN
    DECLARE @id_pedido INT;

    -- Obtener el ID del último pedido (el más grande)
    SELECT @id_pedido = MAX(id_pedido) FROM PEDIDOS;

    -- Verificar si se encontró un pedido
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se encontraron pedidos.', 16, 1);
        RETURN;
    END

    -- Datos del pedido
    DECLARE @pedido NVARCHAR(MAX);
    SELECT @pedido = (SELECT p.id_pedido, p.codigo_estado, p.fecha_entrega_prevista, p.fecha_entrega_real, p.fecha_pedido, p.evaluacion, p.total, p.codigo_seguimiento
                      FROM PEDIDOS p
                      WHERE p.id_pedido = @id_pedido
                      FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    -- Datos del detalle del pedido
    DECLARE @detalles NVARCHAR(MAX);
    SELECT @detalles = (SELECT dp.codigo_barra, dp.cantidad, dp.precio_unitario
                        FROM DETALLE_PEDIDO dp
                        WHERE dp.id_pedido = @id_pedido
                        FOR JSON PATH);

    -- Combinar ambos resultados en un solo JSON
    DECLARE @jsonResult NVARCHAR(MAX);
    SET @jsonResult = CONCAT('[{"Pedido":', @pedido, ', "Detalles":', @detalles, '}]');

    -- Devolver el resultado final
    SELECT @jsonResult AS Resultado;
END;
GO

EXEC OBTENER_DETALLES_ULTIMO_PEDIDO
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////












--////////////////////////////////////////////////////////////////////////////////////////////////////////////////VERIFICAR TOKEN
CREATE OR ALTER   PROCEDURE VERIFICAR_TOKEN
    @token VARCHAR(150)
AS
BEGIN
	SELECT token FROM CONFIGURACION WHERE token = @token 
END;
GO
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







--PROCEDIMIENTOS PROVEEDOR

USE PROVEEDOR3
GO






--//////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER CONFIGURACION
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_CONFIGURACION]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM CONFIGURACION 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Configuracion;
	END;
GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PRODUCTOS]
AS
BEGIN
DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM PRODUCTOS 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Productos;
END;
GO
EXECUTE OBTENER_PRODUCTOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER RANKING
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_RANKING]
AS
BEGIN
  DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM RANKING 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Ranking;
END;
GO
EXECUTE OBTENER_RANKING
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDO] @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
BEGIN

DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PEDIDOS
    SELECT @jsonResult = (
        SELECT * 
        FROM PEDIDOS 
		WHERE codigo_seguimiento = @codigo_seguimiento
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedido;
	END;
GO
EXECUTE OBTENER_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENGO TODOS LOS PEDIDOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDOS]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * FROM PEDIDOS ORDER BY 
    fecha_pedido DESC,
    CASE codigo_estado
        WHEN 'PENDIENTE' THEN 1
        WHEN 'EN_PROCESO' THEN 2
        WHEN 'ENVIADO' THEN 3
        WHEN 'ENTREGADO' THEN 4
        WHEN 'CANCELADO' THEN 5
        ELSE 6
		END
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos
	END;
	GO
EXECUTE OBTENER_PEDIDOS 
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--////////////////////////////////////////////////////////////////////////////////////////////////////////////////CANCELAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER     PROCEDURE [dbo].[CANCELAR_PEDIDO]
    @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
DECLARE @jsonResult NVARCHAR(MAX);
BEGIN

	IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado IN ('PENDIENTE'))
    BEGIN
        -- Si el codigo_estado es 'PENDIENTE' , lo cambia a CANCELADO  
		UPDATE PEDIDOS
	    SET codigo_estado = 'CANCELADO'
		WHERE codigo_seguimiento = @codigo_seguimiento

		 SELECT @jsonResult = (
            SELECT *
            FROM PEDIDOS
            WHERE codigo_seguimiento = @codigo_seguimiento
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
    ELSE
    BEGIN
        -- Si no es 'PENDIENTE', lanzar un error o mensaje informativo
        RAISERROR('El pedido no está en estado PENDIENTE o no EXISTE. No se puede cancelar.', 16, 1);
    END	
END;
GO
/*
EXECUTE CANCELAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////PUNTUAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[EVALUAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @codigo_seguimiento VARCHAR(150);
    DECLARE @evaluacion VARCHAR(150);

    -- Extraer valores del JSON
    SELECT
        @codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento'),
        @evaluacion = JSON_VALUE(@json, '$.evaluacion');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Verificar si el pedido está en estado 'ENTREGADO'
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado = 'ENTREGADO')
    BEGIN
        -- Verificar si la evaluación está en la tabla RANKING
        IF EXISTS (SELECT 1 FROM RANKING WHERE evaluacion = @evaluacion)
        BEGIN
            -- Actualizar la evaluación del pedido
            UPDATE PEDIDOS
            SET evaluacion = @evaluacion
            WHERE codigo_seguimiento = @codigo_seguimiento;

            -- Seleccionar el pedido actualizado y convertirlo a JSON
            SELECT @jsonResult = (
                SELECT *
                FROM PEDIDOS
                WHERE codigo_seguimiento = @codigo_seguimiento
                FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
            );

            -- Devolver el JSON con un nombre de columna específico
            SELECT @jsonResult AS Pedido;
        END
        ELSE
        BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('La evaluación no es válida. No se puede puntuar.', 16, 1);
        END
    END
    ELSE
    BEGIN
        -- Lanzar un error si el pedido no está en estado ENTREGADO
        RAISERROR('El pedido no está en estado ENTREGADO. No se puede puntuar.', 16, 1);
    END
END;
GO
/*
EXECUTE EVALUAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456","evaluacion":"Regular"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--/////////////////////////////////////////////////////////////////////////INSERTAR_PEDIDO 
-- Procedimiento para insertar un nuevo pedido
CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_PEDIDO]
    @id_pedido INT OUTPUT
AS
BEGIN
    DECLARE @fecha_actual DATETIME = GETDATE();
    DECLARE @codigo_seguimiento VARCHAR(150) = CONCAT('ABCD', FLOOR(RAND() * (999999 - 1) + 1));
    DECLARE @nuevo_id_pedido TABLE (id_pedido INT);

    -- Insertar el nuevo pedido y capturar el id_pedido generado
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento) 
    OUTPUT inserted.id_pedido INTO @nuevo_id_pedido
    VALUES (
        'PENDIENTE',
        DATEADD(DAY, 3, @fecha_actual),
        NULL,
        @fecha_actual,
        NULL,
        0,
        @codigo_seguimiento
    );

    -- Asignar el id_pedido generado al parámetro de salida
    SELECT @id_pedido = id_pedido FROM @nuevo_id_pedido;
END;
GO


CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_DETALLE]
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @id_pedido INT;
    DECLARE @total DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio
    SET @total = 0;

    -- Llamar al procedimiento para insertar un nuevo pedido y obtener el id_pedido
    EXEC INSERTAR_PEDIDO @id_pedido OUTPUT;

    -- Verificar si el pedido fue insertado correctamente
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se pudo insertar el pedido.', 16, 1);
        RETURN;
    END

    -- Procesar el JSON y recorrer los elementos
    DECLARE @json_table TABLE (
        codigo_barra NVARCHAR(150),
        cantidad INT
    );

    INSERT INTO @json_table (codigo_barra, cantidad)
    SELECT codigo_barra, cantidad
    FROM OPENJSON(@json)
    WITH (
        codigo_barra NVARCHAR(150) '$.codigo_barra',
        cantidad INT '$.cantidad'
    );

    -- Insertar los detalles del pedido
    DECLARE @codigo_barra NVARCHAR(150);
    DECLARE @cantidad INT;
    DECLARE @precio_unitario DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio

    DECLARE detalle_cursor CURSOR FOR
    SELECT codigo_barra, cantidad FROM @json_table;

    OPEN detalle_cursor;
    FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener el precio del producto
        SELECT @precio_unitario = precio
        FROM PRODUCTOS
        WHERE codigo_barra = @codigo_barra;

        -- Verificar si el precio fue encontrado
        IF @precio_unitario IS NULL
        BEGIN
            RAISERROR('No se encontró el precio para el código de barra: %s', 16, 1, @codigo_barra);
            CLOSE detalle_cursor;
            DEALLOCATE detalle_cursor;
            RETURN;
        END

        -- Calcular el total
        SET @total = @total + (@precio_unitario * @cantidad);

        -- Insertar en DETALLE_PEDIDO
        INSERT INTO DETALLE_PEDIDO (
            id_pedido,
            codigo_barra,
            cantidad,
            precio_unitario
        ) VALUES (
            @id_pedido,
            @codigo_barra,
            @cantidad,
            @precio_unitario
        );

        FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;
    END;

    CLOSE detalle_cursor;
    DEALLOCATE detalle_cursor;

    -- Actualizar el total en la tabla PEDIDOS
    UPDATE PEDIDOS
    SET total = @total
    WHERE id_pedido = @id_pedido;

    -- Devolver el código de seguimiento como JSON con nombre de columna "Pedido"
    DECLARE @jsonResult NVARCHAR(MAX);

    SELECT @jsonResult = (SELECT TOP 1 p.codigo_seguimiento
                          FROM PEDIDOS p
                          WHERE p.id_pedido = @id_pedido 
                          FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER);

    -- Mostrar el resultado final
    SELECT @jsonResult AS Pedido;

END;
GO





GO
/*
DECLARE @json NVARCHAR(MAX) = '[{"codigo_barra":"005005","cantidad":8},{"codigo_barra":"005005","cantidad":15}]';
EXEC INSERTAR_DETALLE @json;
*/
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_DETALLES_ULTIMO_PEDIDO]
AS
BEGIN
    DECLARE @id_pedido INT;

    -- Obtener el ID del último pedido (el más grande)
    SELECT @id_pedido = MAX(id_pedido) FROM PEDIDOS;

    -- Verificar si se encontró un pedido
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se encontraron pedidos.', 16, 1);
        RETURN;
    END

    -- Datos del pedido
    DECLARE @pedido NVARCHAR(MAX);
    SELECT @pedido = (SELECT p.id_pedido, p.codigo_estado, p.fecha_entrega_prevista, p.fecha_entrega_real, p.fecha_pedido, p.evaluacion, p.total, p.codigo_seguimiento
                      FROM PEDIDOS p
                      WHERE p.id_pedido = @id_pedido
                      FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    -- Datos del detalle del pedido
    DECLARE @detalles NVARCHAR(MAX);
    SELECT @detalles = (SELECT dp.codigo_barra, dp.cantidad, dp.precio_unitario
                        FROM DETALLE_PEDIDO dp
                        WHERE dp.id_pedido = @id_pedido
                        FOR JSON PATH);

    -- Combinar ambos resultados en un solo JSON
    DECLARE @jsonResult NVARCHAR(MAX);
    SET @jsonResult = CONCAT('[{"Pedido":', @pedido, ', "Detalles":', @detalles, '}]');

    -- Devolver el resultado final
    SELECT @jsonResult AS Resultado;
END;
GO

EXEC OBTENER_DETALLES_ULTIMO_PEDIDO
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////












--////////////////////////////////////////////////////////////////////////////////////////////////////////////////VERIFICAR TOKEN
CREATE OR ALTER   PROCEDURE VERIFICAR_TOKEN
    @token VARCHAR(150)
AS
BEGIN
	SELECT token FROM CONFIGURACION WHERE token = @token 
END;
GO
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////















--////////////////////////////////////////////////////////////////////////////////////////////////////////////////VERIFICAR TOKEN
CREATE OR ALTER   PROCEDURE VERIFICAR_TOKEN
    @token VARCHAR(150)
AS
BEGIN
	SELECT token FROM CONFIGURACION WHERE token = @token 
END;
GO
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







--PROCEDIMIENTOS PROVEEDOR

USE PROVEEDOR4
GO






--//////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER CONFIGURACION
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_CONFIGURACION]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM CONFIGURACION 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Configuracion;
	END;
GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PRODUCTOS]
AS
BEGIN
DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM PRODUCTOS 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Productos;
END;
GO
EXECUTE OBTENER_PRODUCTOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER RANKING
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_RANKING]
AS
BEGIN
  DECLARE @jsonResult NVARCHAR(MAX);
-- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM RANKING 
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Ranking;
END;
GO
EXECUTE OBTENER_RANKING
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDO] @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
BEGIN

DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PEDIDOS
    SELECT @jsonResult = (
        SELECT * 
        FROM PEDIDOS 
		WHERE codigo_seguimiento = @codigo_seguimiento
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedido;
	END;
GO
EXECUTE OBTENER_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENGO TODOS LOS PEDIDOS
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_PEDIDOS]
AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * FROM PEDIDOS ORDER BY 
    fecha_pedido DESC,
    CASE codigo_estado
        WHEN 'PENDIENTE' THEN 1
        WHEN 'EN_PROCESO' THEN 2
        WHEN 'ENVIADO' THEN 3
        WHEN 'ENTREGADO' THEN 4
        WHEN 'CANCELADO' THEN 5
        ELSE 6
		END
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos
	END;
	GO
EXECUTE OBTENER_PEDIDOS 
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--////////////////////////////////////////////////////////////////////////////////////////////////////////////////CANCELAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER     PROCEDURE [dbo].[CANCELAR_PEDIDO]
    @json VARCHAR(max)
AS
DECLARE
@codigo_seguimiento VARCHAR(150) = (SELECT codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento') )
DECLARE @jsonResult NVARCHAR(MAX);
BEGIN

	IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado IN ('PENDIENTE'))
    BEGIN
        -- Si el codigo_estado es 'PENDIENTE' , lo cambia a CANCELADO  
		UPDATE PEDIDOS
	    SET codigo_estado = 'CANCELADO'
		WHERE codigo_seguimiento = @codigo_seguimiento

		 SELECT @jsonResult = (
            SELECT *
            FROM PEDIDOS
            WHERE codigo_seguimiento = @codigo_seguimiento
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
    ELSE
    BEGIN
        -- Si no es 'PENDIENTE', lanzar un error o mensaje informativo
        RAISERROR('El pedido no está en estado PENDIENTE o no EXISTE. No se puede cancelar.', 16, 1);
    END	
END;
GO
/*
EXECUTE CANCELAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////PUNTUAR PEDIDO CON CODIGO_SEGUIMIENTO
CREATE OR ALTER   PROCEDURE [dbo].[EVALUAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @codigo_seguimiento VARCHAR(150);
    DECLARE @evaluacion VARCHAR(150);

    -- Extraer valores del JSON
    SELECT
        @codigo_seguimiento = JSON_VALUE(@json, '$.codigo_seguimiento'),
        @evaluacion = JSON_VALUE(@json, '$.evaluacion');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Verificar si el pedido está en estado 'ENTREGADO'
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado = 'ENTREGADO')
    BEGIN
        -- Verificar si la evaluación está en la tabla RANKING
        IF EXISTS (SELECT 1 FROM RANKING WHERE evaluacion = @evaluacion)
        BEGIN
            -- Actualizar la evaluación del pedido
            UPDATE PEDIDOS
            SET evaluacion = @evaluacion
            WHERE codigo_seguimiento = @codigo_seguimiento;

            -- Seleccionar el pedido actualizado y convertirlo a JSON
            SELECT @jsonResult = (
                SELECT *
                FROM PEDIDOS
                WHERE codigo_seguimiento = @codigo_seguimiento
                FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
            );

            -- Devolver el JSON con un nombre de columna específico
            SELECT @jsonResult AS Pedido;
        END
        ELSE
        BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('La evaluación no es válida. No se puede puntuar.', 16, 1);
        END
    END
    ELSE
    BEGIN
        -- Lanzar un error si el pedido no está en estado ENTREGADO
        RAISERROR('El pedido no está en estado ENTREGADO. No se puede puntuar.', 16, 1);
    END
END;
GO
/*
EXECUTE EVALUAR_PEDIDO 
    @json = '{"codigo_seguimiento":"ABCD123456","evaluacion":"Regular"}'
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--/////////////////////////////////////////////////////////////////////////INSERTAR_PEDIDO 
-- Procedimiento para insertar un nuevo pedido
CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_PEDIDO]
    @id_pedido INT OUTPUT
AS
BEGIN
    DECLARE @fecha_actual DATETIME = GETDATE();
    DECLARE @codigo_seguimiento VARCHAR(150) = CONCAT('ABCD', FLOOR(RAND() * (999999 - 1) + 1));
    DECLARE @nuevo_id_pedido TABLE (id_pedido INT);

    -- Insertar el nuevo pedido y capturar el id_pedido generado
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento) 
    OUTPUT inserted.id_pedido INTO @nuevo_id_pedido
    VALUES (
        'PENDIENTE',
        DATEADD(DAY, 3, @fecha_actual),
        NULL,
        @fecha_actual,
        NULL,
        0,
        @codigo_seguimiento
    );

    -- Asignar el id_pedido generado al parámetro de salida
    SELECT @id_pedido = id_pedido FROM @nuevo_id_pedido;
END;
GO


CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_DETALLE]
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @id_pedido INT;
    DECLARE @total DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio
    SET @total = 0;

    -- Llamar al procedimiento para insertar un nuevo pedido y obtener el id_pedido
    EXEC INSERTAR_PEDIDO @id_pedido OUTPUT;

    -- Verificar si el pedido fue insertado correctamente
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se pudo insertar el pedido.', 16, 1);
        RETURN;
    END

    -- Procesar el JSON y recorrer los elementos
    DECLARE @json_table TABLE (
        codigo_barra NVARCHAR(150),
        cantidad INT
    );

    INSERT INTO @json_table (codigo_barra, cantidad)
    SELECT codigo_barra, cantidad
    FROM OPENJSON(@json)
    WITH (
        codigo_barra NVARCHAR(150) '$.codigo_barra',
        cantidad INT '$.cantidad'
    );

    -- Insertar los detalles del pedido
    DECLARE @codigo_barra NVARCHAR(150);
    DECLARE @cantidad INT;
    DECLARE @precio_unitario DECIMAL(18, 2);  -- Cambié INT a DECIMAL para manejar decimales en el precio

    DECLARE detalle_cursor CURSOR FOR
    SELECT codigo_barra, cantidad FROM @json_table;

    OPEN detalle_cursor;
    FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Obtener el precio del producto
        SELECT @precio_unitario = precio
        FROM PRODUCTOS
        WHERE codigo_barra = @codigo_barra;

        -- Verificar si el precio fue encontrado
        IF @precio_unitario IS NULL
        BEGIN
            RAISERROR('No se encontró el precio para el código de barra: %s', 16, 1, @codigo_barra);
            CLOSE detalle_cursor;
            DEALLOCATE detalle_cursor;
            RETURN;
        END

        -- Calcular el total
        SET @total = @total + (@precio_unitario * @cantidad);

        -- Insertar en DETALLE_PEDIDO
        INSERT INTO DETALLE_PEDIDO (
            id_pedido,
            codigo_barra,
            cantidad,
            precio_unitario
        ) VALUES (
            @id_pedido,
            @codigo_barra,
            @cantidad,
            @precio_unitario
        );

        FETCH NEXT FROM detalle_cursor INTO @codigo_barra, @cantidad;
    END;

    CLOSE detalle_cursor;
    DEALLOCATE detalle_cursor;

    -- Actualizar el total en la tabla PEDIDOS
    UPDATE PEDIDOS
    SET total = @total
    WHERE id_pedido = @id_pedido;

    -- Devolver el código de seguimiento como JSON con nombre de columna "Pedido"
    DECLARE @jsonResult NVARCHAR(MAX);

    SELECT @jsonResult = (SELECT TOP 1 p.codigo_seguimiento
                          FROM PEDIDOS p
                          WHERE p.id_pedido = @id_pedido 
                          FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER);

    -- Mostrar el resultado final
    SELECT @jsonResult AS Pedido;

END;
GO





GO
/*
DECLARE @json NVARCHAR(MAX) = '[{"codigo_barra":"005005","cantidad":8},{"codigo_barra":"005005","cantidad":15}]';
EXEC INSERTAR_DETALLE @json;
*/
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_DETALLES_ULTIMO_PEDIDO]
AS
BEGIN
    DECLARE @id_pedido INT;

    -- Obtener el ID del último pedido (el más grande)
    SELECT @id_pedido = MAX(id_pedido) FROM PEDIDOS;

    -- Verificar si se encontró un pedido
    IF @id_pedido IS NULL
    BEGIN
        RAISERROR('No se encontraron pedidos.', 16, 1);
        RETURN;
    END

    -- Datos del pedido
    DECLARE @pedido NVARCHAR(MAX);
    SELECT @pedido = (SELECT p.id_pedido, p.codigo_estado, p.fecha_entrega_prevista, p.fecha_entrega_real, p.fecha_pedido, p.evaluacion, p.total, p.codigo_seguimiento
                      FROM PEDIDOS p
                      WHERE p.id_pedido = @id_pedido
                      FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    -- Datos del detalle del pedido
    DECLARE @detalles NVARCHAR(MAX);
    SELECT @detalles = (SELECT dp.codigo_barra, dp.cantidad, dp.precio_unitario
                        FROM DETALLE_PEDIDO dp
                        WHERE dp.id_pedido = @id_pedido
                        FOR JSON PATH);

    -- Combinar ambos resultados en un solo JSON
    DECLARE @jsonResult NVARCHAR(MAX);
    SET @jsonResult = CONCAT('[{"Pedido":', @pedido, ', "Detalles":', @detalles, '}]');

    -- Devolver el resultado final
    SELECT @jsonResult AS Resultado;
END;
GO

EXEC OBTENER_DETALLES_ULTIMO_PEDIDO
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////












--////////////////////////////////////////////////////////////////////////////////////////////////////////////////VERIFICAR TOKEN
CREATE OR ALTER   PROCEDURE VERIFICAR_TOKEN
    @token VARCHAR(150)
AS
BEGIN
	SELECT token FROM CONFIGURACION WHERE token = @token 
END;
GO
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







--PROCEDIMIENTOS SUPER

USE SUPER
GO






--//////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER_CREDENCIALES
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_CREDENCIALES]
@json VARCHAR(max)
AS
BEGIN
    DECLARE @id_proveedor INT;
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Obtener el valor de id_proveedor del JSON de entrada
    SET @id_proveedor = JSON_VALUE(@json, '$.id_proveedor');

    -- Construir el JSON de respuesta
    SELECT @jsonResult = (
        SELECT 
            id_proveedor,
            nombre,
            cuil,
            mail,
            nombre_url,
            token,
            CAST(puntaje AS VARCHAR(20)) AS puntaje,
            habilitado
        FROM PROVEEDORES 
        WHERE id_proveedor = @id_proveedor
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    -- Reemplazar las barras invertidas en el JSON resultante
    SET @jsonResult = REPLACE(@jsonResult, '\/', '/');

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS credenciales;
END;
GO
EXECUTE OBTENER_CREDENCIALES 
    @json = '{"id_proveedor":"2", "id_provsadsaeedor":"2", "id_proveasdasdedor":"2"}'
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--//////////////////////////////////////////////////////////////////////////////////////////////////////////CANCELAR_PEDIDO
CREATE OR ALTER   PROCEDURE [dbo].[CANCELAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @codigo_seguimiento VARCHAR(150) = JSON_VALUE(@json, '$.codigo_seguimiento');
    DECLARE @jsonResult NVARCHAR(MAX);

    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE codigo_seguimiento = @codigo_seguimiento AND codigo_estado = 'PENDIENTE')
    BEGIN
        -- Si el codigo_estado es 'PENDIENTE', lo cambia a CANCELADO  
        UPDATE PEDIDOS
        SET codigo_estado = 'CANCELADO'
        WHERE codigo_seguimiento = @codigo_seguimiento;

        -- Seleccionar el pedido actualizado y convertirlo a JSON
        SELECT @jsonResult = (
            SELECT *
            FROM PEDIDOS
            WHERE codigo_seguimiento = @codigo_seguimiento
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
    ELSE
    BEGIN
        -- Si no es 'PENDIENTE', lanzar un error o mensaje informativo
        RAISERROR('El pedido no está en estado PENDIENTE. No se puede cancelar.', 16, 1);
    END
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














--//////////////////////////////////////////////////////////////////////////////////////////////////////////UPDATE_PONDERACION
CREATE OR ALTER   PROCEDURE [dbo].[UPDATE_PONDERACION]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @id_proveedor INT = JSON_VALUE(@json, '$.id_proveedor');
    DECLARE @evaluacion VARCHAR(150) = JSON_VALUE(@json, '$.evaluacion');
    DECLARE @ponderacion INT = JSON_VALUE(@json, '$.ponderacion');
    DECLARE @jsonResult NVARCHAR(MAX);

    BEGIN
        -- Si el codigo_estado es 'PENDIENTE', lo cambia a CANCELADO  
        UPDATE RANKING
        SET ponderacion = @ponderacion
        WHERE id_proveedor = @id_proveedor
		AND evaluacion = @evaluacion;

        -- Seleccionar el pedido actualizado y convertirlo a JSON
        SELECT @jsonResult = (
            SELECT *
            FROM RANKING
				WHERE id_proveedor = @id_proveedor
				AND evaluacion = @evaluacion
            FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
        );

        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Ponderacion;
    END
END;
GO
EXECUTE [UPDATE_PONDERACION] 
    @json = '{"id_proveedor":1, "evaluacion":"Muy Malo", "ponderacion":5}'
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--//////////////////////////////////////////////////////////////////////////////////////////////////////////EVALUAR_PEDIDO
CREATE OR ALTER PROCEDURE [dbo].[EVALUAR_PEDIDO]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @id_pedido INT;
    DECLARE @evaluacion VARCHAR(150);
    DECLARE @ponderacion INT;
    DECLARE @id_proveedor INT;

    -- Extraer valores del JSON
    SELECT
        @id_proveedor = JSON_VALUE(@json, '$.id_proveedor'),
        @id_pedido = JSON_VALUE(@json, '$.id_pedido'),
        @evaluacion = JSON_VALUE(@json, '$.evaluacion'),
        @ponderacion = JSON_VALUE(@json, '$.ponderacion');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Verificar si el pedido está en estado 'ENTREGADO'
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE id_pedido = @id_pedido AND codigo_estado = 'ENTREGADO')
    BEGIN
        -- Verificar si la evaluación está en la tabla RANKING
        IF EXISTS (SELECT 1 FROM RANKING WHERE evaluacion = @evaluacion)
        BEGIN
            -- Actualizar la evaluación del pedido
            UPDATE PEDIDOS
            SET evaluacion = @evaluacion,
			ponderacion = @ponderacion
            WHERE id_pedido = @id_pedido;

            -- Actualizar puntaje del proveedor
            UPDATE PROVEEDORES
            SET puntaje = (SELECT SUM(ponderacion) * 1.0 / COUNT(id_pedido) FROM PEDIDOS WHERE id_proveedor = @id_proveedor AND ponderacion IS NOT NULL)
            WHERE id_proveedor = @id_proveedor;



            -- Seleccionar el pedido actualizado y convertirlo a JSON
            SELECT @jsonResult = (
                SELECT *
                FROM PEDIDOS
                WHERE id_pedido = @id_pedido
                FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
            );

            -- Devolver el JSON con un nombre de columna específico
            SELECT @jsonResult AS Pedido;
        END
        ELSE
        BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('La evaluación no es válida. No se puede puntuar.', 16, 1);
        END
    END
    ELSE
    BEGIN
        -- Lanzar un error si el pedido no está en estado ENTREGADO
        RAISERROR('El pedido no está en estado ENTREGADO. No se puede puntuar.', 16, 1);
    END
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--//////////////////////////////////////////////////////////////////////////////////////////////////////////INSERTAR DATOS PROVEEDOR (proveedor, ranking, productos)
CREATE OR ALTER   PROCEDURE [dbo].[INSERTAR_DATOS_PROVEEDOR]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declarar variables para los datos del proveedor
    DECLARE @nombre_url NVARCHAR(150), @nombre NVARCHAR(50), @cuil NVARCHAR(150), @mail NVARCHAR(150), @token NVARCHAR(150);

    -- Declarar una tabla temporal para los datos del ranking
    DECLARE @RankingTemp TABLE (
        evaluacion NVARCHAR(50),
        ponderacion INT
    );

    -- Declarar una tabla temporal para los datos del producto
    DECLARE @ProductoTemp TABLE (
        codigo_barra NVARCHAR(150),
        nombre NVARCHAR(150),
        precio INT,
        fecha_actualizacion_precio DATETIME
    );

    -- Extraer datos del JSON
    SELECT
        @nombre_url = Configuracion.nombre_url,
        @nombre = Configuracion.nombre,
        @cuil = Configuracion.cuil,
        @mail = Configuracion.mail,
        @token = Configuracion.token
    FROM
        OPENJSON(@json)
        WITH (
            configuracion NVARCHAR(MAX) AS JSON
        ) AS Proveedor
        CROSS APPLY OPENJSON(Proveedor.configuracion)
        WITH (
            nombre_url NVARCHAR(150),
            nombre NVARCHAR(50),
            cuil NVARCHAR(150),
            mail NVARCHAR(150),
            token NVARCHAR(150)
        ) AS Configuracion;

    -- Insertar datos en la tabla temporal de Ranking
    INSERT INTO @RankingTemp (evaluacion, ponderacion)
    SELECT evaluacion, ponderacion
    FROM
        OPENJSON(@json, '$.ranking')
        WITH (
            evaluacion NVARCHAR(50),
            ponderacion INT
        );

    -- Insertar datos en la tabla temporal de Productos
    INSERT INTO @ProductoTemp (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    SELECT codigo_barra, nombre, precio, fecha_actualizacion_precio
    FROM
        OPENJSON(@json, '$.productos')
        WITH (
            codigo_barra NVARCHAR(150),
            nombre NVARCHAR(150),
            precio INT,
            fecha_actualizacion_precio DATETIME
        );

    -- Insertar datos en la tabla PROVEEDORES
    INSERT INTO PROVEEDORES (nombre,  mail, nombre_url, token, cuil, puntaje, habilitado)
    VALUES (@nombre,  @mail, @nombre_url, @token, @cuil, 5, 1);

    -- Obtener el ID del proveedor recién insertado
    DECLARE @id_proveedor INT;
    SET @id_proveedor = SCOPE_IDENTITY();

    -- Insertar datos en la tabla RANKING
    INSERT INTO RANKING (id_proveedor, evaluacion, ponderacion)
    SELECT @id_proveedor, evaluacion, ponderacion
    FROM @RankingTemp;

    -- Insertar datos en la tabla PRODUCTO_PROVEEDOR
    INSERT INTO PRODUCTO_PROVEEDOR (codigo_barra, id_proveedor, nombre, precio, fecha_actualizacion_precio)
    SELECT codigo_barra, @id_proveedor, nombre, precio, fecha_actualizacion_precio
    FROM @ProductoTemp;

    -- Devolver JSON con la configuración del proveedor
    DECLARE @result NVARCHAR(MAX);
    SELECT @result = (
        SELECT nombre_url, nombre, token
        FROM PROVEEDORES
        WHERE id_proveedor = @id_proveedor
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );
    
    -- Devolver el resultado
    SELECT @result AS configuracion;

    SET NOCOUNT OFF;
END;
GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER RANKING Y LA PONDERACION
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_RANKING_PONDERACION] 
@json VARCHAR(max)
	AS
BEGIN 
DECLARE @jsonResult NVARCHAR(MAX);
DECLARE @id_proveedor VARCHAR(150) = JSON_VALUE(@json, '$.id_proveedor');

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * FROM RANKING 
		WHERE id_proveedor = @id_proveedor
		ORDER BY ponderacion
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Ranking
	END;
GO
/*EXECUTE OBTENER_RANKING_PONDERACION 
@json = '{"id_proveedor":2}' 
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS POR PROVEEDOR
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PRODUCTOS_PROVEEDOR] 
@json VARCHAR(max)
AS
BEGIN 
    DECLARE @jsonResult NVARCHAR(MAX);
    DECLARE @id_proveedor VARCHAR(150) = JSON_VALUE(@json, '$.id_proveedor');

    -- Generar el JSON desde las tablas PRODUCTOS y PRODUCTO_PROVEEDOR
    SELECT @jsonResult = (
        SELECT 
            p.codigo_barra,
            p.nombre AS nombre,
            p.imagen_contenido,
            p.stock_actual,
            p.stock_optimo,
            pp.nombre AS nombre_proveedor_producto,
            pp.precio AS precio_unitario,
            pp.fecha_actualizacion_precio
        FROM 
            PRODUCTOS p
        JOIN 
            PRODUCTO_PROVEEDOR pp ON p.codigo_barra = pp.codigo_barra
        WHERE 
            pp.id_proveedor = @id_proveedor
        FOR JSON PATH
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Productos;
END;
GO

/*EXECUTE [OBTENER_PRODUCTOS_PROVEEDOR] 
@json = '{"id_proveedor":1}' 
GO
*/
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PEDIDOS
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PEDIDOS]
AS
BEGIN 
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PEDIDOS con nombre del proveedor
    SELECT @jsonResult = (
        SELECT
            p.id_pedido,
            p.id_proveedor,
            p.codigo_estado,
            p.fecha_entrega_prevista,
            p.fecha_pedido,
            p.total,
            p.evaluacion,
            p.ponderacion,
            p.codigo_seguimiento,
            pr.nombre as nombre_proveedor  -- Nombre del proveedor
        FROM 
            PEDIDOS p
            INNER JOIN PROVEEDORES pr ON p.id_proveedor = pr.id_proveedor
        ORDER BY 
            CASE p.codigo_estado
                WHEN 'PENDIENTE' THEN 1
                WHEN 'ENTREGADO' THEN 2
                WHEN 'ENVIADO' THEN 3
                WHEN 'CANCELADO' THEN 4
                WHEN 'EN_PROCESO' THEN 5
                ELSE 6
            END
        FOR JSON PATH
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos;
END;
GO
EXEC OBTENER_PEDIDOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER ESTADISTICAS DEL PROVEEDOR
CREATE OR ALTER   PROCEDURE [dbo].[OBTENER_ESTADISTICA_PROVEEDOR] 
@json VARCHAR(max)
AS
BEGIN 
    DECLARE @jsonResult NVARCHAR(MAX);
    DECLARE @id_proveedor VARCHAR(150) = JSON_VALUE(@json, '$.id_proveedor');

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT 
            p.id_proveedor,
            p.nombre,
            p.puntaje,
            p.cuil,
            p.mail,
             ISNULL(AVG(NULLIF(DATEDIFF(MINUTE, r.fecha_entrega_prevista, r.fecha_entrega_real), 0)) / 1440.0, 0) AS promedio_dias_entrega
        FROM 
            PROVEEDORES p
        LEFT JOIN 
            PEDIDOS r ON p.id_proveedor = r.id_proveedor
        WHERE 
            p.id_proveedor = @id_proveedor
        GROUP BY 
            p.id_proveedor,
            p.nombre,
            p.cuil,
            p.mail,
			p.puntaje
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Estadistica;
END;
GO
EXEC OBTENER_ESTADISTICA_PROVEEDOR 
    @json = '{"id_proveedor":1}'
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










--////////////////////////////////////////////////////////////////////////////////////////////////////////////////BAJA/ALTA PROVEEDOR
ALTER PROCEDURE [dbo].[BAJA_ALTA_PROVEEDOR]
    @json VARCHAR(max)
AS
BEGIN
    DECLARE @id_proveedor INT = JSON_VALUE(@json, '$[0].id_proveedor');
    DECLARE @habilitado BIT = CAST(JSON_VALUE(@json, '$[0].habilitado') AS BIT);
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Actualizar el estado de habilitado del proveedor
    UPDATE PROVEEDORES
    SET habilitado = @habilitado
    WHERE id_proveedor = @id_proveedor;

    -- Seleccionar el proveedor actualizado y convertirlo a JSON
    SELECT @jsonResult = (
        SELECT *
        FROM PROVEEDORES
        WHERE id_proveedor = @id_proveedor
        FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Proveedor;
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////













--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER LOS DETALLES DEL PEDIDO
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_DETALLE_PEDIDO]
    @json VARCHAR(MAX)
AS
BEGIN
    DECLARE @id_pedido INT;

    -- Extraer valores del JSON
    SELECT @id_pedido = JSON_VALUE(@json, '$.id_pedido');

    DECLARE @jsonProductos NVARCHAR(MAX);
    DECLARE @jsonPedidos NVARCHAR(MAX);

    -- Obtener detalle de los productos
    SELECT @jsonProductos = (
        SELECT
            dp.id_pedido,
            dp.codigo_barra,
            dp.cantidad,
            dp.precio_unitario,
            p.nombre AS nombre_producto,
            p.imagen_contenido AS imagen_contenido,
            p.stock_actual,
            p.stock_optimo
        FROM
            DETALLE_PEDIDO dp
        JOIN
            PRODUCTOS p ON dp.codigo_barra = p.codigo_barra
        WHERE
            dp.id_pedido = @id_pedido
        FOR JSON PATH
    );

    -- Obtener detalle de los pedidos asociados al id_pedido
    SELECT @jsonPedidos = (
        SELECT
            id_pedido,
            id_proveedor,
            codigo_estado,
            fecha_entrega_prevista,
            fecha_entrega_real,
            fecha_pedido,
            evaluacion,
            ponderacion,
            total,
            codigo_seguimiento
        FROM
            PEDIDOS
        WHERE
            id_pedido = @id_pedido
        FOR JSON PATH
    );

    -- Combinar ambos JSON en un solo resultado
    DECLARE @jsonResult NVARCHAR(MAX);
    SET @jsonResult = '[' + @jsonPedidos + ',' + @jsonProductos + ']';

    -- Devolver el JSON combinado
    SELECT @jsonResult AS detalle_pedido;
END;
GO
EXECUTE OBTENER_DETALLE_PEDIDO 
    @json = '{"id_pedido":"5"}'
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER LOS ULTIMOS 10 PEDIDOS DEL PROVEEDOR
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PEDIDOS_PROVEEDOR]
    @json VARCHAR(max)
AS
BEGIN 
    DECLARE @id_proveedor VARCHAR(150) = JSON_VALUE(@json, '$.id_proveedor');

    DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla CONFIGURACION
    SELECT @jsonResult = (
        SELECT * 
        FROM (
            SELECT TOP 10 *
            FROM PEDIDOS 
            WHERE id_proveedor = @id_proveedor 
            ORDER BY fecha_pedido DESC, 
                     CASE codigo_estado
                        WHEN 'PENDIENTE' THEN 1
                        WHEN 'EN_PROCESO' THEN 2
                        WHEN 'ENVIADO' THEN 3
                        WHEN 'ENTREGADO' THEN 4
                        WHEN 'CANCELADO' THEN 5
                        ELSE 6
                     END
        ) AS LatestOrders
        ORDER BY fecha_pedido DESC
        FOR JSON AUTO
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Pedidos;
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PRODUCTOS
--Le paso un JSON con todos los productos del proveedor, y me devuelve solo los que tenemos nosotros registrados, hace el JOIN de sus productos, con los de la base del SUPER
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PRODUCTOS_JOIN]
    @json NVARCHAR(MAX)
AS
BEGIN
    -- Temporary table to hold the JSON data
    DECLARE @ProductosTemp TABLE (
        codigo_barra NVARCHAR(13),
        nombre NVARCHAR(255),
        precio DECIMAL(10, 2),
        fecha_actualizacion_precio DATE
    );

    -- Insert JSON data into the temporary table
    INSERT INTO @ProductosTemp (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    SELECT 
        codigo_barra, nombre, precio, fecha_actualizacion_precio
    FROM OPENJSON(@json)
    WITH (
        codigo_barra NVARCHAR(13),
        nombre NVARCHAR(255),
        precio DECIMAL(10, 2),
        fecha_actualizacion_precio DATE
    );

    -- Variable to hold the JSON result
    DECLARE @result NVARCHAR(MAX);

    -- Select products from the PRODUCTOS table that match the codigo_barra in the temporary table
    SELECT @result = (
        SELECT pt.codigo_barra, pt.nombre, pt.precio, p.imagen_contenido, pt.fecha_actualizacion_precio
        FROM @ProductosTemp pt
        INNER JOIN PRODUCTOS p ON pt.codigo_barra = p.codigo_barra
        FOR JSON PATH
    );

    -- Return the result as a single column named 'Productos'
    SELECT @result AS Productos;

END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PROVEEDORES
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PROVEEDORES]
AS
BEGIN 
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PROVEEDORES con estadísticas
    SELECT @jsonResult = (
        SELECT
            p.id_proveedor,
            p.nombre,
            p.cuil,
            p.mail,
            p.nombre_url,
            p.token,
            p.puntaje,
            p.habilitado,
            ISNULL(AVG(NULLIF(DATEDIFF(MINUTE, ped.fecha_entrega_prevista, ped.fecha_entrega_real), 0)) / 1440.0, 0) AS promedio_dias_entrega,
            COUNT(ped.id_pedido) AS total_pedidos,
            COUNT(DISTINCT prod.codigo_barra) AS total_productos,
            ISNULL(AVG(ped.ponderacion), 0) AS promedio_ponderacion
        FROM 
            PROVEEDORES p
        LEFT JOIN 
            PEDIDOS ped ON p.id_proveedor = ped.id_proveedor
        LEFT JOIN 
            PRODUCTO_PROVEEDOR pp ON p.id_proveedor = pp.id_proveedor
        LEFT JOIN 
            PRODUCTOS prod ON pp.codigo_barra = prod.codigo_barra
        GROUP BY 
            p.id_proveedor, p.nombre, p.cuil, p.mail, p.nombre_url, p.token, p.puntaje, p.habilitado
        ORDER BY 
            p.id_proveedor
        FOR JSON PATH
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS Proveedores;
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--////////////////////////////////////////////////////////////////////////////////////////////////////////////////OBTENER PROVEEDORES
CREATE OR ALTER PROCEDURE [dbo].[OBTENER_PROVEEDORES_PARA_ACTUALIZAR_PRECIOS]
AS
BEGIN 
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Generar el JSON desde la tabla PROVEEDORES con estadísticas
    SELECT @jsonResult = (
        SELECT
            p.id_proveedor,
            p.nombre,
            p.cuil,
            p.mail,
            p.nombre_url,
            p.token,
            p.puntaje,
            p.habilitado,
            ISNULL(AVG(NULLIF(DATEDIFF(MINUTE, ped.fecha_entrega_prevista, ped.fecha_entrega_real), 0)) / 1440.0, 0) AS promedio_dias_entrega,
            COUNT(ped.id_pedido) AS total_pedidos,
            COUNT(DISTINCT prod.codigo_barra) AS total_productos,
            ISNULL(AVG(ped.ponderacion), 0) AS promedio_ponderacion
        FROM 
            PROVEEDORES p
        LEFT JOIN 
            PEDIDOS ped ON p.id_proveedor = ped.id_proveedor
        LEFT JOIN 
            PRODUCTO_PROVEEDOR pp ON p.id_proveedor = pp.id_proveedor
        LEFT JOIN 
            PRODUCTOS prod ON pp.codigo_barra = prod.codigo_barra
        WHERE
            pp.fecha_actualizacion_precio < DATEADD(DAY, -1, GETDATE())
        GROUP BY 
            p.id_proveedor, p.nombre, p.cuil, p.mail, p.nombre_url, p.token, p.puntaje, p.habilitado
        ORDER BY 
            p.id_proveedor
        FOR JSON PATH
    );

    -- Devolver el JSON con un nombre de columna específico
    SELECT @jsonResult AS ProveedoresSinPreciosActualizados;
END;
GO
EXEC
OBTENER_PROVEEDORES_PARA_ACTUALIZAR_PRECIOS
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--////////////////////////////////////////////////////////////////////////////////////////////////////////////////LOGIN
CREATE OR ALTER   PROCEDURE [dbo].[USUARIO_LOGIN]
    @json NVARCHAR(MAX)
AS
BEGIN
    -- Declarar las variables para usuario y clave
    DECLARE @usuario NVARCHAR(150);
    DECLARE @clave NVARCHAR(150);
    DECLARE @jsonResult NVARCHAR(MAX);

    -- Extraer los valores del JSON de entrada
    SET @usuario = JSON_VALUE(@json, '$.usuario');
    SET @clave = JSON_VALUE(@json, '$.clave');

    -- Generar el JSON desde la tabla USUARIOS
    SELECT @jsonResult = (
        SELECT usuario, clave
        FROM USUARIOS
        WHERE usuario = @usuario AND clave = @clave
        FOR JSON AUTO
    );

    
    -- Verificar si se encontraron registros
    IF @jsonResult IS NULL OR @jsonResult = '[]'
	BEGIN
            -- Lanzar un error si la evaluación no está en la tabla RANKING
            RAISERROR('No existen esos datos.', 16, 1);
    END
    ELSE
    BEGIN
        -- Devolver el JSON con un nombre de columna específico
        SELECT @jsonResult AS Pedido;
    END
END;
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











--////////////////////////////////////////////////////////////////////////////////////////////////////////////////ActualizarPedidosDesdeJson
CREATE OR ALTER PROCEDURE ActualizarPedidosDesdeJson 
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Analizar el JSON y cargarlo en una tabla temporal
    SELECT 
        id_pedido,
        codigo_estado,
        fecha_entrega_prevista,
        fecha_entrega_real,
        fecha_pedido,
        evaluacion,
        total,
        codigo_seguimiento,
        id_proveedor
    INTO #PedidosTemp
    FROM OPENJSON(@json)
    WITH (
        id_pedido INT,
        codigo_estado VARCHAR(20),
        fecha_entrega_prevista DATETIME,
        fecha_entrega_real DATETIME,
        fecha_pedido DATETIME,
        evaluacion VARCHAR(50),
        total INT,
        codigo_seguimiento VARCHAR(150),
        id_proveedor INT
    );

    -- Actualizar la tabla PEDIDOS
    UPDATE p
    SET 
        p.codigo_estado = ISNULL(src.codigo_estado, p.codigo_estado),
        p.fecha_entrega_real = ISNULL(src.fecha_entrega_real, p.fecha_entrega_real)
    FROM PEDIDOS p
    JOIN #PedidosTemp src
        ON p.id_proveedor = src.id_proveedor
        AND p.codigo_seguimiento = src.codigo_seguimiento
    WHERE src.codigo_estado IS NOT NULL OR src.fecha_entrega_real IS NOT NULL;

    -- Eliminar la tabla temporal
    DROP TABLE #PedidosTemp;
END
GO
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
EXEC ActualizarPedidosDesdeJson
@json = '[
  {
    "id_pedido": 1,
    "codigo_estado": "ENTREGADO",
    "fecha_entrega_prevista": "2024-07-01",
    "fecha_pedido": "2024-06-25",
    "evaluacion": "Malo",
    "total": 6000,
    "codigo_seguimiento": "ABCD123456",
    "id_proveedor": 1
  },
  {
    "id_pedido": 2,
    "codigo_estado": "ENTREGADO",
    "fecha_entrega_prevista": "2024-07-01",
    "fecha_pedido": "2024-06-25",
    "evaluacion": "Malo",
    "total": 6000,
    "codigo_seguimiento": "ABCD123456",
    "id_proveedor": 1
  },
  {
    "id_pedido": 1,
    "codigo_estado": "PENDIENTE",
    "fecha_entrega_prevista": "2024-07-02",
    "fecha_pedido": "2024-06-26",
    "total": 6000,
    "codigo_seguimiento": "DEFG456789",
    "id_proveedor": 2
  },
  {
    "id_pedido": 1,
    "codigo_estado": "EN_PROCESO",
    "fecha_entrega_prevista": "2024-07-02",
    "fecha_pedido": "2024-06-26",
    "total": 3000,
    "codigo_seguimiento": "RTYU126766",
    "id_proveedor": 3
  },
  {
    "id_pedido": 2,
    "codigo_estado": "ENTREGADO",
    "fecha_entrega_prevista": "2024-07-05",
    "fecha_entrega_real": "2024-07-06",
    "fecha_pedido": "2024-07-01",
    "total": 5500,
    "codigo_seguimiento": "XYZU987654",
    "id_proveedor": 3
  }
]'
GO
*/


CREATE OR ALTER PROCEDURE ActualizarProductosProveedorDesdeJson 
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Analizar el JSON y cargarlo en una tabla temporal
    SELECT 
        codigo_barra,
        id_proveedor,
        nombre,
        precio,
        fecha_actualizacion_precio
    INTO #ProductosProveedorTemp
    FROM OPENJSON(@json)
    WITH (
        codigo_barra VARCHAR(150),
        id_proveedor INT,
        nombre VARCHAR(150),
        precio INT,
        fecha_actualizacion_precio DATETIME
    );

    -- Actualizar la tabla PRODUCTO_PROVEEDOR
    UPDATE pp
    SET 
        pp.precio = src.precio,
        pp.fecha_actualizacion_precio = src.fecha_actualizacion_precio
    FROM PRODUCTO_PROVEEDOR pp
    JOIN #ProductosProveedorTemp src
        ON pp.codigo_barra = src.codigo_barra
        AND pp.id_proveedor = src.id_proveedor;

    -- Eliminar la tabla temporal
    DROP TABLE #ProductosProveedorTemp;
END
GO
/*
EXEC ActualizarProductosProveedorDesdeJson
@json = '[{"codigo_barra":"001001","nombre":"Mermelada","precio":100,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":1},{"codigo_barra":"002002","nombre":"Cafe","precio":200,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":1},{"codigo_barra":"003003","nombre":"Coca-cola","precio":300,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":1},{"codigo_barra":"004004","nombre":"Lavandina","precio":400,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":1},{"codigo_barra":"999999","nombre":"Macetas","precio":100,"fecha_actualizacion_precio":"2023-03-25T00:00:00","id_proveedor":1},{"codigo_barra":"005005","nombre":"Leche","precio":100,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":2},{"codigo_barra":"006006","nombre":"Pan lactal","precio":200,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":2},{"codigo_barra":"007007","nombre":"Cereales","precio":300,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":2},{"codigo_barra":"008008","nombre":"Dentifrico","precio":400,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":2},{"codigo_barra":"001001","nombre":"Mermelada","precio":400,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":3},{"codigo_barra":"005005","nombre":"Leche","precio":100,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":3},{"codigo_barra":"006006","nombre":"Pan lactal","precio":200,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":3},{"codigo_barra":"007007","nombre":"Cereales","precio":300,"fecha_actualizacion_precio":"2024-06-25T00:00:00","id_proveedor":3}]'
GO
*/


CREATE OR ALTER PROCEDURE SeleccionarMejorProveedorPorProducto
AS
BEGIN
    SET NOCOUNT ON;

    -- Variables para almacenar el resultado
    DECLARE @Json NVARCHAR(MAX) = N'';

    -- Tabla temporal para almacenar el resultado intermedio
    CREATE TABLE #Resultado (
        id_proveedor INT,
        codigo_barra VARCHAR(150),
        cantidad INT
    );

    -- Cálculo de la cantidad requerida para cada producto por proveedor
    INSERT INTO #Resultado (id_proveedor, codigo_barra, cantidad)
    SELECT TOP 1 WITH TIES
           pp.id_proveedor,
           pp.codigo_barra,
           CASE
               WHEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(CASE WHEN ped.codigo_estado NOT IN ('CANCELADO', 'ENTREGADO') THEN dp.cantidad ELSE 0 END), 0)) > 0 
               THEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(CASE WHEN ped.codigo_estado NOT IN ('CANCELADO', 'ENTREGADO') THEN dp.cantidad ELSE 0 END), 0))
               ELSE 0
           END AS cantidad_requerida
    FROM PRODUCTO_PROVEEDOR pp
    INNER JOIN PRODUCTOS p ON pp.codigo_barra = p.codigo_barra
    LEFT JOIN DETALLE_PEDIDO dp ON p.codigo_barra = dp.codigo_barra
    LEFT JOIN PEDIDOS ped ON dp.id_pedido = ped.id_pedido
    LEFT JOIN PROVEEDORES pr ON pp.id_proveedor = pr.id_proveedor -- Join para obtener el puntaje del proveedor
    WHERE pr.habilitado = 1
    GROUP BY pp.id_proveedor, pp.codigo_barra, p.stock_optimo, p.stock_actual, pr.puntaje
    HAVING CASE
               WHEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(CASE WHEN ped.codigo_estado NOT IN ('CANCELADO', 'ENTREGADO') THEN dp.cantidad ELSE 0 END), 0)) > 0 
               THEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(CASE WHEN ped.codigo_estado NOT IN ('CANCELADO', 'ENTREGADO') THEN dp.cantidad ELSE 0 END), 0))
               ELSE 0
           END > 0 -- Filtra productos con cantidad mayor que 0
    ORDER BY ROW_NUMBER() OVER (PARTITION BY pp.codigo_barra 
                                ORDER BY MIN(pp.precio) ASC, 
                                         pr.puntaje DESC, 
                                         NEWID()); -- Ordenar por precio ascendente, puntaje descendente y aleatoriedad

    -- Construcción del JSON de salida excluyendo productos con cantidad 0
    SELECT @Json = JSON_QUERY((SELECT id_proveedor, codigo_barra, cantidad
                               FROM #Resultado
                               WHERE cantidad > 0 -- Asegúrate de que la cantidad sea mayor a 0
                               FOR JSON AUTO));

    -- Eliminar la tabla temporal
    DROP TABLE #Resultado;

    -- Devolver el JSON como resultado
    SELECT @Json AS resultado;
END;
GO







/*
EXEC SeleccionarMejorProveedorPorProducto
[{"id_proveedor":1,"codigo_barra":"002002","cantidad":45},
{"id_proveedor":1,"codigo_barra":"003003","cantidad":42},
{"id_proveedor":1,"codigo_barra":"004004","cantidad":47},
{"id_proveedor":3,"codigo_barra":"005005","cantidad":10},
{"id_proveedor":1,"codigo_barra":"001001","cantidad":40},
{"id_proveedor":3,"codigo_barra":"006006","cantidad":30},
{"id_proveedor":3,"codigo_barra":"007007","cantidad":8},
{"id_proveedor":2,"codigo_barra":"008008","cantidad":27}]

use super
select * from productos where codigo_barra='006006'
--update proveedores set puntaje = 5 where id_proveedor=2
use super
select * from producto_proveedor  where codigo_barra='006006'
use proveedor2
select * from productos where codigo_barra='006006'
--update productos set precio = 200 where codigo_barra='006006'
use proveedor3
select * from productos where codigo_barra='006006'



update productos set precio=999, fecha_actualizacion_precio='2024-07-02 11:00:00.000'
*/

CREATE OR ALTER PROCEDURE [dbo].[INSERTAR_PEDIDO_DETALLES]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
	
    DECLARE @id_pedido INT;
    DECLARE @id_proveedor INT;
    DECLARE @codigo_estado VARCHAR(20);
    DECLARE @fecha_entrega_prevista DATETIME;
    DECLARE @fecha_entrega_real DATETIME;
    DECLARE @fecha_pedido DATETIME;
    DECLARE @evaluacion VARCHAR(50);
    DECLARE @ponderacion INT;
    DECLARE @total INT;
    DECLARE @codigo_seguimiento VARCHAR(150);

    -- Parsear el JSON y obtener los datos del pedido
    DECLARE @pedido NVARCHAR(MAX);
    DECLARE @detalles NVARCHAR(MAX);

    SELECT
        @pedido = JSON_QUERY(value, '$.Pedido'),
        @detalles = JSON_QUERY(value, '$.Detalles')
    FROM OPENJSON(@json);

    -- Parsear los campos del pedido
    SELECT
        @codigo_estado = JSON_VALUE(@pedido, '$.codigo_estado'),
        @fecha_entrega_prevista = JSON_VALUE(@pedido, '$.fecha_entrega_prevista'),
        @fecha_pedido = JSON_VALUE(@pedido, '$.fecha_pedido'),
        @total = JSON_VALUE(@pedido, '$.total'),
        @codigo_seguimiento = JSON_VALUE(@pedido, '$.codigo_seguimiento'),
        @id_proveedor = JSON_VALUE(@pedido, '$.id_proveedor');

    -- Insertar el pedido en la tabla PEDIDOS y obtener el id_pedido generado
    INSERT INTO PEDIDOS (
        id_proveedor,
        codigo_estado,
        fecha_entrega_prevista,
        fecha_pedido,
        total,
        codigo_seguimiento
    ) VALUES (
        @id_proveedor, 
        @codigo_estado,
        @fecha_entrega_prevista,
        @fecha_pedido,
        @total,
        @codigo_seguimiento
    );

    SET @id_pedido = SCOPE_IDENTITY();

    -- Insertar los detalles en la tabla DETALLE_PEDIDO
    DECLARE @codigo_barra VARCHAR(150);
    DECLARE @cantidad INT;
    DECLARE @precio_unitario INT;

    DECLARE detalles_cursor CURSOR FOR
    SELECT
        JSON_VALUE(value, '$.codigo_barra') AS codigo_barra,
        JSON_VALUE(value, '$.cantidad') AS cantidad,
        JSON_VALUE(value, '$.precio_unitario') AS precio_unitario
    FROM OPENJSON(@detalles);

    OPEN detalles_cursor;
    FETCH NEXT FROM detalles_cursor INTO @codigo_barra, @cantidad, @precio_unitario;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO DETALLE_PEDIDO (
            id_pedido,
            codigo_barra,
            cantidad,
            precio_unitario
        ) VALUES (
            @id_pedido,
            @codigo_barra,
            @cantidad,
            @precio_unitario
        );

        FETCH NEXT FROM detalles_cursor INTO @codigo_barra, @cantidad, @precio_unitario;
    END;

    CLOSE detalles_cursor;
    DEALLOCATE detalles_cursor;
	 DECLARE @jsonResult NVARCHAR(MAX);

    SELECT @jsonResult = (
        SELECT
            id_pedido,
            id_proveedor,
            codigo_estado,
            fecha_entrega_prevista,
            fecha_pedido,
            total,
            codigo_seguimiento
        FROM PEDIDOS
        WHERE id_pedido = @id_pedido
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    -- Mostrar el resultado final
    SELECT @jsonResult AS Pedido;
    SET NOCOUNT OFF;
END;
GO

GO
/*
EXEC INSERTAR_PEDIDO_DETALLES
@json = '[
  {
    "Pedido": {
      "id_proveedor": 1,
      "id_pedido": 11,
      "codigo_estado": "PENDIENTE",
      "fecha_entrega_prevista": "2024-07-11T17:02:46.740",
      "fecha_pedido": "2024-07-08T17:02:46.740",
      "total": 3800,
      "codigo_seguimiento": "ABCD333685"
    },
    "Detalles": [
      {
        "codigo_barra": "005005",
        "cantidad": 8,
        "precio_unitario": 100
      },
      {
        "codigo_barra": "006006",
        "cantidad": 15,
        "precio_unitario": 200
      }
    ]
  }
]'
GO
*/

CREATE OR ALTER PROCEDURE ObtenerCantidadPedidosPorProveedor
AS
	 DECLARE @jsonResult NVARCHAR(MAX);
BEGIN
    SET NOCOUNT ON;
	 SELECT @jsonResult = (
		SELECT 
			id_proveedor,
			COUNT(id_pedido) AS cantidad_pedidos
		FROM 
			PEDIDOS
		GROUP BY 
			id_proveedor
		FOR JSON PATH);

		SELECT @jsonResult AS cantidad_pedidos_proveedores;
    SET NOCOUNT OFF;
END;
GO
EXEC ObtenerCantidadPedidosPorProveedor



/*
update proveedores set puntaje = 3 where id_proveedor=1


use super
select * from producto_proveedor
use proveedor1
select * from productos
use proveedor2
select * from productos
use proveedor3
select * from productos


update producto_proveedor set fecha_actualizacion_precio = '2022-05-12 11:11:11.000', precio=1 where codigo_barra='001001' and id_proveedor=1
select * from productos
select * from PROVEEDORES
select * from pedidos
select * from DETALLE_PEDIDO

update PRODUCTOS set stock_actual=0


delete from detalle_pedido
delete from pedidos

*/

USE SUPER

INSERT INTO USUARIOS VALUES ('pablo', 'pablo123')


INSERT INTO PROVEEDORES (nombre, cuil, mail, nombre_url, token, puntaje, habilitado) VALUES
('Pepito S.A.', '38-569844-3', 'pepito_prov@gmail.com', 'http://localhost:8081/proveedor/', 'token123456', 5, 1),
('Proveedor Juan S.A.', '11-65987469-1', 'juan_juv@gmail.com', 'http://localhost:8080/Proveedor2/services/ConfiguracionesWSPort?wsdl', 'token123456', 5, 1),
('Distribuidora Granada', '11-65987469-1', 'granada_dis@dmkdist.com', 'http://localhost:4231/proveedor/', 'token987654', 5, 1);




--INSERT INTO USUARIOS (usuario, clave) VALUES ('pablo', 'pablo123');
INSERT INTO PEDIDOS (id_proveedor, codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, ponderacion, total, codigo_seguimiento)
VALUES 
(1, 'PENDIENTE', '2024-07-01 10:00:00', NULL, '2024-06-25 14:00:00', null, null, 10000, 'ABCD123456'),
(2, 'EN_PROCESO', '2024-07-02 11:00:00', NULL, '2024-06-26 15:00:00', null, null, 10000, 'DEFG456789'),
(3, 'EN_PROCESO', '2024-07-02 11:00:00', NULL, '2024-06-26 15:00:00', null, null, 5400, 'XYZU126766'),
(3, 'ENTREGADO', '2024-07-05 10:00:00', '2024-07-06 12:00:00', '2024-07-01 12:00:00', null, null, 5500, 'XYZU987654'),
(3, 'ENTREGADO', '2024-07-05 10:00:00', '2024-07-06 12:00:00', '2024-07-01 12:00:00', null, null, 5500, 'XYZU335333');

INSERT INTO RANKING (id_proveedor, evaluacion, ponderacion) VALUES
(1, 'Muy Malo', 1),
(1, 'Malo', 2),
(1, 'Regular', 3),
(1, 'Bueno', 4),
(1, 'Muy Bueno', 5),
(2, 'Deficiente', 1),
(2, 'Aceptable', 3),
(2, 'Excelente', 5),
(3, 'Malo', 1),
(3, 'Intermedio', 3),
(3, 'Óptimo', 5);



INSERT INTO PRODUCTOS (codigo_barra, nombre, stock_actual, stock_optimo)
VALUES ('001001', 'Mermelada', 100, 150),
       ('002002', 'Cafe', 50, 100),
       ('003003', 'Coca-cola', 50, 100),
       ('004004', 'Lavandina', 50, 100),
       ('005005', 'Leche', 50, 100),
       ('006006', 'Pan lactal', 200, 250),
	   ('007007', 'Cereales', 80, 120),
	   ('008008', 'Dentifrico', 60, 90);

	   INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (1, '001001', 10, 100),
       (1, '002002', 10, 200),
       (1, '003003', 10, 300),
       (1, '004004', 10, 400);
INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (2, '005005', 10, 100),
       (2, '006006', 10, 200),
       (2, '007007', 10, 300),
       (2, '008008', 10, 400);


INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (3, '005005', 2, 200),
       (3, '006006', 3, 300),
       (3, '007007', 4, 400),
       (3, '001001', 5, 500);
INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (4, '005005', 5, 100),
       (4, '006006', 10, 200),
       (4, '007007', 10, 300);
INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (5, '005005', 5, 100),
       (5, '006006', 10, 200),
       (5, '001001', 10, 300);



INSERT INTO PRODUCTO_PROVEEDOR(id_proveedor, codigo_barra, fecha_actualizacion_precio, nombre, precio)
VALUES (1, '001001', '2024-06-25 00:00:00.000','Mermelada' ,100),
       (1, '002002', '2024-06-25 00:00:00.000','Cafe' ,200),
       (1, '003003', '2024-06-25 00:00:00.000','Coca-cola' ,300),
       (1, '004004', '2024-06-25 00:00:00.000','Lavandina' ,400);

INSERT INTO PRODUCTO_PROVEEDOR(id_proveedor, codigo_barra, nombre, fecha_actualizacion_precio,  precio)
VALUES (2, '005005', 'Leche','2024-06-25 00:00:00.000' ,100),
       (2, '006006','Pan lactal' ,'2024-06-25 00:00:00.000' ,200),
       (2, '007007','Cereales', '2024-06-25 00:00:00.000' ,300),
       (2, '008008','Dentifrico', '2024-06-25 00:00:00.000' ,400);

INSERT INTO PRODUCTO_PROVEEDOR(id_proveedor, codigo_barra, nombre, fecha_actualizacion_precio,  precio)
VALUES (3, '005005', 'Leche','2024-06-25 00:00:00.000' ,100),
       (3, '006006','Pan lactal' ,'2024-06-25 00:00:00.000' ,200),
       (3, '007007','Cereales', '2024-06-25 00:00:00.000' ,300),
       (3, '001001','Mermelada', '2024-06-25 00:00:00.000' ,100);





UPDATE PRODUCTOS 
SET 
    nombre = 'Mermelada', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\mermelada.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '001001'

UPDATE PRODUCTOS 
SET 
    nombre = 'Cafe', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\cafe.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '002002'

UPDATE PRODUCTOS 
SET 
    nombre = 'Coca-cola', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\cocacola.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '003003'

UPDATE PRODUCTOS 
SET 
    nombre = 'Lavandina', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\lavandina.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '004004'

UPDATE PRODUCTOS 
SET 
    nombre = 'Leche', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\leche.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '005005'

UPDATE PRODUCTOS 
SET 
    nombre = 'Pan lactal', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\pan.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '006006'

UPDATE PRODUCTOS 
SET 
    nombre = 'Cereales', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\cereales.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '007007'

UPDATE PRODUCTOS 
SET 
    nombre = 'Dentifrico', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\dentifrico.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '008008'

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
USE PROVEEDOR1;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarDatos')
BEGIN
    DROP PROCEDURE sp_InsertarDatos;
END
GO

CREATE PROCEDURE sp_InsertarDatos
    @nombre_url VARCHAR(50),
    @nombre_configuracion VARCHAR(50),
    @cuil_configuracion  VARCHAR(150),
    @email_configuracion VARCHAR(150),
    @token_configuracion VARCHAR(150),
    @codigo_estado VARCHAR(20),
    @fecha_entrega_prevista DATE,
    @fecha_entrega_real DATE,
    @fecha_pedido DATE,
    @evaluacion VARCHAR(50),
    @total INT,
    @codigo_seguimiento VARCHAR(150),
    @codigo_barra_1 VARCHAR(150), @nombre_producto_1 VARCHAR(150), @precio_producto_1 INT, @fecha_actualizacion_precio_1 DATE,
    @codigo_barra_2 VARCHAR(150), @nombre_producto_2 VARCHAR(150), @precio_producto_2 INT, @fecha_actualizacion_precio_2 DATE, 
    @codigo_barra_3 VARCHAR(150), @nombre_producto_3 VARCHAR(150), @precio_producto_3 INT, @fecha_actualizacion_precio_3 DATE, 
    @codigo_barra_4 VARCHAR(150), @nombre_producto_4 VARCHAR(150), @precio_producto_4 INT, @fecha_actualizacion_precio_4 DATE,
    @cantidad_1 INT, @precio_unitario_1 INT,
    @cantidad_2 INT, @precio_unitario_2 INT,
    @cantidad_3 INT, @precio_unitario_3 INT,
    @cantidad_4 INT, @precio_unitario_4 INT,
    @valor_ranking_1 VARCHAR(50),
    @valor_ranking_2 VARCHAR(50),
    @valor_ranking_3 VARCHAR(50),
    @valor_ranking_4 VARCHAR(50),
    @valor_ranking_5 VARCHAR(50)
AS
BEGIN
    -- Insertar o actualizar el registro en la tabla CONFIGURACION
    IF NOT EXISTS (SELECT 1 FROM CONFIGURACION)
    BEGIN
        INSERT INTO CONFIGURACION (nombre_url, nombre, cuil, mail, token)
        VALUES (@nombre_url, @nombre_configuracion, @cuil_configuracion, @email_configuracion, @token_configuracion);
    END
    ELSE
    BEGIN
        UPDATE CONFIGURACION
        SET nombre_url = @nombre_url,
			nombre = @nombre_configuracion,
            cuil = @cuil_configuracion,
            mail = @email_configuracion,
            token = @token_configuracion;
    END

    -- Insertar en la tabla PEDIDOS
    DECLARE @id_pedido INT;
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento)
    VALUES (@codigo_estado, @fecha_entrega_prevista, @fecha_entrega_real, @fecha_pedido, @evaluacion, @total, @codigo_seguimiento);
    
    SET @id_pedido = SCOPE_IDENTITY();

    -- Insertar en la tabla PRODUCTOS
    INSERT INTO PRODUCTOS (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    VALUES 
        (@codigo_barra_1, @nombre_producto_1, @precio_producto_1, @fecha_actualizacion_precio_1),
        (@codigo_barra_2, @nombre_producto_2, @precio_producto_2, @fecha_actualizacion_precio_2),
        (@codigo_barra_3, @nombre_producto_3, @precio_producto_3, @fecha_actualizacion_precio_3),
        (@codigo_barra_4, @nombre_producto_4, @precio_producto_4, @fecha_actualizacion_precio_4);

    -- Insertar en la tabla DETALLE_PEDIDO
    INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
    VALUES 
        (@id_pedido, @codigo_barra_1, @cantidad_1, @precio_unitario_1),
        (@id_pedido, @codigo_barra_2, @cantidad_2, @precio_unitario_2),
        (@id_pedido, @codigo_barra_3, @cantidad_3, @precio_unitario_3),
        (@id_pedido, @codigo_barra_4, @cantidad_4, @precio_unitario_4);

    -- Insertar en la tabla RANKING
    INSERT INTO RANKING (evaluacion)
    VALUES 
        (@valor_ranking_1),
        (@valor_ranking_2),
        (@valor_ranking_3),
        (@valor_ranking_4),
        (@valor_ranking_5);
END;
GO

-- Ejecutar el procedimiento almacenado con datos de ejemplo
EXEC sp_InsertarDatos
	@nombre_url='http://localhost:8081/proveedor/',
    @nombre_configuracion = 'Pepito S.A.',
    @cuil_configuracion = '38-569844-3',
    @email_configuracion = 'Pepito@gmail.com',
    @token_configuracion = 'token123456',
    @codigo_estado = 'PENDIENTE',
    @fecha_entrega_prevista = '2024-07-01 10:00:00',
    @fecha_entrega_real = null,
    @fecha_pedido = '2024-06-25 14:00:00',
    @evaluacion = null,
    @total = 10000,
    @codigo_seguimiento = 'ABCD123456',
    @codigo_barra_1 = '001001', @nombre_producto_1 = 'Mermelada', @precio_producto_1 = 100, @fecha_actualizacion_precio_1 = '2024-06-25 14:00:00',
    @codigo_barra_2 = '002002', @nombre_producto_2 = 'Cafe', @precio_producto_2 = 200, @fecha_actualizacion_precio_2 = '2024-06-25 14:00:00', 
    @codigo_barra_3 = '003003', @nombre_producto_3 = 'Coca-cola', @precio_producto_3 = 300, @fecha_actualizacion_precio_3 = '2024-06-25 14:00:00',
    @codigo_barra_4 = '004004', @nombre_producto_4 = 'Lavandina', @precio_producto_4 = 400, @fecha_actualizacion_precio_4 = '2024-06-25 14:00:00',
    @cantidad_1 = 10, @precio_unitario_1 = 100,
    @cantidad_2 = 10, @precio_unitario_2 = 200,
    @cantidad_3 = 10, @precio_unitario_3 = 300,
    @cantidad_4 = 10, @precio_unitario_4 = 300,
    @valor_ranking_1 = 'Muy Malo',
    @valor_ranking_2 = 'Malo',
    @valor_ranking_3 = 'Regular',
    @valor_ranking_4 = 'Bueno',
    @valor_ranking_5 = 'Muy Bueno';

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


USE PROVEEDOR2;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarDatos')
BEGIN
    DROP PROCEDURE sp_InsertarDatos;
END
GO

CREATE PROCEDURE sp_InsertarDatos
    @nombre_url VARCHAR(150),
    @nombre_configuracion VARCHAR(50),
    @cuil_configuracion  VARCHAR(150),
    @email_configuracion VARCHAR(150),
    @token_configuracion VARCHAR(150),
    @codigo_estado VARCHAR(20),
    @fecha_entrega_prevista DATE,
    @fecha_entrega_real DATE,
    @fecha_pedido DATE,
    @evaluacion VARCHAR(50),
    @total INT,
    @codigo_seguimiento VARCHAR(150),
    @codigo_barra_1 VARCHAR(150), @nombre_producto_1 VARCHAR(150), @precio_producto_1 INT, @fecha_actualizacion_precio_1 DATE,
    @codigo_barra_2 VARCHAR(150), @nombre_producto_2 VARCHAR(150), @precio_producto_2 INT, @fecha_actualizacion_precio_2 DATE, 
    @codigo_barra_3 VARCHAR(150), @nombre_producto_3 VARCHAR(150), @precio_producto_3 INT, @fecha_actualizacion_precio_3 DATE, 
    @codigo_barra_4 VARCHAR(150), @nombre_producto_4 VARCHAR(150), @precio_producto_4 INT, @fecha_actualizacion_precio_4 DATE,
    @cantidad_1 INT, @precio_unitario_1 INT,
    @cantidad_2 INT, @precio_unitario_2 INT,
    @cantidad_3 INT, @precio_unitario_3 INT,
    @cantidad_4 INT, @precio_unitario_4 INT,
    @valor_ranking_1 VARCHAR(50),
    @valor_ranking_2 VARCHAR(50),
    @valor_ranking_3 VARCHAR(50)
AS
BEGIN
    -- Insertar o actualizar el registro en la tabla CONFIGURACION
    IF NOT EXISTS (SELECT 1 FROM CONFIGURACION)
    BEGIN
        INSERT INTO CONFIGURACION (nombre_url, nombre, cuil, mail, token)
        VALUES (@nombre_url, @nombre_configuracion, @cuil_configuracion, @email_configuracion, @token_configuracion);
    END
    ELSE
    BEGIN
        UPDATE CONFIGURACION
        SET nombre_url = @nombre_url,
			nombre = @nombre_configuracion,
            cuil = @cuil_configuracion,
            mail = @email_configuracion,
            token = @token_configuracion;
    END

    -- Insertar en la tabla PEDIDOS
    DECLARE @id_pedido INT;
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento)
    VALUES (@codigo_estado, @fecha_entrega_prevista, @fecha_entrega_real, @fecha_pedido, @evaluacion, @total, @codigo_seguimiento);
    
    SET @id_pedido = SCOPE_IDENTITY();

    -- Insertar en la tabla PRODUCTOS
    INSERT INTO PRODUCTOS (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    VALUES 
        (@codigo_barra_1, @nombre_producto_1, @precio_producto_1, @fecha_actualizacion_precio_1),
        (@codigo_barra_2, @nombre_producto_2, @precio_producto_2, @fecha_actualizacion_precio_2),
        (@codigo_barra_3, @nombre_producto_3, @precio_producto_3, @fecha_actualizacion_precio_3),
        (@codigo_barra_4, @nombre_producto_4, @precio_producto_4, @fecha_actualizacion_precio_4);

    -- Insertar en la tabla DETALLE_PEDIDO
    INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
    VALUES 
        (@id_pedido, @codigo_barra_1, @cantidad_1, @precio_unitario_1),
        (@id_pedido, @codigo_barra_2, @cantidad_2, @precio_unitario_2),
        (@id_pedido, @codigo_barra_3, @cantidad_3, @precio_unitario_3),
        (@id_pedido, @codigo_barra_4, @cantidad_4, @precio_unitario_4);

    -- Insertar en la tabla RANKING
    INSERT INTO RANKING (evaluacion)
    VALUES 
        (@valor_ranking_1),
        (@valor_ranking_2),
        (@valor_ranking_3);
END;
GO

-- Ejecutar el procedimiento almacenado con datos de ejemplo
EXEC sp_InsertarDatos
	@nombre_url='http://localhost:8080/Proveedor2/services/ConfiguracionesWSPort?wsdl',
    @nombre_configuracion = 'Proveedor Juan S.A.',
    @cuil_configuracion = '11-65987469-1',
    @email_configuracion = 'proveedor_juac@gmail.com',
    @token_configuracion = 'token123456',
    @codigo_estado = 'EN_PROCESO',
    @fecha_entrega_prevista = '2024-07-02 11:00:00',
    @fecha_entrega_real = null,
    @fecha_pedido = '2024-06-26 15:00:00',
    @evaluacion = null,
    @total = 10000,
    @codigo_seguimiento = 'DEFG456789',
    @codigo_barra_1 = '005005', @nombre_producto_1 = 'Leche', @precio_producto_1 = 100, @fecha_actualizacion_precio_1 = '2024-06-25 14:00:00',
    @codigo_barra_2 = '006006', @nombre_producto_2 = 'Pan lactal', @precio_producto_2 = 200, @fecha_actualizacion_precio_2 = '2024-06-25 14:00:00', 
    @codigo_barra_3 = '007007', @nombre_producto_3 = 'Cereales', @precio_producto_3 = 300, @fecha_actualizacion_precio_3 = '2024-06-25 14:00:00',
    @codigo_barra_4 = '008008', @nombre_producto_4 = 'Dentifrico', @precio_producto_4 = 400, @fecha_actualizacion_precio_4 = '2024-06-25 14:00:00',
    @cantidad_1 = 10, @precio_unitario_1 = 100,
    @cantidad_2 = 10, @precio_unitario_2 = 200,
    @cantidad_3 = 10, @precio_unitario_3 = 300,
    @cantidad_4 = 10, @precio_unitario_4 = 400,
    @valor_ranking_1 = 'Deficiente',
    @valor_ranking_2 = 'Aceptable',
    @valor_ranking_3 = 'Excelente';




--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



	USE PROVEEDOR3;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarDatos')
BEGIN
    DROP PROCEDURE sp_InsertarDatos;
END
GO

CREATE PROCEDURE sp_InsertarDatos
    @nombre_url VARCHAR(50),
    @nombre_configuracion VARCHAR(50),
    @cuil_configuracion  VARCHAR(150),
    @email_configuracion VARCHAR(150),
    @token_configuracion VARCHAR(150),
    @codigo_estado VARCHAR(20),
    @fecha_entrega_prevista DATE,
    @fecha_entrega_real DATE,
    @fecha_pedido DATE,
    @evaluacion VARCHAR(50),
    @total INT,
    @codigo_seguimiento VARCHAR(150),
    @codigo_barra_1 VARCHAR(150), @nombre_producto_1 VARCHAR(150), @precio_producto_1 INT, @fecha_actualizacion_precio_1 DATE,
    @codigo_barra_2 VARCHAR(150), @nombre_producto_2 VARCHAR(150), @precio_producto_2 INT, @fecha_actualizacion_precio_2 DATE, 
    @codigo_barra_3 VARCHAR(150), @nombre_producto_3 VARCHAR(150), @precio_producto_3 INT, @fecha_actualizacion_precio_3 DATE, 
    @codigo_barra_4 VARCHAR(150), @nombre_producto_4 VARCHAR(150), @precio_producto_4 INT, @fecha_actualizacion_precio_4 DATE,
    @cantidad_1 INT, @precio_unitario_1 INT,
    @cantidad_2 INT, @precio_unitario_2 INT,
    @cantidad_3 INT, @precio_unitario_3 INT,
    @cantidad_4 INT, @precio_unitario_4 INT,
    @valor_ranking_1 VARCHAR(50),
    @valor_ranking_2 VARCHAR(50),
    @valor_ranking_3 VARCHAR(50)
AS
BEGIN
    -- Insertar o actualizar el registro en la tabla CONFIGURACION
    IF NOT EXISTS (SELECT 1 FROM CONFIGURACION)
    BEGIN
        INSERT INTO CONFIGURACION (nombre_url, nombre, cuil, mail, token)
        VALUES (@nombre_url, @nombre_configuracion, @cuil_configuracion, @email_configuracion, @token_configuracion);
    END
    ELSE
    BEGIN
        UPDATE CONFIGURACION
        SET nombre_url = @nombre_url,
			nombre = @nombre_configuracion,
            cuil = @cuil_configuracion,
            mail = @email_configuracion,
            token = @token_configuracion;
    END

    -- Insertar en la tabla PEDIDOS
    DECLARE @id_pedido INT;
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento)
    VALUES (@codigo_estado, @fecha_entrega_prevista, @fecha_entrega_real, @fecha_pedido, @evaluacion, @total, @codigo_seguimiento);
    
    SET @id_pedido = SCOPE_IDENTITY();

    -- Insertar en la tabla PRODUCTOS
    INSERT INTO PRODUCTOS (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    VALUES 
        (@codigo_barra_1, @nombre_producto_1, @precio_producto_1, @fecha_actualizacion_precio_1),
        (@codigo_barra_2, @nombre_producto_2, @precio_producto_2, @fecha_actualizacion_precio_2),
        (@codigo_barra_3, @nombre_producto_3, @precio_producto_3, @fecha_actualizacion_precio_3),
        (@codigo_barra_4, @nombre_producto_4, @precio_producto_4, @fecha_actualizacion_precio_4);

    -- Insertar en la tabla DETALLE_PEDIDO
    INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
    VALUES 
        (@id_pedido, @codigo_barra_1, @cantidad_1, @precio_unitario_1),
        (@id_pedido, @codigo_barra_2, @cantidad_2, @precio_unitario_2),
        (@id_pedido, @codigo_barra_3, @cantidad_3, @precio_unitario_3),
        (@id_pedido, @codigo_barra_4, @cantidad_4, @precio_unitario_4);

    -- Insertar en la tabla RANKING
    INSERT INTO RANKING (evaluacion)
    VALUES 
        (@valor_ranking_1),
        (@valor_ranking_2),
        (@valor_ranking_3);
END;
GO

-- Ejecutar el procedimiento almacenado con datos de ejemplo
EXEC sp_InsertarDatos
	@nombre_url='http://localhost:4231/proveedor/',
    @nombre_configuracion = 'Distribuidora Granada',
    @cuil_configuracion = '11-65987469-1',
    @email_configuracion = 'granada_dis@dmkdist.com',
    @token_configuracion = 'token987654',
    @codigo_estado = 'EN_PROCESO',
    @fecha_entrega_prevista = '2024-07-02 11:00:00',
    @fecha_entrega_real = null,
    @fecha_pedido = '2024-06-26 15:00:00',
    @evaluacion = null,
    @total = 5400,
    @codigo_seguimiento = 'XYZU126766',
    @codigo_barra_1 = '005005', @nombre_producto_1 = 'Leche', @precio_producto_1 = 100, @fecha_actualizacion_precio_1 = '2024-06-25 14:00:00',
    @codigo_barra_2 = '006006', @nombre_producto_2 = 'Pan lactal', @precio_producto_2 = 200, @fecha_actualizacion_precio_2 = '2024-06-25 14:00:00', 
    @codigo_barra_3 = '007007', @nombre_producto_3 = 'Cereales', @precio_producto_3 = 300, @fecha_actualizacion_precio_3 = '2024-06-25 14:00:00',
    @codigo_barra_4 = '001001', @nombre_producto_4 = 'Mermelada', @precio_producto_4 = 400, @fecha_actualizacion_precio_4 = '2024-06-25 14:00:00',
    @cantidad_1 = 2, @precio_unitario_1 = 200,
    @cantidad_2 = 3, @precio_unitario_2 = 300,
    @cantidad_3 = 4, @precio_unitario_3 = 400,
    @cantidad_4 = 5, @precio_unitario_4 = 500,
    @valor_ranking_1 = 'Malo',
    @valor_ranking_2 = 'Intermedio',
    @valor_ranking_3 = 'Óptimo';


	



	USE PROVEEDOR3;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarPedido')
BEGIN
    DROP PROCEDURE sp_InsertarPedido;
END
GO

CREATE PROCEDURE sp_InsertarPedido
    @codigo_estado VARCHAR(20),
    @fecha_entrega_prevista DATE,
    @fecha_entrega_real DATE,
    @fecha_pedido DATE,
    @evaluacion VARCHAR(50),
    @total INT,
    @codigo_seguimiento VARCHAR(150),
    @codigo_barra_1 VARCHAR(150), @cantidad_1 INT, @precio_unitario_1 INT,
    @codigo_barra_2 VARCHAR(150), @cantidad_2 INT, @precio_unitario_2 INT,
    @codigo_barra_3 VARCHAR(150), @cantidad_3 INT, @precio_unitario_3 INT
AS
BEGIN
    -- Insertar en la tabla PEDIDOS
    DECLARE @id_pedido INT;
    INSERT INTO PEDIDOS (codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, total, codigo_seguimiento)
    VALUES (@codigo_estado, @fecha_entrega_prevista, @fecha_entrega_real, @fecha_pedido, @evaluacion, @total, @codigo_seguimiento);
    
    SET @id_pedido = SCOPE_IDENTITY();

    -- Insertar en la tabla DETALLE_PEDIDO
    INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
    VALUES 
        (@id_pedido, @codigo_barra_1, @cantidad_1, @precio_unitario_1),
        (@id_pedido, @codigo_barra_2, @cantidad_2, @precio_unitario_2),
        (@id_pedido, @codigo_barra_3, @cantidad_3, @precio_unitario_3);
END;
GO

-- Ejecutar el procedimiento almacenado con datos de ejemplo
EXEC sp_InsertarPedido
    @codigo_estado = 'ENTREGADO',
    @fecha_entrega_prevista = '2024-07-05 10:00:00',
    @fecha_entrega_real = '2024-07-06 12:00:00',
    @fecha_pedido = '2024-07-01 12:00:00',
    @evaluacion = NULL,
    @total = 5500,
    @codigo_seguimiento = 'XYZU987654',
    @codigo_barra_1 = '005005', @cantidad_1 = 5, @precio_unitario_1 = 100,
    @codigo_barra_2 = '006006', @cantidad_2 = 10, @precio_unitario_2 = 200,
    @codigo_barra_3 = '007007', @cantidad_3 = 10, @precio_unitario_3 = 300;
EXEC sp_InsertarPedido
    @codigo_estado = 'ENTREGADO',
    @fecha_entrega_prevista = '2024-07-05 10:00:00',
    @fecha_entrega_real = '2024-07-06 12:00:00',
    @fecha_pedido = '2024-07-01 12:00:00',
    @evaluacion = NULL,
    @total = 5500,
    @codigo_seguimiento = 'XYZU335333',
    @codigo_barra_1 = '005005', @cantidad_1 = 5, @precio_unitario_1 = 100,
    @codigo_barra_2 = '006006', @cantidad_2 = 10, @precio_unitario_2 = 200,
    @codigo_barra_3 = '007007', @cantidad_3 = 10, @precio_unitario_3 = 300;
	




--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




	USE PROVEEDOR4;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarDatos')
BEGIN
    DROP PROCEDURE sp_InsertarDatos;
END
GO

CREATE PROCEDURE sp_InsertarDatos
    @nombre_url VARCHAR(150),
    @nombre_configuracion VARCHAR(50),
    @cuil_configuracion  VARCHAR(150),
    @email_configuracion VARCHAR(150),
    @token_configuracion VARCHAR(150),
    @codigo_barra_1 VARCHAR(150), @nombre_producto_1 VARCHAR(150), @precio_producto_1 INT, @fecha_actualizacion_precio_1 DATE,
    @codigo_barra_2 VARCHAR(150), @nombre_producto_2 VARCHAR(150), @precio_producto_2 INT, @fecha_actualizacion_precio_2 DATE, 
    @codigo_barra_3 VARCHAR(150), @nombre_producto_3 VARCHAR(150), @precio_producto_3 INT, @fecha_actualizacion_precio_3 DATE, 
    @codigo_barra_4 VARCHAR(150), @nombre_producto_4 VARCHAR(150), @precio_producto_4 INT, @fecha_actualizacion_precio_4 DATE,
    @precio_unitario_1 INT,
    @precio_unitario_2 INT,
    @precio_unitario_3 INT,
    @valor_ranking_1 VARCHAR(50),
    @valor_ranking_2 VARCHAR(50),
    @valor_ranking_3 VARCHAR(50)
AS
BEGIN
    -- Insertar o actualizar el registro en la tabla CONFIGURACION
    IF NOT EXISTS (SELECT 1 FROM CONFIGURACION)
    BEGIN
        INSERT INTO CONFIGURACION (nombre_url, nombre, cuil, mail, token)
        VALUES (@nombre_url, @nombre_configuracion, @cuil_configuracion, @email_configuracion, @token_configuracion);
    END
    ELSE
    BEGIN
        UPDATE CONFIGURACION
        SET nombre_url = @nombre_url,
			nombre = @nombre_configuracion,
            cuil = @cuil_configuracion,
            mail = @email_configuracion,
            token = @token_configuracion;
    END
	
    -- Insertar en la tabla PRODUCTOS
    INSERT INTO PRODUCTOS (codigo_barra, nombre, precio, fecha_actualizacion_precio)
    VALUES 
        (@codigo_barra_1, @nombre_producto_1, @precio_producto_1, @fecha_actualizacion_precio_1),
        (@codigo_barra_2, @nombre_producto_2, @precio_producto_2, @fecha_actualizacion_precio_2),
        (@codigo_barra_3, @nombre_producto_3, @precio_producto_3, @fecha_actualizacion_precio_3),
        (@codigo_barra_4, @nombre_producto_4, @precio_producto_4, @fecha_actualizacion_precio_4);


    -- Insertar en la tabla RANKING
    INSERT INTO RANKING (evaluacion)
    VALUES 
        (@valor_ranking_1),
        (@valor_ranking_2),
        (@valor_ranking_3);
END;
GO
--use PROVEEDOR2 select * from configuracion
-- Ejecutar el procedimiento almacenado con datos de ejemplo
EXEC sp_InsertarDatos
	@nombre_url='http://localhost:8080/Proveedor4/services/ConfiguracionesWSPort?wsdl',
    @nombre_configuracion = 'Suplier4 Mercaderia',
    @cuil_configuracion = '22-59874569-2',
    @email_configuracion = 'Suplier4@Mercaderia.com',
    @token_configuracion = 'token999999',   
    @codigo_barra_1 = '005005', @nombre_producto_1 = 'Producto 1', @precio_producto_1 = 100, @fecha_actualizacion_precio_1 = '2024-06-25 14:00:00',
    @codigo_barra_2 = '006006', @nombre_producto_2 = 'Producto 2', @precio_producto_2 = 200, @fecha_actualizacion_precio_2 = '2024-06-25 14:00:00', 
    @codigo_barra_3 = '007007', @nombre_producto_3 = 'Producto 3', @precio_producto_3 = 300, @fecha_actualizacion_precio_3 = '2024-06-25 14:00:00',
    @codigo_barra_4 = '008008', @nombre_producto_4 = 'Producto 4', @precio_producto_4 = 400, @fecha_actualizacion_precio_4 = '2024-06-25 14:00:00',
    @precio_unitario_1 = 100,
    @precio_unitario_2 = 200,
    @precio_unitario_3 = 300,
    @valor_ranking_1 = 'Flojo',
    @valor_ranking_2 = 'Aprobado',
    @valor_ranking_3 = 'Increible';

	/*
	USE SUPER
	Delete from DETALLE_PEDIDO 
	Delete from PEDIDOS 
	Delete from RANKING 
	Delete from PRODUCTO_PROVEEDOR where id_proveedor=5
	Delete from PROVEEDORES  where id_proveedor=5
	update pedidos set codigo_estado='ENTREGADO' where id_pedido=39
	update productos set stock_actual=0
	
	select * from proveedores
	select * from PRODUCTOS
	select * from pedidos
	select * from proveedores
	select * from detalle_pedido
	select * from PRODUCTO_proveedor order by id_proveedor where id_proveedor = 5
	select * from proveedores where id_proveedor = 5
	select * from detalle_pedido
	USE PROVEEDOR1
	insert into PRODUCTOS(nombre,precio,codigo_barra,fecha_actualizacion_precio) values ('Macetas',	100, '999999',	'2024-06-25 00:00:00.000')
	Select * from productos
	Select * from DETALLE_PEDIDO
	
	*/
