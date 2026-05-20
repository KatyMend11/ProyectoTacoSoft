USE [master]
GO

CREATE DATABASE [TacoSoft]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TacoSoft', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TacoSoft.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TacoSoft_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TacoSoft_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TacoSoft] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TacoSoft].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TacoSoft] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TacoSoft] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TacoSoft] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TacoSoft] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TacoSoft] SET ARITHABORT OFF 
GO
ALTER DATABASE [TacoSoft] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TacoSoft] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TacoSoft] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TacoSoft] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TacoSoft] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TacoSoft] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TacoSoft] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TacoSoft] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TacoSoft] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TacoSoft] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TacoSoft] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TacoSoft] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TacoSoft] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TacoSoft] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TacoSoft] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TacoSoft] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TacoSoft] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TacoSoft] SET RECOVERY FULL 
GO
ALTER DATABASE [TacoSoft] SET  MULTI_USER 
GO
ALTER DATABASE [TacoSoft] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TacoSoft] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TacoSoft] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TacoSoft] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TacoSoft] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TacoSoft] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TacoSoft', N'ON'
GO
ALTER DATABASE [TacoSoft] SET QUERY_STORE = ON
GO
ALTER DATABASE [TacoSoft] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TacoSoft]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[CategoriaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[Activa] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Telefono] [varchar](20) NULL,
	[CorreoElectronico] [varchar](150) NULL,
	[Ciudad] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePedido](
	[DetalleID] [int] IDENTITY(1,1) NOT NULL,
	[PedidoID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[Subtotal]  AS ([Cantidad]*[PrecioUnitario]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[DetalleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[EmpleadoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreCompleto] [varchar](200) NOT NULL,
	[Telefono] [varchar](20) NOT NULL,
	[Puesto] [varchar](20) NOT NULL,
	[SucursalID] [int] NOT NULL,
	[SalarioQuincenal] [decimal](10, 2) NOT NULL,
	[FechaIngreso] [date] NOT NULL,
	[Estatus] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[PedidoID] [int] IDENTITY(1,1) NOT NULL,
	[SucursalID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[ClienteID] [int] NULL,
	[FechaHora] [datetime] NOT NULL,
	[TipoPedido] [varchar](15) NOT NULL,
	[Estatus] [varchar](15) NOT NULL,
	[Subtotal] [decimal](10, 2) NOT NULL,
	[PromocionID] [int] NULL,
	[IVA] [decimal](10, 2) NOT NULL,
	[Total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PedidoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[CategoriaID] [int] NOT NULL,
	[PrecioVenta] [decimal](10, 2) NOT NULL,
	[CostoPreparacion] [decimal](10, 2) NOT NULL,
	[Estatus] [varchar](15) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promociones]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promociones](
	[PromocionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[PorcentajeDescuento] [decimal](5, 2) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Activa] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PromocionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromocionProducto]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromocionProducto](
	[PromocionID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
 CONSTRAINT [PK_PromocionProducto] PRIMARY KEY CLUSTERED 
(
	[PromocionID] ASC,
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 18/05/2026 12:48:06 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sucursales](
	[SucursalID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Direccion] [varchar](255) NOT NULL,
	[Ciudad] [varchar](100) NOT NULL,
	[Telefono] [varchar](20) NOT NULL,
	[Estatus] [varchar](10) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SucursalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([CategoriaID], [Nombre], [Descripcion], [Activa]) VALUES (1, N'Tacos', N'Tacos de distintos guisos y cortes de carne', 1)
INSERT [dbo].[Categorias] ([CategoriaID], [Nombre], [Descripcion], [Activa]) VALUES (2, N'Burritos', N'Burritos de harina rellenos al gusto', 1)
INSERT [dbo].[Categorias] ([CategoriaID], [Nombre], [Descripcion], [Activa]) VALUES (3, N'Bebidas', N'Aguas frescas, refrescos y bebidas calientes', 1)
INSERT [dbo].[Categorias] ([CategoriaID], [Nombre], [Descripcion], [Activa]) VALUES (4, N'Postres', N'Dulces tipicos y postres artesanales sinaloenses', 1)
INSERT [dbo].[Categorias] ([CategoriaID], [Nombre], [Descripcion], [Activa]) VALUES (5, N'Extras', N'Salsas, guarniciones y complementos del menu', 1)
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (1, N'Jorge Enrique Parra Molina', N'667-511-2233', N'jorge.parra@gmail.com', N'Culiacan', CAST(N'2024-01-15T10:30:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (2, N'Daniela Ximena Rojo Gutierrez', N'667-522-3344', N'daniela.rojo@hotmail.com', N'Culiacan', CAST(N'2024-02-20T14:00:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (3, N'Miguel Angel Torres Bernal', N'669-533-4455', N'miguel.torres@gmail.com', N'Mazatlan', CAST(N'2024-03-05T09:15:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (4, N'Sandra Patricia Lugo Inzunza', N'669-544-5566', N'sandrita.lugo@yahoo.com', N'Mazatlan', CAST(N'2024-04-12T16:45:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (5, N'Rafael Arturo Leal Morales', N'668-555-6677', N'rafael.leal@gmail.com', N'Los Mochis', CAST(N'2024-05-01T11:00:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (6, N'Veronica Salome Meza Canizales', N'668-566-7788', N'vero.meza@gmail.com', N'Los Mochis', CAST(N'2024-06-18T13:30:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (7, N'Oscar Ivan Padilla Acosta', N'687-577-8899', N'oscar.padilla@hotmail.com', N'Guasave', CAST(N'2024-07-22T08:00:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (8, N'Karla Denisse Rios Aramburo', N'687-588-9900', N'karla.rios@gmail.com', N'Guasave', CAST(N'2024-08-30T17:20:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (9, N'Ernesto Gabriel Palma Celis', N'667-599-0011', N'ernesto.palma@gmail.com', N'Culiacan', CAST(N'2024-09-10T12:00:00.000' AS DateTime), 1)
INSERT [dbo].[Clientes] ([ClienteID], [Nombre], [Telefono], [CorreoElectronico], [Ciudad], [FechaRegistro], [Activo]) VALUES (10, N'Alejandra Nohemi Quiroz Nieto', N'669-500-1122', N'ale.quiroz@hotmail.com', N'Mazatlan', CAST(N'2024-10-05T15:45:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallePedido] ON 

INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (1, 1, 1, 3, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (2, 1, 11, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (3, 1, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (4, 2, 6, 2, CAST(55.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (5, 2, 12, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (6, 2, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (7, 3, 2, 3, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (8, 3, 14, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (9, 3, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (10, 4, 7, 2, CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (11, 4, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (12, 4, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (13, 5, 5, 3, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (14, 5, 15, 1, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (15, 5, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (16, 6, 3, 3, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (17, 6, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (18, 6, 18, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (19, 7, 10, 2, CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (20, 7, 12, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (21, 7, 16, 1, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (22, 8, 4, 3, CAST(23.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (23, 8, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (24, 9, 9, 2, CAST(58.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (25, 9, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (26, 9, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (27, 10, 1, 4, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (28, 10, 14, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (29, 10, 17, 1, CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (30, 11, 6, 2, CAST(55.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (31, 11, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (32, 11, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (33, 11, 18, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (34, 12, 2, 3, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (35, 12, 14, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (36, 12, 16, 1, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (37, 13, 8, 2, CAST(40.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (38, 13, 11, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (39, 13, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (40, 14, 3, 3, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (41, 14, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (42, 14, 12, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (43, 15, 10, 2, CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (44, 15, 11, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (45, 15, 17, 1, CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (46, 16, 5, 3, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (47, 16, 14, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (48, 16, 15, 1, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (49, 17, 7, 2, CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (50, 17, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (51, 17, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (52, 17, 18, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (53, 18, 1, 3, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (54, 18, 16, 1, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (55, 18, 12, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (56, 19, 4, 3, CAST(23.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (57, 19, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (58, 19, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (59, 20, 9, 2, CAST(58.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (60, 20, 15, 1, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (61, 20, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (62, 21, 3, 2, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (63, 21, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (64, 22, 10, 2, CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (65, 22, 14, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (66, 22, 17, 1, CAST(22.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (67, 23, 2, 3, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (68, 23, 14, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (69, 23, 18, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (70, 24, 4, 3, CAST(23.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (71, 24, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (72, 25, 1, 3, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (73, 25, 11, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (74, 25, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (75, 26, 6, 1, CAST(55.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (76, 26, 15, 1, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (77, 26, 12, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (78, 27, 7, 2, CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (79, 27, 19, 1, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (80, 27, 13, 1, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (81, 28, 3, 2, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (82, 28, 12, 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (83, 29, 10, 2, CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (84, 29, 14, 2, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (85, 29, 16, 1, CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (86, 29, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (87, 30, 5, 3, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (88, 30, 15, 1, CAST(30.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (89, 30, 18, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (90, 30, 20, 1, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (91, 31, 1, 4, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (92, 31, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (93, 32, 20, 5, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (94, 33, 1, 4, CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (95, 33, 6, 1, CAST(55.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallePedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Empleados] ON 

INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (1, N'Carlos Alberto Lizarraga Perez', N'667-100-1001', N'gerente', 1, CAST(9000.00 AS Decimal(10, 2)), CAST(N'2020-03-15' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (2, N'Maria Elena Valenzuela Ruiz', N'667-100-1002', N'cajero', 1, CAST(5500.00 AS Decimal(10, 2)), CAST(N'2021-06-01' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (3, N'Jose Luis Zazueta Ibarra', N'667-100-1003', N'cocinero', 1, CAST(6000.00 AS Decimal(10, 2)), CAST(N'2021-07-10' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (4, N'Ana Belen Cota Soto', N'667-100-1004', N'repartidor', 1, CAST(5000.00 AS Decimal(10, 2)), CAST(N'2022-01-20' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (5, N'Rosa Isela Osuna Medina', N'669-200-2001', N'gerente', 2, CAST(9000.00 AS Decimal(10, 2)), CAST(N'2020-05-10' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (6, N'Fernando Higuera Bojorquez', N'669-200-2002', N'cajero', 2, CAST(5500.00 AS Decimal(10, 2)), CAST(N'2021-09-15' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (7, N'Lucia Angulo Gaxiola', N'669-200-2003', N'cocinero', 2, CAST(6000.00 AS Decimal(10, 2)), CAST(N'2022-02-01' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (8, N'Roberto Camacho Urquiza', N'668-300-3001', N'gerente', 3, CAST(9000.00 AS Decimal(10, 2)), CAST(N'2019-11-20' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (9, N'Gabriela Meza Palomino', N'668-300-3002', N'cajero', 3, CAST(5500.00 AS Decimal(10, 2)), CAST(N'2022-04-05' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (10, N'Eduardo Fonseca Rivas', N'668-300-3003', N'cocinero', 3, CAST(6000.00 AS Decimal(10, 2)), CAST(N'2022-05-18' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (11, N'Patricia Urrea Sandoval', N'687-400-4001', N'gerente', 4, CAST(9000.00 AS Decimal(10, 2)), CAST(N'2021-01-08' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (12, N'Hector Manuel Beltran Quiñonez', N'687-400-4002', N'cajero', 4, CAST(5500.00 AS Decimal(10, 2)), CAST(N'2022-08-12' AS Date), N'activo')
INSERT [dbo].[Empleados] ([EmpleadoID], [NombreCompleto], [Telefono], [Puesto], [SucursalID], [SalarioQuincenal], [FechaIngreso], [Estatus]) VALUES (13, N'Sonia Judith Corrales Estrada', N'687-400-4003', N'cocinero', 4, CAST(6000.00 AS Decimal(10, 2)), CAST(N'2023-01-03' AS Date), N'activo')
SET IDENTITY_INSERT [dbo].[Empleados] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (1, 1, 2, 1, CAST(N'2026-01-07T13:20:00.000' AS DateTime), N'en local', N'entregado', CAST(118.00 AS Decimal(10, 2)), NULL, CAST(18.88 AS Decimal(10, 2)), CAST(136.88 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (2, 1, 2, NULL, CAST(N'2026-01-07T14:05:00.000' AS DateTime), N'para llevar', N'entregado', CAST(161.00 AS Decimal(10, 2)), NULL, CAST(25.76 AS Decimal(10, 2)), CAST(186.76 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (3, 2, 6, 3, CAST(N'2026-01-10T12:00:00.000' AS DateTime), N'en local', N'entregado', CAST(188.00 AS Decimal(10, 2)), NULL, CAST(30.08 AS Decimal(10, 2)), CAST(218.08 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (4, 2, 6, 4, CAST(N'2026-01-10T13:30:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(130.00 AS Decimal(10, 2)), NULL, CAST(20.80 AS Decimal(10, 2)), CAST(150.80 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (5, 3, 9, 5, CAST(N'2026-01-14T11:00:00.000' AS DateTime), N'en local', N'entregado', CAST(175.00 AS Decimal(10, 2)), NULL, CAST(28.00 AS Decimal(10, 2)), CAST(203.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (6, 4, 12, NULL, CAST(N'2026-01-14T12:45:00.000' AS DateTime), N'para llevar', N'entregado', CAST(125.00 AS Decimal(10, 2)), NULL, CAST(20.00 AS Decimal(10, 2)), CAST(145.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (7, 1, 2, 9, CAST(N'2026-02-03T13:00:00.000' AS DateTime), N'en local', N'entregado', CAST(210.00 AS Decimal(10, 2)), NULL, CAST(33.60 AS Decimal(10, 2)), CAST(243.60 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (8, 1, 2, NULL, CAST(N'2026-02-03T14:10:00.000' AS DateTime), N'para llevar', N'entregado', CAST(95.00 AS Decimal(10, 2)), NULL, CAST(15.20 AS Decimal(10, 2)), CAST(110.20 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (9, 2, 6, 10, CAST(N'2026-02-10T19:00:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(183.00 AS Decimal(10, 2)), NULL, CAST(29.28 AS Decimal(10, 2)), CAST(212.28 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (10, 3, 9, 6, CAST(N'2026-02-14T13:30:00.000' AS DateTime), N'en local', N'entregado', CAST(161.00 AS Decimal(10, 2)), NULL, CAST(25.76 AS Decimal(10, 2)), CAST(186.76 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (11, 4, 12, 7, CAST(N'2026-02-14T14:00:00.000' AS DateTime), N'en local', N'entregado', CAST(148.00 AS Decimal(10, 2)), NULL, CAST(23.68 AS Decimal(10, 2)), CAST(171.68 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (12, 1, 2, 2, CAST(N'2026-03-05T12:20:00.000' AS DateTime), N'en local', N'entregado', CAST(143.00 AS Decimal(10, 2)), NULL, CAST(22.88 AS Decimal(10, 2)), CAST(165.88 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (13, 2, 6, NULL, CAST(N'2026-03-10T13:00:00.000' AS DateTime), N'para llevar', N'entregado', CAST(100.00 AS Decimal(10, 2)), NULL, CAST(16.00 AS Decimal(10, 2)), CAST(116.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (14, 3, 9, NULL, CAST(N'2026-03-15T11:45:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(145.00 AS Decimal(10, 2)), NULL, CAST(23.20 AS Decimal(10, 2)), CAST(168.20 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (15, 4, 12, 8, CAST(N'2026-03-20T14:30:00.000' AS DateTime), N'en local', N'entregado', CAST(171.00 AS Decimal(10, 2)), NULL, CAST(27.36 AS Decimal(10, 2)), CAST(198.36 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (16, 1, 2, 1, CAST(N'2026-04-02T13:10:00.000' AS DateTime), N'en local', N'entregado', CAST(152.00 AS Decimal(10, 2)), NULL, CAST(24.32 AS Decimal(10, 2)), CAST(176.32 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (17, 2, 6, 3, CAST(N'2026-04-08T20:00:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(136.00 AS Decimal(10, 2)), NULL, CAST(21.76 AS Decimal(10, 2)), CAST(157.76 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (18, 3, 9, NULL, CAST(N'2026-04-12T12:00:00.000' AS DateTime), N'en local', N'entregado', CAST(113.00 AS Decimal(10, 2)), NULL, CAST(18.08 AS Decimal(10, 2)), CAST(131.08 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (19, 4, 12, NULL, CAST(N'2026-04-18T13:45:00.000' AS DateTime), N'para llevar', N'entregado', CAST(93.00 AS Decimal(10, 2)), NULL, CAST(14.88 AS Decimal(10, 2)), CAST(107.88 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (20, 1, 2, 9, CAST(N'2026-05-02T14:00:00.000' AS DateTime), N'en local', N'entregado', CAST(183.00 AS Decimal(10, 2)), NULL, CAST(29.28 AS Decimal(10, 2)), CAST(212.28 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (21, 2, 6, NULL, CAST(N'2026-05-05T11:30:00.000' AS DateTime), N'en local', N'entregado', CAST(80.00 AS Decimal(10, 2)), NULL, CAST(12.80 AS Decimal(10, 2)), CAST(92.80 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (22, 3, 9, 5, CAST(N'2026-05-06T13:00:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(218.00 AS Decimal(10, 2)), NULL, CAST(34.88 AS Decimal(10, 2)), CAST(252.88 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (23, 4, 12, 7, CAST(N'2026-05-07T12:30:00.000' AS DateTime), N'en local', N'entregado', CAST(119.00 AS Decimal(10, 2)), NULL, CAST(19.04 AS Decimal(10, 2)), CAST(138.04 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (24, 1, 2, 2, CAST(N'2026-05-17T12:00:00.000' AS DateTime), N'para llevar', N'listo', CAST(95.00 AS Decimal(10, 2)), NULL, CAST(15.20 AS Decimal(10, 2)), CAST(110.20 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (25, 2, 6, NULL, CAST(N'2026-05-17T12:15:00.000' AS DateTime), N'en local', N'preparando', CAST(111.00 AS Decimal(10, 2)), NULL, CAST(17.76 AS Decimal(10, 2)), CAST(128.76 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (26, 3, 9, 6, CAST(N'2026-05-17T12:20:00.000' AS DateTime), N'en local', N'entregado', CAST(106.00 AS Decimal(10, 2)), NULL, CAST(16.96 AS Decimal(10, 2)), CAST(122.96 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (27, 4, 12, NULL, CAST(N'2026-05-17T12:25:00.000' AS DateTime), N'a domicilio', N'cancelado', CAST(160.00 AS Decimal(10, 2)), NULL, CAST(25.60 AS Decimal(10, 2)), CAST(185.60 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (28, 1, 2, NULL, CAST(N'2026-05-10T10:00:00.000' AS DateTime), N'para llevar', N'cancelado', CAST(75.00 AS Decimal(10, 2)), NULL, CAST(12.00 AS Decimal(10, 2)), CAST(87.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (29, 2, 6, 4, CAST(N'2026-05-12T19:30:00.000' AS DateTime), N'a domicilio', N'entregado', CAST(233.00 AS Decimal(10, 2)), NULL, CAST(37.28 AS Decimal(10, 2)), CAST(270.28 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (30, 3, 9, 5, CAST(N'2026-05-15T13:00:00.000' AS DateTime), N'en local', N'entregado', CAST(133.00 AS Decimal(10, 2)), NULL, CAST(21.28 AS Decimal(10, 2)), CAST(154.28 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (31, 1, 2, 1, CAST(N'2026-05-17T13:38:02.103' AS DateTime), N'en local', N'preparando', CAST(116.00 AS Decimal(10, 2)), 1, CAST(18.56 AS Decimal(10, 2)), CAST(134.56 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (32, 1, 2, NULL, CAST(N'2026-05-16T12:42:00.990' AS DateTime), N'en local', N'cancelado', CAST(50.00 AS Decimal(10, 2)), NULL, CAST(8.00 AS Decimal(10, 2)), CAST(58.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([PedidoID], [SucursalID], [EmpleadoID], [ClienteID], [FechaHora], [TipoPedido], [Estatus], [Subtotal], [PromocionID], [IVA], [Total]) VALUES (33, 1, 2, NULL, CAST(N'2026-05-18T01:20:38.950' AS DateTime), N'para llevar', N'pendiente', CAST(155.00 AS Decimal(10, 2)), NULL, CAST(24.80 AS Decimal(10, 2)), CAST(179.80 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (1, N'Taco de Carne Asada', N'Tortilla de maiz, carne asada, cebolla, cilantro y salsa', 1, CAST(25.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.657' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (2, N'Taco de Birria', N'Tortilla dorada en consomé, birria de res, cebolla y cilantro', 1, CAST(28.00 AS Decimal(10, 2)), CAST(14.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.657' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (3, N'Taco de Barbacoa', N'Tortilla de maiz, barbacoa de res, cebolla y salsa verde', 1, CAST(27.00 AS Decimal(10, 2)), CAST(13.50 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.657' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (4, N'Taco de Pollo', N'Tortilla de maiz, pollo al carbon, pico de gallo y aguacate', 1, CAST(23.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.657' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (5, N'Taco de Pescado', N'Tortilla de harina, filete de tilapia empanizado y ensalada', 1, CAST(30.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.657' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (6, N'Burrito de Carne Asada', N'Tortilla de harina grande, carne asada, frijoles y queso', 2, CAST(55.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.663' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (7, N'Burrito de Pollo', N'Tortilla de harina, pollo guisado, arroz y crema', 2, CAST(50.00 AS Decimal(10, 2)), CAST(22.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.663' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (8, N'Burrito de Frijoles', N'Tortilla de harina, frijoles refritos, queso y chile', 2, CAST(40.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.663' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (9, N'Burrito de Barbacoa', N'Tortilla de harina, barbacoa deshebrada, guacamole y pico', 2, CAST(58.00 AS Decimal(10, 2)), CAST(27.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.663' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (10, N'Burrito Especial Sinaloa', N'Burrito con carne asada, camarones y queso fundido', 2, CAST(75.00 AS Decimal(10, 2)), CAST(35.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.663' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (11, N'Agua de Jamaica', N'Agua fresca de flor de jamaica, endulzada al gusto', 3, CAST(18.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.670' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (12, N'Agua de Horchata', N'Agua de arroz con canela, fresca y cremosa', 3, CAST(18.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.670' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (13, N'Refresco 355ml', N'Lata de refresco, variedad a elegir', 3, CAST(20.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.670' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (14, N'Consomé de Birria', N'Consomé de res con garbanzos, cebolla y oregano', 3, CAST(25.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.670' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (15, N'Cajeta con Nieve', N'Bola de nieve de vainilla con cajeta sinaloense', 4, CAST(30.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.680' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (16, N'Flan Napolitano', N'Flan casero con caramelo y crema', 4, CAST(28.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.680' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (17, N'Buñuelo', N'Buñuelo frito espolvoreado con azucar y canela', 4, CAST(22.00 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.680' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (18, N'Orden de Tortillas (5)', N'Cinco tortillas de maiz recien hechas', 5, CAST(15.00 AS Decimal(10, 2)), CAST(3.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.683' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (19, N'Guacamole', N'Guacamole fresco con limon, cebolla y chile serrano', 5, CAST(25.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.683' AS DateTime))
INSERT [dbo].[Productos] ([ProductoID], [Nombre], [Descripcion], [CategoriaID], [PrecioVenta], [CostoPreparacion], [Estatus], [FechaCreacion]) VALUES (20, N'Salsa Roja Extra', N'Porcion extra de salsa roja de chile morita', 5, CAST(10.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), N'disponible', CAST(N'2026-05-17T13:09:35.683' AS DateTime))
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Promociones] ON 

INSERT [dbo].[Promociones] ([PromocionID], [Nombre], [Descripcion], [PorcentajeDescuento], [FechaInicio], [FechaFin], [Activa]) VALUES (1, N'Taco Martes', N'Todos los tacos con 20% de descuento cada martes', CAST(20.00 AS Decimal(5, 2)), CAST(N'2026-01-01' AS Date), CAST(N'2026-12-31' AS Date), 1)
INSERT [dbo].[Promociones] ([PromocionID], [Nombre], [Descripcion], [PorcentajeDescuento], [FechaInicio], [FechaFin], [Activa]) VALUES (2, N'Promo Verano 2025', N'Descuento de temporada en burritos especiales', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-06-01' AS Date), CAST(N'2025-08-31' AS Date), 1)
INSERT [dbo].[Promociones] ([PromocionID], [Nombre], [Descripcion], [PorcentajeDescuento], [FechaInicio], [FechaFin], [Activa]) VALUES (3, N'Semana de la Birria', N'30% en tacos y consomé de birria durante la feria', CAST(30.00 AS Decimal(5, 2)), CAST(N'2026-10-15' AS Date), CAST(N'2026-10-22' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Promociones] OFF
GO
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (1, 1)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (1, 2)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (1, 3)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (1, 4)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (1, 5)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (2, 6)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (2, 7)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (2, 8)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (2, 9)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (2, 10)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (3, 2)
INSERT [dbo].[PromocionProducto] ([PromocionID], [ProductoID]) VALUES (3, 14)
GO
SET IDENTITY_INSERT [dbo].[Sucursales] ON 

INSERT [dbo].[Sucursales] ([SucursalID], [Nombre], [Direccion], [Ciudad], [Telefono], [Estatus], [FechaCreacion]) VALUES (1, N'El Sinaloense Culiacan', N'Blvd. Francisco I. Madero 1452, Col. Centro', N'Culiacan', N'667-123-4567', N'activa', CAST(N'2026-05-17T13:09:35.633' AS DateTime))
INSERT [dbo].[Sucursales] ([SucursalID], [Nombre], [Direccion], [Ciudad], [Telefono], [Estatus], [FechaCreacion]) VALUES (2, N'El Sinaloense Mazatlan', N'Av. Rafael Buelna 890, Col. Palos Prietos', N'Mazatlan', N'669-234-5678', N'activa', CAST(N'2026-05-17T13:09:35.633' AS DateTime))
INSERT [dbo].[Sucursales] ([SucursalID], [Nombre], [Direccion], [Ciudad], [Telefono], [Estatus], [FechaCreacion]) VALUES (3, N'El Sinaloense Los Mochis', N'Av. Leyva 345, Col. Centro', N'Los Mochis', N'668-345-6789', N'activa', CAST(N'2026-05-17T13:09:35.633' AS DateTime))
INSERT [dbo].[Sucursales] ([SucursalID], [Nombre], [Direccion], [Ciudad], [Telefono], [Estatus], [FechaCreacion]) VALUES (4, N'El Sinaloense Guasave', N'Calle Ruiz Cortinez 210, Col. Hidalgo', N'Guasave', N'687-456-7890', N'activa', CAST(N'2026-05-17T13:09:35.633' AS DateTime))
SET IDENTITY_INSERT [dbo].[Sucursales] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__75E3EFCFC4AB2DBA]    Script Date: 18/05/2026 12:48:06 p. m. ******/
ALTER TABLE [dbo].[Categorias] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UX_Empleados_GerentePorSucursal]    Script Date: 18/05/2026 12:48:06 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_Empleados_GerentePorSucursal] ON [dbo].[Empleados]
(
	[SucursalID] ASC
)
WHERE ([Puesto]='gerente' AND [Estatus]='activo')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Pedidos_EmpleadoID]    Script Date: 18/05/2026 12:48:06 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Pedidos_EmpleadoID] ON [dbo].[Pedidos]
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Pedidos_Estatus]    Script Date: 18/05/2026 12:48:06 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Pedidos_Estatus] ON [dbo].[Pedidos]
(
	[Estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Pedidos_FechaHora]    Script Date: 18/05/2026 12:48:06 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Pedidos_FechaHora] ON [dbo].[Pedidos]
(
	[FechaHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Pedidos_SucursalID]    Script Date: 18/05/2026 12:48:06 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Pedidos_SucursalID] ON [dbo].[Pedidos]
(
	[SucursalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categorias] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[Clientes] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[Clientes] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Empleados] ADD  DEFAULT ('activo') FOR [Estatus]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT (getdate()) FOR [FechaHora]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ('pendiente') FOR [Estatus]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ((0)) FOR [Subtotal]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ((0)) FOR [IVA]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ('disponible') FOR [Estatus]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Promociones] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[Sucursales] ADD  DEFAULT ('activa') FOR [Estatus]
GO
ALTER TABLE [dbo].[Sucursales] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Pedidos] FOREIGN KEY([PedidoID])
REFERENCES [dbo].[Pedidos] ([PedidoID])
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [FK_Detalle_Pedidos]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Productos] FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [FK_Detalle_Productos]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [FK_Empleados_Sucursales] FOREIGN KEY([SucursalID])
REFERENCES [dbo].[Sucursales] ([SucursalID])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleados_Sucursales]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Clientes] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Clientes] ([ClienteID])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Clientes]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Empleados] FOREIGN KEY([EmpleadoID])
REFERENCES [dbo].[Empleados] ([EmpleadoID])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Empleados]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Promociones] FOREIGN KEY([PromocionID])
REFERENCES [dbo].[Promociones] ([PromocionID])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Promociones]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Sucursales] FOREIGN KEY([SucursalID])
REFERENCES [dbo].[Sucursales] ([SucursalID])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Sucursales]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([CategoriaID])
REFERENCES [dbo].[Categorias] ([CategoriaID])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
ALTER TABLE [dbo].[PromocionProducto]  WITH CHECK ADD  CONSTRAINT [FK_PP_Productos] FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[PromocionProducto] CHECK CONSTRAINT [FK_PP_Productos]
GO
ALTER TABLE [dbo].[PromocionProducto]  WITH CHECK ADD  CONSTRAINT [FK_PP_Promociones] FOREIGN KEY([PromocionID])
REFERENCES [dbo].[Promociones] ([PromocionID])
GO
ALTER TABLE [dbo].[PromocionProducto] CHECK CONSTRAINT [FK_PP_Promociones]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [CK_Detalle_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [CK_Detalle_Cantidad]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [CK_Detalle_Precio] CHECK  (([PrecioUnitario]>(0)))
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [CK_Detalle_Precio]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [CK_Empleados_Estatus] CHECK  (([Estatus]='inactivo' OR [Estatus]='activo'))
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [CK_Empleados_Estatus]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [CK_Empleados_Puesto] CHECK  (([Puesto]='gerente' OR [Puesto]='repartidor' OR [Puesto]='cocinero' OR [Puesto]='cajero'))
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [CK_Empleados_Puesto]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [CK_Empleados_Salario] CHECK  (([SalarioQuincenal]>(0)))
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [CK_Empleados_Salario]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [CK_Pedidos_Estatus] CHECK  (([Estatus]='cancelado' OR [Estatus]='entregado' OR [Estatus]='listo' OR [Estatus]='preparando' OR [Estatus]='pendiente'))
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [CK_Pedidos_Estatus]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [CK_Pedidos_IVA] CHECK  (([IVA]>=(0)))
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [CK_Pedidos_IVA]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [CK_Pedidos_Subtotal] CHECK  (([Subtotal]>=(0)))
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [CK_Pedidos_Subtotal]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [CK_Pedidos_Tipo] CHECK  (([TipoPedido]='a domicilio' OR [TipoPedido]='para llevar' OR [TipoPedido]='en local'))
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [CK_Pedidos_Tipo]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [CK_Pedidos_Total] CHECK  (([Total]>=(0)))
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [CK_Pedidos_Total]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CK_Productos_Costo] CHECK  (([CostoPreparacion]>=(0)))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CK_Productos_Costo]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CK_Productos_Estatus] CHECK  (([Estatus]='no disponible' OR [Estatus]='disponible'))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CK_Productos_Estatus]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CK_Productos_PrecioVenta] CHECK  (([PrecioVenta]>(0)))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CK_Productos_PrecioVenta]
GO
ALTER TABLE [dbo].[Promociones]  WITH CHECK ADD  CONSTRAINT [CK_Promociones_Fechas] CHECK  (([FechaFin]>=[FechaInicio]))
GO
ALTER TABLE [dbo].[Promociones] CHECK CONSTRAINT [CK_Promociones_Fechas]
GO
ALTER TABLE [dbo].[Promociones]  WITH CHECK ADD  CONSTRAINT [CK_Promociones_Porcentaje] CHECK  (([PorcentajeDescuento]>(0) AND [PorcentajeDescuento]<(100)))
GO
ALTER TABLE [dbo].[Promociones] CHECK CONSTRAINT [CK_Promociones_Porcentaje]
GO
ALTER TABLE [dbo].[Sucursales]  WITH CHECK ADD  CONSTRAINT [CK_Sucursales_Estatus] CHECK  (([Estatus]='cerrada' OR [Estatus]='activa'))
GO
ALTER TABLE [dbo].[Sucursales] CHECK CONSTRAINT [CK_Sucursales_Estatus]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgregarProductoAlPedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- PASO 6: Actualizar sp_AgregarProductoAlPedido
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_AgregarProductoAlPedido]
    @PedidoID   INT,
    @ProductoID INT,
    @Cantidad   INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (
            SELECT 1 FROM Pedidos
            WHERE PedidoID = @PedidoID AND Estatus = 'pendiente'
        )
        BEGIN
            RAISERROR('El pedido no existe o ya no esta en estatus pendiente.', 16, 1);
            RETURN;
        END

        IF @Cantidad <= 0
        BEGIN
            RAISERROR('La cantidad debe ser mayor a cero.', 16, 1);
            RETURN;
        END

        DECLARE @PrecioActual DECIMAL(10,2);

        SELECT @PrecioActual = PrecioVenta
        FROM   Productos
        WHERE  ProductoID = @ProductoID AND Estatus = 'disponible';

        IF @PrecioActual IS NULL
        BEGIN
            RAISERROR('El producto no existe o no esta disponible.', 16, 1);
            RETURN;
        END

        IF EXISTS (
            SELECT 1 FROM DetallePedido
            WHERE PedidoID = @PedidoID AND ProductoID = @ProductoID
        )
        BEGIN
            UPDATE DetallePedido
            SET    Cantidad = Cantidad + @Cantidad
            WHERE  PedidoID   = @PedidoID
              AND  ProductoID = @ProductoID;
        END
        ELSE
        BEGIN
            INSERT INTO DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
            VALUES (@PedidoID, @ProductoID, @Cantidad, @PrecioActual);
        END

        -- Recalcular Subtotal, IVA (16%) 
        DECLARE @NuevoSubtotal DECIMAL(10,2);

        SELECT @NuevoSubtotal = ISNULL(SUM(Subtotal), 0)
        FROM   DetallePedido
        WHERE  PedidoID = @PedidoID;

        UPDATE Pedidos
        SET
            Subtotal = @NuevoSubtotal,
            IVA      = CAST(@NuevoSubtotal * 0.16 AS DECIMAL(10,2)),
            Total    = CAST(@NuevoSubtotal * 1.16 AS DECIMAL(10,2))
        WHERE PedidoID = @PedidoID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev INT            = ERROR_SEVERITY();
        DECLARE @Sta INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AplicarPromocion]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- PASO 7: Actualizar sp_AplicarPromocion
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_AplicarPromocion]
    @PedidoID    INT,
    @PromocionID INT,
    @TotalFinal  DECIMAL(10,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @SubtotalActual  DECIMAL(10,2);
        DECLARE @PromoYaAplicada INT;

        SELECT @SubtotalActual  = Subtotal,
               @PromoYaAplicada = PromocionID
        FROM   Pedidos
        WHERE  PedidoID = @PedidoID AND Estatus = 'pendiente';

        IF @SubtotalActual IS NULL
        BEGIN
            RAISERROR('El pedido no existe o ya no esta en estatus pendiente.', 16, 1);
            RETURN;
        END

        IF @PromoYaAplicada IS NOT NULL
        BEGIN
            RAISERROR('Este pedido ya tiene una promocion aplicada.', 16, 1);
            RETURN;
        END

        DECLARE @Porcentaje DECIMAL(5,2);

        SELECT @Porcentaje = PorcentajeDescuento
        FROM   Promociones
        WHERE  PromocionID = @PromocionID
          AND  Activa      = 1
          AND  CAST(GETDATE() AS DATE) BETWEEN FechaInicio AND FechaFin;

        IF @Porcentaje IS NULL
        BEGIN
            RAISERROR('La promocion no existe, esta inactiva o fuera de su periodo de vigencia.', 16, 1);
            RETURN;
        END

        IF NOT EXISTS (
            SELECT 1
            FROM   DetallePedido     dp
            JOIN   PromocionProducto pp ON dp.ProductoID = pp.ProductoID
            WHERE  dp.PedidoID    = @PedidoID
              AND  pp.PromocionID = @PromocionID
        )
        BEGIN
            RAISERROR('Ningun producto de este pedido aplica para la promocion seleccionada.', 16, 1);
            RETURN;
        END

        -- Aplicar descuento en las lineas que aplican
        UPDATE dp
        SET    dp.PrecioUnitario = dp.PrecioUnitario * (1 - @Porcentaje / 100.0)
        FROM   DetallePedido     dp
        JOIN   PromocionProducto pp ON dp.ProductoID = pp.ProductoID
        WHERE  dp.PedidoID    = @PedidoID
          AND  pp.PromocionID = @PromocionID;

        -- Recalcular Subtotal, IVA y Total
        DECLARE @NuevoSubtotal DECIMAL(10,2);

        SELECT @NuevoSubtotal = ISNULL(SUM(Subtotal), 0)
        FROM   DetallePedido
        WHERE  PedidoID = @PedidoID;

        UPDATE Pedidos
        SET
            Subtotal    = @NuevoSubtotal,
            IVA         = CAST(@NuevoSubtotal * 0.16 AS DECIMAL(10,2)),
            Total       = CAST(@NuevoSubtotal * 1.16 AS DECIMAL(10,2)),
            PromocionID = @PromocionID
        WHERE PedidoID = @PedidoID;

        SELECT @TotalFinal = Total
        FROM   Pedidos
        WHERE  PedidoID = @PedidoID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev INT            = ERROR_SEVERITY();
        DECLARE @Sta INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CambiarEstatusPedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- SP 1: sp_CambiarEstatusPedido
-- Avanza el estatus de un pedido siguiendo el flujo lineal:
--   pendiente -> preparando -> listo -> entregado
--
-- Reglas:
--   - Solo se puede avanzar, nunca retroceder
--   - Un pedido cancelado NO puede cambiar de estatus
--   - El flujo es estrictamente secuencial (no saltar pasos)
--
-- Parametros:
--   @PedidoID INT
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_CambiarEstatusPedido]
    @PedidoID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @EstatusActual VARCHAR(15);

        SELECT @EstatusActual = Estatus
        FROM   Pedidos
        WHERE  PedidoID = @PedidoID;

        -- Validar que el pedido exista
        IF @EstatusActual IS NULL
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1);
            RETURN;
        END

        -- Validar que no este cancelado ni ya entregado
        IF @EstatusActual = 'cancelado'
        BEGIN
            RAISERROR('Un pedido cancelado no puede cambiar de estatus.', 16, 1);
            RETURN;
        END

        IF @EstatusActual = 'entregado'
        BEGIN
            RAISERROR('El pedido ya fue entregado. No hay siguiente estatus.', 16, 1);
            RETURN;
        END

        -- Determinar el siguiente estatus en el flujo lineal
        DECLARE @NuevoEstatus VARCHAR(15);

        SET @NuevoEstatus = CASE @EstatusActual
            WHEN 'pendiente'   THEN 'preparando'
            WHEN 'preparando'  THEN 'listo'
            WHEN 'listo'       THEN 'entregado'
        END;

        UPDATE Pedidos
        SET    Estatus = @NuevoEstatus
        WHERE  PedidoID = @PedidoID;

        -- Informar el cambio realizado
        SELECT
            @PedidoID     AS PedidoID,
            @EstatusActual AS EstatusAnterior,
            @NuevoEstatus  AS EstatusNuevo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg  NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev  INT            = ERROR_SEVERITY();
        DECLARE @Sta  INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelarPedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 2: sp_CancelarPedido
-- Cancela un pedido. Solo aplica si el pedido esta en
-- 'pendiente' o 'preparando'. Un pedido cancelado no se
-- puede reactivar (se valida en sp_CambiarEstatusPedido).
--
-- Parametros:
--   @PedidoID INT
--   @Motivo   VARCHAR(255)  (opcional, para registro)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_CancelarPedido]
    @PedidoID INT,
    @Motivo   VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @EstatusActual VARCHAR(15);

        SELECT @EstatusActual = Estatus
        FROM   Pedidos
        WHERE  PedidoID = @PedidoID;

        -- Validar que el pedido exista
        IF @EstatusActual IS NULL
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1);
            RETURN;
        END

        -- Solo se puede cancelar si esta en 'pendiente' o 'preparando'
        IF @EstatusActual NOT IN ('pendiente', 'preparando')
        BEGIN
            RAISERROR('Solo se pueden cancelar pedidos en estatus pendiente o preparando. Estatus actual: %s', 16, 1, @EstatusActual);
            RETURN;
        END

        UPDATE Pedidos
        SET    Estatus = 'cancelado'
        WHERE  PedidoID = @PedidoID;

        -- Resultado informativo
        SELECT
            @PedidoID      AS PedidoID,
            @EstatusActual AS EstatusAnterior,
            'cancelado'    AS EstatusNuevo,
            ISNULL(@Motivo, 'Sin motivo registrado') AS Motivo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg  NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev  INT            = ERROR_SEVERITY();
        DECLARE @Sta  INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelarPedidosVencidos]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 3: sp_CancelarPedidosVencidos
-- Cancela automaticamente todos los pedidos que llevan mas
-- de 24 horas en estatus 'pendiente'.
-- Debe ejecutarse periodicamente (ej. SQL Server Agent Job).
--
-- Devuelve cuantos pedidos fueron cancelados.
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_CancelarPedidosVencidos]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Identificar pedidos vencidos (pendiente por mas de 24h)
        DECLARE @PedidosVencidos TABLE (PedidoID INT);

        INSERT INTO @PedidosVencidos (PedidoID)
        SELECT PedidoID
        FROM   Pedidos
        WHERE  Estatus   = 'pendiente'
          AND  FechaHora < DATEADD(HOUR, -24, GETDATE());

        -- Cancelarlos en bloque
        UPDATE Pedidos
        SET    Estatus = 'cancelado'
        WHERE  PedidoID IN (SELECT PedidoID FROM @PedidosVencidos);

        DECLARE @Cancelados INT = @@ROWCOUNT;

        -- Resultado informativo
        SELECT
            @Cancelados                    AS PedidosCancelados,
            GETDATE()                      AS FechaEjecucion;

        -- Opcional: ver cuales fueron cancelados
        IF @Cancelados > 0
        BEGIN
            SELECT
                p.PedidoID,
                s.Nombre       AS Sucursal,
                p.FechaHora    AS FechaOriginal,
                DATEDIFF(HOUR, p.FechaHora, GETDATE()) AS HorasTranscurridas
            FROM   Pedidos     p
            JOIN   Sucursales  s ON p.SucursalID = s.SucursalID
            WHERE  p.PedidoID IN (SELECT PedidoID FROM @PedidosVencidos);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg  NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev  INT            = ERROR_SEVERITY();
        DECLARE @Sta  INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ConfirmarPedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 4: sp_ConfirmarPedido
-- Cambia el estatus del pedido de 'pendiente' a 'preparando',
-- marcando que fue aceptado en cocina.
-- Valida que el pedido tenga al menos un producto.
--
-- Parametros:
--   @PedidoID INT
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ConfirmarPedido]
    @PedidoID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que el pedido exista y este en 'pendiente'
        IF NOT EXISTS (
            SELECT 1 FROM Pedidos
            WHERE PedidoID = @PedidoID AND Estatus = 'pendiente'
        )
        BEGIN
            RAISERROR('El pedido no existe o ya no esta en estatus pendiente.', 16, 1);
            RETURN;
        END

        -- Validar que tenga al menos un producto
        IF NOT EXISTS (
            SELECT 1 FROM DetallePedido
            WHERE PedidoID = @PedidoID
        )
        BEGIN
            RAISERROR('No se puede confirmar un pedido sin productos.', 16, 1);
            RETURN;
        END

        -- Avanzar al siguiente estatus en el flujo lineal
        UPDATE Pedidos
        SET    Estatus = 'preparando'
        WHERE  PedidoID = @PedidoID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg  NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev  INT            = ERROR_SEVERITY();
        DECLARE @Sta  INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DetallePedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- PASO 8: Actualizar sp_DetallePedido
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_DetallePedido]
    @PedidoID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.PedidoID,
        s.Nombre                              AS Sucursal,
        e.NombreCompleto                      AS Empleado,
        ISNULL(c.Nombre, 'Publico general')   AS Cliente,
        p.FechaHora,
        p.TipoPedido,
        p.Estatus,
        p.Subtotal                            AS SubtotalSinIVA,
        p.IVA                                 AS IVA_16,
        p.Total                               AS TotalConIVA,
        CASE
            WHEN p.PromocionID IS NOT NULL
                THEN pr.Nombre + ' (-' + CAST(pr.PorcentajeDescuento AS VARCHAR) + '%)'
            ELSE 'Sin promocion'
        END                                   AS PromocionAplicada
    FROM       Pedidos      p
    JOIN       Sucursales   s  ON p.SucursalID  = s.SucursalID
    JOIN       Empleados    e  ON p.EmpleadoID  = e.EmpleadoID
    LEFT JOIN  Clientes     c  ON p.ClienteID   = c.ClienteID
    LEFT JOIN  Promociones  pr ON p.PromocionID = pr.PromocionID
    WHERE p.PedidoID = @PedidoID;

    SELECT
        dp.DetalleID,
        cat.Nombre                            AS Categoria,
        pr.Nombre                             AS Producto,
        dp.Cantidad,
        dp.PrecioUnitario                     AS PrecioAlMomentoVenta,
        pr.PrecioVenta                        AS PrecioActualCatalogo,
        CASE
            WHEN dp.PrecioUnitario <> pr.PrecioVenta THEN 'Si (precio cambio)'
            ELSE 'No'
        END                                   AS PrecioModificado,
        dp.Subtotal
    FROM       DetallePedido dp
    JOIN       Productos     pr  ON dp.ProductoID  = pr.ProductoID
    JOIN       Categorias    cat ON pr.CategoriaID = cat.CategoriaID
    WHERE dp.PedidoID = @PedidoID
    ORDER BY dp.DetalleID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NuevoPedido]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- SP 1: sp_NuevoPedido
-- Crea un pedido nuevo en estatus 'pendiente'.
-- Valida que el empleado exista, este activo y pertenezca
-- a la sucursal indicada.
--
-- Parametros:
--   @SucursalID  INT
--   @EmpleadoID  INT
--   @ClienteID   INT  (NULL = publico general)
--   @TipoPedido  VARCHAR(15) -> 'en local' | 'para llevar' | 'a domicilio'
--   @NuevoPedidoID INT OUTPUT  -> devuelve el ID generado
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_NuevoPedido]
    @SucursalID    INT,
    @EmpleadoID    INT,
    @ClienteID     INT = NULL,
    @TipoPedido    VARCHAR(15),
    @NuevoPedidoID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que la sucursal exista y este activa
        IF NOT EXISTS (
            SELECT 1 FROM Sucursales
            WHERE SucursalID = @SucursalID AND Estatus = 'activa'
        )
        BEGIN
            RAISERROR('La sucursal no existe o se encuentra cerrada.', 16, 1);
            RETURN;
        END

        -- Validar que el empleado exista, este activo y pertenezca a la sucursal
        IF NOT EXISTS (
            SELECT 1 FROM Empleados
            WHERE EmpleadoID = @EmpleadoID
              AND SucursalID = @SucursalID
              AND Estatus    = 'activo'
        )
        BEGIN
            RAISERROR('El empleado no existe, esta inactivo o no pertenece a esta sucursal.', 16, 1);
            RETURN;
        END

        -- Validar que el tipo de pedido sea valido
        IF @TipoPedido NOT IN ('en local', 'para llevar', 'a domicilio')
        BEGIN
            RAISERROR('Tipo de pedido invalido. Use: en local, para llevar o a domicilio.', 16, 1);
            RETURN;
        END

        -- Validar cliente si se proporciono (no obligatorio)
        IF @ClienteID IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM Clientes
            WHERE ClienteID = @ClienteID AND Activo = 1
        )
        BEGIN
            RAISERROR('El cliente especificado no existe o esta dado de baja.', 16, 1);
            RETURN;
        END

        -- Insertar el pedido con Total = 0 (se recalcula al agregar productos)
        INSERT INTO Pedidos (SucursalID, EmpleadoID, ClienteID, FechaHora, TipoPedido, Estatus, Total)
        VALUES (@SucursalID, @EmpleadoID, @ClienteID, GETDATE(), @TipoPedido, 'pendiente', 0);

        SET @NuevoPedidoID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @Msg  NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Sev  INT            = ERROR_SEVERITY();
        DECLARE @Sta  INT            = ERROR_STATE();
        RAISERROR(@Msg, @Sev, @Sta);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteProductosMasVendidos]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 2: sp_ReporteProductosMasVendidos
-- Top 10 productos mas vendidos por cantidad total,
-- con su categoria y el total generado en pesos.
-- Solo pedidos entregados.
--
-- Temas SQL: GROUP BY + ORDER BY + TOP
--
-- Parametros:
--   @FechaInicio DATE
--   @FechaFin    DATE
--   @SucursalID  INT  (0 = todas)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ReporteProductosMasVendidos]
    @FechaInicio DATE,
    @FechaFin    DATE,
    @SucursalID  INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @FechaInicio > @FechaFin
    BEGIN
        RAISERROR('La fecha de inicio no puede ser mayor a la fecha de fin.', 16, 1);
        RETURN;
    END

    SELECT TOP 10
        pr.ProductoID,
        cat.Nombre                          AS Categoria,
        pr.Nombre                           AS Producto,
        pr.Estatus                          AS EstatusProducto,
        SUM(dp.Cantidad)                    AS UnidadesVendidas,
        SUM(dp.Subtotal)                    AS TotalGenerado,
        CAST(AVG(dp.PrecioUnitario) AS DECIMAL(10,2)) AS PrecioPromedioVenta
    FROM       DetallePedido dp
    JOIN       Pedidos    p   ON  dp.PedidoID   = p.PedidoID
                              AND p.Estatus     = 'entregado'
                              AND CAST(p.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
                              AND (@SucursalID = 0 OR p.SucursalID = @SucursalID)
    JOIN       Productos  pr  ON  dp.ProductoID = pr.ProductoID
    JOIN       Categorias cat ON  pr.CategoriaID = cat.CategoriaID
    GROUP BY   pr.ProductoID, cat.Nombre, pr.Nombre, pr.Estatus
    ORDER BY   UnidadesVendidas DESC, TotalGenerado DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteProductosSinMovimiento]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 6: sp_ReporteProductosSinMovimiento
-- Productos que NO han sido vendidos en el periodo indicado.
-- Usa LEFT JOIN + IS NULL para detectar ausencia de ventas.
-- Incluye productos activos e inactivos para auditoria.
--
-- Temas SQL: NOT EXISTS / LEFT JOIN + IS NULL
--
-- Parametros:
--   @FechaInicio DATE
--   @FechaFin    DATE
--   @SucursalID  INT  (0 = todas)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ReporteProductosSinMovimiento]
    @FechaInicio DATE,
    @FechaFin    DATE,
    @SucursalID  INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @FechaInicio > @FechaFin
    BEGIN
        RAISERROR('La fecha de inicio no puede ser mayor a la fecha de fin.', 16, 1);
        RETURN;
    END

    -- Tecnica 1: LEFT JOIN + IS NULL  (la que pide el documento)
    SELECT
        pr.ProductoID,
        cat.Nombre          AS Categoria,
        pr.Nombre           AS Producto,
        pr.PrecioVenta,
        pr.CostoPreparacion,
        pr.Estatus,
        -- Subconsulta escalar: ultima vez que se vendio (fuera del periodo)
        (
            SELECT MAX(CAST(p2.FechaHora AS DATE))
            FROM   DetallePedido dp2
            JOIN   Pedidos       p2 ON dp2.PedidoID = p2.PedidoID
            WHERE  dp2.ProductoID = pr.ProductoID
              AND  p2.Estatus     = 'entregado'
        )                   AS UltimaVentaHistorica
    FROM       Productos     pr
    JOIN       Categorias    cat ON pr.CategoriaID = cat.CategoriaID
    -- LEFT JOIN: si no hay detalle en el periodo, las columnas de dp y p seran NULL
    LEFT JOIN  DetallePedido dp  ON  dp.ProductoID = pr.ProductoID
    LEFT JOIN  Pedidos       p   ON  dp.PedidoID   = p.PedidoID
                                 AND p.Estatus     = 'entregado'
                                 AND CAST(p.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
                                 AND (@SucursalID = 0 OR p.SucursalID = @SucursalID)
    -- Filtro IS NULL: solo los que NO tuvieron ventas en el periodo
    WHERE      p.PedidoID IS NULL
    ORDER BY   cat.Nombre, pr.Nombre;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteRendimientoEmpleados]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 4: sp_ReporteRendimientoEmpleados
-- Pedidos atendidos, total vendido y ticket promedio
-- por empleado. Solo muestra empleados con mas de 5 pedidos
-- (HAVING). Filtra solo cajeros (los que toman pedidos).
--
-- Temas SQL: GROUP BY + HAVING + JOIN
--
-- Parametros:
--   @FechaInicio     DATE
--   @FechaFin        DATE
--   @SucursalID      INT  (0 = todas)
--   @MinimoPedidos   INT  (default 5, segun el documento)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ReporteRendimientoEmpleados]
    @FechaInicio   DATE,
    @FechaFin      DATE,
    @SucursalID    INT = 0,
    @MinimoPedidos INT = 5
AS
BEGIN
    SET NOCOUNT ON;

    IF @FechaInicio > @FechaFin
    BEGIN
        RAISERROR('La fecha de inicio no puede ser mayor a la fecha de fin.', 16, 1);
        RETURN;
    END

    SELECT
        e.EmpleadoID,
        e.NombreCompleto                    AS Empleado,
        e.Puesto,
        s.Nombre                            AS Sucursal,
        COUNT(p.PedidoID)                   AS TotalPedidos,
        SUM(p.Total)                        AS TotalVendido,
        CAST(AVG(p.Total) AS DECIMAL(10,2)) AS TicketPromedio,
        -- Subconsulta escalar: pedido de mayor valor que atendio
        (
            SELECT MAX(p2.Total)
            FROM   Pedidos p2
            WHERE  p2.EmpleadoID = e.EmpleadoID
              AND  p2.Estatus    = 'entregado'
              AND  CAST(p2.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
        )                                   AS PedidoMaximo
    FROM       Empleados  e
    JOIN       Sucursales s  ON  e.SucursalID  = s.SucursalID
    JOIN       Pedidos    p  ON  p.EmpleadoID  = e.EmpleadoID
                             AND p.Estatus     = 'entregado'
                             AND CAST(p.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
                             AND (@SucursalID = 0 OR p.SucursalID = @SucursalID)
    WHERE      (@SucursalID = 0 OR e.SucursalID = @SucursalID)
    GROUP BY   e.EmpleadoID, e.NombreCompleto, e.Puesto, s.Nombre
    HAVING     COUNT(p.PedidoID) > @MinimoPedidos
    ORDER BY   TotalVendido DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentasCategoria]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 3: sp_ReporteVentasCategoria
-- Total vendido agrupado por categoria del menu.
-- Incluye cantidad de productos distintos vendidos y
-- cuantos pedidos contienen productos de esa categoria.
--
-- Temas SQL: GROUP BY + JOIN
--
-- Parametros:
--   @FechaInicio DATE
--   @FechaFin    DATE
--   @SucursalID  INT  (0 = todas)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ReporteVentasCategoria]
    @FechaInicio DATE,
    @FechaFin    DATE,
    @SucursalID  INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @FechaInicio > @FechaFin
    BEGIN
        RAISERROR('La fecha de inicio no puede ser mayor a la fecha de fin.', 16, 1);
        RETURN;
    END

    SELECT
        cat.CategoriaID,
        cat.Nombre                              AS Categoria,
        COUNT(DISTINCT pr.ProductoID)           AS ProductosDistintosVendidos,
        SUM(dp.Cantidad)                        AS UnidadesTotales,
        SUM(dp.Subtotal)                        AS TotalVentas,
        CAST(
            SUM(dp.Subtotal) * 100.0 /
            SUM(SUM(dp.Subtotal)) OVER ()
        AS DECIMAL(5,2))                        AS PorcentajeDelTotal
    FROM       Categorias   cat
    LEFT JOIN  Productos    pr   ON  pr.CategoriaID = cat.CategoriaID
    LEFT JOIN  DetallePedido dp  ON  dp.ProductoID  = pr.ProductoID
    LEFT JOIN  Pedidos       p   ON  dp.PedidoID    = p.PedidoID
                                 AND p.Estatus      = 'entregado'
                                 AND CAST(p.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
                                 AND (@SucursalID = 0 OR p.SucursalID = @SucursalID)
    GROUP BY   cat.CategoriaID, cat.Nombre
    ORDER BY   TotalVentas DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentasSucursal]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- PASO 9: Actualizar sp_ReporteVentasSucursal
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_ReporteVentasSucursal]
    @FechaInicio DATE,
    @FechaFin    DATE,
    @SucursalID  INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @FechaInicio > @FechaFin
    BEGIN
        RAISERROR('La fecha de inicio no puede ser mayor a la fecha de fin.', 16, 1);
        RETURN;
    END

    SELECT
        s.SucursalID,
        s.Nombre                              AS Sucursal,
        s.Ciudad,
        COUNT(p.PedidoID)                     AS TotalPedidos,
        ISNULL(SUM(p.Subtotal), 0)            AS SumaSubtotales,
        ISNULL(SUM(p.IVA),      0)            AS SumaIVA,
        ISNULL(SUM(p.Total),    0)            AS TotalVentasConIVA,
        CAST(ISNULL(AVG(p.Total), 0)
             AS DECIMAL(10,2))                AS TicketPromedio,
        ISNULL(MIN(p.Total), 0)               AS PedidoMinimo,
        ISNULL(MAX(p.Total), 0)               AS PedidoMaximo
    FROM       Sucursales s
    LEFT JOIN  Pedidos    p  ON  s.SucursalID = p.SucursalID
                             AND p.Estatus    = 'entregado'
                             AND CAST(p.FechaHora AS DATE) BETWEEN @FechaInicio AND @FechaFin
                             AND (@SucursalID = 0 OR p.SucursalID = @SucursalID)
    WHERE (@SucursalID = 0 OR s.SucursalID = @SucursalID)
    GROUP BY s.SucursalID, s.Nombre, s.Ciudad
    ORDER BY TotalVentasConIVA DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_VerPedidos]    Script Date: 18/05/2026 12:48:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ============================================================
-- SP 4: sp_VerPedidos
-- Lista pedidos filtrados por sucursal y/o estatus.
-- Si @SucursalID = 0 devuelve todas las sucursales.
-- Si @Estatus = '' devuelve todos los estatus.
-- Incluye nombre de empleado, cliente y sucursal via JOINs.
--
-- Parametros:
--   @SucursalID INT         (0 = todas)
--   @Estatus    VARCHAR(15) ('' = todos)
-- ============================================================
CREATE   PROCEDURE [dbo].[sp_VerPedidos]
    @SucursalID INT          = 0,
    @Estatus    VARCHAR(15)  = ''
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.PedidoID,
        s.Nombre                            AS Sucursal,
        e.NombreCompleto                    AS Empleado,
        ISNULL(c.Nombre, 'Publico general') AS Cliente,
        p.FechaHora,
        p.TipoPedido,
        p.Estatus,
        p.Total,
        CASE
            WHEN p.PromocionID IS NOT NULL THEN pr.Nombre
            ELSE 'Sin promocion'
        END                                 AS Promocion
    FROM   Pedidos     p
    JOIN   Sucursales  s  ON p.SucursalID  = s.SucursalID
    JOIN   Empleados   e  ON p.EmpleadoID  = e.EmpleadoID
    LEFT   JOIN Clientes  c  ON p.ClienteID   = c.ClienteID
    LEFT   JOIN Promociones pr ON p.PromocionID = pr.PromocionID
    WHERE  (@SucursalID = 0 OR p.SucursalID = @SucursalID)
      AND  (@Estatus    = '' OR p.Estatus    = @Estatus)
    ORDER  BY p.FechaHora DESC;
END;
GO
USE [master]
GO
ALTER DATABASE [TacoSoft] SET  READ_WRITE 
GO
