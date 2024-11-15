CREATE DATABASE BarberDB

USE BarberDB

-- Tabla Ocupaciones
CREATE TABLE Ocupaciones (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    id_ocupacion INT,
    telefono NVARCHAR(20),
    direccion NVARCHAR(255),
    FOREIGN KEY (id_ocupacion) REFERENCES Ocupaciones(id)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    telefono NVARCHAR(20),
    direccion NVARCHAR(255)
);

-- Tabla Citas
CREATE TABLE Citas (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATE NOT NULL,
    estado NVARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id)
);

-- Tabla Servicios
CREATE TABLE Servicios (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    precio FLOAT NOT NULL
);

-- Tabla CitasServicios (sin columna ID porque es una tabla de relación)
CREATE TABLE CitasServicios (
    id_cita INT NOT NULL,
    id_servicio INT NOT NULL,
    PRIMARY KEY (id_cita, id_servicio),
    FOREIGN KEY (id_cita) REFERENCES Citas(id),
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id)
);

-- Tabla MetodoPago
CREATE TABLE MetodoPago (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL
);

-- Tabla Pagos
CREATE TABLE Pagos (
    id INT PRIMARY KEY IDENTITY(1,1),
    monto FLOAT NOT NULL,
    id_cita INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    estado NVARCHAR(50),
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cita) REFERENCES Citas(id),
    FOREIGN KEY (id_metodo_pago) REFERENCES MetodoPago(id)
);
