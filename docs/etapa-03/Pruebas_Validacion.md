# Documento

**Sistema de Gestión para Tienda de Artículos Deportivos**

---

# PARTE DE LAUTARO

## Compras, Proveedores, Categorías y Productos

### 1. Introducción

Esta sección detalla la simulación y carga de datos de prueba (*Seed Data*) para el módulo de reabastecimiento e inventario. Se presentan **casos de prueba funcionales y de validación** que explican en lenguaje claro y sencillo qué está ocurriendo detrás de cada operación en el sistema (compras a proveedores, categorización de productos, control de stock y manejo de errores por restricciones).

---

### 2. Definición del Escenario de Prueba

#### Contexto del Negocio

La tienda deportiva necesita reponer inventario de distintos rubros (fútbol, running, musculación, combate, etc.). Para lograrlo:

1. Se configuran las **Categorías** del catálogo.
2. Se registran los **Proveedores** autorizados.
3. Se efectúan **Compras** mayoristas.
4. Se registran los ítems en el **Detalle de Compra**.
5. Se actualiza el inventario final de **Productos**.

---

### 3. Casos de Prueba Éxito (Explicación paso a paso)

#### Caso de Prueba 1: Alta de Categorías para Clasificación de Catálogo

* **Objetivo:** Permitir agrupar los artículos en rubros específicos para facilitar la búsqueda al cliente y la organización del inventario.
* **¿Qué sucede en el sistema?**
  Se insertan 8 categorías distintas en la tabla `Categoria`. El sistema genera automáticamente una clave primaria (`cod_categoria`) secuencial del 1 al 8.
* **Explicación en palabras:**
  El gerente del local ingresa al panel y define los departamentos del negocio: *Deportes de Equipo*, *Calzado Running*, *Indumentaria*, *Musculación y Fitness*, *Deportes de Raqueta*, *Accesorios*, *Deportes de Combate* y *Outdoor y Camping*.

#### Caso de Prueba 2: Registro de Proveedores Oficiales

* **Objetivo:** Tener el padrón de distribuidores con sus CUITs únicos para realizar los pedidos de mercadería.
* **¿Qué sucede en el sistema?**
  Se dan de alta 8 empresas proveedoras en la tabla `Proveedor`. La base de datos valida automáticamente que no existan dos CUITs duplicados mediante la restricción `UQ_Proveedor_Cuit`.
* **Explicación en palabras:**
  Se cargan los datos de contacto y fiscales de las empresas mayoristas (por ejemplo, *Distribuidora Gol S.A.* para pelotas o *Runners Trade S.R.L.* para calzado deportivo).

#### Caso de Prueba 3: Proceso de Compra Mayorista (Reabastecimiento)

* **Objetivo:** Registrar los encabezados de las facturas/pedidos recibidos por parte de los proveedores.
* **¿Qué sucede en el sistema?**
  Se insertan registros en la tabla `Compra`, vinculando cada compra con su respectivo `cod_proveedor` (Clave Foránea) y especificando fecha, costo total y costo de envío.
* **Explicación en palabras:**
  La tienda realiza un pedido a *Textil Sport Pro* por un total de $260.025 con un costo de envío de $2.800 el día 5 de febrero de 2026. El sistema crea el registro general de la compra número 3.

#### Caso de Prueba 4: Detalle de Ítems Comprados y Precios Unitarios

* **Objetivo:** Desglosar qué productos específicos se compraron en cada lote y a qué precio de costo unitario.
* **¿Qué sucede en el sistema?**
  Se cargan registros en `Detalle_de_compra`, asociando un `cod_compra` con un `cod_producto`. La tabla valida mediante un `CHECK` que las cantidades ingresadas sean estrictamente mayores a 0 (`cantidad > 0`).
* **Explicación en palabras:**
  En la compra realizada a la distribuidora de musculación, se especifica que se adquirieron **120 unidades** de *Mancuernas de 5kg* a un precio unitario mayorista de **$3.450**.

#### Caso de Prueba 5: Publicación de Productos e Inventario Disponible

