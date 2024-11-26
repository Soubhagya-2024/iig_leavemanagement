<%@ page import="java.sql.*" %>
<%
    String empid = request.getParameter("empid");
    String fullname = request.getParameter("fullname");

    
    String url = "jdbc:mysql://localhost:3306/Employeeleave";
    String username = "system";
    String password = "system";

    try {
       
        Connection con = DriverManager.getConnection(url, username, password);

     
        String deleteLeaveCountQuery = "DELETE FROM employee_leave_count WHERE empid = ?";
        
      
        String deleteEmployeeQuery = "DELETE FROM employees WHERE empid = ?";
        
       
        PreparedStatement deleteLeaveCountStatement = con.prepareStatement(deleteLeaveCountQuery);
        PreparedStatement deleteEmployeeStatement = con.prepareStatement(deleteEmployeeQuery);
        
      
        deleteLeaveCountStatement.setString(1, empid);
        deleteEmployeeStatement.setString(1, empid);

      
        int leaveCountRowsDeleted = deleteLeaveCountStatement.executeUpdate();
        int employeeRowsDeleted = deleteEmployeeStatement.executeUpdate();

     
        con.close();

  
        if (leaveCountRowsDeleted > 0 && employeeRowsDeleted > 0) {
       
            out.println("<script>alert('Employee with ID " + empid + " and Name " + fullname + " has been deleted successfully .');</script>");
          
            out.println("<script>setTimeout(function(){ window.location.href = 'View_Employees.jsp'; }, 10);</script>");
        } else {
            out.println("<script>alert('No employee found with ID " + empid + ". Deletion failed.');</script>");
        }
    } catch (Exception e) {
       
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>
