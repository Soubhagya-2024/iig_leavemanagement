<%@ page import="java.sql.*" %>
<%
    // Retrieve form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String qualification = request.getParameter("qualification");
    String location = request.getParameter("location");
    String dob = request.getParameter("dob");

    // Retrieve manager ID from session
    String manager_id = (String) session.getAttribute("manager_id");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
        String sql = "UPDATE manager SET name=?, email=?, mobile=?, qualification=?, location=?, dob=? WHERE manager_id=?";
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, email);
        statement.setString(3, mobile);
        statement.setString(4, qualification);
        statement.setString(5, location);
        statement.setString(6, dob);
        statement.setString(7, manager_id);

        int rowsUpdated = statement.executeUpdate();

        if (rowsUpdated > 0) {
            // Update successful
           out.println("<script>");
            out.println("alert('Manager information updated successfully!');");
            out.println("window.location.href='Manager_Profile.jsp';");
            out.println("</script>"); // Redirect to profile page after successful update
        } else {
            // Update failed
            out.println("Failed to update manager information.");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
