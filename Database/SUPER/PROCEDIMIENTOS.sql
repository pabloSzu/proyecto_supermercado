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
            p.imagen_nombre,
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
            p.imagen_nombre,
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
               WHEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(dp.cantidad), 0)) > 0 THEN p.stock_optimo - (p.stock_actual + ISNULL(SUM(dp.cantidad), 0))
               ELSE 0
           END AS cantidad_requerida
    FROM PRODUCTO_PROVEEDOR pp
    INNER JOIN PRODUCTOS p ON pp.codigo_barra = p.codigo_barra
    LEFT JOIN DETALLE_PEDIDO dp ON p.codigo_barra = dp.codigo_barra
    LEFT JOIN PEDIDOS ped ON dp.id_pedido = ped.id_pedido
    LEFT JOIN PROVEEDORES pr ON pp.id_proveedor = pr.id_proveedor -- Join para obtener el puntaje del proveedor
    WHERE (ped.codigo_estado IN ('PENDIENTE', 'EN_PROCESO', 'ENVIADO', 'ENTREGADO') OR ped.codigo_estado IS NULL) AND pr.habilitado = 1
    GROUP BY pp.id_proveedor, pp.codigo_barra, p.stock_optimo, p.stock_actual, pr.puntaje
    ORDER BY ROW_NUMBER() OVER (PARTITION BY pp.codigo_barra 
                                ORDER BY MIN(pp.precio) ASC, 
                                         pr.puntaje DESC, 
                                         NEWID()); -- Ordenar por precio ascendente, puntaje descendente y aleatoriedad

    -- Construcción del JSON de salida
    SELECT @Json = JSON_QUERY((SELECT id_proveedor, codigo_barra, cantidad FROM #Resultado FOR JSON AUTO));

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
