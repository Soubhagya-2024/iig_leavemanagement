<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%
// Retrieve form data
String empId = request.getParameter("empid");
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mob");
String doj = request.getParameter("doj");
String location = request.getParameter("location");
String qualification = request.getParameter("qualification");
String department = request.getParameter("department");
String dob = request.getParameter("dob");

// JDBC driver name and database URL
String JDBC_DRIVER = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/Employeeleave";

// Database credentials
String USER = "system";
String PASS = "system";

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Register JDBC driver
    Class.forName(JDBC_DRIVER);

    // Open a connection
    conn = DriverManager.getConnection(DB_URL, USER, PASS);

    // Prepare SQL query to update employee information
    String sql = "UPDATE employees SET fullname=?, email=?, mobile=?, doj=?, location=?, qualification=?,department=?, dob=? WHERE empid=?";
    stmt = conn.prepareStatement(sql);

    // Set parameters
    stmt.setString(1, name);
    stmt.setString(2, email);
    stmt.setString(3, mobile);
    stmt.setString(4, doj);
    stmt.setString(5, location);
    stmt.setString(6, qualification);
    stmt.setString(7, department);
    stmt.setString(8, dob);
    stmt.setString(9, empId);

    // Execute the update statement
    int rowsAffected = stmt.executeUpdate();

    // Check if the update was successful
    if (rowsAffected > 0) {
        // Profile updated successfully
        // Now, let's send an email notification
        String fromEmail = "umasankardash010@gmail.com"; // Update with your email
        String toEmail = (String) session.getAttribute("email"); // Retrieve email from session

        // Mail configuration
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Use Gmail SMTP
        properties.put("mail.smtp.port", "587"); // TLS Port
        properties.put("mail.smtp.user", fromEmail);
        properties.put("mail.smtp.password", "eulchexyxyvqjztn"); // Update with your password

        Session session3 = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, "eulchexyxyvqjztn");
            }
        });

        try {
            // Create a message
            Message message = new MimeMessage(session3);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Profile Updated");
            message.setText("Dear Employee,\n\nYour profile has been successfully updated.\n\nKindly call 9348574448 immediately to report if it is not done by you.\n\nThank you.");

            // Send the email
            Transport.send(message);
            // Redirect with alert
            out.println("<script>alert('Profile Updated Successfully. Email Sent.'); window.location.href='Profile.jsp';</script>");
        } catch (MessagingException e) {
            out.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            // Redirect with alert
            out.println("<script>alert('Profile Updated Successfully. Failed to send email.'); window.location.href='Profile.jsp';</script>");
        }
    } else {
        // Failed to update employee information
        // Redirect with alert
        out.println("<script>alert('Failed to update employee information.'); window.location.href='Profile.jsp';</script>");
    }
} catch (Exception e) {
    out.println("Exception: " + e.getMessage());
    e.printStackTrace();
} finally {
    // Close resources
    try {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (Exception ex) {
        out.println("Exception in closing resources: " + ex.getMessage());
        ex.printStackTrace();
    }
}
%>
