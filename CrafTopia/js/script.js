document.addEventListener("DOMContentLoaded", function() {
  // Cargar versiones en la página 'versiones.html'
  const tabla = document.getElementById("tabla-versiones");
  if (tabla) {
    fetch('http://localhost:3000/api/versiones')
      .then(response => response.json())
      .then(data => {
        data.forEach(version => {
          const row = document.createElement("tr");
          row.innerHTML = `
            <td>${version.nombre}</td>
            <td>${new Date(version.fecha).toLocaleDateString("es-ES")}</td>
            <td>${version.tamano}</td>
            <td>${version.version}</td>
            <td>${version.descargas}</td>
            <td><a href="http://localhost:3000/api/descargar/${version.id}" class="btn-descargar">Descargar</a></td>
          `;
          tabla.appendChild(row);
        });
      })
      .catch(error => console.error("Error al cargar versiones:", error));
  }
});