* **Objetivo:** Tener disponible el stock y los precios de venta al público para la atención a clientes.
* **¿Qué sucede en el sistema?**
  Se puebla la tabla `Producto`, asociando cada ítem a su `cod_categoria`. El sistema valida mediante `CK_Producto_Stock` que el stock sea mayor o igual a 0.
* **Explicación en palabras:**
  Queda registrada la *Pelota Fútbol N5* a un precio de costo de $12.500 y un precio de venta al público de $21.990, con un stock inicial disponible de 30 unidades en el depósito.

---

### 4. Casos de Prueba con Error / Validación de Reglas de Negocio (Parte de Lautaro)

#### Caso de Error L-1: Intento de Carga de Producto con Stock Negativo

* **Objetivo:** Verificar que el sistema impida ingresar un valor de inventario inválido (ej. stock < 0).
* **¿Qué sucede en el sistema?**
  Se intenta ejecutar la consulta:
  ```sql
  INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
  VALUES ('Camiseta Premium', 10000.00, -5, 18000.00, 3);
  ```
* **Resultado Esperado / Explicación:**
  El motor de base de datos rechaza la instrucción arrojando un error de violación de restricción `CK_Producto_Stock`. El sistema no permite cargar productos con stock en negativo.

#### Caso de Error L-2: Intento de Carga de Proveedor con CUIT Duplicado

* **Objetivo:** Garantizar la unicidad fiscal de los proveedores ingresados.
* **¿Qué sucede en el sistema?**
  Se intenta registrar un proveedor con un CUIT que ya pertenece a *Distribuidora Gol S.A.* (`30712345678`).
  ```sql
  INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit)
  VALUES ('Nuevo Proveedor Gol', 'Pelotas', 'Calle Falsa 123', '1100000000', '30712345678');
  ```
* **Resultado Esperado / Explicación:**
  La base de datos cancela la operación indicando violación de la restricción de clave única `UQ_Proveedor_Cuit`.

---

### 5. Script SQL Consolidado de Datos de Prueba (Parte de Lautaro)

```sql
-- 1. CARGA DE CATEGORIAS
INSERT INTO Categoria (descripcion, nombre_categoria) VALUES 
('Articulos y pelotas para deportes de equipo', 'Deportes de Equipo'),
('Calzado especializado para correr y atletismo', 'Calzado Running'),
('Ropa deportiva de alto rendimiento y entrenamiento', 'Indumentaria'),
('Equipamiento para entrenamiento de fuerza y gym', 'Musculacion y Fitness'),
('Paletas, raquetas y accesorios para raqueta', 'Deportes de Raqueta'),
('Accesorios de hidratacion y complementos', 'Accesorios'),
('Protecciones y equipamiento para artes marciales', 'Deportes Combate'),
('Articulos para montanismo, camping y senderismo', 'Outdoor y Camping');

-- 2. CARGA DE PROVEEDORES
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) VALUES 
('Distribuidora Gol S.A.', 'Pelotas e Inflables', 'Av. Deporte 1234', '1145550101', '30712345678'),
('Runners Trade S.R.L.', 'Calzado Deportivo', 'Calle Atletismo 567', '1145550102', '30712345679'),
('Textil Sport Pro', 'Indumentaria Textil', 'Av. San Martin 2040', '1145550103', '30712345680'),
('Gimnasio & Fuerza Corp', 'Equipamiento de Gym', 'Ruta 8 Km 45', '1145550104', '30712345681'),
('Padel & Tennis Import', 'Articulos de Raqueta', 'Calle Belgrano 890', '1145550105', '30712345682'),
('HydraSport Accesorios', 'Bazar y Hidratacion', 'Av. Cordoba 4321', '1145550106', '30712345683'),
('Knockout Combat Supplies', 'Deportes de Combate', 'Calle Moreno 1122', '1145550107', '30712345684'),
('Wellness Outdoor Group', 'Fitness y Camping', 'Av. Rivadavia 7654', '1145550108', '30712345685');

-- 3. CARGA DE PRODUCTOS
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria) VALUES 
('Pelota Futbol N5', 12500.00, 30, 21990.00, 1),
('Zapatillas Running', 45000.00, 15, 78990.00, 2),
('Remera Termica', 8500.00, 50, 14990.00, 3),
('Mancuerna 5kg', 6200.00, 20, 10500.00, 4),
('Pala Padel Pro', 85000.00, 8, 139990.00, 5),
('Botella Termica 1L', 4100.00, 40, 7800.00, 6),
('Guantes Boxeo 12oz', 18500.00, 12, 31200.00, 7),
('Mat de Yoga 6mm', 5300.00, 25, 9600.00, 4);

-- 4. CARGA DE COMPRAS
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor) VALUES 
('2026-01-15', 255000.00, 3500.00, 1),
('2026-01-20', 147000.00, 4200.00, 2),
('2026-02-05', 260025.00, 2800.00, 3),
('2026-02-18', 414000.00, 5000.00, 4),
('2026-03-02', 99900.00, 3000.00, 5),
('2026-03-12', 172000.00, 2500.00, 6),
('2026-03-22', 182500.00, 4000.00, 7),
('2026-04-01', 288000.00, 3200.00, 8);

-- 5. CARGA DE DETALLE DE COMPRA
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) VALUES 
(1, 1, 8500.00, 30),
(1, 3, 5200.50, 50),
(2, 2, 9800.00, 15),
(2, 4, 3450.00, 120),
(3, 5, 9990.00, 10),
(3, 6, 2150.00, 80),
(4, 7, 7300.00, 25),
(4, 8, 4800.00, 60);
```

