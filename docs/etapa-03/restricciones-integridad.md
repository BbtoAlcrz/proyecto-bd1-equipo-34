# Restricciones e Integridad de Datos en SQL y en el Sistema 

## 1\. Fundamentos Teóricos de la Integridad en Bases de Datos Relacionales
En el modelo relacional, las restricciones de integridad son un conjunto de reglas lógicas y declarativas definidas en el Lenguaje de Definición de Datos (DDL) 
que obligan al Sistema Gestor de Bases de Datos (SGBD) a garantizar que la información almacenada sea válida, exacta, coherente y libre de errores. 
La premisa fundamental del diseño relacional establece que una base de datos solo es tan buena como la calidad y consistencia de los datos almacenados en ella. El estándar ANSI SQL y el modelo
relacional clasifican las restricciones de integridad en cuatro categorías principales: 

A. Integridad de Entidad (Clave Primaria - `PK_`) 
Garantiza que cada fila o tupla de una tabla sea única e identificable de forma inequívoca. Para cumplir esta regla, toda clave primaria (`PRIMARY KEY`) exige de forma estricta e implícita 
dos condiciones: unicidad (no admite valores duplicados) y no nulidad (`NOT NULL`, no puede tener campos vacíos). En la implementación física, suele combinarse con mecanismos autoincrementales
(`IDENTITY`) para generar identificadores surrogate estables e inmutables. 

B. Integridad Referencial (Clave Foránea - `FK_`) 
Asegura la coherencia lógica de las conexiones entre tablas asociando una columna (o conjunto de columnas) en una tabla "hija" con la clave primaria de una tabla "padre". Su objetivo es prevenir 
la aparición de registros huérfanos (filas hijas que referencian a un registro padre inexistente). Cuando se modifica o elimina un registro en la tabla padre, la integridad referencial ejecuta 
acciones declaradas como `RESTRICT` / `NO ACTION` (impide la operación si existen hijos), `CASCADE` (propaga el borrado) o `SET NULL` (deja en nulo la clave foránea). 

C. Integridad de Unicidad (Restricción `UNIQUE` - `UQ_`) 
Asegura que no existan valores duplicados dentro de atributos candidatas que no fueron seleccionados como clave primaria (por ejemplo, DNI o correo electrónico).
A diferencia de la clave primaria, la restricción `UNIQUE` permite la existencia de un valor nulo (`NULL`), salvo que se combine explícitamente con `NOT NULL`. 

D. Integridad de Dominio y Chequeo (`NOT NULL`, `DEFAULT`, `CHECK`) 
Delimitan el conjunto de valores válidos que puede asumir cada atributo o columna individual: 
Obligatoriedad (`NOT NULL`): Exige que la columna contenga obligatoriamente un valor válido. 
Valores por Defecto (`DEFAULT` / `DF_`): Asigna automáticamente un valor predeterminado a un campo cuando una operación de inserción omite dicho dato. 
Verificación de Dominio (`CHECK` / `CK_`): Evalúa una condición lógica booleana sobre el contenido de uno o más atributos antes de confirmar la inserción 
o actualización (por ejemplo, validar que un precio sea estrictamente mayor a cero). 

## 2\. Modificaciones y Refinamiento del Esquema Relacional Basándonos en el proceso de normalización (3FN) y la eliminación de anomalías de redundancia, 
se aplicaron las siguientes optimizaciones sobre el diseño inicial exportado por herramientas conceptuales:

A. Flexibilización de Promociones y Comunicaciones 
Atributos Temporales en `Oferta`: Se estableció la fecha de lanzamiento con la fecha actual del sistema mediante el valor por defecto `DEFAULT GETDATE()`.
La fecha de finalización se definió como opcional (`NULL`) para permitir promociones activas por tiempo indefinido. Resolución N:M en `Notificacion`: La tabla
`Notificacion` actúa como la tabla asociativa que resuelve la relación de muchos a muchos entre `Cliente` y `Oferta`. Se definió mediante una clave primaria
compuesta `(cod_cliente, cod_oferta)`, donde cada componente es simultáneamente una clave foránea referenciando a las tablas padres.

B. Claves Compuestas en Detalle de Compra y Venta 
Las tablas asociativas `Detalle_de_compra` y `Detalle_de_venta` representan la intersección entre transacciones y productos. Sus claves primarias se estructuraron
como claves compuestas `(cod_compra, cod_producto)` y `(cod_producto, cod_venta)` respectivamente, garantizando que un mismo producto no se repita de forma redundante
dentro del mismo comprobante.
