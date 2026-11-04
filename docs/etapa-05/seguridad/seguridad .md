# Seguridad: manejo de permisos a nivel de usuarios y roles en SQL Server

**Proyecto:** Sistema de ventas de artículos deportivos
**Etapa V:** Temas técnicos, tema 4
**Motor:** SQL Server Express

---

## 1. Definición y objetivo

La **seguridad en una base de datos** permite controlar **quién puede acceder** a la información y **qué operaciones puede realizar** (consultar, insertar, modificar, eliminar o ejecutar procedimientos).

SQL Server organiza la seguridad en tres niveles de objetos:

| Concepto | Nivel | Descripción |
|---|---|---|
| **Login** | Servidor | Credencial que permite conectarse a la instancia de SQL Server. |
| **Usuario (User)** | Base de datos | Identidad dentro de una base concreta, asociada a un login. Sobre el usuario se otorgan los permisos. |
| **Rol (Role)** | Base de datos | Grupo de permisos reutilizable. Los usuarios que se agregan al rol heredan sus permisos. |

Los permisos se administran con tres sentencias:

| Sentencia | Función |
|---|---|
| `GRANT` | Otorga un permiso. |
| `DENY` | Prohíbe explícitamente un permiso (tiene prioridad sobre `GRANT`). |
| `REVOKE` | Quita un permiso otorgado o denegado. |

**Objetivo:** aplicar el **principio de mínimo privilegio**: cada usuario recibe únicamente los permisos que necesita para cumplir su función, y nada más.

---

## 2. Ventajas y aplicaciones

### Ventajas

- **Protegen la información sensible** del sistema (por ejemplo, DNI, teléfono y correo de los clientes).
- **Evitan modificaciones accidentales o no autorizadas** de datos críticos (ventas, precios, stock).
- **Asignan responsabilidades según el perfil** del usuario (administrador, vendedor, consulta).
- **Simplifican la administración** mediante roles reutilizables: se define el permiso una vez y se asigna a todos los usuarios que lo necesiten.
- **Mejoran la mantenibilidad:** si cambia un permiso, se modifica en el rol y no usuario por usuario.
- **Permiten operar de forma controlada con procedimientos almacenados:** un usuario sin permiso de escritura sobre una tabla puede igualmente realizar una operación autorizada a través de un procedimiento.

### Aplicaciones en el sistema de ventas

| Perfil | Qué necesita | Qué no debería poder hacer |
|---|---|---|
| Administrador | Control total de la base | (sin restricciones) |
| Vendedor / cajero | Registrar ventas mediante el procedimiento | Modificar tablas directamente |
| Consulta / reportes | Ver productos y ventas | Insertar, modificar o eliminar datos |
| Atención al cliente | Ver nombre y apellido del cliente | Ver DNI, teléfono o correo |

---

## 3. Implementación en SQL Server 

### 3.1 Requisito previo: autenticación mixta

Para conectarse con logins de SQL Server (y no solo con Windows), la instancia debe tener habilitada la **autenticación de SQL Server y Windows**:

1. En SSMS: clic derecho sobre el servidor → **Propiedades** → **Seguridad**.
2. Seleccionar **Modo de autenticación de SQL Server y Windows**.
3. Reiniciar el servicio de SQL Server.

### 3.2 Sentencias utilizadas

```sql
CREATE LOGIN nombre WITH PASSWORD = '...';     -- credencial a nivel servidor
CREATE USER nombre FOR LOGIN nombre;           -- usuario dentro de la base
CREATE ROLE nombre_rol;                        -- rol personalizado
GRANT permiso ON objeto TO usuario_o_rol;      -- otorgar permiso
ALTER ROLE nombre_rol ADD MEMBER usuario;      -- incorporar usuario a un rol
```

### 3.3 Cómo se simulan los usuarios en las pruebas

Para no tener que cerrar sesión y reconectarse con cada login, se utiliza `EXECUTE AS USER`, que ejecuta las sentencias con los permisos de ese usuario, y `REVERT`, que vuelve al usuario original:

```sql
EXECUTE AS USER = 'usuario_lector';
-- sentencias a probar con los permisos de usuario_lector
REVERT;
```

### 3.4 Procedimiento almacenado y permisos (ownership chaining)

Un usuario puede ejecutar un procedimiento aunque **no tenga permiso directo** sobre las tablas que este modifica. Esto ocurre porque el procedimiento y la tabla pertenecen al mismo propietario (`dbo`): SQL Server verifica únicamente el permiso `EXECUTE` sobre el procedimiento y no vuelve a verificar los permisos sobre la tabla dentro del mismo. A este mecanismo se lo llama **encadenamiento de propiedad (ownership chaining)**.

