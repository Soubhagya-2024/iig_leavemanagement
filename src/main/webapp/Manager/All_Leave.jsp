<%-- 
    Document   : Employee_Dashboard
    Created on : 6 Dec, 2023, 1:50:46 PM
    Author     : uduma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.Connection"%>
      
        <%
            try{
                  Class.forName("com.mysql.jdbc.Driver");
            }
            catch(ClassNotFoundException e)
            {
                e.printStackTrace();
            }
            %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave_Management</title>
    <style>
        /* Global styles */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
        
    header {
      background-color:  #001c4e;
      color: #fff;
      padding: 08px;
      text-align: center;
    }
    #profile-card {
            border: 4px solid rgb(255, 5, 5);
            padding: 16px;
            background-color: #fbfffe;
        }

        .container {
            display: flex;
            flex-direction: row;
        }
        /* Sidebar styles */
        .sidebar {
            width: 250px;
            background-color: #001c4e;
            padding: 15px;
            height: 100vh;
        }
        .sidebar h2 {
            margin-bottom: 20px;
        }
        .sidebar p {
            margin-bottom: 10px;
        }
        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 20px;
        }
        /* Logout styles */
        .logout {
            position: absolute;
            top: 9px;
            right: 40px;
            
            padding: 8px 20px;
            
            text-decoration: none;
    
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
         /* Updated table styles */

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px; /* Adjusted padding */
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
}

/* Hover effect on rows */
tr:hover {
    background-color: #f5f5f5;
}

/* Styling for action buttons */
.action-btn {
    padding: 8px 16px; /* Adjusted button padding */
    border: none;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease; /* Smooth transition on hover */
}

.action-btn:hover {
    background-color: #0056b3; /* Darker shade on hover */
}
/* Stylish table styles */

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px; /* Adjusted padding */
    text-align: left;
    border-bottom: 2px solid #ddd; /* Thicker bottom border */
}

th {
    background-color: #f2f2f2;
}

/* Alternate row colors */
tr:nth-child(even) {
    background-color: #f5f5f5;
}

/* Hover effect on rows */
tr:hover {
    background-color: #e6f7ff; /* Light blue on hover */
}

/* Styling for action buttons */
.action-btn {
    padding: 8px 16px;
    border: none;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease; /* Smooth transition on hover */
}

.action-btn:hover {
    background-color: #45a049; /* Darker shade on hover */
}
/* Stylish colored table styles */

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

th {
    background-color: #001c4e;
    color: white;
}

tr:nth-child(even) {
    background-color:white;
}

/* Alternate row colors */
tr:nth-child(odd) {
    background-color:white;
}

/* Hover effect on rows */
tr:hover {
    background-color: #f1f1f1;
}

/* Styling for action buttons */
.action-btn {
    padding: 8px 16px;
    border: none;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.action-btn:hover {
    background-color: #0056b3;
}

        
       .button-container {
    display: flex;
    justify-content: flex-end; /* Aligns items to the right */
    margin-top: 20px; /* Adjust the margin as needed */
}

.download-btn button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.download-btn button:hover {
    background-color: #0056b3;
}
        
    .dropdown {
    position: relative;
    display: inline-block;
   
    width: 250px;
}

/* Add animation styles */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    animation: fadeIn 0.3s ease; 
    width: 250px;
}

.dropdown-content a {
    color: #001c4e;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    font-weight: bold;
    background-color: #cecece;
    
}

.dropdown-content a:hover {
    background-color: #ff0000;
    color: white;
    font-weight: bold;
}

.dropdown:hover .dropdown-content {
    display: block;
}
        
    </style>
     
</head>
<body>
    <header>
        <h1>Manager Dashboard</h1>
    </header>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div id="profile-card">
            <center><h2><b>Profile</b></h2></center>
           <center> <img src="user3.png" alt="Student Avatar" width="100"></center>
           
            <p><strong>manager_id:</strong> <%= session.getAttribute("manager_id") %></p>
           <p><strong>Name:</strong> <%= session.getAttribute("name") %></p>
            <p><strong>Email:</strong><%= session.getAttribute("email") %></p>
        </div>
          <div class="sidebar-buttons">
            <!-- Add the buttons here -->
            <a href="Manager_Dashboard.jsp"><button >Dashboard</button></a>
            <a href="Manager_Profile.jsp"><button >Profile</button></a>
            <a href="Leave_Management.jsp"><button >Leave Requests</button></a>
          
          
            

            <div class="dropdown">
              <button class="dropbtn">Employee Management</button>
              <div class="dropdown-content">
                 
                <a href="Add_Emp.jsp">Add Employee</a>
                <a href="View_Employees.jsp">View All Employees</a>
                  
              </div>
        </div>

            
            <div class="dropdown">
              <button class="dropbtn">Leave Management</button>
              <div class="dropdown-content">
                 
                  <a href="All_Leave.jsp">All Leave</a>
                  <a href="Pending_Leave.jsp">Pending Leave</a>
                  <a href="Approved_Leave.jsp">Approved Leave</a>
                  <a href="Reject_List.jsp">Reject Leave</a>
              </div>
        </div>
            <div class="dropdown">
              <button class="dropbtn">Holidays</button>
              <div class="dropdown-content">
                 
                  <a href="All_Holidays.jsp">All Holidays</a>
                  <a href="Add_Holidays.jsp">Add Holidays</a>
                  <a href="Edit_Holidays.jsp">Edit Holidays</a>
              </div>
        </div>
      </div>
</div>
        <!-- Main Content -->
        
          <div class="main-content">
           <a href="Report_All_Leave.jsp" class="download-btn">
    <button>
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-excel" viewBox="0 0 16 16">
            <path d="M5.293 1.293a1 1 0 0 1 1.414 0l8 8a1 1 0 0 1 0 1.414l-8 8a1 1 0 0 1-1.414-1.414L13.586 9 5.293 1.707a1 1 0 0 1 0-1.414zM10 1h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1.172l-4 4H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h4zm1 4.828V4h.828L11 5.828z"/>
        </svg>
        Export Report
    </button>
</a>

        <a href="Pdf_All_Leave.jsp" class="download-btn">
    <button style="background-color: red; color: white;">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-excel" viewBox="0 0 16 16">
            <path fill="white" d="M5.293 1.293a1 1 0 0 1 1.414 0l8 8a1 1 0 0 1 0 1.414l-8 8a1 1 0 0 1-1.414-1.414L13.586 9 5.293 1.707a1 1 0 0 1 0-1.414zM10 1h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1.172l-4 4H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h4zm1 4.828V4h.828L11 5.828z"/>
        </svg>
        Export pdf
    </button>
</a>

        <h2>All Requests</h2>
        <table border="1">
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
             <%
                try{
                      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");
                    
                    String sql="SELECT * FROM leave_requests;";
                    
                    Statement statement=con.createStatement();
                    Connection connection=null;
                    ResultSet resultSet=statement.executeQuery(sql);
                    
                   
                    while(resultSet.next())
                    {
                        
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
connection.close();
}
catch(Exception e)
                {
                 e.printStackTrace();
                }
                
                %>
            
            
            
            
        </table>
    </div>
           
        
    
        <!-- Logout -->
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
                window.location.href = 'Manager_Login.jsp';
            }
        }
    </script>

    </div>
       
</body>
<script>
        function toggleButtons() {
            var buttons = document.querySelector('.button-container');
            buttons.style.display = buttons.style.display === 'none' ? 'flex' : 'none';
        }
    </script>
</html>
</html>
