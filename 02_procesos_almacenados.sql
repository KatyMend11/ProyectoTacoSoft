USE ElSinaloensePOS;
GO

CREATE OR ALTER PROCEDURE sp_ListarSucursales
    @Busqueda NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre AS nombre, Direccion AS direccion, Ciudad AS ciudad, Telefono AS telefono, Estatus AS estatus
    FROM Sucursales
    WHERE (@Busqueda IS NULL OR Nombre LIKE '%' + @Busqueda + '%' OR Ciudad LIKE '%' + @Busqueda + '%')
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_ObtenerSucursal
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre AS nombre, Direccion AS direccion, Ciudad AS ciudad, Telefono AS telefono, Estatus AS estatus
    FROM Sucursales WHERE Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevaSucursal
    @Nombre NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @Ciudad NVARCHAR(50),
    @Telefono NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Sucursales (Nombre, Direccion, Ciudad, Telefono, Estatus)
        VALUES (@Nombre, @Direccion, @Ciudad, @Telefono, 1);
        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarSucursal
    @Id INT,
    @Nombre NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @Ciudad NVARCHAR(50),
    @Telefono NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Sucursales
        SET Nombre = @Nombre, Direccion = @Direccion, Ciudad = @Ciudad, Telefono = @Telefono
        WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaSucursal
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Sucursales SET Estatus = 0 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ListarCategorias
    @Busqueda NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre AS nombre, Descripcion AS descripcion
    FROM Categorias
    WHERE (@Busqueda IS NULL OR Nombre LIKE '%' + @Busqueda + '%')
    ORDER BY Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevaCategoria
    @Nombre NVARCHAR(50),
    @Descripcion NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Categorias (Nombre, Descripcion) VALUES (@Nombre, @Descripcion);
        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarCategoria
    @Id INT,
    @Nombre NVARCHAR(50),
    @Descripcion NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Categorias SET Nombre = @Nombre, Descripcion = @Descripcion WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaCategoria
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Productos SET Estatus = 0 WHERE CategoriaId = @Id;
        DELETE FROM Categorias WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ListarProductos
    @Busqueda NVARCHAR(100) = NULL,
    @CategoriaId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.Nombre AS nombre, p.Descripcion AS descripcion, p.CategoriaId AS categoriaId, c.Nombre AS categoria,
           p.Precio AS precio, p.Costo AS costo, p.Estatus AS estatus
    FROM Productos p
    INNER JOIN Categorias c ON p.CategoriaId = c.Id
    WHERE (@Busqueda IS NULL OR p.Nombre LIKE '%' + @Busqueda + '%')
      AND (@CategoriaId IS NULL OR p.CategoriaId = @CategoriaId)
    ORDER BY c.Nombre, p.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_ObtenerProducto
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.Nombre AS nombre, p.Descripcion AS descripcion, p.CategoriaId AS categoriaId, c.Nombre AS categoria,
           p.Precio AS precio, p.Costo AS costo, p.Estatus AS estatus
    FROM Productos p
    INNER JOIN Categorias c ON p.CategoriaId = c.Id
    WHERE p.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevoProducto
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(300),
    @CategoriaId INT,
    @Precio DECIMAL(10,2),
    @Costo DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Productos (Nombre, Descripcion, CategoriaId, Precio, Costo, Estatus)
        VALUES (@Nombre, @Descripcion, @CategoriaId, @Precio, @Costo, 1);
        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarProducto
    @Id INT,
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(300),
    @CategoriaId INT,
    @Precio DECIMAL(10,2),
    @Costo DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Productos
        SET Nombre = @Nombre, Descripcion = @Descripcion, CategoriaId = @CategoriaId,
            Precio = @Precio, Costo = @Costo
        WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaProducto
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Productos SET Estatus = 0 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ListarEmpleados
    @Busqueda NVARCHAR(100) = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.Id, e.Nombre AS nombre, e.Telefono AS telefono, e.Puesto AS puesto, e.SucursalId AS sucursalId, s.Nombre AS sucursal,
           e.SalarioQuincenal AS salarioQuincenal, e.FechaIngreso AS fechaIngreso, e.Estatus AS estatus
    FROM Empleados e
    INNER JOIN Sucursales s ON e.SucursalId = s.Id
    WHERE (@Busqueda IS NULL OR e.Nombre LIKE '%' + @Busqueda + '%')
      AND (@SucursalId IS NULL OR e.SucursalId = @SucursalId)
    ORDER BY s.Nombre, e.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_ObtenerEmpleado
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.Id, e.Nombre AS nombre, e.Telefono AS telefono, e.Puesto AS puesto, e.SucursalId AS sucursalId, s.Nombre AS sucursal,
           e.SalarioQuincenal AS salarioQuincenal, e.FechaIngreso AS fechaIngreso, e.Estatus AS estatus
    FROM Empleados e
    INNER JOIN Sucursales s ON e.SucursalId = s.Id
    WHERE e.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevoEmpleado
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Puesto NVARCHAR(30),
    @SucursalId INT,
    @SalarioQuincenal DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF @Puesto = 'gerente'
        BEGIN
            IF EXISTS (SELECT 1 FROM Empleados WHERE SucursalId = @SucursalId AND Puesto = 'gerente' AND Estatus = 1)
            BEGIN
                RAISERROR('Ya existe un gerente activo en esta sucursal.', 16, 1);
            END
        END

        INSERT INTO Empleados (Nombre, Telefono, Puesto, SucursalId, SalarioQuincenal, FechaIngreso, Estatus)
        VALUES (@Nombre, @Telefono, @Puesto, @SucursalId, @SalarioQuincenal, GETDATE(), 1);
        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarEmpleado
    @Id INT,
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Puesto NVARCHAR(30),
    @SucursalId INT,
    @SalarioQuincenal DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF @Puesto = 'gerente'
        BEGIN
            IF EXISTS (SELECT 1 FROM Empleados WHERE SucursalId = @SucursalId AND Puesto = 'gerente' AND Estatus = 1 AND Id <> @Id)
            BEGIN
                RAISERROR('Ya existe un gerente activo en esta sucursal.', 16, 1);
            END
        END

        UPDATE Empleados
        SET Nombre = @Nombre, Telefono = @Telefono, Puesto = @Puesto,
            SucursalId = @SucursalId, SalarioQuincenal = @SalarioQuincenal
        WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaEmpleado
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Empleados SET Estatus = 0 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO


