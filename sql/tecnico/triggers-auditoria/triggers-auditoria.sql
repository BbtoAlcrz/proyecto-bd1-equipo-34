USE Proyecto_BD1;
GO

/*trigger de auditoria sobre la tabla Producto: registra los cambios de precio_venta*/
/*tabla espejo donde se guarda el historial de cambios de precio*/

IF OBJECT_ID('dbo.auditoria_producto') IS NULL
BEGIN
CREATE TABLE dbo.auditoria_producto
(
  cod_auditoria   INT IDENTITY(1,1) NOT NULL,
  cod_producto    INT NOT NULL,
  precio_anterior DECIMAL(10,2) NOT NULL,
  precio_nuevo    DECIMAL(10,2) NOT NULL,
  usuario         VARCHAR(128) NOT NULL DEFAULT SUSER_SNAME(),
  fecha_hora      DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_auditoria_producto PRIMARY KEY (cod_auditoria)
);
END;
GO

/*trigger que se ejecuta despues de cada UPDATE sobre Producto
  deleted tiene los valores anteriores e inserted los nuevos
  solo se registra si el precio cambio, por eso un cambio de stock no se audita*/
CREATE OR ALTER TRIGGER dbo.trg_Producto_Update
ON dbo.Producto
AFTER UPDATE
AS
BEGIN
  INSERT INTO dbo.auditoria_producto (cod_producto, precio_anterior, precio_nuevo)
  SELECT i.cod_producto, d.precio_venta, i.precio_venta
  FROM inserted i
  JOIN deleted d ON d.cod_producto = i.cod_producto
  WHERE d.precio_venta <> i.precio_venta;
END;
GO

/*demostracion con el producto 18 (Creatina), 3 capturas*/

/*captura 1: estado inicial, producto y auditoria vacia*/
SELECT cod_producto, nombre_producto, precio_venta, stock FROM Producto WHERE cod_producto = 18;
SELECT cod_auditoria, cod_producto, precio_anterior, precio_nuevo, usuario, fecha_hora FROM auditoria_producto;

/*captura 2: se cambia el precio y la auditoria registra el cambio*/
UPDATE Producto SET precio_venta = 3500.00 WHERE cod_producto = 18;

SELECT cod_producto, nombre_producto, precio_venta, stock FROM Producto WHERE cod_producto = 18;
SELECT cod_auditoria, cod_producto, precio_anterior, precio_nuevo, usuario, fecha_hora FROM auditoria_producto;

/*captura 3: se cambia solo el stock y la auditoria no registra nada nuevo*/
UPDATE Producto SET stock = stock - 1 WHERE cod_producto = 18;

SELECT cod_producto, nombre_producto, precio_venta, stock FROM Producto WHERE cod_producto = 18;
SELECT cod_auditoria, cod_producto, precio_anterior, precio_nuevo, usuario, fecha_hora FROM auditoria_producto;

/*al terminar se deja el producto como estaba (esto agrega una fila mas a la auditoria, no hace falta captura)*/
UPDATE Producto SET precio_venta = 3100.00, stock = stock + 1 WHERE cod_producto = 18;