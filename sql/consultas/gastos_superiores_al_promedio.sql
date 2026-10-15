SELECT 
    c.cod_cliente,
    c.nombre_cliente,
    c.apellido_cliente,
    SUM(v.precio_total) AS total_gastado
FROM Cliente c
JOIN Venta v ON c.cod_cliente = v.cod_cliente
JOIN Metodo_pago m ON v.cod_metodo = m.cod_metodo
JOIN Detalle_de_venta dv ON v.cod_venta = dv.cod_venta
GROUP BY c.cod_cliente, c.nombre_cliente, c.apellido_cliente
HAVING SUM(v.precio_total) > (
    SELECT AVG(gasto_cliente.total)
    FROM (
        SELECT SUM(v2.precio_total) AS total
        FROM Cliente c2
        JOIN Venta v2 ON c2.cod_cliente = v2.cod_cliente
        GROUP BY c2.cod_cliente
    ) AS gasto_cliente
);
