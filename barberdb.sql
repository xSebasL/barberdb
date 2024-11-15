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

-- Inserción de registros en Ocupaciones
INSERT INTO Ocupaciones (nombre) VALUES
('Barbero'),
('Recepcionista');

-- Inserción de registros en Empleados
INSERT INTO Empleados (nombre, id_ocupacion, telefono, direccion) VALUES
('Carlos Herrera', 1, '3001234567', 'Calle 123 #45-67'),
('José López', 1, '3012345678', 'Carrera 89 #12-34'),
('Ana Méndez', 2, '3023456789', 'Avenida 56 #23-89');

-- Inserción de registros en Clientes
INSERT INTO Clientes (nombre, telefono, direccion) VALUES
('Andrés Ramírez', '3101234567', 'Calle 12 #34-56'),
('Miguel Torres', '3112345678', 'Carrera 34 #56-78'),
('Juan García', '3123456789', 'Avenida 45 #67-89'),
('David Peña', '3134567890', 'Calle 67 #89-12'),
('Luis Martínez', '3145678901', 'Carrera 78 #12-45');

-- Inserción de registros en Servicios
INSERT INTO Servicios (nombre, precio) VALUES
('Corte de Cabello', 30.00),
('Afeitado', 20.00),
('Arreglo de Barba', 25.00);

-- Inserción de registros en Citas
INSERT INTO Citas (id_cliente, id_empleado, fecha, estado) VALUES
(1, 1, '2024-11-15', 'Programada'),
(2, 2, '2024-11-16', 'Completada'),
(3, 1, '2024-11-17', 'Cancelada'),
(4, 2, '2024-11-18', 'Programada'),
(5, 1, '2024-11-19', 'Completada');

-- Inserción de registros en CitasServicios
INSERT INTO CitasServicios (id_cita, id_servicio) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2);

-- Inserción de registros en MetodoPago
INSERT INTO MetodoPago (nombre) VALUES
('Efectivo'),
('Tarjeta de Crédito');

-- Inserción de registros en Pagos
INSERT INTO Pagos (monto, id_cita, id_metodo_pago, estado, fecha) VALUES
(30.00, 1, 1, 'Pagado', '2024-11-15'),
(20.00, 2, 2, 'Pendiente', '2024-11-16'),
(25.00, 3, 1, 'Pagado', '2024-11-17'),
(30.00, 4, 2, 'Cancelado', '2024-11-18'),
(20.00, 5, 1, 'Pagado', '2024-11-19');
