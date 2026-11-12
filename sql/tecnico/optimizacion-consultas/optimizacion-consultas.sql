USE Proyecto_BD1;
GO

-- Parte 1: Creación de tabla sin Primary Key ni Índice (Heap)
-- Se elimina si ya existe para poder repetir la prueba desde cero
DROP TABLE IF EXISTS VentaPruebaHistorica;
GO

CREATE TABLE VentaPruebaHistorica 
(
    cod_venta BIGINT IDENTITY(1,1),
    fecha_venta DATE NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    cod_cliente INT NOT NULL
);
GO


-- Parte 2: Insercion Masiva de un millón de datos
SET NOCOUNT ON;
GO

WITH CTE_Numeros AS (
    SELECT TOP (1000000) 
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
    CROSS JOIN sys.objects c
)
INSERT INTO VentaPruebaHistorica (fecha_venta, precio_total, subtotal, cod_cliente)
SELECT 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1768, '2022-01-01'), -- Fechas entre 2022 y 03/11/2026
    CAST((RAND(CHECKSUM(NEWID())) * 50000 + 1000) AS DECIMAL(10,2)),
    CAST((RAND(CHECKSUM(NEWID())) * 45000 + 1000) AS DECIMAL(10,2)),
    ABS(CHECKSUM(NEWID())) % 8 + 1 -- Asigna IDs de nuestra tabla Clientes precargados (1 a 8)
FROM CTE_Numeros;
GO


-- Contamos la cantidad de registros para corroborar el millón insertado
SELECT COUNT(*) AS CantidadRegistros FROM VentaPruebaHistorica
GO
-- SELECT TOP 10 * FROM VentaPruebaHistorica


-- Parte 3: Consulta sin Indices
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- PRUEBA 1: Consulta por rango de fechas SIN ÍNDICE (Recorrido de Tabla)
SELECT cod_venta, fecha_venta, precio_total, cod_cliente
FROM VentaPruebaHistorica
WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-03-31';
GO


-- Parte 4: Cracion de índice agrupado
CREATE CLUSTERED INDEX IX_VentaPrueba_Fecha 
ON VentaPruebaHistorica(fecha_venta);
GO

-- PRUEBA 2: Consulta con Índice Agrupado (Clustered)
SELECT cod_venta, fecha_venta, precio_total, cod_cliente
FROM VentaPruebaHistorica
WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-03-31';
GO


-- Parte 5: Eliminamos el índice agrupado previo para probar la siguiente variante
DROP INDEX IX_VentaPrueba_Fecha ON VentaPruebaHistorica;
GO

-- Parte 6: Crear un índice que cubra la consulta
CREATE NONCLUSTERED INDEX IX_VentaPrueba_Fecha_Cobertura
ON VentaPruebaHistorica(fecha_venta)
INCLUDE (cod_venta, precio_total, cod_cliente);
GO

-- PRUEBA 3: Consulta con Índice NO Agrupado + Cobertura
SELECT cod_venta, fecha_venta, precio_total, cod_cliente
FROM VentaPruebaHistorica
WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-03-31';
GO