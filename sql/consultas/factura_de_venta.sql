-- Consulta que detalla una venta, calculando subtotales por renglón y total a pagar
SELECT
v.cod_venta,
v.fecha_venta,
c.nombre_cliente + ' ' + c.apellido_cliente AS cliente,
c.dni,
mp.tipo_metodo AS forma_de_pago,
p.nombre_producto,
dv.cantidad,
dv.precio_unitario,
dv.cantidad * dv.precio_unitario AS subtotal_renglon,
    SUM(dv.cantidad * dv.precio_unitario)
    OVER (PARTITION BY v.cod_venta ORDER BY p.cod_producto) AS acumulado,
v.subtotal     AS subtotal_general,
v.aplicable    AS descuento,
v.precio_total AS total_a_pagar

FROM Venta v
INNER JOIN Cliente c           ON c.cod_cliente = v.cod_cliente
INNER JOIN Metodo_pago mp      ON mp.cod_metodo = v.cod_metodo
INNER JOIN Detalle_de_venta dv ON dv.cod_venta = v.cod_venta
INNER JOIN Producto p          ON p.cod_producto = dv.cod_producto

-- variar cod_venta (1-8) para ver las distintas facturas pre-cargadas
WHERE v.cod_venta = 8
ORDER BY p.cod_producto;