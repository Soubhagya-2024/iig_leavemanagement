<%-- 
    Document   : Leave_request_1
    Created on : 7 Dec, 2023, 9:12:34 PM
    Author     : uduma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Request</title>
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
    margin: 50px auto;
    width: 70%;
     height: 700px;
    max-width: 700px;
    text-align: center;
    padding: 30px;
    background-color: #f5f5f5; /* Changed background color */
    border-radius: 8px; /* Slightly reduced border radius */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Enhanced box shadow */
      border: 2px solid black;
}

.large-container h2 {
    margin-bottom: 25px; /* Increased margin for h2 */
    color: #333;
    font-size: 24px; /* Increased font size */
}

.large-container label {
    display: block;
    margin-bottom: 15px; /* Increased margin bottom */
    font-weight: bold;
    color: #555;
}

.large-container select,
.large-container input[type="date"],
.large-container textarea {
    width: calc(100% - 16px);
    padding: 14px;
    border-radius: 6px; /* Slightly increased border radius */
    border: 1px solid #ddd; /* Lightened border color */
    box-sizing: border-box;
    font-size: 16px;
    margin-bottom: 18px; /* Slightly reduced margin bottom */
}

.large-container select {
    width: 100%;
}

.large-container button {
    width: 100%;
    padding: 15px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.large-container button:hover {
    background-color: #0056b3;
}
/* Style placeholders in input fields */
.large-container input[type="text"]::placeholder,
.large-container input[type="password"]::placeholder,
.large-container input[type="date"]::placeholder,
.large-container textarea::placeholder {
    color: #999; /* Placeholder text color */
    opacity: 0.7; /* Placeholder opacity */
}

/* Add a subtle border glow on focus */
.large-container input[type="text"]:focus,
.large-container input[type="password"]:focus,
.large-container input[type="date"]:focus,
.large-container textarea:focus {
    border-color: #007bff; /* Change border color on focus */
    box-shadow: 0 0 8px 0 rgba(0, 123, 255, 0.4); /* Add a subtle box shadow on focus */
}

/* Style the submit button */
.large-container button {
    transition: background-color 0.3s ease, color 0.3s ease;
}

.large-container button:hover {
    background-color: #0056b3;
    color: #fff;
    transition: background-color 0.3s ease, color 0.3s ease;
}

/* Error message for invalid input */
.large-container input:invalid,
.large-container textarea:invalid {
    border-color: #dc3545; /* Change border color for invalid input */
}

/* Success message for valid input */
.large-container input:valid,
.large-container textarea:valid {
    border-color: #28a745; /* Change border color for valid input */
}

/* Style the form submission success message */
.large-container .submission-message {
    margin-top: 20px;
    color: #28a745; /* Success message color */
    font-weight: bold;
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
       <div class="large-container" style="background-color: lightcyan;" height: 200px;">
    <h2>Leave Request Form</h2>
    <form action="Leave_request_2.jsp" method="post">
       <div class="form-group">
    <label for="employeeId"></label>
    <input type="hidden" id="employeeId" name="empid" value="<%= session.getAttribute("empid") %>" readonly style="width: 100%; height: 40px;">
</div>



<div class="form-group">
    <label for="fullname"></label>
    <input type="hidden" id="fullname" name="fullname" value="<%= session.getAttribute("fullname") %>" readonly style="width: 100%; height: 40px;">
</div>


<div class="form-group">
    <label for="fullname"></label>
    <input type="hidden" id="email" name="fullname" value="<%= session.getAttribute("email") %>" readonly style="width: 100%; height: 40px;">
</div>


        <div class="form-group">
            <label for="leaveType">Leave Type:</label>
            <select id="leaveType" name="leaveType" required>
                <option value="">Select Leave Type</option>
                <option value="Casual">Casual</option>
                <option value="Sick Leave">Sick Leave</option>
                <option value="Paid Leave">Paid Leave</option>
                <!-- Add more leave types as needed -->
            </select>
        </div>
        <div class="form-group">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required>
        </div>
        <div class="form-group">
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>
        </div>
        <div class="form-group">
    <label for="duration">Duration:</label>
    <select id="duration" name="duration" required>
        <option value="">Select Duration</option>
        <option value="Full Day">Full Day</option>
        <option value="First Half">First Half</option>
        <option value="Second Half">Second Half</option>
       
    </select>
</div>
        <div class="form-group">
            <label for="reason">Reason:</label>
            <textarea id="reason" name="reason" rows="4" placeholder="Please write the valid reason *"  required></textarea>
        </div>
        <button type="submit">Submit Request</button>
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

    </div>


 </body> 
</html>
