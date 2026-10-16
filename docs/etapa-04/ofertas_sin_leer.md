
# Ofertas Sin Leer

### Qué resuelve
Identifica las notificaciones de promociones o descuentos que fueron enviadas a los clientes pero que aún no han sido leídas, filtrando solo las ofertas que sigan vigentes al día actual

### Estrategia SQL
- **`JOINs`**: Vincula `Notificacion` con `Cliente` y `Oferta` para obtener los datos del destinatario y el detalle de la promoción.
- **Filtro `WHERE` con función temporal**: Filtra por el estado `'ENVIADA'` y evalúa vigencia mediante `o.fecha_finalizacion >= GETDATE()`.
- **Parametrización**: El estado de notificación y el rango de fechas pueden adaptarse según el ciclo de vida de la campaña de email marketing.

### Código SQL
[ofertas_sin_leer.sql](https://github.com/BbtoAlcrz/proyecto-bd1-equipo-34/blob/main/sql/consultas/ofertas_sin_leer.sql.sql)

### Resultado esperado
(Consulta ejecutada sobre ofertas cuya fecha de finalización es superior a la fecha actual)

| cod_oferta | detalle_oferta | cod_cliente | nombre_cliente | apellido_cliente | estado_notificacion |
| :---: | :--- | :---: | :--- | :--- | :---: |
| 3 | Especial Verano: 2x1 en musculosas y shorts deportivos | 3 | Carlos | López | ENVIADA |
| 5 | Especial día de la Madre: 20% OFF en conjuntos deportivos, tops y calzas | 5 | Pedro | Sánchez | ENVIADA |
| 7 | Combo Rendimiento: 15% OFF llevando PROTEÍNA + CREATINA | 7 | Diego | Romero | ENVIADA |
