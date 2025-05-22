<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    Integer usuarioId = (Integer) session.getAttribute("usuario_id");
    if (usuarioId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String contenido = request.getParameter("contenido");
    if (contenido == null || contenido.trim().equals("")) {
        out.println("El comentario no puede estar vacío.");
        return;
    }
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        PreparedStatement ps = con.prepareStatement("INSERT INTO comentarios (id_usuario, contenido) VALUES (?, ?)");
        ps.setInt(1, usuarioId);
        ps.setString(2, contenido);
        ps.executeUpdate();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("Error al guardar el comentario: " + e.getMessage());
        return;
    }
    response.sendRedirect("foro.jsp");
%>
