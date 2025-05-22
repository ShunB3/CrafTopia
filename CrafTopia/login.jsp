<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - CrafTopia</title>
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
    <h2>Iniciar Sesión</h2>
    <%
        String mensaje = "";
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE nombre_usuario=? AND contrasena=?");
                ps.setString(1, usuario);
                ps.setString(2, contrasena);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    session.setAttribute("usuario_id", rs.getInt("id"));
                    session.setAttribute("nombre_usuario", rs.getString("nombre_usuario"));
                    response.sendRedirect("foro.jsp");
                    return;
                } else {
                    mensaje = "Credenciales incorrectas.";
                }
                rs.close();
                ps.close();
                con.close();
            } catch(Exception e) {
                mensaje = "Error: " + e.getMessage();
            }
        }
    %>
    <form method="post">
        Usuario: <input type="text" name="usuario" required><br>
        Contraseña: <input type="password" name="contrasena" required><br>
        <button type="submit">Ingresar</button>
    </form>
    <p style="color:red;"><%= mensaje %></p>
    <p>¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
</body>
</html>
