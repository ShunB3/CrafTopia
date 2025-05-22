document.addEventListener('DOMContentLoaded', () => {
  const tabla = document.getElementById('tablaVersiones');

  fetch('/api/versiones')
    .then(res => res.json())
    .then(versiones => {
      versiones.forEach((v, index) => {
        const fila = document.createElement('tr');

        fila.innerHTML = `
          <td>${index + 1}</td>
          <td>${v.nombre}</td>
          <td>${new Date(v.fecha).toLocaleDateString()}</td>
          <td>${v.tamano}</td>
          <td>${v.version}</td>
          <td>${v.descargas}</td>
          <td><a href="${v.enlace}" class="descargar-btn">Descargar</a></td>
        `;

        tabla.appendChild(fila);
      });
    })
    .catch(err => {
      console.error('Error al cargar versiones:', err);
    });
});