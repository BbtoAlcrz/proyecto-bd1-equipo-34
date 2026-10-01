
CREATE TABLE Oferta
(
  cod_oferta INT IDENTITY(1,1) NOT NULL,
  detalle_oferta VARCHAR(150) NOT NULL,
  fecha_lanzamiento DATE DEFAULT GETDATE() NOT NULL,
  fecha_finalizacion DATE NULL,
  CONSTRAINT PK_Oferta PRIMARY KEY (cod_oferta),
  CONSTRAINT CK_FECHA_OFERTA CHECK (fecha_lanzamiento <= fecha_finalizacion)
);

INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('10% OFF en Lácteos', '2026-10-01', '2026-10-15');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('2x1 en Bebidas', '2026-10-05', '2026-10-20');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('Envío Gratis', '2026-10-10', '2026-10-31');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('15% OFF pagando en Efectivo', '2026-10-01', '2026-11-01');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('Liquidación 50% OFF', '2026-11-01', '2026-11-30');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES('3x2 en Galletitas', '2026-10-15', '2026-10-25');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion)
VALUES('20% OFF Clientes VIP', '2026-10-01', '2026-12-31');
INSERT INTO Oferta (detalle_oferta, fecha_lanzamiento, fecha_finalizacion) 
VALUES ('Descuento de Cumpleaños', '2026-01-01', '2026-12-31');
SELECT * FROM Oferta;

CREATE TABLE Cliente
(
  cod_cliente INT IDENTITY (1,1) NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido_cliente VARCHAR(50) NOT NULL,
  dni INT NOT NULL,
  telefono VARCHAR (50) NOT NULL,
  correo_electronico VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Cliente PRIMARY KEY (cod_cliente),
  CONSTRAINT UQ_Cliente_Correo UNIQUE (correo_electronico),
  CONSTRAINT UQ_Cliente_Dni UNIQUE (dni)
);

INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni) 
VALUES('Juan', 'Pérez', '3794111111', 'juan.perez@email.com', '31111111');
INSERT INTO Cliente( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni) 
VALUES('Laura', 'Martínez', '3794222222', 'laura.m@email.com', '32222222');
INSERT INTO Cliente( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Carlos', 'López', '3794333333', 'carlos.lopez@email.com', '33333333');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Ana', 'García', '3794444444', 'ana.garcia@email.com', '34444444');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Pedro', 'Sánchez', '3794555555', 'pedro.s@email.com', '35555555');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Lucía', 'Fernández', '3794666666', 'lucia.f@email.com', '36666666');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('Diego', 'Romero', '3794777777', 'diego.romero@email.com', '37777777');
INSERT INTO Cliente ( nombre_cliente, apellido_cliente, telefono, correo_electronico, dni)
VALUES('María', 'Gómez', '3794123456', 'maria.gomez@email.com', '30123456');

SELECT * FROM Cliente;

CREATE TABLE Notificacion
(
  cod_cliente INT NOT NULL,
  cod_oferta INT NOT NULL,
  estado_notificacion VARCHAR (15) DEFAULT 'ENVIADA',
  CONSTRAINT PK_Notificacion PRIMARY KEY (cod_cliente, cod_oferta),
  CONSTRAINT FK_Notificacion_Cliente FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente),
  CONSTRAINT FK_Notificacion_Oferta FOREIGN KEY (cod_oferta) REFERENCES Oferta (cod_oferta),
  CONSTRAINT CK_Notificacion_Estado CHECK (estado_notificacion IN ('ENVIADA', 'LEIDA'))
);

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

SELECT * FROM Notificacion;


CREATE TABLE Categoria
(
  cod_categoria INT IDENTITY(1,1) NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  nombre_categoria VARCHAR(20) NOT NULL,
  CONSTRAINT PK_Categoria PRIMARY KEY (cod_categoria)
);

INSERT INTO Categoria (descripcion, nombre_categoria)  
VALUES ('Lácteos y quesos', 'Lácteos');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES ('Bebidas sin alcohol', 'Bebidas');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES ('Artículos de limpieza', 'Limpieza');
INSERT INTO Categoria (descripcion, nombre_categoria)
VALUES ('Panadería y galletas', 'Panadería');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES('Carnes rojas y blancas', 'Carnicería');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES ('Frutas y verduras frescas', 'Verdulería');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES ('Artículos de cuidado personal', 'Perfumería');
INSERT INTO Categoria (descripcion, nombre_categoria) 
VALUES('Golosinas y chocolates', 'Kiosco');
SELECT * FROM Categoria;


