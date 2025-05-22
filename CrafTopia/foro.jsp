<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Foro - CrafTopia</title>
    <style>
        /* (Incluye aquí todo tu CSS para foro.jsp) */
        body {
            background-color: #121212;
            color: #f2f2f2;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        nav {
            background-color: #222;
            padding: 1rem;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
        }
        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0.5rem 1rem;
            font-weight: bold;
            transition: color 0.3s;
        }
        nav a:hover {
            color: #00ffcc;
        }
        h1 {
            text-align: center;
            margin-top: 2rem;
            font-size: 2.2rem;
        }
        p.welcome {
            text-align: center;
            margin: 1rem auto;
            font-size: 1.1rem;
        }
        .btn-comentar {
            display: inline-block;
            background-color: #00cc99;
            color: #fff;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            margin: 1.5rem auto;
            transition: background 0.3s;
        }
        .btn-comentar:hover {
            background-color: #00b386;
        }
        .comentario {
            max-width: 800px;
            background-color: #1e1e1e;
            margin: 1rem auto;
            padding: 1rem 1.5rem;
            border-left: 4px solid #00cc99;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.3);
        }
        .comentario h4 {
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
            color: #00cc99;
        }
        .comentario p {
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }
        .comentario small {
            display: block;
            font-size: 0.9rem;
            color: #aaa;
        }
        @media (max-width: 600px) {
            nav {
                flex-direction: column;
            }
            .comentario {
                margin: 1rem;
                padding: 0.75rem 1rem;
            }
            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <nav>
        <a href="index.html">Inicio</a>
        <a href="foro.jsp">Foro</a>
        <a href="versiones.jsp">Versiones</a>
<%
    Integer usuarioId = (Integer) session.getAttribute("usuario_id");
    if (usuarioId != null) {
%>
        <a href="logout.jsp">Cerrar Sesión</a>
<%
    }
%>
    </nav>

    <h1>Foro de CrafTopia</h1>

<%
    String nombreUsuario = (String) session.getAttribute("nombre_usuario");
    if (usuarioId != null) {
%>
    <p class="welcome">Bienvenido, <strong><%= nombreUsuario %></strong> &mdash; <a href="comentar.jsp" style="color:#00ffcc; text-decoration:underline;">Comentar</a></p>
<%
    } else {
%>
    <p class="welcome"><a href="login.jsp" style="color:#00ffcc; text-decoration:underline;">Inicia sesión</a> para comentar.</p>
<%
    }
%>

    <h3 style="text-align: center; margin-top: 1rem;">Comentarios Recientes</h3>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT c.contenido, c.fecha, u.nombre_usuario FROM comentarios c JOIN usuarios u ON c.id_usuario = u.id ORDER BY c.fecha DESC");
        while (rs.next()) {
            String autor = rs.getString("nombre_usuario");
            String contenido = rs.getString("contenido");
            Timestamp fecha = rs.getTimestamp("fecha");
%>
    <div class="comentario">
        <h4><%= autor %></h4>
        <p><%= contenido %></p>
        <small><%= fecha %></small>
    </div>
<%
        }
        rs.close();
        stmt.close();
        con.close();
    } catch(Exception e) {
        out.println("<p style='text-align:center; color:#f00;'>Error al cargar los comentarios: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