---

# PARTE DE MAXIMILIANO

## Ventas, Clientes, Métodos de Pago y Ofertas/Notificaciones

### 1. Introducción

Esta sección cubre la simulación y carga de datos para el módulo transaccional de ventas, gestión de clientes, canales de cobro y promociones/notificaciones, incluyendo controles de calidad de datos frente a errores en caja o carga de datos.

---

### 2. Definición del Escenario de Prueba

#### Contexto del Negocio

Una vez que la tienda dispone de stock ingresado por compras mayoristas, se habilitan las operaciones comerciales con clientes finales:

1. Configuración de **Métodos de Pago** aceptados en caja/web.
2. Registro del padrón de **Clientes**.
3. Creación de campañas de **Oferta** y envío de **Notificaciones**.
4. Registro de transacciones de **Venta** (encabezados).
5. Desglose de ítems vendidos en **Detalle de Venta**.

---

### 3. Casos de Prueba Éxito (Explicación paso a paso)

#### Caso de Prueba 1: Configuración de Métodos de Pago

* **Objetivo:** Definir las formas de cobro habilitadas en el comercio.
* **¿Qué sucede en el sistema?**
  Se insertan 8 registros en `Metodo_pago`. La columna `cod_metodo` es un entero con propiedad `IDENTITY(1,1)` que se autogenera.
* **Explicación en palabras:**
  El comercio habilita diferentes opciones financieras como *Efectivo*, *Tarjeta de Débito*, *Tarjeta de Crédito*, *Transferencia bancaria*, *Mercado Pago*, *Modo*, *Cuenta DNI* y *Ajuste por Permuta*.

#### Caso de Prueba 2: Alta de Clientes Frecuentes

* **Objetivo:** Registrar compradores únicos manteniendo el control de contacto y validación de DNI/Correo.
* **¿Qué sucede en el sistema?**
  Se registran 8 clientes en la tabla `Cliente`. La base de datos valida automáticamente las restricciones `UQ_Cliente_Dni` y `UQ_Cliente_Correo` para evitar duplicados.
* **Explicación en palabras:**
  Se cargan los datos personales de 8 compradores regulares con sus teléfonos, DNI y correos electrónicos para facturación.

#### Caso de Prueba 3: Lanzamiento de Ofertas y Promociones

* **Objetivo:** Registrar campañas de descuento temporales.
* **¿Qué sucede en el sistema?**
  Se insertan 8 registros en `Oferta`. La restricción `CK_FECHA_OFERTA` verifica que la `fecha_lanzamiento` sea menor o igual a la `fecha_finalizacion`.
* **Explicación en palabras:**
  Se publican promociones de temporada (ejemplo: *"20% Off en Zapatillas Running"* o *"Super Oferta Pelotas de Futbol"*), definiendo el período de vigencia de cada una.

#### Caso de Prueba 4: Envío y Seguimiento de Notificaciones

