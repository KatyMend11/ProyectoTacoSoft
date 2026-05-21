-- =============================================
-- El Sinaloense POS - Database Schema
-- =============================================

CREATE DATABASE ElSinaloensePOS;
GO

USE ElSinaloensePOS;
GO

-- =============================================
-- 1. SUCURSALES
-- =============================================
CREATE TABLE Sucursales (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Direccion NVARCHAR(200) NOT NULL,
    Ciudad NVARCHAR(50) NOT NULL,
    Telefono NVARCHAR(20) NOT NULL,
    Estatus BIT NOT NULL DEFAULT 1 -- 1=Activa, 0=Cerrada
);
GO

-- =============================================
-- 2. CATEGORIAS
-- =============================================
CREATE TABLE Categorias (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(200)
);
GO

-- =============================================
-- 3. PRODUCTOS
-- =============================================
CREATE TABLE Productos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(300),
    CategoriaId INT NOT NULL FOREIGN KEY REFERENCES Categorias(Id),
    Precio DECIMAL(10,2) NOT NULL,
    Costo DECIMAL(10,2) NOT NULL,
    Estatus BIT NOT NULL DEFAULT 1 -- 1=Disponible, 0=No disponible
);
GO

-- =============================================
-- 4. EMPLEADOS
-- =============================================
CREATE TABLE Empleados (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Puesto NVARCHAR(30) NOT NULL CHECK (Puesto IN ('cajero', 'cocinero', 'repartidor', 'gerente', 'mesero')),
    SucursalId INT NOT NULL FOREIGN KEY REFERENCES Sucursales(Id),
    SalarioQuincenal DECIMAL(10,2) NOT NULL,
    FechaIngreso DATE NOT NULL DEFAULT GETDATE(),
    Estatus BIT NOT NULL DEFAULT 1 -- 1=Activo, 0=Inactivo
);
GO

-- =============================================
-- 5. CLIENTES
-- =============================================
CREATE TABLE Clientes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100),
    SucursalId INT NULL FOREIGN KEY REFERENCES Sucursales(Id),
    Ciudad NVARCHAR(50),
    FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    Estatus BIT NOT NULL DEFAULT 1
);
GO

-- =============================================
-- 6. PEDIDOS
-- =============================================
CREATE TABLE Pedidos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SucursalId INT NOT NULL FOREIGN KEY REFERENCES Sucursales(Id),
    EmpleadoId INT NOT NULL FOREIGN KEY REFERENCES Empleados(Id),
    ClienteId INT NULL FOREIGN KEY REFERENCES Clientes(Id),
    PromocionId INT NULL FOREIGN KEY REFERENCES Promociones(Id),
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    TipoPedido NVARCHAR(20) NOT NULL CHECK (TipoPedido IN ('local', 'llevar', 'domicilio')),
    Estatus NVARCHAR(20) NOT NULL DEFAULT 'pendiente' CHECK (Estatus IN ('pendiente', 'preparando', 'listo', 'entregado', 'cancelado')),
    Total DECIMAL(10,2) NOT NULL DEFAULT 0
);
GO

-- =============================================
-- 7. DETALLE_PEDIDO
-- =============================================
CREATE TABLE DetallePedido (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PedidoId INT NOT NULL FOREIGN KEY REFERENCES Pedidos(Id),
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL
);
GO

-- =============================================
-- 8. PROMOCIONES
-- =============================================
CREATE TABLE Promociones (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(300),
    PorcentajeDescuento DECIMAL(5,2) NOT NULL CHECK (PorcentajeDescuento BETWEEN 0 AND 100),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Estatus BIT NOT NULL DEFAULT 1,
    CHECK (FechaFin >= FechaInicio)
);
GO

-- =============================================
-- 9. PROMOCION_PRODUCTOS (tabla puente)
-- =============================================
CREATE TABLE PromocionProductos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PromocionId INT NOT NULL FOREIGN KEY REFERENCES Promociones(Id),
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    UNIQUE (PromocionId, ProductoId)
);
GO

-- Indexes for performance
CREATE INDEX IX_Pedidos_Fecha ON Pedidos(FechaHora);
CREATE INDEX IX_Pedidos_Estatus ON Pedidos(Estatus);
CREATE INDEX IX_Pedidos_Sucursal ON Pedidos(SucursalId);
CREATE INDEX IX_DetallePedido_Pedido ON DetallePedido(PedidoId);
CREATE INDEX IX_DetallePedido_Producto ON DetallePedido(ProductoId);
CREATE INDEX IX_Empleados_Sucursal ON Empleados(SucursalId);
CREATE INDEX IX_Productos_Categoria ON Productos(CategoriaId);
GO
