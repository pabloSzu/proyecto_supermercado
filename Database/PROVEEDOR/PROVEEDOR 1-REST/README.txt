Orden de ejecucion:

CREATE_TABLES
INSERT_DATOS
PROCEDIMIENTOS

**Unifiqué "agregar al detalle" y "modificar detalle", para que les pasemos la cantidades y se fije solo si
al producto lo elimina, lo modifica o lo agrega
INSERTAR_PEDIDO: crea un pedido nuevo
INSERTAR_DETALLE_PEDIDO: Se deberá ejecutar después de INSERTAR_PEDIDO; en un loop dependiendo la variedad de productos - le pasamos el id del nuevo pedido como parametro.

**Faltaría un trigger para que al cambiar el codigo_estado a 'ENTREGADO' se actualice fech_entrega_real a la fecha actual