De esta forma, la lógica de negocio queda controlada: el usuario solo puede realizar la operación tal como la define el procedimiento.

---

## 4. Caso concreto aplicado al sistema de ventas

El sistema cuenta con las tablas `Cliente`, `Venta`, `Producto`, `Categoria`, `Metodo_pago`, entre otras. Se propone:

| Usuario | Perfil | Permisos |
|---|---|---|
| `usuario_admin` | Administrador | Miembro de `db_owner` (control total). |
| `usuario_lector` | Consulta limitada | `SELECT` sobre `Venta`, `SELECT` solo de las columnas `cod_cliente`, `nombre_cliente` y `apellido_cliente` de `Cliente`, y `EXECUTE` sobre `sp_RegistrarVentaSimple`. |
| `usuario_con_rol` | Consulta de productos | Miembro del rol `rol_consulta_productos` (`SELECT` sobre `Producto`). |
| `usuario_sin_rol` | Sin permisos | No pertenece a ningún rol ni tiene permisos asignados. |

Se desea demostrar:

1. Permisos asignados **directamente a usuarios**.
2. Permisos asignados **mediante roles**.
3. La diferencia entre un **INSERT directo** y la ejecución de un **procedimiento almacenado**.
4. **Permisos a nivel de columna** para proteger datos personales de los clientes.

---

## 5. Script de demostración

### 5.1 Procedimiento almacenado

```sql
CREATE PROCEDURE dbo.sp_RegistrarVentaSimple
    @cod_cliente INT,
    @cod_metodo  INT,
    @Total       DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Venta (fecha_venta, precio_total, subtotal, cod_cliente, cod_metodo)
    VALUES (GETDATE(), @Total, @Total, @cod_cliente, @cod_metodo);
END;
GO
```

### 5.2 Creación de logins y usuarios

```sql
CREATE LOGIN usuario_admin   WITH PASSWORD = 'Admin123*';
CREATE LOGIN usuario_lector  WITH PASSWORD = 'Lector123*';
CREATE LOGIN usuario_con_rol WITH PASSWORD = 'Rol123*';
CREATE LOGIN usuario_sin_rol WITH PASSWORD = 'Rol456*';
GO

CREATE USER usuario_admin   FOR LOGIN usuario_admin;
CREATE USER usuario_lector  FOR LOGIN usuario_lector;
CREATE USER usuario_con_rol FOR LOGIN usuario_con_rol;
CREATE USER usuario_sin_rol FOR LOGIN usuario_sin_rol;
GO

```
![Captura de pantalla 2026-11-03 184231](<img/Captura de pantalla 2026-11-03 184231.png>)

```sql
SELECT name AS usuario, type_desc AS tipo
FROM sys.database_principals
WHERE name IN ('usuario_admin','usuario_lector','usuario_con_rol','usuario_sin_rol');
```


![Captura de pantalla 2026-11-03 184332](<img/Captura de pantalla 2026-11-03 184332.png>)


### 5.3 Parte 1: permisos a nivel de usuario

```sql
-- Administrador: control total de la base
ALTER ROLE db_owner ADD MEMBER usuario_admin;

-- Lector: solo lectura sobre Venta
GRANT SELECT ON dbo.Venta TO usuario_lector;

-- Lector: puede ejecutar el procedimiento autorizado
GRANT EXECUTE ON dbo.sp_RegistrarVentaSimple TO usuario_lector;
GO
```

### 5.4 Parte 2: permisos a nivel de rol

```sql
CREATE ROLE rol_consulta_productos;
GO

GRANT SELECT ON dbo.Producto TO rol_consulta_productos;
GO

ALTER ROLE rol_consulta_productos ADD MEMBER usuario_con_rol;
GO
```

### 5.5 Permisos a nivel de columna (datos personales de clientes)

```sql
-- usuario_lector solo puede ver nombre y apellido, no los datos de contacto
GRANT SELECT (cod_cliente, nombre_cliente, apellido_cliente)
ON dbo.Cliente TO usuario_lector;
GO
```

```sql
-- Pertenencia a roles
SELECT r.name AS rol, m.name AS miembro
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE m.name IN ('usuario_admin','usuario_con_rol');

-- Permisos otorgados
SELECT pr.name AS usuario_o_rol,
       pe.permission_name AS permiso,
       pe.state_desc AS estado,
       OBJECT_NAME(pe.major_id) AS objeto,
       COL_NAME(pe.major_id, pe.minor_id) AS columna
FROM sys.database_permissions pe
JOIN sys.database_principals pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name IN ('usuario_lector','rol_consulta_productos');
```

![Captura de pantalla 2026-11-03 184951](<img/Captura de pantalla 2026-11-03 184951.png>)

