<%-- 
    Document   : Employee_Dashboard
    Created on : 6 Dec, 2023, 1:50:46 PM
    Author     : uduma
--%>
<%@ page import="java.sql.*" %>
<%
    String empid = (String) session.getAttribute("empid");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
        String sql = "SELECT * FROM employees WHERE empid = ?";
        		
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setString(1, empid);
        ResultSet resultSet = statement.executeQuery();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
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
            color: black; /* Blue color for headings */
        }

        .large-container p {
            font-size: 32px; /* Larger font size for numbers */
            margin-bottom: 0;
            color: blue; /* Green color for numbers */
        }
      
            form {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 80%;
        max-width: 600px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }

    input[type="text"],
    input[type="email"],
    input[type="date"],
    input[type="submit"] {
        width: calc(50% - 12px);
        margin-bottom: 16px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    input[type="submit"] {
        width: 100%;
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    /* Responsive styles */
    @media (max-width: 768px) {
        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="submit"] {
            width: 100%;
        }
    }
         .clearfix {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .field {
        width: 48%;
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="date"],
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    input[type="submit"] {
        width: auto;
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    /* Media queries for responsiveness */
    @media (max-width: 768px) {
        .field {
            width: 100%;
        }
    }
      form {
        background-color: lightcyan;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%; /* Adjust the width */
            max-width: 1200px; /* Set maximum width */
            margin: auto; /* Center align the form */
            border: 2px solid black;
    }
     input[type="text"],
    input[type="email"],
    input[type="date"],
    input[type="submit"] {
        width: 100%;
        padding: 12px; 
        border: 1px solid #ccc;
        border-radius: 6px; 
        box-sizing: border-box;
        font-size: 16px; /* Adjusted font size */
        font-family: Arial, sans-serif;
    }

    input[type="submit"] {
        width: auto;
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 16px;
    font-family: Arial, sans-serif;
    /* Add other necessary styles */
}
    /* Existing styles... */

/* For the change password form */
.change-password-form {
    background-color: lightcyan;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 800px;
    margin: auto;
}

.field-row {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.field {
    width: calc(32% - 10px); /* Adjust width as needed */
    margin-bottom: 15px;
}

.field label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
}

.field input[type="password"] {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 16px;
    font-family: Arial, sans-serif;
}

.field input[type="submit"] {
    width: 100%;
    background-color: #007bff;
    color: #fff;
    font-weight: bold;
    cursor: pointer;
    border: none;
    border-radius: 6px;
    padding: 12px;
    transition: background-color 0.3s;
}

.field input[type="submit"]:hover {
    background-color: #0056b3;
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
           
              <a href="Employee_Dashboard.jsp"><button >Home</button></a>
             <a href="Profile.jsp"><button >Update Profile</button></a>
            <a href="Leave_request_1.jsp"><button >Leave Request</button></a>
              <a href="Leave_History.jsp"><button >Leave History</button></a>
              <a href="All_Holidays.jsp"><button >Holidays</button></a>
            
        </div></div>
        <!-- Main Content -->
         <div class="main-content">
        <h2>Profile Update</h2>
        <form action="UpdateProfile.jsp" method="post">
            <div class="clearfix">
             <% if(resultSet.next()) { %>
                <div class="field">
                    <label for="empid" style="color: red;">Employee ID : *</label>
                    <input type="text" id="empid" name="empid" value="<%= resultSet.getString("empid") %>" readonly>
                </div>
                 <div class="field">
                    <label for="doj" style="color: red;">Date of Joining : *</label>
                    <input type="date" id="doj" name="doj" value="<%= resultSet.getString("doj") %>" readonly>
                </div>
                <div class="field">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= resultSet.getString("fullname") %>">
                </div>

                <div class="field">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= resultSet.getString("email") %>">
                </div>
                
                <div class="field">
                    <label for="mob">Mobile:</label>
                    <input type="text" id="mob" name="mob" value="<%= resultSet.getString("mobile") %>">
                </div>

               
                <div class="field">
                    <label for="location">Location:</label>
                    <input type="text" id="location" name="location" value="<%= resultSet.getString("location") %>">
                </div>
                

        <div class="field">
    <label for="qualification">Qualification:</label>
    <select id="qualification" name="qualification">
        <option value="High School" <%= resultSet.getString("qualification").equals("High School") ? "selected" : "" %>>High School</option>
        <option value="Associate Degree" <%= resultSet.getString("qualification").equals("Associate Degree") ? "selected" : "" %>>Associate Degree</option>
        <option value="Bachelor's Degree" <%= resultSet.getString("qualification").equals("Bachelor's Degree") ? "selected" : "" %>>Bachelor's Degree</option>
        <option value="Master's Degree" <%= resultSet.getString("qualification").equals("Master's Degree") ? "selected" : "" %>>Master's Degree</option>
        <option value="Doctorate" <%= resultSet.getString("qualification").equals("Doctorate") ? "selected" : "" %>>Doctorate</option>
      
    </select>
</div>
				

              <div class="field">
    <label for="department">Department:</label>
    <select id="department" name="department">
        <option value="HR" <%= resultSet.getString("department").equals("HR") ? "selected" : "" %>>HR</option>
        <option value="IT" <%= resultSet.getString("department").equals("IT") ? "selected" : "" %>>IT</option>
        <option value="Finance" <%= resultSet.getString("department").equals("Finance") ? "selected" : "" %>>Finance</option>
        <option value="Marketing" <%= resultSet.getString("department").equals("Marketing") ? "selected" : "" %>>Marketing</option>
        <option value="Operations" <%= resultSet.getString("department").equals("Operations") ? "selected" : "" %>>Operations</option>
        <option value="Sales" <%= resultSet.getString("department").equals("Sales") ? "selected" : "" %>>Sales</option>
       
    </select>
</div>

                <div class="field">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" value="<%= resultSet.getString("dob") %>">
                </div>
                 <% } else { %>
                        <p>No data found for this employee ID.</p>
                    <% } %>
            </div>

            <input type="submit" value="Update">
        </form>
        
        
         <h2>Change Password</h2>
    <form action="ChangePassword.jsp" method="post">
        <div class="clearfix">
            <div class="field">
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="field">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="field">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="field">
                <input type="submit" value="Change Password">
            </div>
        </div>
    </form>
        
        
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
<%
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
