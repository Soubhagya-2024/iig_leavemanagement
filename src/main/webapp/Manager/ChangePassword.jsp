<%@ page import="java.sql.*" %>
<%
    // Retrieve form data
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    // Retrieve manager ID from session
    String manager_id = (String) session.getAttribute("manager_id");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

        // Check if the new password and confirm password match
        if (newPassword.equals(confirmPassword)) {
            // Prepare SQL query to update the manager's password
            String sql = "UPDATE manager SET password = ? WHERE manager_id = ? AND password = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, manager_id);
            statement.setString(3, currentPassword);

            int rowsUpdated = statement.executeUpdate();

            if (rowsUpdated > 0) {
                // Password updated successfully
                out.println("<script>");
                out.println("alert('Password updated successfully!');");
                out.println("window.location.href='Manager_Profile.jsp';");
                out.println("</script>");
            } else {
                // Password update failed (incorrect current password or other issues)
                out.println("<script>");
                out.println("alert('Failed to update password. Please check your current password.');");
                out.println("window.location.href='Manager_Profile.jsp';");
                out.println("</script>");
            }
        } else {
            // New password and confirm password do not match
            out.println("<script>");
            out.println("alert('New password and confirm password do not match.');");
            out.println("window.location.href='Manager_Profile.jsp';");
            out.println("</script>");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
