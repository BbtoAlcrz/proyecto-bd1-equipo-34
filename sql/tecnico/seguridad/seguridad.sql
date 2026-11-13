/* ============================================================
   0. VERIFICAR MODO DE AUTENTICACIÓN (mixto)
   Resultado esperado: Modo mixto (Windows + SQL Server)
   ============================================================ */
SELECT CASE SERVERPROPERTY('IsIntegratedSecurityOnly')
         WHEN 0 THEN 'Modo mixto (Windows + SQL Server)'
         WHEN 1 THEN 'Solo autenticación de Windows'
       END AS modo_autenticacion;
GO
 
 
USE Proyecto_BD1;
GO
 
/* ============================================================
   1. PROCEDIMIENTO ALMACENADO
   (si ya existe el de tu equipo, usá ese en los pasos 4 y 6)
   ============================================================ */
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarVentaSimple
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
 
/* ============================================================
   2. CREACIÓN DE LOGINS Y USUARIOS
   (las contraseñas son de ejemplo)
   ============================================================ */
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'usuario_admin')
    CREATE LOGIN usuario_admin   WITH PASSWORD = 'Admin123*';
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'usuario_lector')
    CREATE LOGIN usuario_lector  WITH PASSWORD = 'Lector123*';
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'usuario_con_rol')
    CREATE LOGIN usuario_con_rol WITH PASSWORD = 'Rol123*';
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'usuario_sin_rol')
    CREATE LOGIN usuario_sin_rol WITH PASSWORD = 'Rol456*';
GO
 
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_admin')
    CREATE USER usuario_admin   FOR LOGIN usuario_admin;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_lector')
    CREATE USER usuario_lector  FOR LOGIN usuario_lector;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_con_rol')
    CREATE USER usuario_con_rol FOR LOGIN usuario_con_rol;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_sin_rol')
    CREATE USER usuario_sin_rol FOR LOGIN usuario_sin_rol;
GO
 
-- Verificación: debe devolver 4 filas de tipo SQL_USER
SELECT name AS usuario, type_desc AS tipo
FROM sys.database_principals
WHERE name IN ('usuario_admin','usuario_lector','usuario_con_rol','usuario_sin_rol');
GO
 
 
/* ============================================================
   3. PARTE 1: PERMISOS A NIVEL DE USUARIO
   ============================================================ */
 
-- Administrador: control total de la base
ALTER ROLE db_owner ADD MEMBER usuario_admin;
 
-- Lector: solo lectura sobre Venta
GRANT SELECT ON dbo.Venta TO usuario_lector;
 
-- Lector: puede ejecutar el procedimiento autorizado
GRANT EXECUTE ON dbo.sp_RegistrarVentaSimple TO usuario_lector;
GO
 
 
/* ============================================================
   4. PARTE 2: PERMISOS A NIVEL DE ROL
   ============================================================ */
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_consulta_productos')
    CREATE ROLE rol_consulta_productos;
GO
 
GRANT SELECT ON dbo.Producto TO rol_consulta_productos;
GO
 
ALTER ROLE rol_consulta_productos ADD MEMBER usuario_con_rol;
GO
 
 
/* ============================================================
   5. PERMISOS A NIVEL DE COLUMNA (datos personales de Cliente)
   ============================================================ */
GRANT SELECT (cod_cliente, nombre_cliente, apellido_cliente)
ON dbo.Cliente TO usuario_lector;
GO
 
 
/* ============================================================
   6. VERIFICACIÓN DE ROLES Y PERMISOS OTORGADOS
   ============================================================ */
 
-- Pertenencia a roles
-- Esperado: db_owner -> usuario_admin | rol_consulta_productos -> usuario_con_rol
SELECT r.name AS rol, m.name AS miembro
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE m.name IN ('usuario_admin','usuario_con_rol');
GO
 
-- Permisos otorgados
-- Esperado: CONNECT, SELECT Venta, EXECUTE sp_RegistrarVentaSimple,
--           SELECT Producto (rol) y SELECT sobre 3 columnas de Cliente
SELECT pr.name AS usuario_o_rol,
       pe.permission_name AS permiso,
       pe.state_desc AS estado,
       OBJECT_NAME(pe.major_id) AS objeto,
       COL_NAME(pe.major_id, pe.minor_id) AS columna
