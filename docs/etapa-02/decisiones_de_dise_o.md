# Decisiones de Diseño

## 1. Módulo de Gestión de Clientes

*   **Cliente:** Se definió a *Cliente* como una entidad que almacena la información personal de quienes realizan una compra. Se definieron condiciones de unicidad sobre el DNI y el correo electrónico para evitar duplicados. Asimismo, se asocia la clave foránea `Nro_notificacion`, la cual vincula al cliente con sus alertas registradas.
*   **Notificación y Oferta:** Se definieron para poder ejecutar una estrategia de comunicación comercial con el cliente. La entidad *Notificación* se relaciona con *Oferta* mediante la clave foránea `cod_oferta`, lo que permite el envío de notificaciones y alertas a los clientes.

---

## 2. Módulo de Ventas

*   **Detalle de Venta:** Se creó esta entidad para modelar la relación de varios ítems por venta. Almacena el `precio_unitario` al momento de la transacción y se conecta con *Producto* mediante la clave foránea `cod_producto` y con la cabecera *Venta*.
*   **Gestión de Pagos:** Las transacciones se registran en la entidad `Pago_venta`, la cual también registra el método de pago utilizado a través de la clave foránea `cod_metodo`.
*   **Descuentos y Recargos:** La entidad *Aplicable* registra los descuentos o recargos posibles de la venta según el método de pago utilizado; por esta razón, `Metodo_pago` contiene la clave foránea `cod_descuento`.

---

## 3. Módulo de Productos y Categorías

*   **Clasificación de Inventario:** Se normalizó la información mediante la creación de la entidad *Categoría*. De este modo, un producto puede pertenecer a una categoría específica utilizando la clave foránea `cod_categoria`, lo que facilita el agrupamiento y la búsqueda de productos.
*   **Control de Stock y Precios:** En la entidad *Producto* se registran tanto el `precio_compra` como el `precio_venta`, junto con el stock actual. Esto permite calcular márgenes de ganancia y controlar la disponibilidad en el inventario.

---

## 4. Módulo de Compras y Proveedores

*   **Relación con Proveedores:** Se diseñó la entidad *Proveedor* con un atributo único DNI para registrar datos de contacto y rubro. Las órdenes de compra almacenadas en `Compra` referencian directamente al proveedor mediante la clave foránea `cod_proveedor`.
*   **Detalle de Compra:** Funciona como el desglose de la compra, registrando el precio unitario y el precio de envío. Se relaciona con la compra principal y con los productos reabastecidos.