CREATE TABLE Proveedor
(
  cod_proveedor INT IDENTITY(1,1) NOT NULL,
  nombre_proveedor VARCHAR(50) NOT NULL,
  rubro VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  cuit VARCHAR(11) NOT NULL, -- Corregido de INT a VARCHAR(11)[cite: 4, 6]
  CONSTRAINT PK_Proveedor PRIMARY KEY (cod_proveedor),
  CONSTRAINT UQ_Proveedor_Cuit UNIQUE (cuit)
);

INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('La Serenísima', 'Lácteos', 'Av. San Martín 123', '1144445555', '30500001119');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Coca Cola', 'Bebidas', 'Av. Corrientes 456', '1144446666', '30500002229');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Unilever', 'Limpieza', 'Calle Falsa 123', '1144447777', '30500003339');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Arcor', 'Alimentos', 'Av. Córdoba 789', '1144448888', '30500004449');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Bimbo', 'Panadería', 'Ruta 9 Km 50', '1144449999', '30500005559');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Swift', 'Carnes', 'Av. Mitre 1000', '1144440000', '30500006669');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Molinos', 'Alimentos', 'Av. Belgrano 2000', '1144441111', '30500007779');
INSERT INTO Proveedor (nombre_proveedor, rubro, direccion, telefono, cuit) 
VALUES('Procter & Gamble', 'Perfumería', 'Av. Libertador 3000', '1144442222', '30500008889');
SELECT * FROM Proveedor;


CREATE TABLE Metodo_pago
(
  cod_metodo INT IDENTITY(1,1) NOT NULL,
  tipo_metodo VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Metodo_pago PRIMARY KEY (cod_metodo)
);

INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Efectivo');
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Tarjeta de Crédito'); 
INSERT INTO Metodo_pago (tipo_metodo)
VALUES('Tarjeta de Débito');
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Mercado Pago'); 
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Transferencia Bancaria');
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Modo'); 
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Cheque'); 
INSERT INTO Metodo_pago (tipo_metodo) 
VALUES('Criptomonedas');
SELECT * FROM Metodo_pago;



CREATE TABLE Compra
(
  cod_compra INT IDENTITY(1,1) NOT NULL,
  fecha_compra DATE NOT NULL,
  precio_total DECIMAL(10,2) NOT NULL,
  precio_envio DECIMAL(10,2) NOT NULL,
  cod_proveedor INT NOT NULL,
  CONSTRAINT PK_Compra PRIMARY KEY (cod_compra),
  CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (cod_proveedor) REFERENCES Proveedor(cod_proveedor)
);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-01-15', 255000.00, 3500.00, 1);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-01-20', 147000.00, 4200.00, 2);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-02-05', 260025.00, 2800.00, 3);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-02-18', 414000.00, 5000.00, 4);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-03-02', 99900.00, 3000.00, 5);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-03-12', 172000.00, 2500.00, 6);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-03-22', 182500.00, 4000.00, 7);

INSERT INTO Compra (fecha_compra, precio_total, precio_envio, cod_proveedor)
VALUES ('2026-04-01', 288000.00, 3200.00, 8);

SELECT * FROM Compra;

CREATE TABLE Producto
(
  cod_producto INT IDENTITY(1,1) NOT NULL,
  nombre_producto VARCHAR(20) NOT NULL,
  precio_compra DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL,
  precio_venta DECIMAL(10,2) NOT NULL,
  cod_categoria INT NOT NULL,
  CONSTRAINT PK_Producto PRIMARY KEY (cod_producto),
  CONSTRAINT FK_Producto_Categoria FOREIGN KEY (cod_categoria) REFERENCES Categoria(cod_categoria),
  CONSTRAINT CK_Producto_Stock CHECK (stock >= 0)
);


INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Pelota Futbol N5', 12500.00, 30, 21990.00, 1);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Zapatillas Running', 45000.00, 15, 78990.00, 2);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Remera Termica', 8500.00, 50, 14990.00, 3);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mancuerna 5kg', 6200.00, 20, 10500.00, 4);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Pala Padel Pro', 85000.00, 8, 139990.00, 5);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Botella Termica 1L', 4100.00, 40, 7800.00, 6);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Guantes Boxeo 12oz', 18500.00, 12, 31200.00, 7);
INSERT INTO Producto (nombre_producto, precio_compra, stock, precio_venta, cod_categoria)
VALUES ('Mat de Yoga 6mm', 5300.00, 25, 9600.00, 4);
SELECT * FROM Producto;


CREATE TABLE Detalle_de_compra
(
  cod_compra INT NOT NULL,
  cod_producto INT NOT NULL,
  precio_unitario DECIMAL (10,2) NOT NULL,
  cantidad INT NOT NULL,
  CONSTRAINT PK_Detalle_de_compra PRIMARY KEY (cod_compra, cod_producto),
  CONSTRAINT FK_Detalle_de_compra_Compra FOREIGN KEY (cod_compra) REFERENCES Compra (cod_compra),
  CONSTRAINT FK_Detalle_de_compra_Producto FOREIGN KEY (cod_producto) REFERENCES Producto (cod_producto),
  CONSTRAINT CK_Detalle_de_compra_Cantidad CHECK (cantidad > 0)
);


INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (1, 1, 8500.00, 30);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (1, 3, 5200.50, 50);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (2, 2, 9800.00, 15);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (2, 4, 3450.00, 120);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (3, 5, 9990.00, 10);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (3, 6, 2150.00, 80);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (4, 7, 7300.00, 25);
INSERT INTO Detalle_de_compra (cod_compra, cod_producto, precio_unitario, cantidad)
VALUES (4, 8, 4800.00, 60);
SELECT * FROM Detalle_de_compra;


CREATE TABLE Venta
(
  cod_venta INT IDENTITY (1,1) NOT NULL,
  fecha_venta DATE NOT NULL,
  precio_total DECIMAL (10,2) NOT NULL,
  subtotal DECIMAL (10,2) NOT NULL,
  aplicable DECIMAL (10,2) DEFAULT 0.00,
  cod_cliente INT NOT NULL,
  cod_metodo INT NOT NULL,
  CONSTRAINT PK_Venta PRIMARY KEY (cod_venta),
  CONSTRAINT FK_Venta_Cliente FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente),
  CONSTRAINT FK_Venta_Metodo FOREIGN KEY (cod_metodo) REFERENCES Metodo_pago (cod_metodo)
);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-10', 3600.00, 3600.00, 0.00, 1, 1);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES ('2026-09-11', 4400.00, 4400.00, 0.00, 2, 2);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-12', 1900.00, 1900.00, 0.00, 3, 3);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-13', 3600.00, 3600.00, 0.00, 4, 4);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-14', 13000.00, 13000.00, 0.00, 5, 5);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-15', 3000.00, 3000.00, 0.00, 6, 6);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-16', 7600.00, 7600.00, 0.00, 7, 7);

INSERT INTO Venta (fecha_venta, precio_total, subtotal, aplicable, cod_cliente, cod_metodo) 
VALUES('2026-09-17', 5000.00, 5000.00, 0.00, 8, 8);
SELECT * FROM Venta;

CREATE TABLE Detalle_de_venta
(
  cod_producto INT NOT NULL,
  cod_venta INT NOT NULL,
  precio_unitario DECIMAL (10,2) NOT NULL,
  cantidad INT NOT NULL,
  CONSTRAINT PK_Detalle_de_venta PRIMARY KEY (cod_producto, cod_venta),
  CONSTRAINT FK_Detalle_de_venta_Producto FOREIGN KEY (cod_producto) REFERENCES Producto (cod_producto),
  CONSTRAINT FK_Detalle_de_venta_Venta FOREIGN KEY (cod_venta) REFERENCES Venta (cod_venta),
  CONSTRAINT CK_Detalle_de_venta_Cantidad CHECK (cantidad > 0)
);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(1, 1, 1500.50, 2);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(2, 1, 800.00, 5);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(3, 2, 4500.00, 1);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(4, 3, 1200.00, 3);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(5, 3, 300.00, 10);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(6, 4, 950.00, 4);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(7, 5, 2100.00, 2);

INSERT INTO Detalle_de_venta (cod_producto, cod_venta, precio_unitario, cantidad) 
VALUES(8, 6, 750.25, 6);
SELECT * FROM Detalle_de_venta;
