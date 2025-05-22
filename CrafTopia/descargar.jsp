<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Obtener el id pasado como parámetro
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("No se proporcionó un ID.");
        return;
    }
    int id = Integer.parseInt(idStr);
    
    Connection con = null;
    PreparedStatement pst = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftopia", "root", "");
        
        // Incrementar el contador en la base de datos
        String sql = "UPDATE versiones SET descargas = descargas + 1 WHERE id = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, id);
        pst.executeUpdate();
    } catch(Exception ex) {
        out.println("Error al actualizar descargas: " + ex.getMessage());
        return;
    } finally {
        if(pst != null) try { pst.close(); } catch(Exception ex) {}
        if(con != null) try { con.close(); } catch(Exception ex) {}
    }
    
    // Enviar el archivo para descarga
    String filePath = application.getRealPath("/") + "jar" + File.separator + "craftopia-1.0.0.jar";
    File downloadFile = new File(filePath);
    if (!downloadFile.exists()) {
        out.println("El archivo no se encontró.");
        return;
    }
    
    response.setContentType("application/java-archive");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadFile.getName() + "\"");
    
    FileInputStream inStream = new FileInputStream(downloadFile);
    ServletOutputStream outStream = response.getOutputStream();
    
    byte[] buffer = new byte[4096];
    int bytesRead = -1;
    while ((bytesRead = inStream.read(buffer)) != -1) {
        outStream.write(buffer, 0, bytesRead);
    }
    
    inStream.close();
    outStream.close();
%>
