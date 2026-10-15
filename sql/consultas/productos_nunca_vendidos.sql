  --Usando LEFT JOIN ... IS NULL
    SELECT 
    p.cod_producto,
    p.nombre_producto
FROM 
    Producto p
LEFT JOIN 
    Detalle_de_venta dv ON p.cod_producto = dv.cod_producto
WHERE 
    dv.cod_producto IS NULL;


    --Usando NOT EXISTS
    SELECT 
    p.cod_producto,
    p.nombre_producto
FROM 
    Producto p
WHERE NOT EXISTS (
    SELECT 1 
    FROM Detalle_de_venta dv 
    WHERE dv.cod_producto = p.cod_producto
);


   