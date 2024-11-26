<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Carry Forward</title>
    <script>
        function showAlert() {
            window.location.href = "ViewcarryForwardProcess.jsp"; 
        }
    </script>
</head>
<body>
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

        // Retrieve empid, left_paid_leave from employee_leave_count
        String selectQuery = "SELECT empid, left_paid_leave FROM employee_leave_count";
        pstmt = conn.prepareStatement(selectQuery);
        ResultSet rs = pstmt.executeQuery();

        // Prepare the update query
        String updateQuery = "UPDATE employee_leave_count2 " +
                             "SET total_paid_leave = total_paid_leave + ?, " +
                             "left_paid_leave = left_paid_leave + ? " +
                             "WHERE empid = ?";
        pstmt = conn.prepareStatement(updateQuery);

        while (rs.next()) {
            String empId = rs.getString("empid");
            double leftPaidLeave = rs.getDouble("left_paid_leave");

            pstmt.setDouble(1, leftPaidLeave);
            pstmt.setDouble(2, leftPaidLeave);
            pstmt.setString(3, empId);
            pstmt.executeUpdate();
        }

        out.println("<script>showAlert();</script>");

        // Close resources
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
    %>
</body>
</html>
