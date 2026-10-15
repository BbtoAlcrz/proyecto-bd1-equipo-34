SELECT 
    c.nombre_categoria AS Categoria,
    SUM(dv.cantidad * dv.precio_unitario) AS Total_Ventas
FROM 
    Categoria c
JOIN 
    Producto p ON c.cod_categoria = p.cod_categoria
JOIN 
    Detalle_de_venta dv ON p.cod_producto = dv.cod_producto
JOIN 
    Venta v ON dv.cod_venta = v.cod_venta
WHERE v.fecha_venta BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY 
    c.nombre_categoria
ORDER BY 
    Total_Ventas DESC;

   