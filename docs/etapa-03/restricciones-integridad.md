# Restricciones e Integridad de Datos en SQL y en el Sistema 

## 1\. Fundamentos Teóricos de la Integridad en Bases de Datos Relacionales En el modelo relacional, las \*\*restricciones de integridad\*\* son un conjunto de reglas lógicas y declarativas definidas 
en el Lenguaje de Definición de Datos (DDL) que obligan al Sistema Gestor de Bases de Datos (SGBD) a garantizar que la información almacenada sea válida, exacta, coherente y libre de errores [1-4]. 
La premisa fundamental del diseño relacional establece que \*una base de datos solo es tan buena como la calidad y consistencia de los datos almacenados en ella\* [3, 4]. El estándar ANSI SQL y el modelo
relacional clasifican las restricciones de integridad en cuatro categorías principales [5, 6]: 

### A. Integridad de Entidad (Clave Primaria - \`PK\_\`) Garantiza que cada fila o tupla de una tabla sea única e identificable de forma inequívoca [5, 7-9]. 
Para cumplir esta regla, toda clave primaria (\`PRIMARY KEY\`) exige de forma estricta e implícita dos condiciones: \*\*unicidad\*\* (no admite valores duplicados) y \*\*no nulidad\*\* (\`NOT NULL\`,
no puede tener campos vacíos) [2, 8, 10]. En la implementación física, suele combinarse con mecanismos autoincrementales (\`IDENTITY\`) para generar identificadores surrogate estables e inmutables [11-13]. 

### B. Integridad Referencial (Clave Foránea - \`FK\_\`) Asegura la coherencia lógica de las conexiones entre tablas asociando una columna (o conjunto de columnas) en una tabla "hija" con la clave primaria de una tabla 
"padre" [5, 7, 8, 14]. Su objetivo es prevenir la aparición de \*\*registros huérfanos\*\* (filas hijas que referencian a un registro padre inexistente) [15, 16]. Cuando se modifica o elimina un registro en la tabla padre,
la integridad referencial ejecuta acciones declaradas como \`RESTRICT\` / \`NO ACTION\` (impide la operación si existen hijos), \`CASCADE\` (propaga el borrado) o \`SET NULL\` (deja en nulo la clave foránea) [17-20]. 

### C. Integridad de Unicidad (Restricción \`UNIQUE\` - \`UQ\_\`) Asegura que no existan valores duplicados dentro de atributos candidatas que no fueron seleccionados como clave primaria (por ejemplo, DNI o correo electrónico) [5, 21-23].
A diferencia de la clave primaria, la restricción \`UNIQUE\` permite la existencia de un valor nulo (\`NULL\`), salvo que se combine explícitamente con \`NOT NULL\` [22-24]. 

### D. Integridad de Dominio y Chequeo (\`NOT NULL\`, \`DEFAULT\`, \`CHECK\`) Delimitan el conjunto de valores válidos que puede asumir cada atributo o columna individual [25-28]: \* \*\*Obligatoriedad (\`NOT NULL\`):\*\* 
Exige que la columna contenga obligatoriamente un valor válido [2, 23, 29]. \* \*\*Valores por Defecto (\`DEFAULT\` / \`DF\_\`):\*\* Asigna automáticamente un valor predeterminado a un campo cuando una operación de
inserción omite dicho dato [30-32]. \* \*\*Verificación de Dominio (\`CHECK\` / \`CK\_\`):\*\* Evalúa una condición lógica booleana sobre el contenido de uno o más atributos antes de confirmar la inserción o 
actualización (por ejemplo, validar que un precio sea estrictamente mayor a cero) [29, 30, 33, 34]. 

--- ## 2\. Modificaciones y Refinamiento del Esquema Relacional Basándonos en el proceso de normalización (3FN) y la eliminación de anomalías de redundancia [35-37], 
se aplicaron las siguientes optimizaciones sobre el diseño inicial exportado por herramientas conceptuales:

### A. Eliminación de Redundancia en Métodos de Pago y Descuentos \* \*\*Simplificación de \`Aplicable\`:\*\* Se eliminó la tabla independiente \`Aplicable\` por considerarse redundante. En el modelo de negocio,
cada venta aplica un único porcentaje de ajuste (descuento o recargo). Por ello, dicho valor se unificó como un atributo numérico (\`aplicable\`) dentro de la propia tabla \`Venta\`, asignándole un valor predeterminado 
de cero (\`DEFAULT 0\`). \* \*\*Eliminación de \`Pago\_venta\`:\*\* Se eliminó la tabla intermedia \`Pago\_venta\` al tratarse de una relación uno a uno (1:1) innecesaria [38-40]. La tabla \`Venta\` se conectó 
directamente con \`Metodo\_pago\` mediante la clave foránea \`cod\_metodo\`. 

### B. Flexibilización de Promociones y Comunicaciones \* \*\*Atributos Temporales en \`Oferta\`:\*\* Se estableció la fecha de lanzamiento con la fecha actual del sistema mediante el valor por defecto \`DEFAULT GETDATE()\`.
La fecha de finalización se definió como opcional (\`NULL\`) para permitir promociones activas por tiempo indefinido. \* \*\*Resolución N:M en \`Notificacion\`:\*\* La tabla \`Notificacion\` actúa como la tabla 
asociativa que resuelve la relación de muchos a muchos entre \`Cliente\` y \`Oferta\` [41-43]. Se definió mediante una clave primaria compuesta \`(cod\_cliente, cod\_oferta)\`, donde cada componente es simultáneamente 
una clave foránea referenciando a las tablas padres [41-43].

### C. Claves Compuestas en Detalle de Compra y Venta Las tablas asociativas \`Detalle\_de\_compra\` y \`Detalle\_de\_venta\` representan la intersección entre transacciones y productos [43, 44]. Sus claves primarias 
se estructuraron como claves compuestas \`(cod\_compra, cod\_producto)\` y \`(cod\_producto, cod\_venta)\` respectivamente, garantizando que un mismo producto no se repita de forma redundante dentro del mismo comprobante
[43, 45, 46].