* **Objetivo:** Comunicar las promociones a los clientes y rastrear la lectura del mensaje.
* **¿Qué sucede en el sistema?**
  Se insertan registros en la tabla `Notificacion`, cuya clave primaria es compuesta por `(cod_cliente, cod_oferta)`. La restricción `CK_Notificacion_Estado` valida que el estado sea solo `'ENVIADA'` o `'LEIDA'`.
* **Explicación en palabras:**
  El sistema de marketing envía avisos sobre ofertas específicas a los clientes registrados y monitorea si el cliente abrió o leyó la notificación.

#### Caso de Prueba 5: Registro de Ventas a Clientes

* **Objetivo:** Registrar la cabecera del comprobante comercial emitido al cliente.
* **¿Qué sucede en el sistema?**
  Se crean 8 transacciones en `Venta`, asociando cada venta con un `cod_cliente` y un `cod_metodo`. `cod_venta` se autogenera con `IDENTITY(1,1)`.
* **Explicación en palabras:**
  Se registra cada operación de cobro realizada en la tienda especificando la fecha, el subtotal, descuentos/cargos aplicables, monto total cobrado y el medio de pago utilizado.

#### Caso de Prueba 6: Detalle de Productos Vendidos

* **Objetivo:** Especificar las unidades y precios de cada artículo entregado en una venta concreta.
* **¿Qué sucede en el sistema?**
  Se cargan registros en `Detalle_de_venta` con clave primaria compuesta `(cod_producto, cod_venta)`. Se valida `CK_Detalle_de_venta_Cantidad` para asegurar que las cantidades vendidas sean estrictamente mayores a 0.
* **Explicación en palabras:**
  Por cada ticket o factura emitida, el sistema descuenta los productos específicos entregados (por ejemplo, en la Venta 1 se vendió 1 *Pelota Futbol N5* a $21.990).

---

### 4. Casos de Prueba con Error / Validación de Reglas de Negocio (Parte de Maximiliano)

#### Caso de Error M-1: Venta con Cantidad de Productos Igual a Cero o Negativa

* **Objetivo:** Evitar que un cajero o la web registre el detalle de una venta con cantidad 0 o valores negativos.
* **¿Qué sucede en el sistema?**
  Se intenta cargar la siguiente línea de facturación:
  ```sql
  INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
  VALUES (1, 1, 21990.00, 0);
  ```
* **Resultado Esperado / Explicación:**
  El sistema rechaza la inserción debido a la restricción `CK_Detalle_de_venta_Cantidad` (que exige `cantidad > 0`). Evita la emisión de tickets inconsistentes o cobros vacíos.

#### Caso de Error M-2: Intento de Oferta con Período Inválido (Fecha Final Anteriores al Inicio)

* **Objetivo:** Garantizar la coherencia temporal de las promociones.
* **¿Qué sucede en el sistema?**
  El departamento de marketing intenta crear una oferta donde la fecha de finalización es anterior a la fecha de inicio:
  ```sql
  INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
  VALUES ('Descuento Erróneo', '2026-05-10', '2026-05-01');
  ```
* **Resultado Esperado / Explicación:**
  El motor SQL bloquea la carga lanzando una excepción por incumplimiento del check `CK_FECHA_OFERTA`.

#### Caso de Error M-3: Asignación de Estado de Notificación Inválido

* **Objetivo:** Restringir los estados válidos de interacción con las notificaciones a clientes.
* **¿Qué sucede en el sistema?**
  Se envía un valor distinto a `'ENVIADA'` o `'LEIDA'`:
  ```sql
  INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
  VALUES (1, 1, 'PENDIENTE');
  ```
* **Resultado Esperado / Explicación:**
  Falla por la regla `CK_Notificacion_Estado`, asegurando que no entren estados no mapeados por el módulo de promociones.

#### Caso de Error M-4: Venta de un Producto Inexistente (Falta de Integridad Referencial)

* **Objetivo:** Impedir cobros de ítems que no están en el catálogo.
* **¿Qué sucede en el sistema?**
  Se intenta facturar un código de producto no registrado (ej. `cod_producto = 999`):
  ```sql
  INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
  VALUES (999, 1, 5000.00, 1);
  ```
