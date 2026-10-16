
# Ranking de Clientes por Gasto

### Qué resuelve
Genera un listado ordenado de mayor a menor con los clientes que más ingresos han aportado al negocio, indicando el importe total acumulado y la cantidad de compras realizadas por cada uno.

### Estrategia SQL
- **`INNER JOIN`**: Vincula las tablas `Cliente` y `Venta` mediante el campo clave `cod_cliente`.
- **`GROUP BY`**: Agrupa el conjunto de ventas por el identificador y nombre del cliente.
- **Agregaciones `SUM()` y `COUNT()`**: Calcula el dinero facturado acumulado (`SUM(v.precio_total)`) y el total de transacciones concretadas (`COUNT(v.cod_venta)`).
- **`ORDER BY`**: Ordena de manera descendente según el importe total gastado para priorizar a los compradores con mayor volumen de facturación.

### Código SQL
[ranking_clientes_gasto.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/ranking_clientes_gasto.sql)

### Resultado esperado

| nombre_cliente | cod_cliente | importe_total | cantidad_compras |
| :--- | :---: | :---: | :---: |
| Juan | 1 | 68100.00 | 2 |
| Laura | 2 | 31050.00 | 2 |
| Ana | 4 | 15000.00 | 1 |
| Pedro | 5 | 11542.50 | 1 |
| Carlos | 3 | 10200.00 | 1 |
| Lucía | 6 | 8600.00 | 1 |
