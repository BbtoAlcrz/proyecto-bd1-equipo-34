SELECT 
    p.cod_producto,
    p.nombre_producto,
    p.precio_compra,
    p.precio_venta,
    (p.precio_venta - p.precio_compra) AS ganancia_unitaria,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM((p.precio_venta - p.precio_compra) * dv.cantidad) AS margen_ganancia_total
FROM Producto p
JOIN Detalle_de_venta dv ON p.cod_producto = dv.cod_producto
GROUP BY p.cod_producto, p.nombre_producto, p.precio_compra, p.precio_venta;
