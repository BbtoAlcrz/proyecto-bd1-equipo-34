
# Ganancias Superiores al Promedio

### Qué resuelve
Filtra y lista a aquellos clientes cuyo gasto acumulado en la tienda supera el promedio de gasto por cliente de todo el negocio, permitiendo identificar a los compradores de mayor valor (VIPs).

### Estrategia SQL
- **`JOINs`**: Vincula `Cliente`, `Venta`, `Metodo_pago` y `Detalle_de_venta` para consolidar el historial transaccional por comprador.
- **Subconsulta de Agregación (`AVG`)**: Calcula primero el promedio gastado por cliente en todo el historial mediante una subconsulta derivando `SUM(v2.precio_total)` agrupado por `c2.cod_cliente`.
- **Filtro de Grupo `HAVING`**: Compara la suma total gastada por cada cliente registrado en el bloque principal (`SUM(v.precio_total)`) contra el promedio global obtenido dinámicamente en la subconsulta.

### Código SQL
[ganancias_superiores_al_promedio.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/gastos_superiores_al_promedio.sql)

### Resultado esperado
*(Promedio general de gasto por clientes: $28,908.75)*

| cod_cliente | nombre_cliente | apellido_cliente | total_gastado |
| :---: | :--- | :--- | :---: |
| 1 | Juan | Pérez | 68100.00 |
| 2 | Laura | Martínez | 31050.00 |
