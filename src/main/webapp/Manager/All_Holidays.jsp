<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Holiday Calender</title>
     <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.js"></script>
    <style>
        body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
        
    header {
      background-color: #001c4e;
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
    background-color: red;
    color:white;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3);
    transform: translateY(-2px);
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
 table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px; 
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color:#001c4e;
}


tr:hover {
    background-color: #f5f5f5;
}


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


table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 2px solid #ddd;
}

th {
    background-color: #001c4e;
}


tr:nth-child(even) {
    background-color: #f5f5f5;
}

/* Hover effect on rows */
tr:hover {
    background-color: #e6f7ff;
}


.action-btn {
    padding: 8px 16px;
    border: none;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.action-btn:hover {
    background-color: #45a049; 
}


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
    background-color:#001c4e;
    color: white;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

/* Alternate row colors */
tr:nth-child(odd) {
    background-color: #f9f9f9;
}


tr:hover {
    background-color: #f1f1f1;
}


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
    </style>
</head>
<body>
    <header>
        <h1>Manager Dashboard</h1>
    </header>
    <div class="container">
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
      </div></div>
    
    <div class="main-content">
            <h2>All Holidays</h2>
     <table border="1">
            <thead>
                <tr>
                     <th>SL NO</th>
                    <th>Holidays Name</th>
                    <th>Holidays Date</th>
                   
                   
                    
                    
                </tr>
            </thead>
             <%
                try{
                      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");
                    
                      String sql = "SELECT * FROM holidays WHERE DAYOFWEEK(holiday_date) != 1 AND holiday_name != 'Sunday'";

                    Statement statement=con.createStatement();
                    Connection connection=null;
                    ResultSet resultSet=statement.executeQuery(sql);
                    
                    int slNo = 1;  
                    while(resultSet.next())
                    {
                        
                    %>
                    <tr>
                    	 <td ><%= slNo %></td>
                        <td><%=resultSet.getString("holiday_name") %></td>
                        <td><%=resultSet.getString("holiday_date") %></td>
                        
                         
        
<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this employee?");
    }
</script>

       
    
              
                    </tr>
                 
                    <%
                            slNo++;
                            }%>
                            
                    <%
connection.close();
}
catch(Exception e)
                {
                 e.printStackTrace();
                }
                
                %>
            
            
            
            
        </table>
        
        
    </div>
        <a href="#" class="logout" style="text-decoration: none;">
            <button 
                style="color: white; height: 50px; width: 120px; background-color: #ff6347; border: none; border-radius: 8px; cursor: pointer; outline: none; transition: background-color 0.3s ease;"
                onmouseover="this.style.backgroundColor='#c0392b'" 
                onmouseout="this.style.backgroundColor='#ff6347'"
                onclick="logoutClicked(event)">
                <b style="font-size: 18px;">Logout</b>
            </button>
        </a>

       
    </div>
</body>
</html>
