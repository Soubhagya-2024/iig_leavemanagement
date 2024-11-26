<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>

  
</head>
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
button.button,
    button.button1 {
        padding: 12px 30px; /* Adjust the padding as needed */
        font-size: 18px; /* Adjust the font size as needed */
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
background-image: url(b1.png);

background-size: cover;
background-repeat: no-repeat;
 font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}


    /* Previous styles... */
    @media (max-width: 768px) {
      /* Adjust navigation bar for smaller screens */
      .navbar ul {
        display: flex;
        flex-direction: column;
      }
      .navbar li {
        float: none;
        margin: 10px 0;
      }
    }
    .call-to-action {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }

    /* Add margin between the buttons */
    .call-to-action button {
      margin: 0 10px;
    }
  
    footer {
            background-color:#001c4e;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
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
  
  
<body>
    <header>
        <nav class="navbar">
            <ul style="font-size: 20px;" style="font-style: bold;">
                <li ><a href="home1.jsp">Home</a></li>
                <li><a href="Employee_Login.jsp">Employee Login</a></li>
                <li><a href="../Manager/Manager_Login.jsp">Manager Login</a></li>
                
                <li><a href="">About</a></li>
                <li><a href="contact.html">Contact Us</a></li>
               
            </ul>
        </nav>
        
    </header>
  
    <!-- Add more announcements as needed -->
  </div>
</body>

    
  
<footer>
    <div class="footer-content">
      <p>Employee Leave Management Portal &copy; 2023</p>
      <ul>
        <li><a href="terms.html">Terms of Service</a></li>
        <li><a href="privacy.html">Privacy Policy</a></li>
      </ul>
    </div>
  </footer>
    
</html>
