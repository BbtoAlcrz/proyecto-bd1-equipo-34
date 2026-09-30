# Implementacion  del sql

Armamos una base de datos para un sistema de comercio, compras y ventas con 11 tablas relacionales, organizadas en tres niveles jerárquicos para mantener los datos ordenados y evitar redundancias:

Nivel 1 — Catálogos y Tablas Base: Comprende las entidades independientes del sistema: `Cliente`, `Proveedor`, `Categoria`, `Oferta` y `Metodo_pago`.
Cada una de estas tablas utiliza una clave primaria autoincremental de tipo entero para la identificación automática y única de sus registros. 

Nivel 2 — Tablas Intermedias de Operación: Contiene las entidades centrales que registran las transacciones de negocio: `Compra`, `Producto` y `Venta`. Estas tablas vinculan 
los catálogos principales mediante claves foráneas y almacenan atributos operativos clave como precios totales, stocks y fechas. 

Nivel 3 — Tablas Asociativas y Detalles de Operación: Incluye las tablas `Detalle_de_compra`, `Detalle_de_venta` y `Notificacion`. Resuelven las relaciones de muchos a muchos (N:M) 
entre las entidades principales, utilizando claves primarias compuestas por la combinación de las claves de las tablas padres.

## Decisiones de Diseño Adaptadas 
Identificadores Únicos: Se definieron llaves primarias numéricas simples para las entidades independientes, facilitando la indexación y velocidad de consulta. 
Precisión en los Datos: Se seleccionaron tipos de datos específicos para prevenir inconsistencias: valores decimales para importes monetarios y porcentajes,
tipos de fecha estrictos para el registro temporal, y cadenas de caracteres para teléfonos y correos.
