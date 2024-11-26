<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Delete Data</title>
</head>
<body>
    <% 
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

        String sql = "DELETE FROM Employee_leave_count2"; // Delete all records

        Statement stmt = con.createStatement();
        int rowsAffected = stmt.executeUpdate(sql);

        if (rowsAffected > 0) {
        	 out.println("<script>alert('All records deleted successfully!');</script>");
        	  response.sendRedirect("ViewcarryForwardProcess.jsp");
        } else {
            out.println("<script>alert('No records found for deletion.');</script>");
        }

        stmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
    %>
</body>
</html>
