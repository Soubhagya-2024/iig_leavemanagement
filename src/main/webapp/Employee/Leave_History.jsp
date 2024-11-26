<%-- 
    Document   : Employee_Dashboard
    Created on : 6 Dec, 2023, 1:50:46 PM
    Author     : uduma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Histroy</title>
    <style>
        /* Global styles */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
        
        header {
            background-color:#001c4e;
            color: #fff;
            padding: 8px;
            text-align: center;
        }

        .container {
            display: flex;
            flex-direction: row;
        }
        
        .sidebar {
            width: 250px;
            background-color:#001c4e;
            padding: 15px;
            height: 100vh;
        }
        
        .profile-card {
            border: 4px solid rgb(255, 5, 5);
            padding: 16px;
            background-color: #fbfffe;
            text-align: left;
            margin-bottom: 20px;
        }

        .profile-card img {
            width: 100px;
            display: block;
            margin: 0 auto;
            margin-bottom: 15px;
        }

        .profile-card p {
            margin-bottom: 10px;
        }

        .sidebar-buttons {
            margin-top: 20px;
        }
        
            .sidebar-buttons button {
    display: block;
    width: 100%;
    padding: 12px 20px;
    margin-bottom: 10px;
    border: none;
    background-color: white;
    color: black;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.3s ease;
    text-decoration: none;
    font-weight: bold;
    border-radius: 5px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
}
        .sidebar-buttons a{
        text-decoration: none;
        }
       .sidebar-buttons button:hover {
    background-color: red; /* Darker background color */
    color:white;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3);
    transform: translateY(-2px); /* Push the button slightly on hover */
}
        
        .leave-container {
            display: flex;
            align-items: center;
            margin-top: 20px;
            margin-left: 90px;
            flex-direction: column;
        }

        /* Styles for leave information */
        .leave-info {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            margin-top: 20px;
            width: 100%;
        }

        .leave-box {
            flex: 1;
         
            background-color: LightCoral;
            padding: 20px;
            margin: 0 10px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
          .leave-box1 {
            flex: 1;
         
            background-color: Lightblue;
            padding: 20px;
            margin: 0 10px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
          .leave-box2 {
            flex: 1;
         
            background-color: Lightgreen;
            padding: 20px;
            margin: 0 10px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
 .leave-box h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: black;
        }

        .leave-box p {
            font-size: 32px;
            margin-bottom: 0;
            color: white;
        } 
        .leave-box1 h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: black;
        }

        .leave-box1 p {
            font-size: 32px;
            margin-bottom: 0;
            color: white;
        } 
        .leave-box2 h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: black;
        }

        .leave-box2 p {
            font-size: 32px;
            margin-bottom: 0;
            color: white;
        } 
        

        /* Styles for the leave history table */
        .leave-history-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .leave-history-table caption {
            font-weight: bold;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .leave-history-table th,
        .leave-history-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        .leave-history-table thead {
           background-color: #4287f5; /* Header color */
            color: white;
            style="font-size: px;"
        }

        .leave-history-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .logout {
            position: absolute;
            top: 9px;
            right: 40px;
            padding: 8px 20px;
            text-decoration: none;
        }
               
       .button-container {
    display: flex;
    justify-content: flex-end; /* Aligns items to the right */
    margin-top: 20px; /* Adjust the margin as needed */
}

.download-buttons {
    display: flex;
    justify-content: flex-end;
    align-items: right;
}

.download-btn {
    margin-left: 10px; /* Adjust the margin between buttons */
}

.spacer {
    flex: 1;
}


.download-btn button:hover {
    background-color: #0056b3;
}
   .leave-box,
    .leave-box1,
    .leave-box2 {
        position: relative;
        transition: transform 0.9s ease;
        transform-style: preserve-3d;
    }

    .leave-box:hover,
    .leave-box1:hover,
    .leave-box2:hover {
        transform: rotateY(180deg);
         background-color: orange;
         color:white;
    }

    /* Front and back styles for the box */
    .leave-box .front,
    .leave-box1 .front,
    .leave-box2 .front,
    .leave-box .back,
    .leave-box1 .back,
    .leave-box2 .back {
        position: absolute;
        width: 100%;
        height: 100%;
        backface-visibility: hidden;
    }

    .leave-box .front,
    .leave-box1 .front,
    .leave-box2 .front {
        transform: rotateY(0deg);
    }

    .leave-box .back,
    .leave-box1 .back,
    .leave-box2 .back {
        transform: rotateY(180deg);
    }

    /* Additional text style for back side */
    .additional-text {
        display: none;
        margin-top: 10px;
        font-size: 18px;
        color: black;
        transition: opacity 0.3s ease;
    }

    .leave-box:hover .additional-text,
    .leave-box1:hover .additional-text,
    .leave-box2:hover .additional-text {
        display: block;
        opacity: 1;
    }
    </style>
</head>
<body>
    <header>
        <h1>Employee Dashboard</h1>
    </header>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="profile-card">
                <h2 style="text-align: center;"><b>Profile</b></h2>

                <img src="user3.png" alt="Student Avatar">
                <p ><strong >Employee Id: </strong> <%= session.getAttribute("empid") %></p>
                <p><strong>Name: </strong> <%= session.getAttribute("fullname") %></p>
                <p><strong>Email: </strong><%= session.getAttribute("email") %></p>
            </div>
            <div class="sidebar-buttons">
            <a href="Employee_Dashboard.jsp"><button >Home</button></a>
             <a href="Profile.jsp"><button >Update Profile</button></a>
            <a href="Leave_request_1.jsp"><button >Leave Request</button></a>
              <a href="Leave_History.jsp"><button >Leave History</button></a>
              <a href="All_Holidays.jsp"><button >Holidays</button></a>
             
               
            </div>
        </div>
           <%@ page import="java.sql.*" %>
        <%@ page import="javax.servlet.http.*" %>
        <% 
            String empid = (String) session.getAttribute("empid");
            if (empid != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

                    // Retrieve leave count details based on empid
                    String leaveCountQuery = "SELECT left_casual_leave, left_sick_leave, left_paid_leave,total_used_casual_leave,total_used_sick_leave FROM employee_leave_count WHERE empid = ?";
                    PreparedStatement leaveCountStmt = con.prepareStatement(leaveCountQuery);
                    leaveCountStmt.setString(1, empid);
                    ResultSet leaveCountResult = leaveCountStmt.executeQuery();

                    if (leaveCountResult.next()) {
                        double leftCasualLeave = leaveCountResult.getDouble("left_casual_leave");
                        double leftSickLeave = leaveCountResult.getDouble("left_sick_leave");
                        double leftPaidLeave = leaveCountResult.getDouble("left_paid_leave");
                        double total_used_casual_leave = leaveCountResult.getDouble("total_used_casual_leave");
                        double total_used_sick_leave = leaveCountResult.getDouble("total_used_sick_leave");
                        
        %>
                        <!-- Display the retrieved leave count details -->
                      
     
        <!-- Main Content -->
        <div class="leave-container">
            
            <div class="leave-info">
                <div class="leave-box">
                    <div class="front">
                <h2>Left Casual Leave</h2>
                <p><%= leftCasualLeave %> Days</p>
            </div>
            <div class="back">
               <h2>Used Casual Leave</h2>
                <p><%= total_used_casual_leave %> Days</p>
            </div>
        </div>
               <div class="leave-box1">
                    <div class="front">
                <h2>Left Sick Leave</h2>
                <p><%= leftSickLeave %> Days</p>
            </div>
            <div class="back">
               <h2>Used Sick Leave</h2>
                <p><%= total_used_sick_leave %> Days</p>
            </div>
        </div>
                <div class="leave-box2">
                    <h2>Left Paid Leave</h2>
                    <p><%= leftPaidLeave %> Days</p>
                </div>
            </div>
               <%
                    }

                    // Close the database connections
                    leaveCountResult.close();
                    leaveCountStmt.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                response.sendRedirect("Employee_Login.jsp");
            }
        %>
            <!-- Leave History Table -->
            
          
                <tbody>
                <%@ page import="java.sql.*" %>
    <%@ page import="javax.servlet.http.*" %>
    
    <%
       
        if (empid != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
                String query = "SELECT postingdate,startdate,enddate, reason,duration,daysbetween, leavetype, status FROM leave_requests WHERE empid = ?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, empid);
                ResultSet rs = pstmt.executeQuery();
    %>
    <br>
    <div class="download-buttons">
    
    <a href="emp_leave_report.jsp" class="download-btn">
    <button>
        <img src="xls.png" alt="excel Image" width="40" height="40">
       
    </button>
</a>
<div class="spacer"></div>

<a href="emp_leave_pdf.jsp" class="download-btn">
    <button>
        <img src="pdf.png" alt="excel Image" width="40" height="40">
       
    </button>
</a>
</div>
                <table class="leave-history-table">
                 <caption style="font-size: 30px;">Leave History</caption>

                    <thead>
                        <tr>
                         <th style="font-size: 25px;" >Sl_No</th>
                            <th style="font-size: 25px;" >Applying Date</th>
                            <th style="font-size: 25px;">Leave Type</th>
                            <th style="font-size: 25px;">From Date</th>
                             <th style="font-size: 25px;">To Date</th>
                              <th style="font-size: 25px;">Duration</th>
                             
                              <th style="font-size: 25px;">Reason</th>
                               <th style="font-size: 25px;">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    int slNo = 1;                    
                        while(rs.next()) {
                    %>
                            <tr>
                             <td style="font-size: 20px;"><%= slNo %></td>
                                <td style="font-size: 20px;"><%= rs.getString("postingdate") %></td>
                                <td  style="font-size: 20px;"><%= rs.getString("leavetype") %></td>
                                 <td style="font-size: 20px;"><%= rs.getString("startdate") %></td>
                                <td  style="font-size: 20px;"><%= rs.getString("enddate") %></td>
                                <td style="font-size: 20px;"><%= rs.getString("duration") %></td>
                              
                                 <td style="font-size: 20px;"><%= rs.getString("reason") %></td>
                     
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
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Logout button -->
            <a href="#" class="logout" style="text-decoration: none;">
        <button 
            style="color: white; height: 50px; width: 120px; background-color: #ff6347; border: none; border-radius: 8px; cursor: pointer; outline: none; transition: background-color 0.3s ease;"
            onmouseover="this.style.backgroundColor='#c0392b'" 
            onmouseout="this.style.backgroundColor='#ff6347'"
            onclick="logoutClicked(event)">
            <b style="font-size: 18px;">Logout</b>
        </button>
    </a>

    <script>
        function logoutClicked(event) {
            event.preventDefault(); // Prevent default link behavior
            
            const confirmed = confirm('Are you sure you want to log out?');

            if (confirmed) {
                // Redirect to the logout page or perform logout action here
                window.location.href = 'Employee_Login.jsp';
            }
        }
    </script>

    </div>
</body>
</html>
