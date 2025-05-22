<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    Integer usuarioId = (Integer) session.getAttribute("usuario_id");
    if (usuarioId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Comentar - CrafTopia</title>
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
            width: 400px;
            border-radius: 8px;
        }
        textarea {
            width: 90%;
            height: 120px;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
        }
        input[type="submit"] {
            padding: 0.5rem 1rem;
            background-color: #00cc99;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #00b386;
        }
        a {
            color: #00cc99;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h2>Nuevo Comentario</h2>
    <form method="post" action="guardarComentario.jsp">
        <textarea name="contenido" placeholder="Escribe tu comentario..." required></textarea><br>
        <input type="submit" value="Publicar">
    </form>
    <p><a href="foro.jsp">Volver al Foro</a></p>
</body>
</html>
