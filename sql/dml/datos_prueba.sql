-- Ofertas / Descuentos
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('5% OFF en tu primera compra', '2026-01-01', NULL);
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES ('10% OFF durante la semana de tu cumpleaños', '2026-01-01', NULL);

INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('Especial Verano: 2x1 en musculosas y shorts deportivos', '2026-12-21', '2027-03-15');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('Vuelta al Entrenamiento: 20% OFF en remeras térmicas', '2026-05-01', '2026-05-31');

INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('Especial día de la Madre: 20% OFF en conjuntos deportivos, tops y calzas', '2026-10-05', '2026-10-18');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion)
VALUES('Especial día del Padre: 20% OFF en camisetas y calzado de entrenamiento', '2026-06-08', '2026-06-21');

INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion)
VALUES('Combo Rendimiento: 15% OFF llevando PROTEÍNA + CREATINA', '2026-10-01', '2026-12-31');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('GYM en casa: 10% OFF en mancuernas, pesas rusas y bandas de resistencia', '2026-06-01', '2026-06-30');
-- SELECT * FROM Oferta;


-- Clientes
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni) 
VALUES('Juan', 'Pérez', '3794111111', 'juan_perz1@gmail.com', '11111111');
INSERT INTO Cliente( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni) 
VALUES('Laura', 'Martínez', '3794222222', 'laura_mz2@gmail.com', '22222222');
INSERT INTO Cliente( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Carlos', 'López', '3794333333', 'carlos_lopz3@gmail.com', '33333333');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Ana', 'García', '3794444444', 'ana_garc4@gmail.com', '44444444');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Pedro', 'Sánchez', '3794555555', 'pedro_snz5@gmail.com', '55555555');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Lucía', 'Fernández', '3794666666', 'lucia_fern6@gmail.com', '66666666');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Diego', 'Romero', '3794777777', 'diego_rom7@gmail.com', '77777777');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('María', 'Gómez', '3794888888', 'maria_gomez8@gmail.com', '88888888');
-- SELECT * FROM Cliente;


-- Notificaciones
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES(1, 1, 'ENVIADA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES(2, 2, 'LEIDA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES (3, 3, 'ENVIADA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES (4, 4, 'LEIDA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES (5, 5, 'ENVIADA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES (6, 6, 'LEIDA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES (7, 7, 'ENVIADA');
INSERT INTO Notificacion (cod_cliente, cod_oferta, estado_notificacion) 
VALUES(8, 8, 'LEIDA');
-- SELECT * FROM Notificacion;


-- Categorías de la tienda
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Calzados', 'Zapatillas de running, entrenamiento y botines.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Indumentaria', 'Camisetas, pantalones, shorts, tops, calzas.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Accesorios', 'Mochilas, bolsos, botellas y gorras');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Pelotas', 'Pelotas de fútbol, básquet, Voley, Rugby, etc.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Artes marciales', 'Guantes, bucales, vendas y protecciones.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Fitness & Gym', 'Mancuernas, discos, barras, sogas y colchonetas.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Raquetas & Paletas', 'Paletas de pádel, tenis y fundas.');
INSERT INTO Categoria (nombre_categoria, descripcion)  
VALUES ('Suplementos', 'Proteínas, Creatinas y geles.');
--SELECT * FROM Categoria;


-- Proveedores
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Nike Argentina', 'Calzados', 'Av. del Libertador 2442', '1144445555', '30654897219');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Adidas Argentina', 'Indumentaria', 'Av. San Martín 1520', '1144446666', '30504018529');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Under Armour Sport', 'Accesorios', 'Calle Florida 800', '1144447777', '30711234569');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Penalty Deportes', 'Pelotas', 'Av. Corrientes 3200', '1144448888', '30689541239');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Everlast Fight Co.', 'Artes marciales', 'Av. Córdoba 4500', '1144449999', '30708529639');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Athletic Fitness Equipment', 'Fitness & Gym', 'Ruta 9 Km 35', '1144440000', '30621478539');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Babolat & Head Distribuidora', 'Raquetas & Paletas', 'Av. Mitre 1800', '1144441111', '30598741259');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES ('Star Nutrition Lab', 'Suplementos', 'Av. Belgrano 1100', '1144442222', '30714589629');
--SELECT * FROM Proveedor;


-- Metodos de pago
INSERT INTO Metodo_pago (tipo_metodo) VALUES ('Efectivo');
INSERT INTO Metodo_pago (tipo_metodo) VALUES ('Tarjeta de Crédito');
INSERT INTO Metodo_pago (tipo_metodo) VALUES ('Tarjeta de Débito');
INSERT INTO Metodo_pago (tipo_metodo) VALUES ('Transferencia Bancaria');
INSERT INTO Metodo_pago (tipo_metodo) VALUES ('Billetera Virtual');
-- SELECT * FROM Metodo_pago;


