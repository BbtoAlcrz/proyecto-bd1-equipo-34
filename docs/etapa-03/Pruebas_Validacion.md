# Pruebas de validaciones

### 1. Introducción

Esta sección detalla la simulación y carga de datos de prueba para el módulo de reabastecimiento e inventario, también para transacciones de ventas, gestión de clientes, canales de cobro y promociones/notificaciones. Se presentan **casos de prueba funcionales y de validación** que explican qué está ocurriendo detrás de cada operación en el sistema, incluyendo controles de calidad de datos frente a errores en caja o carga de datos.

---

### 2. Definición del Escenario de Prueba

#### Contexto

La tienda deportiva necesita reponer inventario de distintos rubros (fútbol, running, musculación, combate, etc.). Para lograrlo:

1. Se configuran las **Categorías** del catálogo.
2. Se registran los **Proveedores** autorizados.
3. Se efectúan **Compras** mayoristas.
4. Se registran los ítems en el **Detalle de Compra**.
5. Se actualiza el inventario final de **Productos**.

Una vez que la tienda dispone de stock ingresado por compras mayoristas, se habilitan las operaciones comerciales con clientes finales:

1. Configuración de **Métodos de Pago** aceptados.
2. Registro de **Clientes**.
3. Creación de campañas de **Oferta** y envío de **Notificaciones**.
4. Registro de transacciones de **Venta**.
5. Desglose de ítems vendidos en **Detalle de Venta**.
---

### 3. Casos de Prueba Éxito

#### Caso de Prueba 1: Alta de Categorías para Clasificación de Catálogo

* **Objetivo:** Permitir agrupar los artículos en rubros específicos para facilitar la búsqueda al cliente y la organización del inventario.
* **¿Qué sucede en el sistema?**
  Se insertan 8 categorías distintas en la tabla `Categoria`. El sistema genera automáticamente una clave primaria (`cod_categoria`) secuencial del 1 al 8.
* **Explicación:**
  El gerente del local ingresa al panel y define los departamentos del negocio: *Deportes de Equipo*, *Calzado Running*, *Indumentaria*, *Musculación y Fitness*, *Deportes de Raqueta*, *Accesorios*, *Deportes de Combate* y *Outdoor y Camping*.

#### Caso de Prueba 2: Registro de Proveedores Oficiales

* **Objetivo:** Tener el padrón de distribuidores con sus CUITs únicos para realizar los pedidos de mercadería.
* **¿Qué sucede en el sistema?**
  Se dan de alta 8 empresas proveedoras en la tabla `Proveedor`. La base de datos valida automáticamente que no existan dos CUITs duplicados mediante la restricción `UQ_Proveedor_Cuit`.
* **Explicación:**
  Se cargan los datos de contacto y fiscales de las empresas mayoristas (por ejemplo, *Distribuidora Gol S.A.* para pelotas o *Runners Trade S.R.L.* para calzado deportivo).

#### Caso de Prueba 3: Proceso de Compra Mayorista

* **Objetivo:** Registrar los encabezados de las facturas/pedidos recibidos por parte de los proveedores.
* **¿Qué sucede en el sistema?**
  Se insertan registros en la tabla `Compra`, vinculando cada compra con su respectivo `cod_proveedor` (Clave Foránea) y especificando fecha, costo total y costo de envío.
* **Explicación:**
  La tienda realiza un pedido a *Textil Sport Pro* por un total de $260.025 con un costo de envío de $2.800 el día 5 de febrero de 2026. El sistema crea el registro general de la compra número 3.

#### Caso de Prueba 4: Detalle de Ítems Comprados y Precios Unitarios

* **Objetivo:** Desglosar qué productos específicos se compraron en cada lote y a qué precio de costo unitario.
* **¿Qué sucede en el sistema?**
  Se cargan registros en `Detalle_de_compra`, asociando un `cod_compra` con un `cod_producto`. La tabla valida mediante un `CHECK` que las cantidades ingresadas sean estrictamente mayores a 0 (`cantidad > 0`).
