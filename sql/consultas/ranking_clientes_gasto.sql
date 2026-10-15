SELECT c.nombre_cliente, c.cod_cliente, SUM(v.precio_total) AS importe_total, COUNT(v.cod_venta) AS cantidad_compras
FROM Cliente AS c 
INNER JOIN Venta AS v
ON c.cod_cliente = v.cod_cliente
GROUP BY  c.nombre_cliente, c.cod_cliente
ORDER BY importe_total DESC
