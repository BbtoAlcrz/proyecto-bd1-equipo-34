# Decisiones de Diseño

## 1. Módulo de Gestión de Clientes y Notificaciones

*   **Cliente:** Se definió a *Cliente* como una entidad que almacena la información personal de quienes realizan una compra. Se definieron condiciones de unicidad sobre el DNI y el correo electrónico para evitar duplicados.
*   **Notificación y Oferta:** Se decidió representar a `Notificacion` como una entidad intermedia entre `Cliente` y `Oferta`, estableciendo una relación de muchos a muchos. De esta manera, un cliente puede recibir múltiples ofertas y una misma oferta puede notificarse a distintos clientes. La tabla utiliza una clave primaria compuesta por `cod_cliente` y `cod_oferta`, y almacena el estado de cada notificación (`ENVIADA` o `LEIDA`).


## 2. Módulo de Ventas y Métodos de Pago

*   **Detalle de Venta:** Se creó esta entidad para modelar la relación de varios ítems por venta. Almacena el `precio_unitario` al momento de la transacción y se conecta con *Venta* y *Producto* mediante sus claves foráneas. Su clave primaria compuesta por `cod_producto` y `cod_venta` evita registrar dos veces el mismo producto en el detalle.
*   **Gestión de Pagos:** Se decidió simplificar el registro de los pagos incorporando el método utilizado dentro de `Venta`, usando la clave foránea `cod_metodo`. La tabla `Metodo_pago` almacena los distintos medios de pago aceptados por el local.
*   **Descuentos y Recargos:** La tabla `Venta` contiene el atributo `aplicable`, el cual registra el importe del descuento o recargo correspondiente a cada operación. Este valor es ingresado manualmente, considerando las ofertas y el método de pago utilizado. Actualmente, la base de datos no realiza el cálculo automático de estos importes.


## 3. Módulo de Productos y Categorías

*   **Clasificación de Inventario:** Se normalizó la información mediante la creación de la entidad *Categoría*. De este modo, un producto puede pertenecer a una categoría específica utilizando la clave foránea `cod_categoria`, lo que facilita el agrupamiento y la búsqueda de productos.
*   **Control de Stock y Precios:** En la entidad *Producto* se registran tanto el `precio_compra` como el `precio_venta`, junto con el stock actual. Esto permite calcular márgenes de ganancia y controlar la disponibilidad en el inventario. Además se estableció una restricción para impedir que el stock registrado sea negativo.


## 4. Módulo de Compras y Proveedores

*   **Relación con Proveedores:** Se diseñó la entidad *Proveedor* para almacenar los datos de contacto, el rubro y el CUIT de las empresas proveedoras. Se estableció una restricción de unicidad sobre el CUIT para evitar duplicaciones. Cada compra referencia al proveedor correspondiente mediante la clave foránea `cod_proveedor`.
*   **Detalle de Compra:** La entidad `Compra` almacena datos como la fecha, el precio total, el costo de envío y el proveedor asociado. Por su parte, `Detalle_de_compra` registra los productos incluidos en cada compra, junto con su precio unitario y cantidad. 