* **Resultado Esperado / Explicación:**
  El motor de la base de datos aborta la transacción notificando la violación de clave foránea (`FOREIGN KEY`) hacia la tabla `Producto`.

---

### 5. Script SQL Consolidado de Datos de Prueba (Parte de Maximiliano)

```sql
-- 1. CARGA DE METODOS DE PAGO
INSERT INTO Metodo_pago (tipo_metodo) VALUES 
('Efectivo'),
('Tarjeta de Debito'),
('Tarjeta de Credito (1 cuota)'),
('Tarjeta de Credito (3 cuotas)'),
('Transferencia Bancaria'),
('Mercado Pago QR'),
('Cuenta DNI'),
('MODO');

-- 2. CARGA DE CLIENTES
INSERT INTO Cliente (nombre_cliente, apellido_cliente, dni, telefono, correo_electronico) VALUES 
('Juan', 'Perez', 38123456, '1122334455', 'juan.perez@email.com'),
('Maria', 'Gomez', 40987654, '1133445566', 'maria.gomez@email.com'),
('Lucas', 'Rodriguez', 35678901, '1144556677', 'lucas.rodriguez@email.com'),
('Sofia', 'Fernandez', 42112233, '1155667788', 'sofia.fernandez@email.com'),
('Carlos', 'Lopez', 33445566, '1166778899', 'carlos.lopez@email.com'),
('Ana', 'Martinez', 39887766, '1177889900', 'ana.martinez@email.com'),
('Diego', 'Santi', 37443322, '1188990011', 'diego.santi@email.com'),
('Laura', 'Benitez', 41554433, '1199001122', 'laura.benitez@email.com');

-- 3. CARGA DE OFERTAS
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) VALUES 
('20% Off en Zapatillas Running', '2026-03-01', '2026-03-15'),
('Combo Futbol: Pelota N5 + Inflador', '2026-03-05', '2026-03-20'),
('15% Descuento en Guantes de Boxeo', '2026-03-10', '2026-03-25'),
('3x2 en Remeras Termicas', '2026-03-15', '2026-03-30'),
('Pala de Padel con Funda de Regalo', '2026-04-01', '2026-04-15'),
('10% Off Pagando con Transferencia', '2026-04-05', '2026-04-30'),
('Semana del Yoga: Mat + Botella Termica', '2026-04-10', '2026-04-20'),
('Liquidacion de Calzado Deportivo', '2026-04-15', '2026-04-30');

-- 4. CARGA DE NOTIFICACIONES
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) VALUES 
(1, 2, 'LEIDA'),
(2, 1, 'LEIDA'),
(3, 4, 'ENVIADA'),
(4, 5, 'LEIDA'),
(5, 3, 'ENVIADA'),
(6, 7, 'LEIDA'),
(7, 6, 'LEIDA'),
(8, 8, 'ENVIADA');

-- 5. CARGA DE VENTAS
INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) VALUES 
('2026-03-02', 21990.00, 21990.00, 0.00, 1, 1),
('2026-03-06', 63192.00, 78990.00, 15798.00, 2, 6),
('2026-03-11', 26520.00, 31200.00, 4680.00, 5, 2),
('2026-03-16', 29980.00, 44970.00, 14990.00, 3, 5),
('2026-04-02', 139990.00, 139990.00, 0.00, 4, 3),
('2026-04-06', 7020.00, 7800.00, 780.00, 7, 5),
('2026-04-11', 17400.00, 17400.00, 0.00, 6, 7),
('2026-04-16', 63192.00, 78990.00, 15798.00, 8, 4);

-- 6. CARGA DE DETALLE DE VENTA
INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) VALUES 
(1, 1, 21990.00, 1), -- Pelota Futbol
(2, 2, 78990.00, 1), -- Zapatillas Running
(7, 3, 31200.00, 1), -- Guantes Boxeo
(3, 4, 14990.00, 3), -- Remeras Termicas (Promo 3x2)
(5, 5, 139990.00, 1),-- Pala Padel Pro
(6, 6, 7800.00, 1),  -- Botella Termica
(8, 7, 9600.00, 1),  -- Mat Yoga
(4, 7, 10500.00, 1); -- Mancuerna 5kg
```