CREATE OR ALTER PROCEDURE sp_ListarClientes
    @Busqueda NVARCHAR(100) = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.Id, c.Nombre AS nombre, c.Telefono AS telefono, c.Correo AS correo, c.SucursalId AS sucursalId, s.Nombre AS sucursal, c.Ciudad AS ciudad, c.FechaRegistro AS fechaRegistro, c.Estatus AS estatus
    FROM Clientes c
    LEFT JOIN Sucursales s ON c.SucursalId = s.Id
    WHERE (@Busqueda IS NULL OR c.Nombre LIKE '%' + @Busqueda + '%' OR c.Telefono LIKE '%' + @Busqueda + '%')
      AND (@SucursalId IS NULL OR c.SucursalId = @SucursalId OR c.SucursalId IS NULL)
      AND c.Estatus = 1
    ORDER BY c.Nombre;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevoCliente
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @SucursalId INT = NULL,
    @Ciudad NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Clientes (Nombre, Telefono, Correo, SucursalId, Ciudad, FechaRegistro, Estatus)
        VALUES (@Nombre, @Telefono, @Correo, @SucursalId, @Ciudad, GETDATE(), 1);
        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarCliente
    @Id INT,
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @SucursalId INT = NULL,
    @Ciudad NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Clientes
        SET Nombre = @Nombre, Telefono = @Telefono, Correo = @Correo, SucursalId = @SucursalId, Ciudad = @Ciudad
        WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaCliente
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Clientes SET Estatus = 0 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ListarPromociones
    @Busqueda NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.Nombre AS nombre, p.Descripcion AS descripcion, p.PorcentajeDescuento AS porcentajeDescuento, p.FechaInicio AS fechaInicio,
           p.FechaFin AS fechaFin, p.Estatus AS estatus,
           CASE WHEN GETDATE() BETWEEN p.FechaInicio AND p.FechaFin THEN 1 ELSE 0 END AS vigente
    FROM Promociones p
    WHERE (@Busqueda IS NULL OR p.Nombre LIKE '%' + @Busqueda + '%')
    ORDER BY p.FechaInicio DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_ObtenerPromocion
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.Nombre AS nombre, p.Descripcion AS descripcion, p.PorcentajeDescuento AS porcentajeDescuento, p.FechaInicio AS fechaInicio, p.FechaFin AS fechaFin, p.Estatus AS estatus,
           pp.ProductoId AS productoId, pr.Nombre AS productoNombre
    FROM Promociones p
    LEFT JOIN PromocionProductos pp ON p.Id = pp.PromocionId
    LEFT JOIN Productos pr ON pp.ProductoId = pr.Id
    WHERE p.Id = @Id;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevaPromocion
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(300),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @ProductosJson NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Promociones (Nombre, Descripcion, PorcentajeDescuento, FechaInicio, FechaFin, Estatus)
        VALUES (@Nombre, @Descripcion, @PorcentajeDescuento, @FechaInicio, @FechaFin, 1);

        DECLARE @PromocionId INT = SCOPE_IDENTITY();

        INSERT INTO PromocionProductos (PromocionId, ProductoId)
        SELECT @PromocionId, value
        FROM OPENJSON(@ProductosJson);

        COMMIT TRANSACTION;
        SELECT @PromocionId AS Id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EditarPromocion
    @Id INT,
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(300),
    @PorcentajeDescuento DECIMAL(5,2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @ProductosJson NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Promociones
        SET Nombre = @Nombre, Descripcion = @Descripcion,
            PorcentajeDescuento = @PorcentajeDescuento, FechaInicio = @FechaInicio, FechaFin = @FechaFin
        WHERE Id = @Id;

        DELETE FROM PromocionProductos WHERE PromocionId = @Id;

        INSERT INTO PromocionProductos (PromocionId, ProductoId)
        SELECT @Id, value
        FROM OPENJSON(@ProductosJson);

        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_BajaPromocion
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Promociones SET Estatus = 0 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_EliminarPromocion
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM Pedidos WHERE PromocionId = @Id)
        BEGIN
            RAISERROR('No se puede eliminar: la promocion esta asociada a pedidos existentes.', 16, 1);
        END

        DELETE FROM PromocionProductos WHERE PromocionId = @Id;
        DELETE FROM Promociones WHERE Id = @Id;

        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ReactivarPromocion
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Promociones SET Estatus = 1 WHERE Id = @Id;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_PromocionesVigentes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.Nombre AS nombre, p.Descripcion AS descripcion, p.PorcentajeDescuento AS porcentajeDescuento, p.FechaInicio AS fechaInicio, p.FechaFin AS fechaFin
    FROM Promociones p
    WHERE p.Estatus = 1 AND GETDATE() BETWEEN p.FechaInicio AND p.FechaFin;
