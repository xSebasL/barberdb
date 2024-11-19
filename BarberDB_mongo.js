//CREACIÓN DE BASE DE DATOS
// test> use BarberDB
//switched to db BarberDB 

//CREACIÓN DE COLECCIONES
BarberDB> db.createCollection("Clientes")
//{ ok: 1 }
BarberDB> db.createCollection("Empleados")
//{ ok: 1 }
BarberDB> db.createCollection("Servicios")
//{ ok: 1 }
BarberDB> db.createCollection("CitasServicios")
//{ ok: 1 }
BarberDB> db.createCollection("Pagos")
// { ok: 1 }
BarberDB> db.createCollection("Citas")
// { ok: 1 }
BarberDB> db.createCollection("Ocupaciones")
// { ok: 1 }
BarberDB> db.createCollection("MetodosPago")
// { ok: 1 }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Ocupaciones
db.Ocupaciones.insertMany([
	{
		"nombre": "barbero"
	},
	{
		"nombre": "recepcionista"
	}
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673ceb2ff63ab53c280d8190'),
//     '1': ObjectId('673ceb2ff63ab53c280d8191')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Empleados
db.Empleados.insertMany([
	{ 
		nombre: "Miguel Torres",
		ocupacion: ObjectId("673ceb2ff63ab53c280d8190"),
		telefono: "3112345678",
		direccion: "Avenida 45 #67-89" 
	},
	{ 
		nombre: "David Peña",
		ocupacion: ObjectId("673ceb2ff63ab53c280d8190"),
		telefono: "3145678901",
		direccion: "Avenida 45 #67-89" 
	},
	{ 
		nombre: "Luis Martínez",
		ocupacion: ObjectId("673ceb2ff63ab53c280d8191"),
		telefono: "3145678901",
		direccion: "Carrera 78 #12-45"
	}
])

// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673cec9df63ab53c280d8192'),
//     '1': ObjectId('673cec9df63ab53c280d8193'),
//     '2': ObjectId('673cec9df63ab53c280d8194')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Clientes
db.Clientes.insertMany(
	[
		{
			"nombre": "Andrés Ramírez",
			"telefono": "3101234567",
			"direccion": "Calle 12 #34-56"
		},
		{ 
			nombre: "Luis García",
			telefono: "3009876543",
			direccion: "Carrera 15 #25-40" 
		},
		{ 
			nombre: "Miguel Torres",
			telefono: "3112345678",
			direccion: "Avenida 45 #67-89" 
		},
		{ 
			nombre: "David Peña",
			telefono: "3145678901",
			direccion: "Avenida 45 #67-89" 
		},
		{ 
			nombre: "Luis Martínez",
			telefono: "3145678901",
			direccion: "Carrera 78 #12-45"
		}
	]
)
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673ced4af63ab53c280d8195'),
//     '1': ObjectId('673ced4af63ab53c280d8196'),
//     '2': ObjectId('673ced4af63ab53c280d8197'),
//     '3': ObjectId('673ced4af63ab53c280d8198'),
//     '4': ObjectId('673ced4af63ab53c280d8199')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Servicios

db.Servicios.insertMany([
	{
		"nombre": "Corde de Cabello",
		"precio": 30.00
	},
	{
		"nombre": "Afeitado",
		"precio": 20.00
	},
	{
		"nombre": "Arreglo de Barba",
		"precio": 25.00
	}
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673cee10f63ab53c280d819a'),
//     '1': ObjectId('673cee10f63ab53c280d819b'),
//     '2': ObjectId('673cee10f63ab53c280d819c')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN MetodosPago

db.MetodosPago.insertMany([
	{
		"nombre": "efectivo"
	},
	{
		"nombre": "tarjeta de credito"
	}
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673cf6caf63ab53c280d819d'),
//     '1': ObjectId('673cf6caf63ab53c280d819e')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN MetodosPago

db.MetodosPago.insertMany([
	{
		"nombre": "efectivo"
	},
	{
		"nombre": "tarjeta de credito"
	}
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673cff65f63ab53c280d81a7'),
//     '1': ObjectId('673cff65f63ab53c280d81a8')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Citas

db.Citas.insertMany([
	{
		"id_cliente": ObjectId("673ced4af63ab53c280d8195"),
		"id_empleado": ObjectId("673cec9df63ab53c280d8192"),
		"servicios": [
			ObjectId("673cee10f63ab53c280d819a"),
			ObjectId("673cee10f63ab53c280d819c")
		],
		"fecha": new Date("2024-11-15"),
		"estado": "programada"
	},
	{
		"id_cliente": ObjectId("673ced4af63ab53c280d8196"),
		"id_empleado": ObjectId("673cec9df63ab53c280d8193"),
		"servicios": [
			ObjectId("673cee10f63ab53c280d819c")
		],
		"fecha": new Date("2024-11-16"),
		"estado": "completada"
	},
	{
		"id_cliente": ObjectId("673ced4af63ab53c280d8197"),
		"id_empleado": ObjectId("673cec9df63ab53c280d8192"),
		"servicios": [
			ObjectId("673cee10f63ab53c280d819b")
		],
		"fecha": new Date("2024-11-17"),
		"estado": "cancelada"
	},
	{
		"id_cliente": ObjectId("673ced4af63ab53c280d8198"),
		"id_empleado": ObjectId("673cec9df63ab53c280d8193"),
		"servicios": [
			ObjectId("673cee10f63ab53c280d819a"),
			ObjectId("673cee10f63ab53c280d819c")
		],
		"fecha": new Date("2024-11-18"),
		"estado": "programada"
	},
	{
		"id_cliente": ObjectId("673ced4af63ab53c280d8199"),
		"id_empleado": ObjectId("673cec9df63ab53c280d8192"),
		"servicios": [
			ObjectId("673cee10f63ab53c280d819a")
		],
		"fecha": new Date("2024-11-19"),
		"estado": "completada"
	}
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673cff72f63ab53c280d81a9'),
//     '1': ObjectId('673cff72f63ab53c280d81aa'),
//     '2': ObjectId('673cff72f63ab53c280d81ab'),
//     '3': ObjectId('673cff72f63ab53c280d81ac'),
//     '4': ObjectId('673cff72f63ab53c280d81ad')
//   }
// }

//CREACIÓN DE DOCUMENTOS PARA LA COLECCIÓN Pagos
db.Pagos.insertMany([
	{
		"monto": 30.00,
		"id_cita": ObjectId("673cff72f63ab53c280d81a9"),
		"id_metodo_pago": ObjectId("673cff65f63ab53c280d81a7"),
		"estado": "pagado",
		"fecha": new Date("2024-11-15")
	},
	{
		"monto": 20.00,
		"id_cita": ObjectId("673cff72f63ab53c280d81aa"),
		"id_metodo_pago": ObjectId("673cff65f63ab53c280d81a8"),
		"estado": "pendiente",
		"fecha": new Date("2024-11-16")
	},
	{
		"monto": 25.00,
		"id_cita": ObjectId("673cff72f63ab53c280d81ab"),
		"id_metodo_pago": ObjectId("673cff65f63ab53c280d81a7"),
		"estado": "pagado",
		"fecha": new Date("2024-11-17")
	},
	{
		"monto": 30.00,
		"id_cita": ObjectId("673cff72f63ab53c280d81ac"),
		"id_metodo_pago": ObjectId("673cff65f63ab53c280d81a8"),
		"estado": "cancelado",
		"fecha": new Date("2024-11-18")
	},
	{
		"monto": 20.00,
		"id_cita": ObjectId("673cff72f63ab53c280d81ad"),
		"id_metodo_pago": ObjectId("673cff65f63ab53c280d81a7"),
		"estado": "pagado",
		"fecha": new Date("2024-11-19")
	},
])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('673d0592a00bb8197a0d8190'),
//     '1': ObjectId('673d0592a00bb8197a0d8191'),
//     '2': ObjectId('673d0592a00bb8197a0d8192'),
//     '3': ObjectId('673d0592a00bb8197a0d8193'),
//     '4': ObjectId('673d0592a00bb8197a0d8194')
//   }
// }