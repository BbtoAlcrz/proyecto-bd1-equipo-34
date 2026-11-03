# Procedimientos y Funciones Almacenadas en SQL Server

## 1. Definición y Objetivo
* **Procedimientos Almacenados:** Son programas SQL que se guardan en la base de datos para ejecutarse en múltiples operaciones. No están diseñados para retornar un valor mediante la instrucción `RETURN`, pero pueden devolver múltiples filas y manejar parámetros de salida (`OUTPUT`).
* **Funciones Almacenadas:** Son rutinas que reciben parámetros y devuelven un valor (escalar) o una tabla completa. Pueden ser llamadas directamente dentro de una consulta SQL (`SELECT`, `WHERE`, etc.).

---

## 2. Ventajas
* Ayudan a reutilizar la lógica de negocio.
* Reducen el código repetido.
* Mejoran la mantenibilidad del sistema.
* Facilitan la seguridad sobre los datos, restringiendo el acceso directo a las tablas físicas.
* Reducen el tráfico de red al enviar llamadas más cortas y precompiladas al servidor.

---

## 3. Implementación en SQL Server Express

### A. Función Almacenada (Escalar)
Para crearla se usa `CREATE FUNCTION`, se le asigna un nombre, se reciben los parámetros necesarios y se retorna el resultado de un cálculo (por ejemplo, el cálculo del IVA):

```sql
CREATE FUNCTION dbo.fn_CalcularTotalConIVA (@PrecioBase DECIMAL(10,2)) 
RETURNS DECIMAL(10,2) 
AS 
BEGIN 
    DECLARE @TotalConIVA DECIMAL(10,2); 
    SET @TotalConIVA = @PrecioBase * 1.21; 
    RETURN @TotalConIVA; 
END;
GO
```

**Cómo utilizarla (aplicarla):**
Se llama directamente dentro de una consulta `SELECT`:
```sql
SELECT 
    Nombre, 
    Precio AS PrecioOriginal, 
    dbo.fn_CalcularTotalConIVA(Precio) AS PrecioFinalConIVA 
FROM Productos;
```

---

### B. Procedimiento Almacenado
Para crearlo se usa `CREATE PROCEDURE`, se le asigna un nombre, se definen los parámetros de entrada o salida y se implementa su lógica interna.

```sql
CREATE PROCEDURE dbo.sp_SaludarPersona 
    @Nombre VARCHAR(50) 
AS 
BEGIN 
    PRINT '¡Hola, ' + @Nombre + '! Bienvenido a SQL Server.'; 
END;
GO
```

**Cómo utilizarlo (aplicarlo):**
Para invocarlo en SQL Server se antepone la palabra clave `EXEC`:
```sql
EXEC dbo.sp_SaludarPersona @Nombre = 'Juan';
```