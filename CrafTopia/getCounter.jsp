<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain;charset=UTF-8" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.print("0");
        return;
    }
    int id = Integer.parseInt(idStr);
    
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    int counter = 0;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        
        String sql = "SELECT descargas FROM versiones WHERE id = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, id);
        rs = pst.executeQuery();
        if (rs.next()) {
            counter = rs.getInt("descargas");
        }
        out.print(counter);
    } catch(Exception e) {
        out.print("error");
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception ex) {}
        if (pst != null) try { pst.close(); } catch(Exception ex) {}
        if (con != null) try { con.close(); } catch(Exception ex) {}
    }
%>