-- Compra
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-09-15', 675000.00, 3500.00, 1);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-09-20', 665000.00, 4200.00, 2);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-10-05', 105000.00, 2800.00, 3);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-10-18', 117000.00, 5000.00, 4);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-11-02', 50000.00, 3000.00, 5);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-11-12', 267000.00, 2500.00, 6);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-12-22', 20000.00, 4000.00, 7);
INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2025-12-29', 178500.00, 3200.00, 8);
-- SELECT * FROM Compra;


-- Productos
-- ALTER TABLE Producto ALTER COLUMN nombre_producto VARCHAR(80) NOT NULL;
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Zapatillas Nike Pro-Speed', 45000.00, 15, 60800.00, 1);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Remera Térmica Warm Adidas', 8500.00, 20, 11500.00, 2);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Musculosa Cold Adidas', 4500.00, 30, 6000.00, 2);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Top Deportivo protector Adidas', 7000.00, 30, 9500.00, 2);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Pantalón Essential Adidas', 15000.00, 10, 20300.00, 2);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mochila Under', 3500.00, 10, 4800.00, 3);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Botella térmica Pro', 2800.00, 25, 3800.00, 3);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Pelota Futbol 5', 5500.00, 10, 7500.00, 4);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Pelota básquet N6', 6200.00, 10, 8400.00, 4);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Guantes boxeo 12 oz Everlast', 8000.00, 5, 10800.00, 5);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Protector bucal simple Everlast', 1000.00, 10, 1350.00, 5);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mancuernas 5Kg', 2500.00, 30, 3400.00, 6);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mancuernas 8Kg', 2900.00, 30, 3900.00, 6);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mancuernas 10Kg', 3500.00, 30, 4700.00, 6);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Paleta Padel Hibrida', 2000.00, 10, 2700.00, 7);

INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Proteina Whey Concentrado', 5300.00, 15, 7100.00, 8);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Proteina Isopure', 4300.00, 15, 5800.00, 8);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Creatina', 2300.00, 15, 3100.00, 8);
-- SELECT * FROM Producto;


-- Detalle de Compra
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (1, 1, 45000.00, 15);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (2, 2, 8500.00, 20);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (2, 3, 4500.00, 30);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (2, 4, 7000.00, 30);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (2, 5, 15000.00, 10);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (3, 6, 3500.00, 10);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (3, 7, 2800.00, 25);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (4, 8, 5500.00, 10);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (4, 9, 6200.00, 10);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (5, 10, 8000.00, 5);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (5, 11, 1000.00, 10);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (6, 12, 2500.00, 30);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (6, 13, 2900.00, 30);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (6, 14, 3500.00, 30);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (7, 15, 2000.00, 10);

INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (8, 16, 5300.00, 15);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (8, 17, 4300.00, 15);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad) 
VALUES (8, 18, 2300.00, 15);
-- SELECT * FROM Detalle_de_compra;


-- Venta
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-01-10', 60800.00, 0.00, 60800.00, 1, 5);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-01-15', 31800.00, 3180.00, 28620.00, 2, 1);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-01-20', 8600.00, 0.00, 8600.00, 3, 2);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-02-02', 15000.00, 0.00, 15000.00, 4, 3);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-02-14', 12150.00, 607.50, 11542.50, 5, 4);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-02-25', 7300.00, 0.00, 7300.00, 1, 5);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-03-01', 2700.00, 270.00, 2430.00, 2, 1);
INSERT INTO Venta (fecha_venta, subtotal, aplicable, precio_total, cod_cliente, cod_metodo) 
VALUES ('2026-03-10', 10200.00, 0.00, 10200.00, 3, 3);
-- SELECT * FROM Venta;


-- Detalle Venta
INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (1, 1, 60800.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (2, 2, 11500.00, 1);
INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (2, 5, 20300.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (3, 6, 4800.00, 1);
INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (3, 7, 3800.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (4, 8, 7500.00, 2);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (5, 10, 10800.00, 1);
INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (5, 11, 1350.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (6, 12, 3400.00, 1);
INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (6, 13, 3900.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (7, 15, 2700.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (8, 16, 7100.00, 1);

INSERT INTO Detalle_de_venta (cod_venta, cod_producto, precio_unitario, cantidad) 
VALUES (8, 18, 3100.00, 1);
-- SELECT * FROM Detalle_de_venta
