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












--////////////////////////////////////////////////////////////////////////////////////////////////////////////////VERIFICAR TOKEN
CREATE OR ALTER   PROCEDURE VERIFICAR_TOKEN
    @token VARCHAR(150)
AS
BEGIN
	SELECT token FROM CONFIGURACION WHERE token = @token 
END;
GO
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







