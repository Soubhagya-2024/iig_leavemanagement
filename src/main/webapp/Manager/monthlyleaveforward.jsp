<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
 <script>
        function showAlert() {
           // alert("Leave Details carried forward successfully!");
            window.location.href = "ViewcarryForwardProcess.jsp"; 
        }
        b 
    </script>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

        // Retrieve all employee IDs
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT empid FROM employee_leave_count");

        while (rs.next()) {
            String empid = rs.getString("empid");

            // Update leaves for each employee
          String updateQuery = "UPDATE employee_leave_count SET " +
    "Total_Casual_Leave = Total_Casual_Leave + 1.0, " +
    "Total_Sick_Leave = Total_Sick_Leave + 1.0, " +
    "Total_Paid_Leave = Total_Paid_Leave + 1.0, " +
    "left_Casual_Leave = left_Casual_Leave + 1.0, " +
    "left_Sick_Leave = left_Sick_Leave + 1.0, " +
    "left_Paid_Leave = left_Paid_Leave + 1.0 " +
    "WHERE empid = ?";

                    
            PreparedStatement pstmt = con.prepareStatement(updateQuery);
            pstmt.setString(1, empid);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Leaves incremented successfully for each employee
            	
            	out.println("<script>alert('Monthly Leave Details carried forward successfully!'); window.location.href='ViewcarryForwardProcess.jsp';</script>");
           

            } else {
                // No rows updated
                out.println("No leaves incremented for empid: " + empid);
            }

            pstmt.close();
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        // Handle exceptions
        out.println("Exception occurred: " + e.getMessage());
        e.printStackTrace();
    }
%>
