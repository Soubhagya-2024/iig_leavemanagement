<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%@ page import="java.sql.*" %>

<%
String empid = request.getParameter("empid");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");
        String sql = "SELECT * FROM Employees WHERE empid = ?";
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setString(1, empid);
    
        ResultSet resultSet = statement.executeQuery();
       
       
      %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #f2f2f2;
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }

        .company-name {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .company-address {
            font-style: italic;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #000;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: blue;
            color:white;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="company-name">IIG TECHNOLOGY</div>
        <div class="company-address">i-Hub, E/43, Infocity, Patia, Bhubaneswar, Odisha-751024</div>
    </div>
    <h2>Employee Information</h2>
    <table>
     
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Location</th>
                <th>Qualification</th>
                 <th>Department</th>
                <th>Date of Birth</th>
                <th>Date of Joining</th>
            </tr>
        </thead>
        <tbody>
        <%
            while(resultSet.next()) {
        %>
                <tr>
                    <td><%= resultSet.getString("empid") %></td>
                    <td><%= resultSet.getString("fullname") %></td>
                    <td><%= resultSet.getString("email") %></td>
                    <td><%= resultSet.getString("Mobile") %></td>
                    <td><%= resultSet.getString("Location") %></td>
                    <td><%= resultSet.getString("Qualification") %></td>
                     <td><%= resultSet.getString("department") %></td>
                    <td><%= resultSet.getString("dob") %></td>
                    <td><%= resultSet.getString("doj") %></td>
        <% 
            }
            %>
  <%     
  resultSet.close();
  statement.close();
  con.close();
} catch (Exception e) {
  e.printStackTrace();
}


%></tr></tbody></table>


 <%
       
        if (empid != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
                String query = "SELECT total_casual_leave,total_sick_leave,total_paid_leave, total_used_casual_leave, total_used_sick_leave, total_used_paid_leave,left_casual_leave,left_sick_leave,left_paid_leave FROM employee_leave_count WHERE empid = ?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, empid);
                ResultSet resultSet = pstmt.executeQuery();
    %>
    
       <div class="table" style="flex: 1;">
            <h2>Leave Count</h2>
            <table border="1">
             <tr>
               <th>#</th>
                <th>Total</th>
                 <th>Used</th>
                 <th>Remaining</th>
               </tr>
             <% 
                                
                        if(resultSet.next()) {
                    %>
             <tr>
               <th>Casual</th>
                <td><%= resultSet.getString("total_casual_leave") %></td>
                 <td><%= resultSet.getString("total_used_casual_leave") %></td>
                  <td><%= resultSet.getString("left_casual_leave") %></td>
               </tr>
                <tr>
               <th>Sick</th>
                <td><%= resultSet.getString("total_sick_leave") %></td>
                 <td><%= resultSet.getString("total_used_sick_leave") %></td>
                  <td><%= resultSet.getString("left_sick_leave") %></td>
               </tr>
                <tr>
               <th>Paid</th>
                <td><%= resultSet.getString("total_paid_leave") %></td>
                 <td><%= resultSet.getString("total_used_paid_leave") %></td>
                  <td><%= resultSet.getString("left_paid_leave") %></td>
               </tr>
            </table>
        </div>
          <%
                          
                            }%>
                            
                    <%
                        
                    resultSet.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                   
                }
                    %>
                    
                      <%@ page import="java.sql.*" %>
    <%@ page import="javax.servlet.http.*" %>
    
    <%
       
        if (empid != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
                String query = "SELECT postingdate,startdate,enddate, reason, leavetype, status FROM leave_requests WHERE empid = ?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, empid);
                ResultSet rs = pstmt.executeQuery();
    %>
    
        <div class="table" >
        <h2>Leave History</h2>
            <table border="1">
             <tr>
                 			<th>Sl_No</th>
                            <th>Applying Date</th>
                            <th >Leave Type</th>
                            <th >From Date</th>
                             <th>To Date</th>
                              <th>Reason</th>
                               <th>Status</th>
               </tr>
             
            
               <tr>
                 <% 
                    int slNo = 1;                    
                        while(rs.next()) {
                    %>
               
               <td><%= slNo %></td>
                <td><%= rs.getString("postingdate") %></td>
                 <td><%= rs.getString("leavetype") %></td>
                  <td><%= rs.getString("startdate") %></td>
                  <td><%= rs.getString("enddate") %></td>
                <td><%= rs.getString("reason") %></td>
                 <td><%= rs.getString("status") %></td>
               </tr>
                 <%  slNo++;
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                   
                }
                %>
            </table>
        </div>

        <%-- Generating Excel File --%>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.servlet.http.*" %>
        <% response.setContentType("application/vnd.ms-excel");
           response.setHeader("Content-Disposition", "attachment; filename=All_Employee_Details.xls");
        %>
    </body>
    </html>