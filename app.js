// Importar dependencias
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const app = express();

// Habilitar CORS para permitir solicitudes desde el frontend
app.use(cors({
    origin: 'http://localhost',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'] // Add 'Authorization' header
}));

// Parsear las solicitudes JSON
app.use(express.json());

// Crear la conexión a la base de datos
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'plazasgourmetv2'
});

// Conectar a la base de datos
db.connect(err => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('Conectado a la base de datos');
});

// Endpoint para obtener los restaurantes
app.get('/restaurantes', (req, res) => {
    const query = 'SELECT * FROM restaurantes';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al obtener los restaurantes:', err);
            res.status(500).json({ error: 'Error al obtener los restaurantes' });
            return;
        }
        res.json(results);
    });
});

// Endpoint para crear una reserva
app.post('/reservas', (req, res) => {
    const { id_restaurante, nombre, telefono, fecha_reserva, hora_reserva, numero_personas } = req.body;
    
    // Insertar la reserva en la base de datos
    const query = 'INSERT INTO reservas (id_restaurante, nombre, telefono, fecha_reserva, hora_reserva, numero_personas) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(query, [id_restaurante, nombre, telefono, fecha_reserva, hora_reserva, numero_personas], (err, result) => {
        if (err) {
            console.error('Error al insertar la reserva:', err);
            res.status(500).json({ error: 'Error al insertar la reserva' });
            return;
        }
        res.json({ message: 'Reserva creada', id: result.insertId });
    });
});

// Endpoint para registrar un restaurante
app.post('/register', (req, res) => {
    const { email, password, name, location, foodType, totalTables, availableTables } = req.body;
    const query = 'INSERT INTO restaurantes (correo, contraseña, nombre, ubicacion, tipo_comida, mesas_totales, mesas_disponibles) VALUES (?, ?, ?, ?, ?, ?, ?)';
    db.query(query, [email, password, name, location, foodType, totalTables, availableTables], (err, result) => {
        if (err) {
            console.error('Error al registrar el restaurante:', err);
            res.status(500).json({ error: 'Error al registrar el restaurante' });
            return;
        }
        // Send back the same format as login endpoint
        res.status(201).json({ id: result.insertId });
    });
});

// Endpoint para iniciar sesión
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    console.log('Login attempt:', email, password); // Add this line for debugging
    const query = 'SELECT id FROM restaurantes WHERE correo = ? AND contraseña = ?';
    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.error('Error al iniciar sesión:', err);
            res.status(500).json({ error: 'Error al iniciar sesión' });
            return;
        }
        console.log('Login results:', results); // Add this line for debugging
        if (results.length > 0) {
            res.json({ id: results[0].id });
        } else {
            res.status(401).json({ error: 'Credenciales inválidas' });
        }
    });
});

// Endpoint para obtener un restaurante por ID
app.get('/restaurantes/:id', (req, res) => {
    const query = 'SELECT * FROM restaurantes WHERE id = ?';
    db.query(query, [req.params.id], (err, results) => {
        if (err) {
            console.error('Error al obtener el restaurante:', err);
            res.status(500).json({ error: 'Error al obtener el restaurante' });
            return;
        }
        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).json({ error: 'Restaurante no encontrado' });
        }
    });
});

// Endpoint para actualizar un restaurante
app.put('/restaurantes/:id', (req, res) => {
    const { id } = req.params;
    const { correo, nombre, ubicacion, tipo_comida, mesas_totales, mesas_disponibles } = req.body;

    console.log('Updating restaurant with ID:', id); // Debugging information
    console.log('Request body:', req.body); // Debugging information

    const query = 'UPDATE restaurantes SET correo = ?, nombre = ?, ubicacion = ?, tipo_comida = ?, mesas_totales = ?, mesas_disponibles = ? WHERE id = ?';
    db.query(query, [correo, nombre, ubicacion, tipo_comida, mesas_totales, mesas_disponibles, id], (err, result) => {
        if (err) {
            console.error('Error al actualizar el restaurante:', err);
            res.status(500).json({ error: 'Error al actualizar el restaurante' });
            return;
        }
        if (result.affectedRows > 0) {
            res.json({ message: 'Restaurante actualizado' });
        } else {
            res.status(404).json({ error: 'Restaurante no encontrado' });
        }
    });
});

// Endpoint para obtener las reservas de un restaurante
app.get('/reservas/:id_restaurante', (req, res) => {
    const query = 'SELECT * FROM reservas WHERE id_restaurante = ?';
    db.query(query, [req.params.id_restaurante], (err, results) => {
        if (err) {
            console.error('Error al obtener las reservas:', err);
            res.status(500).json({ error: 'Error al obtener las reservas' });
            return;
        }
        console.log('Reservations fetched from database:', results); // Add this line for debugging
        res.json(results);
    });
});

// Iniciar el servidor
app.listen(3000, () => {
    console.log('Servidor corriendo en http://localhost:3000');
});
