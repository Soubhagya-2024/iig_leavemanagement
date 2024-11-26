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
    <title>Add holidays</title>
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
            background-color:#001c4e;
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
   
        
        .large-container {
        background-color: lightcyan;
        padding: 20px;
        margin: 50px auto;
        text-align: center;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 40%;
        height: 540px;
        border: 2px solid black;
    }

    .large-container h2 {
        font-size: 34px;
        margin-bottom: 40px;
        color: black; /* Blue color for headings */
    }

    .large-container form {
        display: flex;
        flex-direction: column;
       
        width: 100%; /* Adjust the width of the form */
        max-width: 600px; /* Set a maximum width */
        margin: 0 auto; /* Center the form */
       
    }

    .large-container form div {
        margin-bottom: 15px;
        width: 100%;
         /* Adjust the width of the form fields */
    }

    .large-container form label {
        display: block;
        margin-bottom: 20px;
         margin-top: 20px;
        color: #333;
        font-weight: bold;
        text-align: left;
        font-size:20px;
    }

    .large-container form input[type="text"],
    .large-container form input[type="email"],
    .large-container form input[type="password"],
    .large-container form input[type="date"],
    .large-container form input[type="number"],
    .large-container form input[type="tel"] {
        width: 100%;
        padding: 17px;
        border-radius: 10px;
        border: 1px solid #ccc;
        box-sizing: border-box;
        font-size: 18px;
    }

    .large-container form button[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 40px; /* Add margin between form fields and button */
        font-size:20px;
        font-weight:bold;
        
    }

    .large-container form button[type="submit"]:hover {
        background-color: #0056b3;
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
         <div class="large-container">
     <h2>Add Holidays</h2>
        <form action="Insert_Holidays.jsp" method="post">
            <label for="holidayName">Holiday Name:</label>
            <input type="text" id="holidayName" name="holidayName" required>

            <label for="holidayDate">Holiday Date:</label>
            <input type="date" id="holidayDate" name="holidayDate" required>

            <button type="submit">Submit</button>
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
            event.preventDefault(); 
            
            const confirmed = confirm('Are you sure you want to log out?');

            if (confirmed) {
              
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




    </body>
</html>

