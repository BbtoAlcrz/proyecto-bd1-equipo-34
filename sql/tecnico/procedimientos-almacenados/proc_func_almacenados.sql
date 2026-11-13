USE Proyecto_BD1;
GO

/*crear una funcion sobre gasto de los proveedores, permite el ingreso de un parametro que define el minimo*/
CREATE OR ALTER FUNCTION dbo.fn_ObtenerProveedoresConGastoMinimo (@MinimoGasto DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT 
        p.cod_proveedor,
        p.nombre_proveedor,
        SUM(c.precio_total) AS gasto_total_compras
    FROM Proveedor p
    JOIN Compra c ON p.cod_proveedor = c.cod_proveedor
    GROUP BY p.cod_proveedor, p.nombre_proveedor
    HAVING SUM(c.precio_total) > @MinimoGasto
);
GO

/*siguiendo la logica de la consulta previamente hecha*/
SELECT * FROM dbo.fn_ObtenerProveedoresConGastoMinimo(100000.00);

/*probando con un parametro distinto*/
SELECT * FROM dbo.fn_ObtenerProveedoresConGastoMinimo(200000.00);

GO

/*crear un proceso para obtener las ganancias que deja cada producto*/
CREATE OR ALTER PROCEDURE dbo.sp_ObtenerRentabilidadProductos
AS
BEGIN
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
END;
GO

/*utilizacioon del procedimiento*/
EXEC dbo.sp_ObtenerRentabilidadProductos;
