# Implementacion  del sql

Armamos una base de datos para un sistema de comercio, compras y ventas con \*\*13 tablas\*\*, organizadas en tres niveles jerárquicos para mantener los datos ordenados y evitar redundancias:

Nivel 1 (Catálogos y Tablas Base): Creamos primero las tablas independientes que no necesitan de otras para existir: `Cliente`, `Proveedor`, `Categoria`, `Oferta`, `Aplicable` 
(descuentos y recargas), `Metodo_pago` y `Pago_venta`. A cada una le pusimos una clave primaria autoincremental (`INT IDENTITY(1,1)`) para que los identificadores se generen solos al insertar datos.

Nivel 2 (Tablas Intermedias): Creamos las tablas que gestionan las operaciones principales: `Producto`, `Compra`, `Venta` y `Notificacion`. 

Nivel 3 (Detalles de Operación): Creamos `Detalle_de_compra` y `Detalle_de_venta` para registrar ítem por ítem los productos incluidos en cada transacción.