END
GO

CREATE OR ALTER PROCEDURE sp_ProductosPromocion
    @PromocionId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT pp.ProductoId AS productoId, pr.Nombre AS nombre, pr.Precio AS precio
    FROM PromocionProductos pp
    INNER JOIN Productos pr ON pp.ProductoId = pr.Id
    WHERE pp.PromocionId = @PromocionId AND pr.Estatus = 1;
END
GO

CREATE OR ALTER PROCEDURE sp_NuevoPedido
    @SucursalId INT,
    @EmpleadoId INT,
    @ClienteId INT = NULL,
    @PromocionId INT = NULL,
    @TipoPedido NVARCHAR(20),
    @PedidoId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Empleados WHERE Id = @EmpleadoId AND Estatus <> 0)
        BEGIN
            RAISERROR('El empleado no esta activo.', 16, 1);
        END

        INSERT INTO Pedidos (SucursalId, EmpleadoId, ClienteId, PromocionId, FechaHora, TipoPedido, Estatus, Total)
        VALUES (@SucursalId, @EmpleadoId, @ClienteId, @PromocionId, GETDATE(), @TipoPedido, 'pendiente', 0);

        SET @PedidoId = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_AgregarProductoAlPedido
    @PedidoId INT,
    @ProductoId INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @PedidoId AND Estatus = 'pendiente')
        BEGIN
            RAISERROR('El pedido no esta pendiente o no existe.', 16, 1);
        END

        IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id = @ProductoId AND Estatus = 1)
        BEGIN
            RAISERROR('El producto no esta disponible.', 16, 1);
        END

        DECLARE @Precio DECIMAL(10,2);
        SELECT @Precio = Precio FROM Productos WHERE Id = @ProductoId;

        DECLARE @Subtotal DECIMAL(10,2) = @Precio * @Cantidad;

        INSERT INTO DetallePedido (PedidoId, ProductoId, Cantidad, PrecioUnitario, Subtotal)
        VALUES (@PedidoId, @ProductoId, @Cantidad, @Precio, @Subtotal);

        UPDATE Pedidos SET Total = Total + @Subtotal WHERE Id = @PedidoId;

        COMMIT TRANSACTION;
        SELECT @Subtotal AS subtotal, @Precio AS precioUnitario;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_AplicarPromocion
    @PedidoId INT,
    @PromocionId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @PedidoId AND Estatus = 'pendiente')
        BEGIN
            RAISERROR('El pedido no esta pendiente o no existe.', 16, 1);
        END

        IF NOT EXISTS (SELECT 1 FROM Promociones WHERE Id = @PromocionId AND Estatus = 1 AND GETDATE() BETWEEN FechaInicio AND FechaFin)
        BEGIN
            RAISERROR('La promocion no esta vigente.', 16, 1);
        END

        DECLARE @Porcentaje DECIMAL(5,2);
        SELECT @Porcentaje = PorcentajeDescuento FROM Promociones WHERE Id = @PromocionId;

        UPDATE dp
        SET dp.Subtotal = dp.Cantidad * (dp.PrecioUnitario * (1 - @Porcentaje / 100))
        FROM DetallePedido dp
        INNER JOIN PromocionProductos pp ON dp.ProductoId = pp.ProductoId
        WHERE dp.PedidoId = @PedidoId AND pp.PromocionId = @PromocionId;

        DECLARE @NuevoTotal DECIMAL(10,2);
        SELECT @NuevoTotal = ISNULL(SUM(Subtotal), 0) FROM DetallePedido WHERE PedidoId = @PedidoId;

        UPDATE Pedidos SET Total = @NuevoTotal WHERE Id = @PedidoId;

        COMMIT TRANSACTION;
        SELECT @NuevoTotal AS nuevoTotal;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ObtenerPedido
    @PedidoId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.SucursalId AS sucursalId, s.Nombre AS sucursal, p.EmpleadoId AS empleadoId, e.Nombre AS empleado,
           p.ClienteId AS clienteId, c.Nombre AS cliente, p.PromocionId AS promocionId, pr.Nombre AS promocion, pr.PorcentajeDescuento AS porcentajeDescuento,
           p.FechaHora AS fechaHora, p.TipoPedido AS tipoPedido, p.Estatus AS estatus, p.Total AS total
    FROM Pedidos p
    INNER JOIN Sucursales s ON p.SucursalId = s.Id
    INNER JOIN Empleados e ON p.EmpleadoId = e.Id
    LEFT JOIN Clientes c ON p.ClienteId = c.Id
    LEFT JOIN Promociones pr ON p.PromocionId = pr.Id
    WHERE p.Id = @PedidoId;

    SELECT dp.Id, dp.ProductoId AS productoId, pr.Nombre AS producto, dp.Cantidad AS cantidad, dp.PrecioUnitario AS precioUnitario, dp.Subtotal AS subtotal
    FROM DetallePedido dp
    INNER JOIN Productos pr ON dp.ProductoId = pr.Id
    WHERE dp.PedidoId = @PedidoId;
