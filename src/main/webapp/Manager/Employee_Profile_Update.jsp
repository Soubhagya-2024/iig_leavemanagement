<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
// Retrieve form data
String empId = request.getParameter("empid");
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mob");
String doj = request.getParameter("doj");
String location = request.getParameter("location");
String qualification = request.getParameter("qualification");
String department = request.getParameter("department");
String dob = request.getParameter("dob");

// JDBC driver name and database URL
String JDBC_DRIVER = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/Employeeleave";

// Database credentials
String USER = "system";
String PASS = "system";

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Register JDBC driver
    Class.forName(JDBC_DRIVER);

    // Open a connection
    conn = DriverManager.getConnection(DB_URL, USER, PASS);

    // Prepare SQL query to update employee information
    String sql = "UPDATE employees SET fullname=?, email=?, mobile=?, doj=?, location=?, qualification=?,department=?, dob=? WHERE empid=?";
    stmt = conn.prepareStatement(sql);

    // Set parameters
    stmt.setString(1, name);
    stmt.setString(2, email);
    stmt.setString(3, mobile);
    stmt.setString(4, doj);
    stmt.setString(5, location);
    stmt.setString(6, qualification);
    stmt.setString(7, department);
    stmt.setString(8, dob);
    stmt.setString(9, empId);

    // Execute the update statement
    int rowsAffected = stmt.executeUpdate();

    // Check if the update was successful
    if (rowsAffected > 0) {
    	// response.sendRedirect("Profile.jsp");
       // out.println("Employee information updated successfully!");
       out.println("<script>");
              out.println("    alert(\"Profile Updated Successfully.\");");
               out.println("    window.location.href='View_Employees.jsp';");
               out.println("</script>");
       
    } else {
      //  out.println("Failed to update employee information.");
    	 out.println("<script>");
         out.println("    alert(\"Failed to update employee information.\");");
          out.println("    window.location.href='Employee_Profile_Edit.jsp';");
          out.println("</script>");
    }
} catch (Exception e) {
    out.println("Exception: " + e.getMessage());
    e.printStackTrace();
} finally {
    // Close resources
    try {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (Exception ex) {
        out.println("Exception in closing resources: " + ex.getMessage());
        ex.printStackTrace();
    }
}
%>
