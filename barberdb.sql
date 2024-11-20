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

-- ---------------------------------------------

-- Hacer consultas con su respectivo enunciado:

-- 1. Con inner join con tres o más tablas.

/* Enunciado: Obtener el nombre del cliente, el nombre del empleado 
y el servicio asociado a cada cita, solo para las citas que están programadas o completadas.*/

SELECT Clientes.nombre as "Cliente", Empleados.nombre as "Empleado", Servicios.nombre as "Servicio"
FROM Citas
INNER JOIN Clientes ON Citas.id_cliente = Clientes.id
INNER JOIN Empleados ON Citas.id_empleado = Empleados.id
INNER JOIN CitasServicios ON Citas.id = CitasServicios.id_cita
INNER JOIN Servicios ON CitasServicios.id_servicio = Servicios.id
WHERE Citas.estado IN ('Programada', 'Completada');


-- 2. Con todas las cláusulas.

/*Enunciado: Obtener la cantidad de citas programadas y completadas
por cada empleado, filtrando por aquellos que tengan más de 1 cita y
ordenando por la cantidad de citas de manera descendente.*/

SELECT Empleados.nombre, COUNT(Citas.id) AS "Cantidad Citas"
FROM Empleados
INNER JOIN Citas ON Empleados.id = Citas.id_empleado
WHERE Citas.estado IN ('Programada', 'Completada')
GROUP BY Empleados.nombre
HAVING COUNT(Citas.id) > 1
ORDER BY "Cantidad Citas" DESC;

-- 3. Agrupación y filtro de grupos con dos o más tablas.

/*Enunciado: Obtener el total de pagos por servicio, 
agrupado por servicio, para las citas que ya se han pagado.*/

SELECT Servicios.nombre, SUM(Pagos.monto) AS "Total Pagos"
FROM Pagos
INNER JOIN Citas ON Pagos.id_cita = Citas.id
INNER JOIN CitasServicios ON Citas.id = CitasServicios.id_cita
INNER JOIN Servicios ON CitasServicios.id_servicio = Servicios.id
WHERE Pagos.estado = 'Pagado'
GROUP BY Servicios.nombre;

-- 4. Diferencia con left join.

/*Enunciado: Obtener la lista de clientes junto con las citas que tienen 
asignadas, mostrando también aquellos clientes que no tienen citas.*/

SELECT Clientes.nombre, Citas.fecha
FROM Clientes
LEFT JOIN Citas ON Clientes.id = Citas.id_cliente;

-- 5. Diferencia con subconsulta.

/*Enunciado: Obtener el nombre de los clientes que han 
realizado pagos, excluyendo aquellos que no han pagado por su cita.*/

SELECT nombre
FROM Clientes
WHERE id IN (
	SELECT id_cliente
	FROM Citas 
	INNER JOIN Pagos ON Citas.id = Pagos.id_cita
	WHERE Pagos.estado = 'Pagado'
);


-- OPERACIONES SQL DML CRUD

-- C:
-- Crear la tabla ClientesPagos
CREATE TABLE ClientesPagos (
    id_cliente INT PRIMARY KEY,
    nombre NVARCHAR(100),
    monto FLOAT
);

-- Insertar datos en ClientesPagos desde Clientes y Pagos
INSERT INTO ClientesPagos (id_cliente, nombre, monto)
SELECT Clientes.id, Clientes.nombre, Pagos.monto
FROM Clientes
INNER JOIN Citas ON Clientes.id = Citas.id_cliente
INNER JOIN Pagos ON Citas.id = Pagos.id_cita
WHERE Pagos.estado = 'Pagado';

-- R:
-- Obtener detalles de los pagos de citas agrupados por empleado
SELECT Empleados.nombre AS "Empleado", COUNT(Pagos.id) AS "Total Pagos", SUM(Pagos.monto) AS "Monto Total"
FROM Empleados
INNER JOIN Citas ON Empleados.id = Citas.id_empleado
INNER JOIN Pagos ON Citas.id = Pagos.id_cita
WHERE Pagos.estado = 'Pagado'
GROUP BY Empleados.nombre
HAVING SUM(Pagos.monto) > 50
ORDER BY "Monto Total" DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY; -- Similar a LIMIT

-- U:
-- Actualizar el estado de citas a "Pendiente de pago" si el pago no se ha realizado
UPDATE Citas
SET estado = 'Pendiente de pago'
WHERE id IN (
    SELECT id_cita
    FROM Citas
    LEFT JOIN Pagos ON Citas.id = Pagos.id_cita
    WHERE Pagos.id IS NULL
);

-- R:
-- Eliminar citas de un empleado que ya no está en la tabla Empleados
DELETE Citas
FROM Citas
LEFT JOIN Empleados ON Citas.id_empleado = Empleados.id
WHERE Empleados.id IS NULL;

-- PROCEDIMIENTOS ALMACENADOS

/*Enunciado: Procedimiento almacenado que permite insertar una nueva cita
con cliente, empleado, fecha, estado y un servicio asociado.*/

CREATE PROCEDURE InsertarCitaConServicio
    @id_cliente INT,
    @id_empleado INT,
    @fecha DATE,
    @estado NVARCHAR(50),
    @id_servicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar la cita en la tabla Citas
        DECLARE @id_cita INT;
        INSERT INTO Citas (id_cliente, id_empleado, fecha, estado)
        VALUES (@id_cliente, @id_empleado, @fecha, @estado);

        SET @id_cita = SCOPE_IDENTITY();

        -- Insertar el servicio asociado en la tabla CitasServicios
        INSERT INTO CitasServicios (id_cita, id_servicio)
        VALUES (@id_cita, @id_servicio);

        COMMIT TRANSACTION;
        PRINT 'Cita y servicio agregado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al agregar la cita y el servicio.';
        THROW;
    END CATCH
END;

EXEC InsertarCitaConServicio
    @id_cliente = 1, 
    @id_empleado = 2, 
    @fecha = '2024-11-15', 
    @estado = 'Programada', 
    @id_servicio = 1;

/*Enunciado: Crear un procedimiento almacenado que devuelva todas las citas según el estado.*/
CREATE PROCEDURE ConsultarCitasPorEstado
    @estado NVARCHAR(50)
AS
BEGIN
    SELECT 
        Citas.id AS ID_Cita,
        Citas.fecha AS Fecha_Cita,
        Clientes.nombre AS Nombre_Cliente,
        Empleados.nombre AS Nombre_Empleado
    FROM Citas
    INNER JOIN Clientes ON Citas.id_cliente = Clientes.id
    INNER JOIN Empleados ON Citas.id_empleado = Empleados.id
    WHERE Citas.estado = @estado
    ORDER BY Citas.fecha;
END;

EXEC ConsultarCitasPorEstado @estado = 'Programada';
