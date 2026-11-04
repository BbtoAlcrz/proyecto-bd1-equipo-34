# Manejo de Transacciones y Transacciones Anidadas

## Definición y Objetivos

Una **transacción** en SQL es un conjunto de instrucciones que se ejecutan como una única unidad lógica de trabajo. 
Su objetivo es garantizar que la base de datos se mantenga en un estado consistente. Si todas las operaciones dentro de la transacción tienen éxito, las modificaciones se guardan de forma permanente (`COMMIT`), Pero si alguna de las operaciones falla o se interrumpe, todos los cambios realizados desde el inicio se cancelan y se devuelven a su estado original (`ROLLBACK`).

## Propiedades ACID
El manejo de transacciones asegura el cumplimiento de las cuatro propiedades fundamentales:
* **Atomicidad:** Toda la transacción se realiza o no se realiza nada.
* **Consistencia:** La base de datos pasa de un estado válido a otro estado válido, respetando todas las restricciones (FK, CHECK, UNIQUE).
* **Aislamiento / Isolation:** Las operaciones concurrentes no interfieren entre sí antes de confirmarse.
* **Durabilidad:** Una vez realizada la confirmación del `COMMIT`, los cambios persisten en el sistema.

## Implementación en SQL Server
En SQL Server la gestión transaccional se implementa mediante los comandos:
* `BEGIN TRANSACTION`: Inicia el bloque transaccional.
* Bloques `BEGIN TRY ... BEGIN CATCH`: Permiten capturar excepciones y errores de restricciones, como violaciones de llaves foráneas, `CHECK` o `UNIQUE` y desencadenar el `ROLLBACK` de manera controlada.
* `COMMIT TRANSACTION`: Confirma los cambios en la base de datos.
* `ROLLBACK TRANSACTION`: Revierte todas las operaciones del bloque.

---

## Aplicación al Sistema de Ventas
En el dominio de nuestro sistema, el registro de un pedido abarca tres modificaciones sobre distintas tablas:
1. **Insertar** un nuevo registro en `Venta`.
2. **Insertar** uno o más renglones en `Detalle_de_venta`.
3. **Actualizar** el campo `stock` en la tabla `Producto`.

Si la actualización de stock falla (por ejemplo, por no disponer del stock mínimo permitido por la restricción `CHECK (stock >= 0)`), la venta y sus detalles **no deben registrarse**.

---

## Pruebas de Ejecución

### Prueba 1: Transacción Exitosa
* **Escenario:** Venta de 2 unidades del producto ID 1 (`Zapatillas Nike Pro-Speed`) al Cliente 1.
* **Resultado:** Se creó la venta, el detalle correspondiente y el stock disminuyó de 15 a 13 unidades.
* **Comprobación:** Confirmación mediante `COMMIT TRANSACTION`.

![Evidencia antes de la transaccion](img/antes_transaccion.png)
![Evidencia luego de la transaccion exitosa](img/despues_transaccion_exitosa.png)

### Prueba 2: Error Intencional y Verificación de Atomicidad
* **Escenario:** Intento de venta de 999 unidades del producto ID 1 (superior al stock disponible de 13 unidades).
* **Resultado Esperado:** Al ejecutar el `UPDATE`, el motor de BD detecta la violación de la restricción `CK_Producto_Stock`. El control pasa inmediatamente al bloque `CATCH` y ejecuta un `ROLLBACK`.
* **Evidencia:** Ni la `Venta` ni el `Detalle_de_venta` se insertaron en la base de datos. El total de registros en la tabla `Venta` se mantuvo inalterado.

![Evidencia luego de la transaccion erronea](img/despues_transaccion_erronea.png)

---

## Conclusiones
1. **Integridad de Datos:** Utilizar `BEGIN TRANSACTION` junto con bloques `TRY...CATCH` previene la existencia de "datos huérfanos" o inconsistencias, como registrar una venta pero sin haber podido descontar el stock.
2. **Efectividad ante fallos:** Se comprobó que ante errores (provocados intencionalmente) por restricciones que pusimos en la base de datos, SQL Server cancela correctamente toda la secuencia operativa, manteniendo la consistencia global del sistema.
