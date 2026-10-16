
# Ranking de Ventas por Método de Pago

### Qué resuelve
Evalúa el rendimiento financiero de los medios de pago aceptados y los clasifica por la frecuencia de uso por el monto total de dinero recaudado de cada uno.

### Estrategia SQL
- **`INNER JOIN`**: Relaciona la tabla `Metodo_pago` con `Venta` a través de la clave foránea `cod_metodo`.
- **`GROUP BY`**: Agrupa las ventas realizadas según el código y la descripción del método de pago.
- **Agregaciones `COUNT()` y `SUM()`**: Contabiliza la cantidad total de transacciones procesadas con cada medio (`COUNT(v.cod_metodo)`) y calcula el importe total recaudado (`SUM(v.precio_total)`).
- **`ORDER BY`**: Ordena el resultado de forma descendente tomando como criterio la cantidad de usos para identificar los canales preferidos por los clientes.

### Código SQL
[ranking_ventas_metodo.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/ranking_ventas_metodo.sql)

### Resultado esperado

| cod_metodo | tipo_metodo | cantidad_usos | importe_recaudado |
| :---: | :--- | :---: | :---: |
| 1 | Efectivo | 2 | 31050.00 |
| 3 | Tarjeta de Débito | 2 | 25200.00 |
| 5 | Billetera Virtual | 2 | 68100.00 |
| 2 | Tarjeta de Crédito | 1 | 8600.00 |
| 4 | Transferencia Bancaria | 1 | 11542.50 |
