CREATE DATABASE Agenda_Electronica;
use Agenda_Electronica

USE Agenda_Electronica;


DROP TABLE Personas;


CREATE TABLE Personas (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    Fecha_Nacimiento DATE,
    Direccion NVARCHAR(100),
    Genero NVARCHAR(10),
    Estado_Civil NVARCHAR(20),
    Movil NVARCHAR(15),
    Telefono NVARCHAR(15),
    Correo_Electronico NVARCHAR(100)
);

select * from Personas