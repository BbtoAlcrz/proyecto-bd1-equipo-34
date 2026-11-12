USE Proyecto_BD1;
GO

-- Manejo de Transacciones y Transacciones Anidadas

-- Modificar estos valores para alternar entre la Prueba Correcta e Incorrecta
-- CASO DE PRUEBA CORRECTA: 
DECLARE @cod_cliente INT = 1;
DECLARE @cod_metodo INT = 1;
DECLARE @cod_producto INT = 1;
DECLARE @cantidad INT = 2; -- caso correcto (stock 15 -> 13). Para el caso con error usar 999
DECLARE @precio_unitario DECIMAL(10,2) = 60800.00;
DECLARE @aplicable DECIMAL(10,2) = 0.00;

-- Variables para cálculo de precios
DECLARE @subtotal DECIMAL(10,2) = @precio_unitario * @cantidad;
DECLARE @precio_total DECIMAL(10,2) = @subtotal - @aplicable;
DECLARE @id_venta_generada INT;
DECLARE @ventas_previas INT = (SELECT COUNT(*) FROM Venta);

PRINT 'INICIANDO TRANSACCION...';

-- Consulta estato previo a la transaccion
SELECT 'ESTADO INICIAL' AS Control, 
    cod_producto, 
    nombre_producto, 
    stock 
FROM Producto 
WHERE cod_producto = @cod_producto;

BEGIN TRY
    -- Inicio de la transacción atómica
    BEGIN TRANSACTION;

    -- Insertar el registro en la tabla Venta
    INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo)
    VALUES (GETDATE(), @subtotal, @aplicable, @precio_total, @cod_cliente, @cod_metodo);

    -- Obtener el ID que fue generado para la Venta
    SET @id_venta_generada = SCOPE_IDENTITY();

    -- Insertar registro en la tabla Detalle_de_venta
    INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad)
    VALUES (@id_venta_generada, @cod_producto, @precio_unitario, @cantidad);

    -- Descontar stock en la tabla Producto
    UPDATE Producto
    SET stock = stock - @cantidad
    WHERE cod_producto = @cod_producto;

    -- Si las 3 operaciones anteriores sucedieron sin errores, se efectúan los cambios de forma permanente
    COMMIT TRANSACTION;
    PRINT 'ÉXITO: Transacción confirmada (COMMIT). Venta registrada correctamente';

END TRY
BEGIN CATCH
    -- Si ocurrió cualquier error en las inserciones o en el update, se revierte TODO
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END

    PRINT 'ERROR: La transacción ha sido revertida completamente';
END CATCH;


-- Consulta si cambió el stock del producto
SELECT 'ESTADO FINAL' AS Control, 
    cod_producto, 
    nombre_producto, 
    stock 
FROM Producto 
WHERE cod_producto = @cod_producto;
GO