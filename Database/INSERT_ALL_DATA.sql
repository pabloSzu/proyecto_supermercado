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


	/*
	USE SUPER
	Delete from DETALLE_PEDIDO 
	Delete from PEDIDOS 
	Delete from RANKING 
	Delete from PRODUCTO_PROVEEDOR where id_proveedor=5
	Delete from PROVEEDORES  where id_proveedor=5
	*/
	update pedidos set codigo_estado='PENDIENTE' where id_pedido=5
	update productos set stock_optimo=100, stock_actual=0
	
	select * from proveedores
	select * from pedidos
	select * from detalle_pedido
	select * from PRODUCTO_proveedor where id_proveedor = 5
	select * from proveedores where id_proveedor = 5
	select * from detalle_pedido