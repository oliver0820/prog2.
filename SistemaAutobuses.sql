CREATE DATABASE SistemaAutobuses;
USE SistemaAutobuses;

CREATE TABLE Choferes (
    Id INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    FechaNacimiento DATE,
    Cedula NVARCHAR(20) UNIQUE
);

EXEC sp_rename 'Autobuses.Anio', 'Año', 'COLUMN';
select * from  Autobuses;
CREATE  TABLE Autobuses (
    Id INT PRIMARY KEY IDENTITY,
    Marca NVARCHAR(50),
    Modelo NVARCHAR(50),
    Placa NVARCHAR(20) UNIQUE,
    Color NVARCHAR(20),
    Año  INT
);


CREATE TABLE Rutas (
    Id INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) UNIQUE,
    Distancia DECIMAL(10,2),
    Paradas NVARCHAR(MAX)
);

CREATE TABLE Viajes (
    Id INT PRIMARY KEY IDENTITY,
    ChoferId INT,
    AutobusId INT,
    RutaId INT,
    CONSTRAINT FK_Chofer FOREIGN KEY (ChoferId) REFERENCES Choferes(Id),
    CONSTRAINT FK_Autobus FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id),
    CONSTRAINT FK_Ruta FOREIGN KEY (RutaId) REFERENCES Rutas(Id)
);



-- Procedimiento para insertar un nuevo chofer
CREATE PROCEDURE InsertarChofer
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @FechaNacimiento DATE,
    @Cedula NVARCHAR(20)
AS
BEGIN
    INSERT INTO Choferes (Nombre, Apellido, FechaNacimiento, Cedula)
    VALUES (@Nombre, @Apellido, @FechaNacimiento, @Cedula);
END;

-- Procedimiento para editar los datos de un chofer existente
CREATE PROCEDURE EditarChofer
    @Id INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @FechaNacimiento DATE,
    @Cedula NVARCHAR(20)
AS
BEGIN
    UPDATE Choferes
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        FechaNacimiento = @FechaNacimiento,
        Cedula = @Cedula
    WHERE Id = @Id;
END;

-- Procedimiento para eliminar un chofer por su ID
CREATE PROCEDURE EliminarChofer
    @Id INT
AS
BEGIN
    DELETE FROM Choferes
    WHERE Id = @Id;
END;




-- Procedimiento para buscar un chofer por su ID--error
CREATE PROCEDURE BuscarChoferPorId
    @Id INT
AS
BEGIN
    SELECT * FROM Choferes
    WHERE Id = @Id;
END;

-- Procedimiento para listar todos los choferes
CREATE PROCEDURE ListarChoferes
AS
BEGIN
    SELECT * FROM Choferes;
END;

-- Procedimiento para listar choferes disponibles
CREATE PROCEDURE ListarChoferesDisponibles
AS
BEGIN
    SELECT * FROM Choferes
    WHERE Id NOT IN (SELECT DISTINCT ChoferId FROM Viajes);
END;







-- Procedimiento almacenado para listar todas las rutas
CREATE PROCEDURE ListarRutas
AS
BEGIN
    SELECT * FROM Rutas;
END;

-- Procedimiento almacenado para insertar una nueva ruta
CREATE PROCEDURE InsertarRuta
    @Nombre NVARCHAR(100),
    @Distancia DECIMAL(10,2),
    @Paradas NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Rutas (Nombre, Distancia, Paradas)
    VALUES (@Nombre, @Distancia, @Paradas);
END;

-- Procedimiento almacenado para editar una ruta existente
CREATE PROCEDURE EditarRuta
    @Id INT,
    @Nombre NVARCHAR(100),
    @Distancia DECIMAL(10,2),
    @Paradas NVARCHAR(MAX)
AS
BEGIN
    UPDATE Rutas
    SET Nombre = @Nombre, Distancia = @Distancia, Paradas = @Paradas
    WHERE Id = @Id;
END;

-- Procedimiento almacenado para eliminar una ruta por su Id
CREATE PROCEDURE EliminarRuta
    @Id INT
AS
BEGIN
    DELETE FROM Rutas WHERE Id = @Id;
END;






-- Procedimiento almacenado para listar todos los autobuses
CREATE PROCEDURE ListarAutobuses
AS
BEGIN
    SELECT * FROM Autobuses;
END;

-- Procedimiento almacenado para insertar un nuevo autobús
CREATE PROCEDURE InsertarAutobus
    @Marca NVARCHAR(100),
    @Modelo NVARCHAR(100),
    @Placa NVARCHAR(20),
    @Color NVARCHAR(50),
    @Año INT
AS
BEGIN
    INSERT INTO Autobuses (Marca, Modelo, Placa, Color, Año)
    VALUES (@Marca, @Modelo, @Placa, @Color, @Año);
END;

-- Procedimiento almacenado para editar un autobús existente   --error
CREATE PROCEDURE EditarAutobus
    @Id INT,
    @Marca NVARCHAR(100),
    @Modelo NVARCHAR(100),
    @Placa NVARCHAR(20),
    @Color NVARCHAR(50),
    @Año int
AS
BEGIN
    UPDATE Autobuses
    SET Marca = @Marca, Modelo = @Modelo, Placa = @Placa, Color = @Color, Año = @Año
    WHERE Id = @Id;
END;

-- Procedimiento almacenado para eliminar un autobús por su Id
CREATE PROCEDURE EliminarAutobus
    @Id INT
AS
BEGIN
    DELETE FROM Autobuses WHERE Id = @Id;
END;
