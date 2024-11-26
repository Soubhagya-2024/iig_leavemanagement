<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Carry Forward</title>
     <script>
     function showAlert() {
    	    alert("Employee Leave Details carried forward successfully !");
    	    setTimeout(function() {
    	        window.location.href = "carryForwardProcessleave.jsp";
    	    }, 100); // Delay of 100 milliseconds (adjust as needed)
    	}

        function errorAlert() {
            alert("Employee Details already forwarded !");
            window.location.href = "View_Employees.jsp"; 
        }
    </script>
</head>
<body>
    <%
        Connection conn = null;
        Statement stmt = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

            stmt = conn.createStatement();

            // Retrieve all employee IDs from employee_leave_count table
            String selectQuery = "SELECT empid FROM employee_leave_count";
            ResultSet rs = stmt.executeQuery(selectQuery);

            // Iterate through the result set and insert into employee_leave_count2
            String insertQuery = "INSERT INTO employee_leave_count2 (empid) VALUES (?)";
            PreparedStatement pstmt = conn.prepareStatement(insertQuery);

            while (rs.next()) {
                String empId = rs.getString("empid");
                pstmt.setString(1, empId);
                pstmt.executeUpdate();
            }

            out.println("<script>showAlert();</script>");

            // Close resources
            rs.close();
            pstmt.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>errorAlert();</script>");
        }
    %>
</body>
</html>
