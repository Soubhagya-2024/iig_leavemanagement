<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.mail.*,javax.mail.internet.*,java.util.Properties" %>
<%@ page import="java.util.*" %>

<%
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    
    String empid = (String) request.getSession().getAttribute("empid");
    String email = (String) request.getSession().getAttribute("email");
   
    String url = "jdbc:mysql://localhost:3306/employeeleave";
    String username = "system";
    String password = "system";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        if (!newPassword.equals(confirmPassword)) {
    %>
        <script>
            alert("New password and confirm password do not match.");
            window.location.href = "Profile.jsp";
        </script>
    <%
        } else {
            String checkPasswordQuery = "SELECT * FROM employees WHERE empid=? AND password=?";
            PreparedStatement checkPasswordStmt = conn.prepareStatement(checkPasswordQuery);
            checkPasswordStmt.setString(1, empid); 
            checkPasswordStmt.setString(2, currentPassword);
            ResultSet passwordResult = checkPasswordStmt.executeQuery();

            if (passwordResult.next()) {
                String updatePasswordQuery = "UPDATE employees SET password=? WHERE empid=?";
                PreparedStatement updatePasswordStmt = conn.prepareStatement(updatePasswordQuery);
                updatePasswordStmt.setString(1, newPassword);
                updatePasswordStmt.setString(2, empid); 
                int rowsAffected = updatePasswordStmt.executeUpdate();

                if (rowsAffected > 0) {
                    Properties properties = new Properties();
                    properties.put("mail.smtp.auth", "true");
                    properties.put("mail.smtp.starttls.enable", "true");
                    properties.put("mail.smtp.host", "smtp.gmail.com");
                    properties.put("mail.smtp.port", "587");
                    properties.put("mail.smtp.user", "yourEmail@gmail.com");
                    properties.put("mail.smtp.password", "yourPassword");

                    Session session3 = Session.getInstance(properties, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication("umasankardash010@gmail.com", "eulchexyxyvqjztn");
                        }
                    });

                    try {
                        Message message = new MimeMessage(session3);
                        message.setFrom(new InternetAddress("umasankardash010@gmail.com"));
                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                        message.setSubject("Password Changed Successfully");
                        message.setText("Dear Employee,\n\nYour password has been successfully changed.\n\nKindly call 9348574448 immediately to report if it is not done by you.\n\nThank you.");

                        Transport.send(message);

                       // response.sendRedirect("Profile.jsp?success=Password updated Successfully. Email Sent.");
                        %>
                        <script>
                            alert("Password updated Successfully. Email Sent.");
                            window.location.href = "Profile.jsp";
                        </script>
                        <%
                       
                    } catch (MessagingException e) {
                        out.println("Failed to send email: " + e.getMessage());
                        e.printStackTrace();
                    }
                } else {
                	 %>
                     <script>
                         alert("Failed to update password.");
                         window.location.href = "Profile.jsp";
                     </script>
                     <%
                }
            } else {
            	 %>
                 <script>
                     alert("Current password is incorrect.");
                     window.location.href = "Profile.jsp";
                 </script>
                 <%
            }
        }

        conn.close();
    } catch (Exception e) {
        out.println("Error occurred: " + e.getMessage());
        e.printStackTrace();
    }
%>