FROM sys.database_permissions pe
JOIN sys.database_principals pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name IN ('usuario_lector','rol_consulta_productos');
GO
 
-- Permisos por columna sobre Cliente (esperado: 3 filas)
SELECT pr.name AS usuario, pe.permission_name AS permiso, pe.state_desc AS estado,
       OBJECT_NAME(pe.major_id) AS objeto, COL_NAME(pe.major_id, pe.minor_id) AS columna
FROM sys.database_permissions pe
JOIN sys.database_principals pr ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'usuario_lector' AND OBJECT_NAME(pe.major_id) = 'Cliente';
GO
 
 
/* ============================================================
   7. PRUEBAS
   Ajustar cod_cliente y cod_metodo (1, 1) si en tu base los
   códigos son otros.
   ============================================================ */
 
-- ---------- Prueba 1a: INSERT directo con ADMIN -> CORRECTO ----------
-- Esperado: dos mensajes "(1 row affected)": uno del SELECT USER_NAME()
-- y otro del INSERT.
EXECUTE AS USER = 'usuario_admin';
SELECT USER_NAME() AS usuario_actual;
INSERT INTO dbo.Venta (fecha_venta, precio_total, subtotal, cod_cliente, cod_metodo)
VALUES (GETDATE(), 15000, 15000, 1, 1);
REVERT;
GO
 
-- ---------- Prueba 1b: INSERT directo con LECTOR -> DENEGADO ----------
-- Esperado: Msg 229, The INSERT permission was denied on the object 'Venta'
EXECUTE AS USER = 'usuario_lector';
SELECT USER_NAME() AS usuario_actual;
INSERT INTO dbo.Venta (fecha_venta, precio_total, subtotal, cod_cliente, cod_metodo)
VALUES (GETDATE(), 15000, 15000, 1, 1);
REVERT;
GO
 
-- ---------- Prueba 2: INSERT por PROCEDIMIENTO con LECTOR -> CORRECTO ----------
-- Esperado: sin errores. El procedimiento usa SET NOCOUNT ON, por eso no
-- muestra "filas afectadas" del INSERT (solo la del SELECT USER_NAME()).
-- La venta nueva se comprueba con el SELECT TOP 3 siguiente.
EXECUTE AS USER = 'usuario_lector';
SELECT USER_NAME() AS usuario_actual;
EXEC dbo.sp_RegistrarVentaSimple
    @cod_cliente = 1,
    @cod_metodo  = 1,
    @Total       = 15000;
REVERT;
GO
 
-- Comprobar la venta registrada (con tu usuario normal)
SELECT TOP 3 * FROM dbo.Venta ORDER BY cod_venta DESC;
GO
 
-- ---------- Prueba 3a: SELECT Producto CON ROL -> CORRECTO ----------
-- Esperado: grilla con todos los productos
EXECUTE AS USER = 'usuario_con_rol';
SELECT USER_NAME() AS usuario_actual;
SELECT * FROM dbo.Producto;
REVERT;
GO
 
-- ---------- Prueba 3b: SELECT Producto SIN ROL -> DENEGADO ----------
-- Esperado: Msg 229, The SELECT permission was denied on the object 'Producto'
EXECUTE AS USER = 'usuario_sin_rol';
SELECT USER_NAME() AS usuario_actual;
SELECT * FROM dbo.Producto;
REVERT;
GO
 
-- ---------- Prueba 4a: columnas PERMITIDAS de Cliente -> CORRECTO ----------
-- Esperado: grilla con cod_cliente, nombre_cliente, apellido_cliente
EXECUTE AS USER = 'usuario_lector';
SELECT USER_NAME() AS usuario_actual;
SELECT cod_cliente, nombre_cliente, apellido_cliente FROM dbo.Cliente;
REVERT;
GO
 
-- ---------- Prueba 4b: columnas PROTEGIDAS de Cliente -> DENEGADO ----------
-- Esperado: Msg 230, The SELECT permission was denied on the column 'dni'...
EXECUTE AS USER = 'usuario_lector';
SELECT USER_NAME() AS usuario_actual;
SELECT dni, telefono, correo_electronico FROM dbo.Cliente;
REVERT;
GO
 
 
/* ============================================================
   8. VERIFICACIÓN FINAL
   ============================================================ */
SELECT * FROM dbo.Venta;
GO
 
 
