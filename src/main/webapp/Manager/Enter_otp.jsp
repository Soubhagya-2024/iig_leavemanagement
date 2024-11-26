<%-- 
    Document   : Employee_Login
    Created on : 6 Dec, 2023, 2:48:40 PM
    Author     : uduma
--%>


<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter otp</title>

    <style>

        .navbar{
            background-color:#001c4e;
            border-radius: 12px;
        }
        button {
    padding: 8px 20px;
    background-color: #0db304;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  button1 {
    padding: 8px 20px;
    background-color: #5405dc;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
        .navbar ul{
            overflow: auto;
        }
        .navbar li{
            float: left;
            list-style: none;
            margin: 20px 28px;
        }
       .navbar li a {
            padding: 2px 2px;
            text-decoration: none;
            color: white;
            
            transition: transform 0.2s;
            display: inline-block; /* Ensures the elements have dimensions to scale */
        }

        .navbar li a:hover {
           
            transform: scale(1.2);
        }
        body{
    background-image: url(Image1.jpg);
    background-size: cover;
    background-repeat: no-repeat;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; 
}
    </style>
    <style>
        

.body1 {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.login-container {
    padding: 20px;
    border: 2px solid #ccc;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    width: 100%;
    height: 550px;
   

}

.login-container h2 {
    text-align: center;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
}

.form-group input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
    font-size: 16px;
}

.form-group button {
    width: 100%;
    padding: 8px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 3px;
    font-size: 16px;
    cursor: pointer;
}

footer {
    background-color: #001c4e;
    color: #fff;
    text-align: center;
    padding: 10px;
    position: fixed; /* Change position to 'fixed' */
    bottom: 0;
    left: 0;
    right: 0;
    width: 100%; /* Add width: 100% to make it full-width */
  }

        footer ul {
            list-style: none;
            padding: 0;
        }

        footer li {
            display: inline;
            margin: 0 10px;
        }

        footer li a {
            text-decoration: none;
            color: #fff;
        }

        footer li a:hover {
            color: #ddd;
        }


    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <ul style="font-size: 20px;" style="font-style: bold;">
                <li ><a href="home1.jsp">Home</a></li>
                <li><a href="Employee_Login.jsp">Employee Login</a></li>
                <li><a href="../Manager/Manager_Login.jsp">Manager Login</a></li>
               
                <li><a href="">About</a></li>
                <li><a href="">Contact Us</a></li>
               
            </ul>
        </nav>
        
    </header><br><br><br>
   
  
    
</body><center>

<body class="body">
    <body>
        <div class="login-container">
            <h2>Enter otp</h2>
             <div class="container">
        <!-- Sidebar and other content -->

        <!-- Image in the body -->
          <img src="../Employee/password.jpg" alt="Description of the image" width="400">
        
           <form action="verify_otp.jsp" method="post"> <!-- Form action to verify OTP -->
            <div class="form-group">
                <label for="otp"><h3>Enter OTP:</h3></label>
                <input type="text" id="otp" name="userOTP" placeholder="Enter OTP received" required>
                <input type="hidden" name="resetEmpID" value="<%= session.getAttribute("resetEmpID") %>">
            </div>
            <div class="form-group">
                <button type="submit">Verify OTP</button>
            </div>
        </form>
        </div>
        
<footer>
    <div class="footer-content">
      <p>Employee Leave Management Portal &copy; 2023</p>
      <ul>
        <li><a href="terms.html">Terms of Service</a></li>
        <li><a href="privacy.html">Privacy Policy</a></li>
      </ul>
    </div>
  </footer>
    </body>
   </center>

   <!-- JSP logic to handle OTP generation and email sending -->
  
</html>