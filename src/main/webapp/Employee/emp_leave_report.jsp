<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

String empid = (String) session.getAttribute("empid");
String fullname = (String) session.getAttribute("fullname");


if (empid != null) {
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
        String query = "SELECT DATE_FORMAT(postingdate, '%Y-%m-%d %H:%i:%s') AS postingdate, leavetype, status, startdate, enddate, reason FROM leave_requests WHERE empid = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, empid);
        ResultSet rs = pstmt.executeQuery();
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
            font-size: 30px;
            margin-bottom: 9px;
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
        <div class="employee-details">
            <p><strong>Name:</strong> <%= fullname %></p>
            <p><strong>Employee ID:</strong> <%= empid %></p>
           
        </div>
    </div>
   
    <table>
        <caption>Leave History</caption>
        <thead>
            <tr>
               				<th >Sl_No</th>
                            <th  >Applying Date</th>
                            <th >Leave Type</th>
                            <th >From Date</th>
                             <th >To Date</th>
                              <th >Reason</th>
                               <th >Status</th>
            </tr>
        </thead>
        <tbody>
         <% 
                    int slNo = 1;                    
                        while(rs.next()) {
                    %>
                            <tr>
                             <td ><%= slNo %></td>
                                <td ><%= rs.getString("postingdate") %></td>
                                <td ><%= rs.getString("leavetype") %></td>
                                 <td><%= rs.getString("startdate") %></td>
                                <td ><%= rs.getString("enddate") %></td>
                                 <td ><%= rs.getString("reason") %></td>
                     
                                <td style="color: darkgreen; font-size: 20px;"><b><%= rs.getString("status") %></b></td>
                            </tr>
                            <%
                            slNo++;
                            }%>
                            
                    <%
            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
} else {
    response.sendRedirect("Login.jsp");
}
// Generating Excel file for download
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename=Leave_report_" + session.getAttribute("fullname") + ".xls");
%>
    </tbody>
</table>
</body>
</html>
