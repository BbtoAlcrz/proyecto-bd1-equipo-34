
# Ventas por Categoría

### Qué resuelve
Permite evaluar la facturación total generada por cada categoría de productos dentro de un período de tiempo definido (por defecto el el 2026)

### Estrategia SQL
- **`JOIN`**: Vincula `Categoria`, `Producto`, `Detalle_de_venta` y `Venta` para relacionar las unidades vendidas con su categoría correspondiente.
- **`WHERE`**: Filtra las transacciones dentro del rango de fechas deseado (`v.fecha_venta BETWEEN '2026-01-01' AND '2026-12-31'`). Los límites temporales se pueden modificar para análisis mensuales, trimestrales o de temporadas específicas.
- **`GROUP BY` y `SUM()`**: Agrupa los resultados por el nombre de la categoría y calcula la recaudación total multiplicando la cantidad vendida por el precio unitario registrado en la venta (`SUM(dv.cantidad * dv.precio_unitario)`).
- **`ORDER BY`**: Ordena de mayor a menor según la facturación total para identificar rápidamente las categorías líderes.

### Código SQL
[ventas_por_categoria](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/Ventas_por_categoria.sql)

### Resultado esperado

| Categoria | Total_Ventas |
| :--- | :---: |
| Calzados | 60800.00 |
| Indumentaria | 31800.00 |
| Pelotas | 15000.00 |
| Artes marciales | 12150.00 |
| Suplementos | 10200.00 |
| Accesorios | 8600.00 |
| Fitness & Gym | 7300.00 |
| Raquetas & Paletas | 2700.00 |
