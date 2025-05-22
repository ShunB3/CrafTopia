const express = require('express');
const mysql = require('mysql');
const path = require('path');
const app = express();
const port = 3000;

app.use(express.json());

// Configuración de la conexión a MySQL (asegúrate de que la BD 'craftopia' y la tabla 'versiones' existan)
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // En XAMPP, el usuario root normalmente no tiene contraseña.
  database: 'craftopia'
});

connection.connect((err) => {
  if (err) {
    console.error('Error de conexión: ', err);
    return;
  }
  console.log('Conectado a MySQL con XAMPP');
});

// Endpoint para obtener las versiones
app.get('/api/versiones', (req, res) => {
  const query = 'SELECT * FROM versiones';
  connection.query(query, (error, results) => {
    if (error) {
      return res.status(500).json({ error: error.message });
    }
    res.json(results);
  });
});

// Endpoint para descargar el .jar (se incrementa el contador de descargas)
app.get('/api/descargar/:id', (req, res) => {
  const versionId = req.params.id;
  // Incrementar el contador de descargas
  const updateQuery = 'UPDATE versiones SET descargas = descargas + 1 WHERE id = ?';
  connection.query(updateQuery, [versionId], (err, result) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    // Ruta del archivo .jar (asegúrate de tenerlo en public/files/)
    const filePath = path.join(__dirname, 'public', 'files', 'CrafTopia.jar');
    res.download(filePath, 'CrafTopia.jar', (error) => {
      if (error) {
        console.error('Error al enviar el archivo:', error);
      }
    });
  });
});

// Servir archivos estáticos (CSS, JS, archivos, etc.)
app.use(express.static(path.join(__dirname, 'public')));

app.listen(port, () => {
  console.log(`Servidor ejecutándose en http://localhost:${port}`);
});
