USE ElSinaloensePOS;
GO

INSERT INTO Sucursales (Nombre, Direccion, Ciudad, Telefono, Estatus) VALUES
('El Sinaloense - Culiacan', 'Blvd. Pedro Infante #1250, Col. Centro', 'Culiacan', '667-123-4567', 1),
('El Sinaloense - Mazatlan', 'Av. Camaron Sábalo #890, Zona Dorada', 'Mazatlan', '669-234-5678', 1),
('El Sinaloense - Los Mochis', 'Blvd. Rosendo G. Castro #456, Centro', 'Los Mochis', '668-345-6789', 1),
('El Sinaloense - Guasave', 'Blvd. Josefa Ortiz de Dominguez #321', 'Guasave', '671-456-7890', 1);
GO

INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Tacos', 'Tacos de todo tipo con tortilla de maiz o harina'),
('Burritos', 'Burritos rellenos con ingredientes variados'),
('Bebidas', 'Refrescos, aguas frescas y bebidas'),
('Postres', 'Postres tradicionales mexicanos'),
('Extras', 'Guacamole, salsas, quesadillas y complementos');
GO


INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus) VALUES
('Taco de Asada', 'Taco de carne asada con cebolla y cilantro', 1, 35.00, 12.00, 1),
('Taco de Pastor', 'Taco de carne al pastor con pina', 1, 30.00, 10.00, 1),
('Taco de Carnitas', 'Taco de carnitas estilo Michoacan', 1, 35.00, 11.00, 1),
('Taco de Chorizo', 'Taco de chorizo casero', 1, 30.00, 9.00, 1),
('Taco de Camaron', 'Taco de camaron empanizado', 1, 55.00, 20.00, 1);

INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus) VALUES
('Burrito de Asada', 'Burrito grande de carne asada con frijoles', 2, 85.00, 28.00, 1),
('Burrito de Pastor', 'Burrito de carne al pastor con guacamole', 2, 80.00, 25.00, 1),
('Burrito Vegetariano', 'Burrito de nopales, champinones y queso', 2, 75.00, 22.00, 1),
('Burrito de Camaron', 'Burrito de camaron con pico de gallo', 2, 110.00, 40.00, 1);

INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus) VALUES
('Agua de Horchata', 'Agua fresca de horchata 500ml', 3, 30.00, 8.00, 1),
('Agua de Jamaica', 'Agua fresca de jamaica 500ml', 3, 30.00, 8.00, 1),
('Refresco', 'Coca-Cola, Sprite o Fanta 600ml', 3, 25.00, 12.00, 1),
('Cerveza', 'Cerveza nacional 355ml', 3, 45.00, 20.00, 1),
('Jarrito', 'Refresco de sabores mexicanos 355ml', 3, 20.00, 8.00, 1);

INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus) VALUES
('Flan Napolitano', 'Flan casero de vainilla', 4, 40.00, 12.00, 1),
('Churros con Chocolate', '4 churros con salsa de chocolate', 4, 35.00, 10.00, 1),
('Tres Leches', 'Rebanada de pastel tres leches', 4, 50.00, 18.00, 1);

INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus) VALUES
('Guacamole', 'Guacamole fresco con totopos', 5, 55.00, 15.00, 1),
('Quesadilla', 'Quesadilla de queso Oaxaqueno', 5, 40.00, 12.00, 1),
('Elote', 'Elote preparado con mayonesa y queso', 5, 35.00, 10.00, 1),
('Papas a la Francesa', 'Porcion de papas fritas', 5, 30.00, 8.00, 1);
GO

INSERT INTO Empleados (Nombre, Telefono, Puesto, SucursalId, SalarioQuincenal, FechaIngreso, Estatus) VALUES
('Maria Elena Rodriguez', '667-111-2222', 'gerente', 1, 8500.00, '2023-01-15', 1),
('Carlos Mendoza Lopez', '667-333-4444', 'cajero', 1, 5500.00, '2023-03-20', 1),
('Jose Luis Ramirez', '667-555-6666', 'cocinero', 1, 6000.00, '2023-02-10', 1),
('Ana Patricia Vega', '667-777-8888', 'repartidor', 1, 5000.00, '2023-06-01', 1),
('Luis Fernando Castro', '667-999-0001', 'mesero', 1, 5200.00, '2023-08-15', 1);

