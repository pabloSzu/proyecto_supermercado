USE PROVEEDOR2;
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
        (@id_pedido, @codigo_barra_3, @cantidad_3, @precio_unitario_3);

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
    @total = 2000,
    @codigo_seguimiento = 'DEFG456789',
    @codigo_barra_1 = '005005', @nombre_producto_1 = 'Producto 1', @precio_producto_1 = 100, @fecha_actualizacion_precio_1 = '2024-06-25 14:00:00',
    @codigo_barra_2 = '006006', @nombre_producto_2 = 'Producto 2', @precio_producto_2 = 200, @fecha_actualizacion_precio_2 = '2024-06-25 14:00:00', 
    @codigo_barra_3 = '007007', @nombre_producto_3 = 'Producto 3', @precio_producto_3 = 300, @fecha_actualizacion_precio_3 = '2024-06-25 14:00:00',
    @codigo_barra_4 = '008008', @nombre_producto_4 = 'Producto 4', @precio_producto_4 = 400, @fecha_actualizacion_precio_4 = '2024-06-25 14:00:00',
    @cantidad_1 = 2, @precio_unitario_1 = 100,
    @cantidad_2 = 3, @precio_unitario_2 = 200,
    @cantidad_3 = 4, @precio_unitario_3 = 300,
    @valor_ranking_1 = 'Deficiente',
    @valor_ranking_2 = 'Aceptable',
    @valor_ranking_3 = 'Excelente';
