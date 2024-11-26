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
    <title>Employee_Login</title>

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
    border: 1px solid #ccc;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    width: 100%;
    background: rgb(235,208,233);
background: linear-gradient(90deg, rgba(235,208,233,0.9977240896358543) 42%, rgba(216,247,254,1) 100%);
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

 .forgot-password-link {
         display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #007bff; /* Link color */
        padding: 8px 16px;
        border: 1px solid #007bff;
        border-radius: 5px;
        transition: background-color 0.3s, color 0.3s;
         /* Increase the bottom margin */
        display: block; /* To ensure the margin-bottom works */

    .forgot-password-link:hover {
        background-color: red; /* Background color on hover */
        color: white; /* Text color on hover */
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
            <h2>Employee Login</h2>
             <div class="container">
        <!-- Sidebar and other content -->

        <!-- Image in the body -->
        <img src="profile.png" alt="Description of the image" width="200">
        
            <form action="Employee_Login.jsp">
                <div class="form-group">
                    <label for="username"><h3>Email:</h3></label>
                    <input type="text" id="username" name="email" placeholder="Email *" required>
                </div>
                <div class="form-group">
                    <label for="password"><h3>Password:</h3></label>
                    <input type="password" id="password" name="password" placeholder="password *" required>
                </div>
               <a href="forgot.jsp" class="forgot-password-link">Forgot Password?</a><br>
                <div class="form-group">
                    <button type="submit">Login</button>
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

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        


        try
        {
             Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

            PreparedStatement ps = con.prepareStatement("select * from employees where email = ? AND password = ?");

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            
         
       
  if(rs.next())
       
                {
                    response.sendRedirect("Employee_Dashboard.jsp");
                     String Fullname = rs.getString("fullname");
                     String empid = rs.getString("empid");
                     String Mobile = rs.getString("Mobile");
                     String Location = rs.getString("Location");
                     String dob = rs.getString("dob");
                     String doj = rs.getString("doj");
                     String Qualification = rs.getString("Qualification");
                    
                     
                     
//                   empid
//    
//                    // Set the attributes in the session
//                  
                    session.setAttribute("fullname", Fullname);
                   session.setAttribute("email", email);
                   session.setAttribute("empid", empid);
                   session.setAttribute("Mobile", Mobile);
                   session.setAttribute("Location", Location);
                   session.setAttribute("dob", dob);
                   session.setAttribute("doj", doj);
                   session.setAttribute("Qualification", Qualification);
                  
                   
%>
                
                <%}
                else 
 
                { 
                	
                	
                	 %>
                	 
               
               <% }
                
       
            }
                
            catch(Exception e)
            {
                
            }
              
    %>

</html>