INSERT INTO Empleados (Nombre, Telefono, Puesto, SucursalId, SalarioQuincenal, FechaIngreso, Estatus) VALUES
('Roberto Sanchez Diaz', '669-111-2222', 'gerente', 2, 8500.00, '2023-01-20', 1),
('Laura Gutierrez Ruiz', '669-333-4444', 'cajero', 2, 5500.00, '2023-04-15', 1),
('Fernando Torres Medina', '669-555-6666', 'cocinero', 2, 6000.00, '2023-03-01', 1),
('Daniela Ruiz Campos', '669-777-0002', 'mesero', 2, 5200.00, '2023-09-01', 1);

INSERT INTO Empleados (Nombre, Telefono, Puesto, SucursalId, SalarioQuincenal, FechaIngreso, Estatus) VALUES
('Patricia Navarro Cruz', '668-111-2222', 'gerente', 3, 8500.00, '2023-02-01', 1),
('Diego Hernandez Flores', '668-333-4444', 'cajero', 3, 5500.00, '2023-05-10', 1),
('Sofia Castillo Ortiz', '668-555-6666', 'cocinero', 3, 6000.00, '2023-04-20', 1),
('Miguel Angel Duarte', '668-777-8888', 'repartidor', 3, 5000.00, '2023-07-01', 1),
('Andrea Luna Paredes', '668-999-0003', 'mesero', 3, 5200.00, '2023-10-01', 1);

INSERT INTO Empleados (Nombre, Telefono, Puesto, SucursalId, SalarioQuincenal, FechaIngreso, Estatus) VALUES
('Gabriela Morales Silva', '671-111-2222', 'gerente', 4, 8500.00, '2023-03-01', 1),
('Ricardo Pena Vargas', '671-333-4444', 'cajero', 4, 5500.00, '2023-06-15', 1),
('Luis Alberto Rios', '671-555-6666', 'cocinero', 4, 6000.00, '2023-05-01', 1),
('Valentina Orozco Mejia', '671-777-0004', 'mesero', 4, 5200.00, '2023-11-01', 1);
GO


INSERT INTO Clientes (Nombre, Telefono, Correo, SucursalId, Ciudad, FechaRegistro, Estatus) VALUES
('Juan Manuel Ochoa', '667-999-1111', 'juan.ochoa@email.com', 1, 'Culiacan', '2023-06-01', 1),
('Rosa Maria Beltran', '669-999-2222', 'rosa.beltran@email.com', 2, 'Mazatlan', '2023-06-15', 1),
('Francisco Javier Leyva', '668-999-3333', 'francisco.leyva@email.com', 3, 'Los Mochis', '2023-07-01', 1),
('Carmen Alicia Valenzuela', '671-999-4444', 'carmen.valenzuela@email.com', 4, 'Guasave', '2023-07-15', 1),
('Pedro Antonio Gastelum', '667-999-5555', 'pedro.gastelum@email.com', 1, 'Culiacan', '2023-08-01', 1),
('Maria Guadalupe Felix', '669-999-6666', 'maria.felix@email.com', 2, 'Mazatlan', '2023-08-15', 1),
('Alejandro Paez', '668-999-7777', 'alejandro.paez@email.com', 3, 'Los Mochis', '2023-09-01', 1),
('Veronica Soto', '671-999-8888', 'veronica.soto@email.com', 4, 'Guasave', '2023-09-15', 1),
('Hector Manuel Armenta', '667-999-9999', 'hector.armenta@email.com', 1, 'Culiacan', '2023-10-01', 1),
('Diana Laura Escobar', '669-999-0000', 'diana.escobar@email.com', 2, 'Mazatlan', '2023-10-15', 1);
GO


