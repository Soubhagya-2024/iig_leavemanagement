<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
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
              <button class="dropbtn">Employee Management ▼</button>
              <div class="dropdown-content">
                 
                <a href="Add_Emp.jsp">Add Employee</a>
                <a href="View_Employees.jsp">View All Employees</a>
                  
              </div>
        </div>

            
            <div class="dropdown">
              <button class="dropbtn">Leave Management ▼</button>
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
        <section class="summary">
            <canvas id="summaryChart" width="400" height="200"></canvas>
        </section>
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

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            function logoutClicked(event) {
                event.preventDefault(); 
                const confirmed = confirm('Are you sure you want to log out?');
                if (confirmed) {
                    window.location.href = 'Manager_Login.jsp';
                }
            }

            <%@ page import="java.sql.*" %>
            <% 
                String url = "jdbc:mysql://localhost:3306/employeeleave";
                String username = "system";
                String password = "system";

                int employeeCount = 0;
                int approvedCount = 0;
                int pendingCount = 0;
                int rejectedCount = 0;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, username, password);

                    // Query to count employees
                    Statement empStatement = connection.createStatement();
                    ResultSet empResultSet = empStatement.executeQuery("SELECT COUNT(*) AS employeeCount FROM employees");

                    if (empResultSet.next()) {
                        employeeCount = empResultSet.getInt("employeeCount");
                    }

                    empResultSet.close();
                    empStatement.close();

                    // Query to count approved, pending, and rejected requests
                    Statement leaveStatement = connection.createStatement();
                    ResultSet leaveResultSet = leaveStatement.executeQuery("SELECT " +
                            "SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) AS approvedCount, " +
                            "SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pendingCount, " +
                            "SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END) AS rejectedCount " +
                            "FROM leave_requests");

                    if (leaveResultSet.next()) {
                        approvedCount = leaveResultSet.getInt("approvedCount");
                        pendingCount = leaveResultSet.getInt("pendingCount");
                        rejectedCount = leaveResultSet.getInt("rejectedCount");
                    }

                    leaveResultSet.close();
                    leaveStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            // Use retrieved data to populate the chart
            const ctx = document.getElementById('summaryChart').getContext('2d');
            const summaryChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Employees', 'Pending', 'Approved', 'Rejected'],
                    datasets: [{
                        label: 'Data from Database',
                        data: [<%= employeeCount %>, <%= pendingCount %>, <%= approvedCount %>, <%= rejectedCount %>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)', // Red shade
                            'rgba(54, 162, 235, 0.7)', // Blue shade
                            'rgba(255, 206, 86, 0.7)', // Yellow shade
                            'rgba(75, 192, 192, 0.7)', // Teal shade
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)', // Red
                            'rgba(54, 162, 235, 1)', // Blue
                            'rgba(255, 206, 86, 1)', // Yellow
                            'rgba(75, 192, 192, 1)', // Teal
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </div>
</body>
</html>
