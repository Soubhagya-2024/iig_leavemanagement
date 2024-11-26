<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>

<%
// Retrieve form data
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");
String resetEmpID = request.getParameter("resetEmpID");

// Check if passwords match
if (!newPassword.equals(confirmPassword)) {
	 %>
     <script>
         alert("Passwords do not match. Please try again. !! ");
         window.location.replace("New_Password.jsp");
     </script>
<%
} else {
    try {
        // Establish database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

        // Update password in the database
        String updateQuery = "UPDATE manager SET password = ? WHERE manager_id = ?";
        PreparedStatement updateStatement = con.prepareStatement(updateQuery);
        updateStatement.setString(1, newPassword);
        updateStatement.setString(2, resetEmpID);
        int rowsAffected = updateStatement.executeUpdate();

        if (rowsAffected > 0) {
        	 %>
             <script>
                 alert("Password changed Successfully !! ");
                 window.location.replace("Manager_Login.jsp");
             </script>
        <%
        } else {
            out.println("Failed to update password. Please try again.");
        }

        // Close database connection
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while updating the password.");
    }
}
%>
