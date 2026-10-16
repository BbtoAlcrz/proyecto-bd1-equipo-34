
# Ganancias por Producto

### Qué resuelve
Muestra el rendimiento individual de cada producto, calculando su margen unitario, la cantidad total de unidades vendidas y el beneficio total generado.

### Estrategia SQL
- **Cálculo directo**: Resta `p.precio_venta - p.precio_compra` para determinar la ganancia unitaria de cada artículo.
- **`JOIN`**: Vincula `Producto` con `Detalle_de_venta` para contabilizar únicamente las operaciones concretadas.
- **`GROUP BY` y agregaciones**: Agrupa por el identificador y atributos del producto, acumulando las unidades comercializadas (`SUM(dv.cantidad)`) y calculando la ganancia total mediante `SUM((p.precio_venta - p.precio_compra) * dv.cantidad)`.

### Código SQL
[ganancias_por_producto.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/ganancias_por_producto.sql)

### Resultado esperado

| cod_producto | nombre_producto | precio_compra | precio_venta | ganancia_unitaria | unidades_vendidas | margen_ganancia_total |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| 1 | Zapatillas Nike Pro-Speed | 45000.00 | 60800.00 | 15800.00 | 1 | 15800.00 |
| 2 | Remera Térmica Warm Adidas | 8500.00 | 11500.00 | 3000.00 | 1 | 3000.00 |
| 5 | Pantalón Essential Adidas | 15000.00 | 20300.00 | 5300.00 | 1 | 5300.00 |
| 6 | Mochila Under | 3500.00 | 4800.00 | 1300.00 | 1 | 1300.00 |
| 7 | Botella térmica Pro | 2800.00 | 3800.00 | 1000.00 | 1 | 1000.00 |
| 8 | Pelota Futbol 5 | 5500.00 | 7500.00 | 2000.00 | 2 | 4000.00 |
| 10 | Guantes boxeo 12 oz Everlast | 8000.00 | 10800.00 | 2800.00 | 1 | 2800.00 |
| 11 | Protector bucal simple Everlast | 1000.00 | 1350.00 | 350.00 | 1 | 350.00 |
| 12 | Mancuernas 5Kg | 2500.00 | 3400.00 | 900.00 | 1 | 900.00 |
| 13 | Mancuernas 8Kg | 2900.00 | 3900.00 | 1000.00 | 1 | 1000.00 |
| 15 | Paleta Padel Hibrida | 2000.00 | 2700.00 | 700.00 | 1 | 700.00 |
| 16 | Proteina Whey Concentrado | 5300.00 | 7100.00 | 1800.00 | 1 | 1800.00 |
| 18 | Creatina | 2300.00 | 3100.00 | 800.00 | 1 | 800.00 |
