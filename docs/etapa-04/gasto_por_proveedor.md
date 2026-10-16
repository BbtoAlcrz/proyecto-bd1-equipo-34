
# Gasto por Proveedor

### Qué resuelve
Indentifica proveedores a los cuales se les ha realizado una compra significativa para el stock, filtrando por aquellos donde el gasto supere un mínimo (por defecto $100.000,00)

### Estrategia SQL
- **`JOIN`**: Vincula la tabla `Proveedor` con `Compra` mediante el campo relacional `cod_proveedor`.
- **`GROUP BY`**: Agrupa la inversión acumulada por cada proveedor individual.
- **Filtro de Agregación `HAVING`**: Condiciona el resultado para mostrar solamente a los proveedores cuyo total comprado (`SUM(c.precio_total)`) supere el monto límite establecido.

### Código SQL
[gasto_por_proveedor.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/gasto_por_proveedor.sql.sql)

### Resultado esperado
(Filtro aplicado: `HAVING SUM(c.precio_total) > 100000.00`)

| cod_proveedor | nombre_proveedor | gasto_total_compras |
| :---: | :--- | :---: |
| 1 | Nike Argentina | 675000.00 |
| 2 | Adidas Argentina | 665000.00 |
| 3 | Under Armour Sport | 105000.00 |
| 4 | Penalty Deportes | 117000.00 |
| 6 | Athletic Fitness Equipment | 267000.00 |
| 8 | Star Nutrition Lab | 178500.00 |
