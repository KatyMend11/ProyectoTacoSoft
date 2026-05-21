USE ElSinaloensePOS;
GO

CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    EmpleadoId INT NOT NULL FOREIGN KEY REFERENCES Empleados(Id),
    Rol NVARCHAR(20) NOT NULL CHECK (Rol IN ('admin', 'gerente', 'empleado')),
    Estatus BIT NOT NULL DEFAULT 1
);
GO

CREATE INDEX IX_Usuarios_Empleado ON Usuarios(EmpleadoId);
GO

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('elpatron', 'taqueria4jefes', 1, 'admin', 1);

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('gerente_culiacan', 'tacossoft', 1, 'gerente', 1),
('gerente_mazatlan', 'tacossoft', 6, 'gerente', 1),
('gerente_mochis', 'tacossoft', 10, 'gerente', 1),
('gerente_guasave', 'tacossoft', 15, 'gerente', 1);

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('cajero_culiacan', 'tacossoft', 2, 'empleado', 1),
('cajero_mazatlan', 'tacossoft', 7, 'empleado', 1),
('cajero_mochis', 'tacossoft', 11, 'empleado', 1),
('cajero_guasave', 'tacossoft', 16, 'empleado', 1);

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('cocina_culiacan', 'tacossoft', 3, 'empleado', 1),
('cocina_mazatlan', 'tacossoft', 8, 'empleado', 1),
('cocina_mochis', 'tacossoft', 12, 'empleado', 1),
('cocina_guasave', 'tacossoft', 17, 'empleado', 1);

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('repartidor_culiacan', 'tacossoft', 4, 'empleado', 1),
('repartidor_mochis', 'tacossoft', 13, 'empleado', 1);

INSERT INTO Usuarios (Username, PasswordHash, EmpleadoId, Rol, Estatus) VALUES
('mesero_culiacan', 'tacossoft', 5, 'empleado', 1),
('mesero_mazatlan', 'tacossoft', 9, 'empleado', 1),
('mesero_mochis', 'tacossoft', 14, 'empleado', 1),
('mesero_guasave', 'tacossoft', 18, 'empleado', 1);
GO
