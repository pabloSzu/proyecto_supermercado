
INSERT INTO USUARIOS VALUES ('pablo', 'pablo123')


INSERT INTO PROVEEDORES (nombre, cuil, mail, nombre_url, token, puntaje, habilitado) VALUES
('Pepito S.A.', '38-569844-3', 'pepito_prov@gmail.com', 'http://localhost:8081/proveedor/', 'token123456', 10, 0),
('Proveedor Juan S.A.', '11-65987469-1', 'juan_juv@gmail.com', 'http://localhost:8080/Proveedor2/services/ConfiguracionesWSPort?wsdl', 'token123456', 10, 0);



--INSERT INTO USUARIOS (usuario, clave) VALUES ('pablo', 'pablo123');
INSERT INTO PEDIDOS (id_proveedor, codigo_estado, fecha_entrega_prevista, fecha_entrega_real, fecha_pedido, evaluacion, ponderacion, total, codigo_seguimiento)
VALUES 
(1, 'PENDIENTE', '2024-07-01 10:00:00', NULL, '2024-06-25 14:00:00', 'Bueno', null, 6000, 'ABCD123456'),
(2, 'EN_PROCESO', '2024-07-02 11:00:00', NULL, '2024-06-26 15:00:00', 'Excelente', null, 6000, 'DEFG456789');

INSERT INTO RANKING (id_proveedor, evaluacion, ponderacion) VALUES
(1, 'Muy Malo', 1),
(1, 'Malo', 3),
(1, 'Regular', 5),
(1, 'Bueno', 7),
(1, 'Muy Bueno', 10),
(2, 'Deficiente', 1),
(2, 'Aceptable', 5),
(2, 'Excelente', 10);



INSERT INTO PRODUCTOS (codigo_barra, nombre, stock_actual, stock_optimo)
VALUES ('001001', 'Producto 1', 100, 150),
       ('002002', 'Producto 2', 50, 100),
       ('003003', 'Producto 2', 50, 100),
       ('004004', 'Producto 2', 50, 100),
       ('005005', 'Producto 2', 50, 100),
       ('006006', 'Producto 3', 200, 250),
	   ('007007', 'Producto 4', 80, 120),
	   ('008008', 'Producto 5', 60, 90),
	   ('009009', 'Producto 6', 150, 200),
	   ('010010', 'Producto 7', 30, 50),
	   ('011011', 'Producto 8', 100, 150),
	   ('012012', 'Producto 9', 70, 100);

	   INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (1, '001001', 10, 100),
       (1, '002002', 5, 200),
       (1, '003003', 8, 300),
       (1, '004004', 3, 400);
	    INSERT INTO DETALLE_PEDIDO (id_pedido, codigo_barra, cantidad, precio_unitario)
VALUES (2, '005005', 10, 100),
       (2, '006006', 5, 200),
       (2, '007007', 8, 300),
       (2, '008008', 3, 400);

	   

UPDATE PRODUCTOS 
SET 
    nombre = 'mermelada.jpg', -- Nombre de la imagen
    imagen_contenido = (SELECT BulkColumn 
                        FROM OPENROWSET(BULK N'C:\Users\pablo\Downloads\mermelada.jpg', SINGLE_BLOB) AS Imagen)
WHERE codigo_barra = '001001'
