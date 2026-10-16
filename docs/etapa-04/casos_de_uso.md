
# Casos de Uso de las Consultas SQL

Este documento detalla los escenarios de negocio e investigación donde resulta necesario utilizar cada una de las consultas SQL desarrolladas en la Etapa 04, explicando el motivo de su elección y la información que aporta al negocio.

---

| Escenario de Negocio | Consultas a Usar | Por qué | Resultado que obtenés |
| :--- | :--- | :--- | :--- |
| **Emitir una factura/comprobante de venta** | `factura-de-venta.md` | Permite desglosar articulo por articulo los precios unitarios, subtotales por renglón, saldo acumulado y total final con descuentos aplicados para una venta específica. | Factura lista para presentar al cliente. |
| **Evaluar el desempeño comercial por sector** | `ventas-por-categoria.md` | Permite conocer qué categorías de productos generan mayor facturación en un período de tiempo determinado. | Clasificación de las categorías de productos ordenadas por nivel de facturación. |
| **Identificar stock inmovilizado** | `productos-nunca-vendidos.md` | Permite detectar los artículos registrados en el catálogo que no registran ventas asociadas para planificar promociones o liquidaciones. | Listado de productos que no venden para liberar stock. |
| **Analizar rentabilidad por producto** | `ganancias-por-producto.md` | Permite ver el volumen de ventas del margen nulo o positivo, calculando el beneficio unitario y el acumulado por artículo. | Ranking de productos según la ganancia real que aportan. |
| **Detectar compradores con consumo superior al promedio** | `ganancias-superiores-al-promedio.md` | Permite identificar automáticamente a los clientes cuyo gasto acumulado supera la media para acciones especiales. | Clientes con nivel de facturación por encima del promedio general. |
| **Rankear a los clientes por facturación e interacciones** | `ranking-clientes-gasto.md` | Permite ordenar la base de clientes según el dinero total gastado y la cantidad de compras realizadas en la tienda. | Listado de clientes jerarquizados por volumen de compra y frecuencia. |
| **Evaluar los medios de cobro** | `ranking-ventas-metodo.md` | Permite medir la cantidad de operaciones e importe recaudado por cada método de pago disponible. | Distribución de transaccionado según la modalidad de pago. |
| **Auditar la inversión en compras por proveedor** | `gasto-por-proveedor.md` | Permite filtrar y analizar los desembolsos acumulados por proveedor que superan un umbral de inversión estipulado. | Listado de proveedores principales ordenados por monto de compra. |
| **Lectura de campañas promocionales** | `ofertas-sin-leer.md` | Permite identificar los mensajes de ofertas vigentes que fueron entregados a los clientes pero que aún no han sido leídos. | Lista de notificaciones pendientes de apertura para realizar reenvíos o seguimiento. |

---

### Cuándo utilizar cada documento

- **`factura-de-venta.md`**: Se utiliza cada vez que se requiere consultar, validar o imprimir el desglose completo de una transacción específica a partir de su número identificador (`cod_venta`).
- **`ventas-por-categoria.md`**: Se utiliza durante revisiones trimestrales, semestrales o anuales para evaluar el peso de cada rubro en la facturación total y tomar decisiones de reabastecimiento.
- **`productos-nunca-vendidos.md`**: Se utiliza en revisiones periódicas de inventario para detectar mercadería estancada y armar combos o descuentos de liquidación.
- **`ganancias-por-producto.md`**: Se utiliza para analizar qué productos son verdaderamente rentables y cuáles generan volumen de venta pero poco margen ganancial.
- **`ganancias-superiores-al-promedio.md`**: Se utiliza para filtrar la base de compradores cuando se desea realizar promociones exclusivas o programas de fidelización sin incluir a clientes esporádicos.
- **`ranking-clientes-gasto.md`**: Se utiliza cuando se necesita tener una visión general ordenada de los clientes de mayor a menor consumo histórico en el negocio.
- **`ranking-ventas-metodo.md`**: Se utiliza para analizar los costos operativos y comisiones de las pasarelas de pago según los canales de cobro más utilizados por los clientes.
- **`gasto-por-proveedor.md`**: Se utiliza al momento de revisar cuentas por pagar, negociar volumen o evaluar la concentración de compras en pocos proveedores.
- **`ofertas-sin-leer.md`**: Se utiliza durante el transcurso de una campaña publicitaria activa para identificar a los destinatarios que no han abierto el comunicado y evaluar un nuevo envío.
