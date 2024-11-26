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
    <title>forgot password</title>

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
            <h2>Forgot Password</h2>
             <div class="container">
        <!-- Sidebar and other content -->

        <!-- Image in the body -->
        <img src="../Employee/password.jpg" alt="Description of the image" width="400">
        
            <form action="forgot.jsp" method="post">
                <div class="form-group">
                    <label for="username"><h3>Enter Your Manager ID:</h3></label>
                    <input type="text" id="username" name="empid" placeholder="Emp ID *" required>
                </div>
               
                <div class="form-group">
                    <button type="submit">Send otp</button>
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
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.*, java.util.Random, javax.mail.*, javax.mail.internet.*, java.util.Properties"%>
    <%!
        // Function to generate OTP
        int generateOTP() {
            Random random = new Random();
            return 1000 + random.nextInt(9000); // Generates a 4-digit OTP
        }

        // Function to send OTP via email
        boolean sendOTPEmail(String email, int otp) {
            // Configure SMTP properties
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");

            // Set up sender's email and password
            final String senderEmail = "umasankardash010@gmail.com";
            final String senderPassword = "eulchexyxyvqjztn";

            Session session = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(senderEmail));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Password Reset OTP");
                message.setText("Your OTP for password reset is: " + otp);

                Transport.send(message);
                return true; // Email sent successfully
            } catch (MessagingException e) {
                e.printStackTrace();
                return false; // Failed to send email
            }
        }
    %>

    <%-- JSP code to handle sending OTP --%>
    <%
        if (request.getMethod().equals("POST")) {
            String empID = request.getParameter("empid"); // Retrieve empID from the input field

            try {
                // Replace the connection details with your database information
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
                String sql = "SELECT email FROM manager WHERE manager_id = ?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setString(1, empID);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    String email = resultSet.getString("email");
                    int otp = generateOTP();
                    boolean sent = sendOTPEmail(email, otp);

                    if (sent) {
                        // Store the OTP in session for verification on the next page
                        session.setAttribute("resetOTP", otp);
                        session.setAttribute("resetEmpID", empID);
                        %>
                        <script>
                            alert("OTP sent to registered email");
                            window.location.replace("Enter_otp.jsp");
                        </script>
                <%// Redirect to OTP verification page
                    } else {
                        // Handle failure to send OTP
                        out.println("Failed to send OTP. Please try again.");
                    }
                } else {
                    // No user found with the given empID, handle accordingly
                    out.println("Invalid Employee ID.");
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("An error occurred. Please try again later.");
            }
        }
    %>
</html>