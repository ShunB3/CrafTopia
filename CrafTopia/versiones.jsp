<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Versiones - CrafTopia</title>
    <style>
        body {
            background-color: #1c1c1c;
            color: #f2f2f2;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }
        nav {
            background-color: #222;
            padding: 1rem;
            display: flex;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }
        nav a:hover {
            color: #00ffcc;
        }
        h1 {
            text-align: center;
            margin-top: 2rem;
        }
        table {
            width: 80%;
            margin: 2rem auto;
            border-collapse: collapse;
            background-color: #2a2a2a;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 1rem;
            border-bottom: 1px solid #444;
            text-align: center;
        }
        th {
            background-color: #333;
        }
        a.download {
            background-color: #00cc99;
            color: #fff;
            padding: 0.5rem 1rem;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
            cursor: pointer;
        }
        a.download:hover {
            background-color: #00b386;
        }
    </style>
    <script>
        // Función que se llama al hacer clic en "Descargar"
        function descargar(id) {
            // Abrir en segundo plano (por ejemplo, en un iframe oculto) la descarga
            var iframe = document.createElement('iframe');
            iframe.style.display = 'none';
            iframe.src = 'descargar.jsp?id=' + id;
            document.body.appendChild(iframe);
            // Después de 1 segundo, llamar a getCounter.jsp para actualizar el contador en la página
            setTimeout(function() {
                actualizarContador(id);
            }, 1000);
        }

        // Función que llama a getCounter.jsp para obtener el contador actualizado
        function actualizarContador(id) {
            fetch('getCounter.jsp?id=' + id)
            .then(response => response.text())
            .then(valor => {
                document.getElementById('counter_' + id).innerText = valor;
            })
            .catch(error => console.error('Error al actualizar contador: ', error));
        }
    </script>
</head>
<body>
    <nav>
        <a href="index.html">Inicio</a>
        <a href="versiones.jsp">Versiones</a>
        <a href="foro.jsp">Foro</a>
    </nav>

    <h1>Versiones Disponibles</h1>

    <table>
        <tr>
            <th>Nombre</th>
            <th>Fecha</th>
            <th>Tamaño</th>
            <th>Versión</th>
            <th>Descargas</th>
            <th>Acción</th>
        </tr>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Asegúrate de ajustar el URL, la base de datos y credenciales
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM versiones");
        
        while (rs.next()) {
            int id = rs.getInt("id");
            String nombre = rs.getString("nombre");
            String fecha = rs.getString("fecha");
            String tamano = rs.getString("tamano");
            String version = rs.getString("version");
            int descargas = rs.getInt("descargas");
%>
        <tr>
            <td><%= nombre %></td>
            <td><%= fecha %></td>
            <td><%= tamano %></td>
            <td><%= version %></td>
            <td id="counter_<%= id %>"><%= descargas %></td>
            <td>
                <a class="download" onclick="descargar(<%= id %>)">Descargar</a>
            </td>
        </tr>
<%
        }
    } catch(Exception e) {
%>
        <tr>
            <td colspan="6">Error: <%= e.getMessage() %></td>
        </tr>
<%
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ex) {}
        if(stmt != null) try { stmt.close(); } catch(Exception ex) {}
        if(con != null) try { con.close(); } catch(Exception ex) {}
    }
%>
    </table>
</body>
</html>