END
GO

CREATE OR ALTER PROCEDURE sp_ListarPedidos
    @Estatus NVARCHAR(20) = NULL,
    @SucursalId INT = NULL,
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.Id, p.SucursalId AS sucursalId, s.Nombre AS sucursal, p.EmpleadoId AS empleadoId, e.Nombre AS empleado,
           c.Nombre AS cliente, p.FechaHora AS fechaHora, p.TipoPedido AS tipoPedido, p.Estatus AS estatus, p.Total AS total
    FROM Pedidos p
    INNER JOIN Sucursales s ON p.SucursalId = s.Id
    INNER JOIN Empleados e ON p.EmpleadoId = e.Id
    LEFT JOIN Clientes c ON p.ClienteId = c.Id
    WHERE (@Estatus IS NULL OR p.Estatus = @Estatus)
      AND (@SucursalId IS NULL OR p.SucursalId = @SucursalId)
      AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
      AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
    ORDER BY p.FechaHora DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_CambiarEstatusPedido
    @PedidoId INT,
    @NuevoEstatus NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @EstatusActual NVARCHAR(20);
        SELECT @EstatusActual = Estatus FROM Pedidos WHERE Id = @PedidoId;

        IF @EstatusActual IS NULL
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1);
        END

        IF @EstatusActual = 'cancelado'
        BEGIN
            RAISERROR('Un pedido cancelado no se puede reactivar.', 16, 1);
        END

        IF @EstatusActual = 'entregado'
        BEGIN
            RAISERROR('El pedido ya fue entregado.', 16, 1);
        END

        DECLARE @FlujoValido BIT = 0;
        IF @EstatusActual = 'pendiente' AND @NuevoEstatus = 'preparando' SET @FlujoValido = 1;
        IF @EstatusActual = 'preparando' AND @NuevoEstatus = 'listo' SET @FlujoValido = 1;
        IF @EstatusActual = 'listo' AND @NuevoEstatus = 'entregado' SET @FlujoValido = 1;

        IF @FlujoValido = 0
        BEGIN
            RAISERROR('Transicion de estatus no valida. El flujo es: pendiente -> preparando -> listo -> entregado.', 16, 1);
        END

        UPDATE Pedidos SET Estatus = @NuevoEstatus WHERE Id = @PedidoId;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_CancelarPedido
    @PedidoId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @EstatusActual NVARCHAR(20);
        SELECT @EstatusActual = Estatus FROM Pedidos WHERE Id = @PedidoId;

        IF @EstatusActual IS NULL
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1);
        END

        IF @EstatusActual = 'cancelado'
        BEGIN
            RAISERROR('El pedido ya esta cancelado.', 16, 1);
        END

        IF @EstatusActual NOT IN ('pendiente', 'preparando')
        BEGIN
            RAISERROR('Solo se pueden cancelar pedidos en estado pendiente o preparando.', 16, 1);
        END

        UPDATE Pedidos SET Estatus = 'cancelado' WHERE Id = @PedidoId;
        COMMIT TRANSACTION;
        SELECT 1 AS Resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_CancelarPedidosPendientesVencidos
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Pedidos
        SET Estatus = 'cancelado'
        WHERE Estatus = 'pendiente' AND DATEDIFF(HOUR, FechaHora, GETDATE()) > 24;
        SELECT @@ROWCOUNT AS cancelados;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteVentasSucursal
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT s.Id AS sucursalId, s.Nombre AS sucursal, s.Ciudad AS ciudad,
           COUNT(p.Id) AS totalPedidos,
           ISNULL(SUM(CASE WHEN p.Estatus <> 'cancelado' THEN p.Total ELSE 0 END), 0) AS totalVentas,
           CASE WHEN COUNT(p.Id) > 0
                THEN ISNULL(SUM(CASE WHEN p.Estatus <> 'cancelado' THEN p.Total ELSE 0 END), 0) / COUNT(p.Id)
                ELSE 0 END AS ticketPromedio
    FROM Sucursales s
    LEFT JOIN Pedidos p ON s.Id = p.SucursalId
        AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
        AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
    WHERE (@SucursalId IS NULL OR s.Id = @SucursalId)
    GROUP BY s.Id, s.Nombre, s.Ciudad
    ORDER BY totalVentas DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteProductosMasVendidos
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @SucursalId INT = NULL,
    @Top INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP (@Top)
           pr.Id AS productoId, pr.Nombre AS producto, c.Nombre AS categoria,
           SUM(dp.Cantidad) AS cantidadVendida,
           ISNULL(SUM(dp.Subtotal), 0) AS totalVentas
    FROM DetallePedido dp
    INNER JOIN Productos pr ON dp.ProductoId = pr.Id
    INNER JOIN Categorias c ON pr.CategoriaId = c.Id
    INNER JOIN Pedidos p ON dp.PedidoId = p.Id
    WHERE p.Estatus <> 'cancelado'
      AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
      AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
      AND (@SucursalId IS NULL OR p.SucursalId = @SucursalId)
    GROUP BY pr.Id, pr.Nombre, c.Nombre
    ORDER BY cantidadVendida DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteVentasPorCategoria
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.Nombre AS categoria,
           COUNT(DISTINCT dp.PedidoId) AS numPedidos,
           SUM(dp.Cantidad) AS cantidadVendida,
           ISNULL(SUM(dp.Subtotal), 0) AS totalVentas
    FROM DetallePedido dp
    INNER JOIN Productos pr ON dp.ProductoId = pr.Id
    INNER JOIN Categorias c ON pr.CategoriaId = c.Id
    INNER JOIN Pedidos p ON dp.PedidoId = p.Id
    WHERE p.Estatus <> 'cancelado'
      AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
      AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
      AND (@SucursalId IS NULL OR p.SucursalId = @SucursalId)
    GROUP BY c.Nombre
    ORDER BY totalVentas DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteRendimientoEmpleados
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.Id AS empleadoId, e.Nombre AS empleado, e.Puesto AS puesto, s.Nombre AS sucursal,
           COUNT(p.Id) AS totalPedidos,
           ISNULL(SUM(CASE WHEN p.Estatus <> 'cancelado' THEN p.Total ELSE 0 END), 0) AS totalVentas,
           CASE WHEN COUNT(p.Id) > 0
                THEN ISNULL(SUM(CASE WHEN p.Estatus <> 'cancelado' THEN p.Total ELSE 0 END), 0) / COUNT(p.Id)
                ELSE 0 END AS ticketPromedio
    FROM Empleados e
    INNER JOIN Sucursales s ON e.SucursalId = s.Id
    LEFT JOIN Pedidos p ON e.Id = p.EmpleadoId
        AND p.Estatus <> 'cancelado'
        AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
        AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
        AND (@SucursalId IS NULL OR p.SucursalId = @SucursalId)
    GROUP BY e.Id, e.Nombre, e.Puesto, s.Nombre
    HAVING COUNT(p.Id) > 5
    ORDER BY totalVentas DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteComparativoMensual
    @Anio INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT YEAR(p.FechaHora) AS anio, MONTH(p.FechaHora) AS mes,
           s.Nombre AS sucursal,
           COUNT(p.Id) AS totalPedidos,
           ISNULL(SUM(CASE WHEN p.Estatus <> 'cancelado' THEN p.Total ELSE 0 END), 0) AS totalVentas
    FROM Pedidos p
    INNER JOIN Sucursales s ON p.SucursalId = s.Id
    WHERE p.Estatus <> 'cancelado'
      AND (@Anio IS NULL OR YEAR(p.FechaHora) = @Anio)
    GROUP BY YEAR(p.FechaHora), MONTH(p.FechaHora), s.Nombre
    ORDER BY anio, mes, sucursal;
END
GO

CREATE OR ALTER PROCEDURE sp_ReporteProductosSinMovimiento
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @SucursalId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT pr.Id AS productoId, pr.Nombre AS producto, c.Nombre AS categoria
    FROM Productos pr
    INNER JOIN Categorias c ON pr.CategoriaId = c.Id
    WHERE pr.Estatus = 1
      AND NOT EXISTS (
          SELECT 1 FROM DetallePedido dp
          INNER JOIN Pedidos p ON dp.PedidoId = p.Id
          WHERE dp.ProductoId = pr.Id
            AND p.Estatus <> 'cancelado'
            AND (@FechaInicio IS NULL OR CAST(p.FechaHora AS DATE) >= @FechaInicio)
            AND (@FechaFin IS NULL OR CAST(p.FechaHora AS DATE) <= @FechaFin)
            AND (@SucursalId IS NULL OR p.SucursalId = @SucursalId)
      )
    ORDER BY c.Nombre, pr.Nombre;
END
GO
