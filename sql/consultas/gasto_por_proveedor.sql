SELECT 
    p.cod_proveedor,
    p.nombre_proveedor,
    SUM(c.precio_total) AS gasto_total_compras
FROM Proveedor p
JOIN Compra c ON p.cod_proveedor = c.cod_proveedor
GROUP BY p.cod_proveedor, p.nombre_proveedor
HAVING SUM(c.precio_total) > 100000.00; -- Ajustá  monto mínimo 