INSERT INTO Promociones (Nombre, Descripcion, PorcentajeDescuento, FechaInicio, FechaFin, Estatus) VALUES
('Martes de Tacos', '20% de descuento en todos los tacos los martes', 20.00, '2024-01-01', '2024-12-31', 1),
('Verano Mazatlan', '15% de descuento en bebidas y postres', 15.00, '2024-06-01', '2024-08-31', 1),
('Promo Inauguracion', '25% de descuento en todo el menu', 25.00, '2023-01-01', '2023-03-31', 0);

INSERT INTO PromocionProductos (PromocionId, ProductoId) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5);

INSERT INTO PromocionProductos (PromocionId, ProductoId) VALUES
(2, 10), (2, 11), (2, 12), (2, 13), (2, 14),
(2, 15), (2, 16), (2, 17);

INSERT INTO PromocionProductos (PromocionId, ProductoId) VALUES
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(3, 6), (3, 7), (3, 8), (3, 9),
(3, 10), (3, 11), (3, 12), (3, 13), (3, 14),
(3, 15), (3, 16), (3, 17), (3, 18), (3, 19), (3, 20);
GO

INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, FechaHora, TipoPedido, Estatus, Total) VALUES
(1, 2, 1, '2024-10-01 12:30:00', 'local', 'entregado', 0),
(1, 2, NULL, '2024-10-01 13:15:00', 'llevar', 'entregado', 0),
(1, 2, 5, '2024-10-02 14:00:00', 'local', 'entregado', 0),
(1, 2, NULL, '2024-10-03 19:30:00', 'domicilio', 'entregado', 0),
(1, 2, 9, '2024-10-05 20:00:00', 'local', 'entregado', 0),
(1, 2, 1, '2024-10-08 12:00:00', 'llevar', 'entregado', 0),
(1, 2, NULL, '2024-10-10 13:30:00', 'local', 'entregado', 0),
(1, 2, 5, '2024-10-12 14:45:00', 'domicilio', 'entregado', 0);

INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, FechaHora, TipoPedido, Estatus, Total) VALUES
(2, 5, 2, '2024-10-01 13:00:00', 'local', 'entregado', 0),
(2, 5, NULL, '2024-10-02 12:30:00', 'llevar', 'entregado', 0),
(2, 5, 6, '2024-10-03 14:00:00', 'local', 'entregado', 0),
(2, 5, 10, '2024-10-05 19:00:00', 'domicilio', 'entregado', 0),
(2, 5, NULL, '2024-10-07 20:30:00', 'local', 'entregado', 0),
(2, 5, 2, '2024-10-09 12:15:00', 'llevar', 'entregado', 0),
(2, 5, 6, '2024-10-11 13:00:00', 'local', 'entregado', 0),
(2, 5, NULL, '2024-10-13 14:30:00', 'domicilio', 'entregado', 0);

INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, FechaHora, TipoPedido, Estatus, Total) VALUES
(3, 9, 3, '2024-10-01 12:00:00', 'local', 'entregado', 0),
(3, 9, NULL, '2024-10-02 13:30:00', 'llevar', 'entregado', 0),
(3, 9, 7, '2024-10-04 14:00:00', 'local', 'entregado', 0),
(3, 9, NULL, '2024-10-06 19:00:00', 'domicilio', 'entregado', 0),
(3, 9, 3, '2024-10-08 20:00:00', 'local', 'entregado', 0),
(3, 9, 7, '2024-10-10 12:30:00', 'llevar', 'entregado', 0),
(3, 9, NULL, '2024-10-12 13:00:00', 'local', 'entregado', 0),
(3, 9, 3, '2024-10-14 14:00:00', 'domicilio', 'entregado', 0);

INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, FechaHora, TipoPedido, Estatus, Total) VALUES
(4, 13, 4, '2024-10-01 12:30:00', 'local', 'entregado', 0),
(4, 13, NULL, '2024-10-03 13:00:00', 'llevar', 'entregado', 0),
(4, 13, 8, '2024-10-05 14:30:00', 'local', 'entregado', 0),
(4, 13, NULL, '2024-10-07 19:00:00', 'domicilio', 'entregado', 0),
(4, 13, 4, '2024-10-09 20:00:00', 'local', 'entregado', 0),
(4, 13, 8, '2024-10-11 12:00:00', 'llevar', 'entregado', 0),
(4, 13, NULL, '2024-10-13 13:30:00', 'local', 'entregado', 0),
(4, 13, 4, '2024-10-15 14:00:00', 'domicilio', 'entregado', 0);
GO


INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(1, 1, 2, 35.00, 70.00), (1, 2, 1, 30.00, 30.00), (1, 10, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 130.00 WHERE Id = 1;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(2, 6, 1, 85.00, 85.00), (2, 7, 1, 80.00, 80.00), (2, 13, 2, 45.00, 90.00);
UPDATE Pedidos SET Total = 255.00 WHERE Id = 2;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(3, 2, 5, 30.00, 150.00), (3, 18, 1, 55.00, 55.00);
UPDATE Pedidos SET Total = 205.00 WHERE Id = 3;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(4, 9, 1, 110.00, 110.00), (4, 15, 1, 40.00, 40.00);
UPDATE Pedidos SET Total = 150.00 WHERE Id = 4;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(5, 5, 3, 55.00, 165.00), (5, 14, 2, 20.00, 40.00);
UPDATE Pedidos SET Total = 205.00 WHERE Id = 5;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(6, 6, 2, 85.00, 170.00), (6, 17, 1, 50.00, 50.00);
UPDATE Pedidos SET Total = 220.00 WHERE Id = 6;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(7, 1, 2, 35.00, 70.00), (7, 3, 2, 35.00, 70.00), (7, 19, 1, 35.00, 35.00);
UPDATE Pedidos SET Total = 175.00 WHERE Id = 7;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(8, 8, 1, 75.00, 75.00), (8, 11, 1, 30.00, 30.00), (8, 16, 1, 35.00, 35.00);
UPDATE Pedidos SET Total = 140.00 WHERE Id = 8;


INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(9, 1, 3, 35.00, 105.00), (9, 10, 2, 30.00, 60.00);
UPDATE Pedidos SET Total = 165.00 WHERE Id = 9;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(10, 7, 2, 80.00, 160.00), (10, 18, 1, 55.00, 55.00);
UPDATE Pedidos SET Total = 215.00 WHERE Id = 10;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(11, 3, 4, 35.00, 140.00), (11, 13, 1, 45.00, 45.00), (11, 15, 1, 40.00, 40.00);
UPDATE Pedidos SET Total = 225.00 WHERE Id = 11;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(12, 5, 2, 55.00, 110.00), (12, 9, 1, 110.00, 110.00), (12, 12, 1, 25.00, 25.00);
UPDATE Pedidos SET Total = 245.00 WHERE Id = 12;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(13, 2, 5, 30.00, 150.00), (13, 20, 2, 30.00, 60.00), (13, 14, 2, 20.00, 40.00);
UPDATE Pedidos SET Total = 250.00 WHERE Id = 13;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(14, 6, 1, 85.00, 85.00), (14, 19, 1, 40.00, 40.00), (14, 11, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 155.00 WHERE Id = 14;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(15, 4, 3, 30.00, 90.00), (15, 19, 1, 35.00, 35.00), (15, 10, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 155.00 WHERE Id = 15;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(16, 8, 2, 75.00, 150.00), (16, 17, 2, 50.00, 100.00);
UPDATE Pedidos SET Total = 250.00 WHERE Id = 16;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(17, 1, 4, 35.00, 140.00), (17, 18, 1, 55.00, 55.00), (17, 13, 1, 45.00, 45.00);
UPDATE Pedidos SET Total = 240.00 WHERE Id = 17;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(18, 9, 2, 110.00, 220.00), (18, 12, 1, 25.00, 25.00);
UPDATE Pedidos SET Total = 245.00 WHERE Id = 18;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(19, 5, 3, 55.00, 165.00), (19, 16, 1, 35.00, 35.00), (19, 10, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 230.00 WHERE Id = 19;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(20, 1, 2, 35.00, 70.00), (20, 3, 2, 35.00, 70.00), (20, 4, 1, 30.00, 30.00), (20, 20, 2, 30.00, 60.00);
UPDATE Pedidos SET Total = 230.00 WHERE Id = 20;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(21, 6, 1, 85.00, 85.00), (21, 7, 1, 80.00, 80.00), (21, 14, 1, 20.00, 20.00);
UPDATE Pedidos SET Total = 185.00 WHERE Id = 21;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(22, 3, 2, 35.00, 70.00), (22, 19, 1, 40.00, 40.00), (22, 11, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 140.00 WHERE Id = 22;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(23, 2, 3, 30.00, 90.00), (23, 19, 1, 35.00, 35.00), (23, 13, 1, 45.00, 45.00);
UPDATE Pedidos SET Total = 170.00 WHERE Id = 23;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(24, 9, 1, 110.00, 110.00), (24, 15, 1, 40.00, 40.00), (24, 12, 1, 25.00, 25.00);
UPDATE Pedidos SET Total = 175.00 WHERE Id = 24;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(25, 1, 3, 35.00, 105.00), (25, 10, 1, 30.00, 30.00), (25, 16, 1, 35.00, 35.00);
UPDATE Pedidos SET Total = 170.00 WHERE Id = 25;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(26, 6, 2, 85.00, 170.00), (26, 13, 2, 45.00, 90.00);
UPDATE Pedidos SET Total = 260.00 WHERE Id = 26;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(27, 3, 4, 35.00, 140.00), (27, 18, 1, 55.00, 55.00), (27, 11, 1, 30.00, 30.00);
UPDATE Pedidos SET Total = 225.00 WHERE Id = 27;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(28, 5, 3, 55.00, 165.00), (28, 17, 1, 50.00, 50.00), (28, 14, 1, 20.00, 20.00);
UPDATE Pedidos SET Total = 235.00 WHERE Id = 28;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(29, 9, 1, 110.00, 110.00), (29, 19, 1, 40.00, 40.00), (29, 12, 1, 25.00, 25.00);
UPDATE Pedidos SET Total = 175.00 WHERE Id = 29;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(30, 2, 5, 30.00, 150.00), (30, 19, 2, 35.00, 70.00), (30, 10, 2, 30.00, 60.00);
UPDATE Pedidos SET Total = 280.00 WHERE Id = 30;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(31, 8, 2, 75.00, 150.00), (31, 15, 1, 40.00, 40.00);
UPDATE Pedidos SET Total = 190.00 WHERE Id = 31;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(32, 4, 3, 30.00, 90.00), (32, 20, 1, 30.00, 30.00), (32, 13, 1, 45.00, 45.00);
UPDATE Pedidos SET Total = 165.00 WHERE Id = 32;
GO

INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, FechaHora, TipoPedido, Estatus, Total) VALUES
(1, 2, 1, GETDATE(), 'local', 'pendiente', 0),
(2, 5, 2, GETDATE(), 'llevar', 'preparando', 0),
(3, 9, 3, GETDATE(), 'domicilio', 'listo', 0),
(4, 13, 4, DATEADD(HOUR, -2, GETDATE()), 'local', 'pendiente', 0);

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(33, 1, 3, 35.00, 105.00), (33, 10, 2, 30.00, 60.00);
UPDATE Pedidos SET Total = 165.00 WHERE Id = 33;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(34, 6, 1, 85.00, 85.00), (34, 7, 1, 80.00, 80.00);
UPDATE Pedidos SET Total = 165.00 WHERE Id = 34;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(35, 5, 2, 55.00, 110.00), (35, 13, 1, 45.00, 45.00);
UPDATE Pedidos SET Total = 155.00 WHERE Id = 35;

INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal) VALUES
(36, 9, 1, 110.00, 110.00), (36, 15, 1, 40.00, 40.00);
UPDATE Pedidos SET Total = 150.00 WHERE Id = 36;
GO
