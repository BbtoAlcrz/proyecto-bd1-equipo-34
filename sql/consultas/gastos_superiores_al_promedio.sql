SELECT 
    c.cod_cliente,
    c.nombre_cliente,
    c.apellido_cliente,
    SUM(v.precio_total) AS total_gastado
FROM Cliente c
JOIN Venta v ON c.cod_cliente = v.cod_cliente
GROUP BY c.cod_cliente, c.nombre_cliente, c.apellido_cliente
HAVING SUM(v.precio_total) > (
    SELECT AVG(gasto_cliente.total)
    FROM (
        SELECT SUM(v2.precio_total) AS total
        FROM Venta v2
        GROUP BY v2.cod_cliente
    ) AS gasto_cliente
);
