<%@ page import="java.sql.*, java.io.*, java.nio.file.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;
InputStream inputStream = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

    // Get image data from the form
    Part filePart = request.getPart("image");
    inputStream = filePart.getInputStream();

    // Prepare SQL statement to insert image into the database
    pstmt = conn.prepareStatement("INSERT INTO images (name, image) VALUES (?, ?)");
    pstmt.setString(1, filePart.getSubmittedFileName());
    pstmt.setBlob(2, inputStream);
    pstmt.executeUpdate();

    out.println("Image uploaded successfully!");
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    try {
        if (inputStream != null) inputStream.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("Error in closing resources: " + e.getMessage());
    }
}
%>
