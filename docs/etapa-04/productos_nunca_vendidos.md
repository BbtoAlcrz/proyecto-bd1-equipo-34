
# Productos Nunca Vendidos

### Qué resuelve
Identifica aquellos productos registrados en el inventario que jamás han tenido registros de venta , lo cual es crítico para la toma de decisiones sobre promociones o liquidaciones

### Estrategia SQL
Presenta dos enfoques alternativos para lograr el mismo resultado:
1. **Sintaxis `LEFT JOIN ... IS NULL`**: Realiza un join inclusivo desde `Producto` hacia `Detalle_de_venta` y filtra los registros donde la clave primaria del detalle resulta nula
2. **Sintaxis `NOT EXISTS`**: Utiliza una subconsulta para verificar la no existencia de registros coincidentes en la tabla de ventas

### Código SQL
[productos_nunca_vendidos.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/productos_nunca_vendidos.sql)

### Resultado esperado
(Mismo resultado para ambas versiones de la consulta)

| cod_producto | nombre_producto |
| :---: | :--- |
| 3 | Musculosa Cold Adidas |
| 4 | Top Deportivo protector Adidas |
| 9 | Pelota básquet N6 |
| 14 | Mancuernas 10Kg |
| 17 | Proteina Isopure |