## 6. Pruebas y resultados obtenidos

### Prueba 1: INSERT directo sobre `Venta`

**Con usuario administrador** (resultado esperado: correcto)

```sql
EXECUTE AS USER = 'usuario_admin';

INSERT INTO dbo.Venta (fecha_venta, precio_total, subtotal, cod_cliente, cod_metodo)
VALUES (GETDATE(), 15000, 15000, 1, 1);

REVERT;
```

Es decir, el INSERT se ejecutó sin errores. Después del `REVERT`, se puede ejecutar `SELECT * FROM dbo.Venta;` para ver la fila nueva.


![Captura de pantalla 2026-11-03 185126](<img/Captura de pantalla 2026-11-03 185126.png>)


```sql
EXECUTE AS USER = 'usuario_lector';

INSERT INTO dbo.Venta (fecha_venta, precio_total, subtotal, cod_cliente, cod_metodo)
VALUES (GETDATE(), 15000, 15000, 1, 1);

REVERT;
```


```sql
EXECUTE AS USER = 'usuario_lector';

EXEC dbo.sp_RegistrarVentaSimple
    @cod_cliente = 1,
    @cod_metodo  = 1,
    @Total       = 15000;

REVERT;
```
```sql
SELECT TOP 3 * FROM dbo.Venta ORDER BY cod_venta DESC;
```


![Captura de pantalla 2026-11-03 190259](<img/Captura de pantalla 2026-11-03 190259.png>)



**Explicación:** `usuario_lector` no puede insertar directamente en `Venta`, pero sí puede hacerlo a través del procedimiento, porque posee permiso `EXECUTE` sobre este y ambos objetos pertenecen a `dbo` (encadenamiento de propiedad). El usuario solo puede realizar la operación autorizada, conservando el control de la lógica de negocio.

### Prueba 3: SELECT sobre `Producto` según rol

**Usuario con rol** (resultado esperado: correcto)

```sql
EXECUTE AS USER = 'usuario_con_rol';

SELECT * FROM dbo.Producto;

REVERT;
```


![Captura de pantalla 2026-11-03 191308](<img/Captura de pantalla 2026-11-03 191308.png>)




Usuario sin rol (resultado esperado: acceso denegado)
```sql
EXECUTE AS USER = 'usuario_sin_rol';

SELECT * FROM dbo.Producto;

REVERT;
```


### Prueba 4: permisos a nivel de columna sobre `Cliente`

```sql
EXECUTE AS USER = 'usuario_lector';

-- Columnas permitidas (resultado esperado: correcto)
SELECT cod_cliente, nombre_cliente, apellido_cliente
FROM dbo.Cliente;

-- Columnas protegidas (resultado esperado: acceso denegado)
SELECT dni, telefono, correo_electronico
FROM dbo.Cliente;

REVERT;
```


![Captura de pantalla 2026-11-03 191703](<img/Captura de pantalla 2026-11-03 191703.png>)




### Verificación final de datos

```sql
SELECT * FROM dbo.Venta;
```

![Captura de pantalla 2026-11-03 191835](<img/Captura de pantalla 2026-11-03 191835.png>)


## 7. Cuadro resumen de resultados

| Prueba | Usuario | Resultado esperado | 
|---|---|---|
| `SELECT` sobre `Producto` | `usuario_con_rol` | Correcto | 
| `SELECT` sobre `Producto` | `usuario_sin_rol` | Acceso denegado | 
| `INSERT` directo sobre `Venta` | `usuario_admin` | Correcto | 
| `INSERT` directo sobre `Venta` | `usuario_lector` | Acceso denegado | 
| `EXEC sp_RegistrarVentaSimple` | `usuario_lector` | Correcto | 
| `SELECT` de columnas permitidas de `Cliente` | `usuario_lector` | Correcto | 
| `SELECT` de `dni`, `telefono`, `correo_electronico` | `usuario_lector` | Acceso denegado | 

---

## 8. Conclusiones

- Los **roles** permiten administrar los accesos de forma centralizada y reutilizable, en lugar de asignar permisos usuario por usuario.
- El **principio de mínimo privilegio** se cumple al otorgar a cada usuario solo lo que necesita: el lector puede consultar pero no modificar datos.
- Los **procedimientos almacenados** permiten que un usuario realice una operación autorizada sin tener acceso directo a las tablas, manteniendo la lógica de negocio bajo control.
- Los **permisos a nivel de columna** protegen datos personales de los clientes (DNI, teléfono, correo) sin impedir el acceso al resto de la información.
- Todo intento de operación no autorizada es rechazado por SQL Server, lo que se evidencia en los mensajes de error obtenidos en las pruebas.