* **Explicación:**
  En la compra realizada a la distribuidora de musculación, se especifica que se adquirieron **120 unidades** de *Mancuernas de 5kg* a un precio unitario mayorista de **$3.450**.

#### Caso de Prueba 5: Publicación de Productos e Inventario Disponible

* **Objetivo:** Tener disponible el stock y los precios de venta al público para la atención a clientes.
* **¿Qué sucede en el sistema?**
  Se puebla la tabla `Producto`, asociando cada ítem a su `cod_categoria`. El sistema valida mediante `CK_Producto_Stock` que el stock sea mayor o igual a 0.
* **Explicación:**
  Se registran los productos del catálogo junto con sus precios y cantidades iniciales disponibles. La restricción `CK_Producto_Stock` garantiza que el stock almacenado no sea negativo.

#### Caso de Prueba 6: Configuración de Métodos de Pago

* **Objetivo:** Definir las formas de cobro habilitadas en el comercio.
* **¿Qué sucede en el sistema?**
  Se insertan 8 registros en `Metodo_pago`. La columna `cod_metodo` es un entero con propiedad `IDENTITY(1,1)` que se autogenera.
* **Explicación:**
  El comercio habilita diferentes opciones financieras como *Efectivo*, *Tarjeta de Débito*, *Tarjeta de Crédito*, *Transferencia bancaria*, *Mercado Pago*, *Modo*, etc.

#### Caso de Prueba 7: Alta de Clientes

* **Objetivo:** Registrar compradores únicos manteniendo el control de contacto y validación de DNI/Correo.
* **¿Qué sucede en el sistema?**
  Se registran 8 clientes en la tabla `Cliente`. La base de datos valida automáticamente las restricciones `UQ_Cliente_Dni` y `UQ_Cliente_Correo` para evitar duplicados.
* **Explicación:**
  Se cargan los datos personales de 8 compradores regulares con sus teléfonos, DNI y correos electrónicos para facturación.

#### Caso de Prueba 8: Lanzamiento de Ofertas y Promociones

* **Objetivo:** Registrar campañas de descuento temporales.
* **¿Qué sucede en el sistema?**
  Se insertan 8 registros en `Oferta`. La restricción `CK_FECHA_OFERTA` verifica que la `fecha_lanzamiento` sea menor o igual a la `fecha_finalizacion`.
* **Explicación:**
  Se publican promociones de temporada (ejemplo: *"20% Off en Zapatillas Running"* o *"Super Oferta Pelotas de Futbol"*), definiendo la vigencia de cada una.

#### Caso de Prueba 9: Envío y Seguimiento de Notificaciones

* **Objetivo:** Comunicar las promociones a los clientes y rastrear la lectura del mensaje.
* **¿Qué sucede en el sistema?**
  Se insertan registros en la tabla `Notificacion`, cuya clave primaria es compuesta por `(cod_cliente, cod_oferta)`. La restricción `CK_Notificacion_Estado` valida que el estado sea solo `'ENVIADA'` o `'LEIDA'`.
* **Explicación:**
  El sistema de marketing envía avisos sobre ofertas específicas a los clientes registrados y monitorea si el cliente abrió o leyó la notificación.

#### Caso de Prueba 10: Registro de Ventas a Clientes

* **Objetivo:** Registrar la cabecera del comprobante comercial emitido al cliente.
* **¿Qué sucede en el sistema?**
  Se crean 8 transacciones en `Venta`, asociando cada venta con un `cod_cliente` y un `cod_metodo`. `cod_venta` se autogenera con `IDENTITY(1,1)`.
* **Explicación:**
  Se registra cada operación de cobro realizada en la tienda especificando la fecha, el subtotal, descuentos/cargos aplicables, monto total cobrado y el medio de pago utilizado.

#### Caso de Prueba 11: Detalle de Productos Vendidos

* **Objetivo:** Especificar las unidades y precios de cada artículo entregado en una venta concreta.
* **¿Qué sucede en el sistema?**
  Se cargan registros en `Detalle_de_venta` con clave primaria compuesta `(cod_producto, cod_venta)`. Se valida `CK_Detalle_de_venta_Cantidad` para asegurar que las cantidades vendidas sean estrictamente mayores a 0.
