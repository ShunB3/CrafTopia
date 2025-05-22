const express = require('express');
const mysql = require('mysql');
const path = require('path');
const app = express();
const PORT = 3000;

// Configurar la carpeta pública
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Conexión con la base de datos (ajústalo si cambias algo en XAMPP)
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // Cambia esto si tu MySQL tiene contraseña
    database: 'craftopia'
});

db.connect(err => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('🟢 Conexión exitosa a MySQL.');
});

// Ruta para obtener versiones desde la base de datos
app.get('/api/versiones', (req, res) => {
    const query = 'SELECT * FROM versiones';
    db.query(query, (err, results) => {
        if (err) {
            console.error('❌ Error al obtener versiones:', err);
            res.status(500).json({ error: 'Error en el servidor' });
        } else {
            res.json(results);
        }
    });
});

// Ruta para incrementar las descargas
app.post('/api/descargar/:id', (req, res) => {
    const id = req.params.id;
    const query = 'UPDATE versiones SET descargas = descargas + 1 WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error('❌ Error al actualizar descargas:', err);
            res.status(500).json({ error: 'Error al actualizar descargas' });
        } else {
            res.json({ message: '✅ Descarga registrada correctamente' });
        }
    });
});

// Rutas HTML
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});
app.get('/versiones', (req, res) => {
    res.sendFile(path.join(__dirname, 'versiones.html'));
});
app.get('/foro', (req, res) => {
    res.sendFile(path.join(__dirname, 'foro.html'));
});
app.get('/admin', (req, res) => {
    res.sendFile(path.join(__dirname, 'admin.html'));
});

// Iniciar servidor
app.listen(PORT, () => {
    console.log(`🚀 Servidor corriendo en: http://localhost:${PORT}`);
});
