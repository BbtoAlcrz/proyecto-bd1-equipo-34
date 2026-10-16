# Factura de Venta

### Qué resuelve
Permite generar el comprobante detallado de una venta especifica, mostrando los articulos comprados, los precios unitarios, subtotales por renglón, el cálculo acumulado articulo por articulo y los totales generales con descuentos aplicados

### Estrategia SQL
- **`INNER JOIN`**: Conecta `Venta` con `Cliente`, `Metodo_pago`, `Detalle_de_venta` y `Producto` para reconstruir la información completa del comprobante.
- **Función de Ventana `SUM() OVER()`**: `PARTITION BY v.cod_venta ORDER BY p.cod_producto` calcula el saldo acumulado conforme se leen los renglones de la factura.
- **Filtrado dinámico**: Se filtra mediante la cláusula `WHERE v.cod_venta = X`, lo que permite variarlo (valores del 1 al 8) según la factura a emitir.

### Código SQL
[factura_de_venta.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/factura_de_venta.sql)

### Resultado esperado
(Consulta ejecutada para cod_venta = 8)

| cod_venta | fecha_venta | cliente | dni | forma_de_pago | nombre_producto | cantidad | precio_unitario | subtotal_renglon | acumulado | subtotal_general | descuento | total_a_pagar |
| :---: | :---: | :--- | :---: | :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 8 | 2026-03-10 | Carlos López | 33333333 | Tarjeta de Débito | Proteina Whey Concentrado | 1 | 7100.00 | 7100.00 | 7100.00 | 10200.00 | 0.00 | 10200.00 |
| 8 | 2026-03-10 | Carlos López | 33333333 | Tarjeta de Débito | Creatina | 1 | 3100.00 | 3100.00 | 10200.00 | 10200.00 | 0.00 | 10200.00 |