* **Explicación:**
  Por cada factura emitida, el sistema descuenta los productos específicos entregados (por ejemplo, en la Venta 1 se vendió 1 *Pelota Futbol N5* a $21.990).

---

### 4. Casos de Prueba con Error  (Validación de Reglas de Negocio)

#### Caso de Error 1: Intento de Carga de Producto con Stock Negativo

* **Objetivo:** Verificar que el sistema impida ingresar un valor de inventario inválido (ej. stock < 0).
* **¿Qué sucede en el sistema?**
  Se intenta ejecutar la consulta:
  ```sql
  INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
  VALUES ('Camiseta Premium', 10000.00, -5, 18000.00, 3);
  ```
* **Resultado Esperado:**
  El motor de base de datos rechaza la instrucción arrojando un error de violación de restricción `CK_Producto_Stock`. El sistema no permite cargar productos con stock en negativo.

#### Caso de Error 2: Intento de Carga de Proveedor con CUIT Duplicado

* **Objetivo:** Garantizar la unicidad fiscal de los proveedores ingresados.
* **¿Qué sucede en el sistema?**
  Se intenta registrar un proveedor con un CUIT que ya pertenece a *Distribuidora Gol S.A.* (`30712345678`).
  ```sql
  INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit)
  VALUES ('Nuevo Proveedor Gol', 'Pelotas', 'Calle Falsa 123', '1100000000', '30712345678');
  ```
* **Resultado Esperado:**
  La base de datos cancela la operación indicando violación de la restricción de clave única `UQ_Proveedor_Cuit`.

#### Caso de Error 3: Venta con Cantidad de Productos Igual a Cero o Negativa

* **Objetivo:** Evitar que un cajero o la web registre el detalle de una venta con cantidad 0 o valores negativos.
* **¿Qué sucede en el sistema?**
  Se intenta cargar la siguiente línea de facturación:
  ```sql
  INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
  VALUES (1, 1, 21990.00, 0);
  ```
* **Resultado Esperado:**
  El sistema rechaza la inserción debido a la restricción `CK_Detalle_de_venta_Cantidad` (que exige `cantidad > 0`). Evita la emisión de tickets inconsistentes o cobros vacíos.

#### Caso de Error 4: Intento de Oferta con Período Inválido (Fecha Final Anteriores al Inicio)

* **Objetivo:** Garantizar la coherencia temporal de las promociones.
* **¿Qué sucede en el sistema?**
  El departamento de marketing intenta crear una oferta donde la fecha de finalización es anterior a la fecha de inicio:
  ```sql
  INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
  VALUES ('Descuento Erróneo', '2026-05-10', '2026-05-01');
  ```
* **Resultado Esperado:**
  El motor SQL bloquea la carga lanzando una excepción por incumplimiento del check `CK_FECHA_OFERTA`.

#### Caso de Error 5: Asignación de Estado de Notificación Inválido

* **Objetivo:** Restringir los estados válidos de interacción con las notificaciones a clientes.
* **¿Qué sucede en el sistema?**
  Se envía un valor distinto a `'ENVIADA'` o `'LEIDA'`:
  ```sql
  INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
  VALUES (1, 1, 'PENDIENTE');
  ```
* **Resultado Esperado:**
  Falla por la regla `CK_Notificacion_Estado`, asegurando que no entren estados no mapeados por el módulo de promociones.

#### Caso de Error 6: Venta de un Producto Inexistente (Falta de Integridad Referencial)

* **Objetivo:** Impedir cobros de ítems que no están en el catálogo.
* **¿Qué sucede en el sistema?**
  Se intenta facturar un código de producto no registrado (ej. `cod_producto = 999`):
  ```sql
  INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
  VALUES (999, 1, 5000.00, 1);
  ```
* **Resultado Esperado:**
  El motor de la base de datos rechaza la inserción por incumplimiento de la clave foránea hacia la tabla `Producto`.
