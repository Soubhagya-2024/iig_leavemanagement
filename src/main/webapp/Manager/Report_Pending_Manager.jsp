<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

try {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
    String query = "SELECT * FROM leave_requests  WHERE status = 'Pending';";
    PreparedStatement pstmt = con.prepareStatement(query);
    ResultSet resultSet = pstmt.executeQuery();
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
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="company-name">IIG TECHNOLOGY</div>
        <div class="company-address">i-Hub, E/43, Infocity, Patia, Bhubaneswar, Odisha-751024</div>
    </div>
     <h1>Pending Requests</h1>
    <table>
        <caption>Employee Information</caption>
        <thead>
            <tr>
                 <th>Sl No</th>
                    <th>Employee ID</th>
                    <th>Name</th>
                    
                    <th>Leave Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Posting Date</th>
                    
                    <th>Reason</th>
                    <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <%
            while(resultSet.next()) {
        %>
                <tr>
                     <td><%=resultSet.getString("sl_no") %></td>
                        <td><%=resultSet.getString("empid") %></td>
                         <td><%=resultSet.getString("fullname") %></td>
                        <td><%=resultSet.getString("leavetype") %></td>
                         <td><%=resultSet.getString("startdate") %></td>
                          <td><%=resultSet.getString("enddate") %></td>
                          
                          
                          <td><%=resultSet.getString("postingdate") %></td>
                           <td><%=resultSet.getString("reason") %></td>
                         <td><%=resultSet.getString("status") %></td>
                </tr>
        <%
            }
            resultSet.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    // Generating Excel file for download
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment; filename=Pending_Request_Details.xls");
%>
    </tbody>
</table>
</body>
</html>
