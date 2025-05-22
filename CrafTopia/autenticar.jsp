<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        
        String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, username);
        pst.setString(2, password); // ⚠️ Solo si estás guardando la contraseña sin cifrar
        
        rs = pst.executeQuery();
        
        if (rs.next()) {
            // Guardar el nombre completo o username en sesión
            session.setAttribute("username", rs.getString("username"));
            session.setAttribute("nombre_completo", rs.getString("nombre_completo"));
            response.sendRedirect("foro.jsp");
        } else {
            out.println("Usuario o contraseña incorrectos. <a href='login.jsp'>Intentar de nuevo</a>");
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception ex) {}
        if (pst != null) try { pst.close(); } catch(Exception ex) {}
        if (con != null) try { con.close(); } catch(Exception ex) {}
    }
%>
