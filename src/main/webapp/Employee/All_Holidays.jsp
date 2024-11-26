<%-- 
    Document   : Employee_Dashboard
    Created on : 6 Dec, 2023, 1:50:46 PM
    Author     : uduma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <style>
        /* Global styles */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
         .main-content {
            flex: 1;
            padding: 20px;
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
    background-color: red; 
    color:white;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3);
    transform: translateY(-2px);
}
       .large-container {
            background-color:  #e3edf1;
            padding: 20px;
            margin: 20px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .large-container h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: black; 
        }

        .large-container p {
            font-size: 32px;
            margin-bottom: 0;
            color: blue; 
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
        <h1>Employee Dashboard</h1>
    </header>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div id="profile-card">
            <center><h2><b>Profile</b></h2></center>
           <center> <img src="user3.png" alt="Student Avatar" width="100"></center>
            
            <p><strong>Employee Id: </strong> <%= session.getAttribute("empid") %></p>
          <p><strong>Name: </strong> <%= session.getAttribute("fullname") %></p>
            <p><strong>Email: </strong><%= session.getAttribute("email") %></p>
        </div>
         <div class="sidebar-buttons">
            <!-- Add the buttons here -->
            <a href="Employee_Dashboard.jsp"><button >Home</button></a>
             <a href="Profile.jsp"><button >Update Profile</button></a>
            <a href="Leave_request_1.jsp"><button >Leave Request</button></a>
              <a href="Leave_History.jsp"><button >Leave History</button></a>
               <a href="All_Holidays.jsp"><button >Holidays</button></a>
            
        </div></div>
        <!-- Main Content -->
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
                window.location.href = 'Employee_Login.jsp';
            }
        }
    </script>
       
</body>
</html>
