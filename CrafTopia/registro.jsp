<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - CrafTopia</title>
    <style>
        body {
            background-color: #121212;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
            padding-top: 3rem;
        }
        form {
            background-color: #2a2a2a;
            padding: 2rem;
            margin: auto;
            width: 300px;
            border-radius: 8px;
        }
        input, button {
            width: 90%;
            padding: 0.5rem;
            margin: 0.5rem 0;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
        }
        button {
            background-color: #00cc99;
            color: #fff;
            cursor: pointer;
        }
        button:hover {
            background-color: #00b386;
        }
        a {
            color: #00cc99;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h2>Registro de Usuario</h2>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String nombre = request.getParameter("nombre_usuario");
            String contrasena = request.getParameter("contrasena");
            String mensaje = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
                // Verificar si ya existe el usuario
                PreparedStatement verif = con.prepareStatement("SELECT * FROM usuarios WHERE nombre_usuario = ?");
                verif.setString(1, nombre);
                ResultSet rs = verif.executeQuery();
                if (rs.next()) {
                    mensaje = "El nombre de usuario ya está en uso.";
                } else {
                    PreparedStatement ps = con.prepareStatement("INSERT INTO usuarios(nombre_usuario, contrasena) VALUES (?, ?)");
                    ps.setString(1, nombre);
                    ps.setString(2, contrasena);
                    ps.executeUpdate();
                    mensaje = "Registro exitoso. <a href='login.jsp'>Inicia sesión</a>";
                }
                rs.close();
                verif.close();
                con.close();
            } catch (Exception ex) {
                mensaje = "Error: " + ex.getMessage();
            }
            out.println("<p>" + mensaje + "</p>");
        }
    %>
    <form method="post">
        <input type="text" name="nombre_usuario" placeholder="Nombre de usuario" required><br>
        <input type="password" name="contrasena" placeholder="Contraseña" required><br>
        <button type="submit">Registrarse</button>
    </form>
    <p>¿Ya tienes cuenta? <a href="login.jsp">Inicia Sesión</a></p>
</body>
</html>
