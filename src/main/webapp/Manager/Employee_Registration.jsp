<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>

<%
String EmployeeId = request.getParameter("employeeId");
String FullName = request.getParameter("fullName");
String Email = request.getParameter("email");
String Password = request.getParameter("password");
String ConfirmPassword = request.getParameter("confirmPassword");
String doj = request.getParameter("doj");

try {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

    PreparedStatement fetchStatement = con.prepareStatement("SELECT COUNT(*) AS empCount FROM employees");
    ResultSet resultSet = fetchStatement.executeQuery();
    int currentEmployeeCount = 0;
    if (resultSet.next()) {
        currentEmployeeCount = resultSet.getInt("empCount");
    }
    fetchStatement.close();

    if (currentEmployeeCount < 10) {
        PreparedStatement ps = con.prepareStatement("INSERT INTO employees (empid , fullName , email , password, confirmPassword , doj ) VALUES (?, ?, ?, ?, ?, ?)");

        ps.setString(1, EmployeeId);
        ps.setString(2, FullName);
        ps.setString(3, Email);
        ps.setString(4, Password);
        ps.setString(5, ConfirmPassword);
        ps.setString(6, doj);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            String toEmail = Email;

            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");
            properties.put("mail.smtp.user", "umasankardash010@gmail.com");
            properties.put("mail.smtp.password", "eulchexyxyvqjztn");
            
            Session session2 = Session.getInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("umasankardash010@gmail.com", "eulchexyxyvqjztn");
                }
            });

            Message message = new MimeMessage(session2);
            message.setFrom(new InternetAddress("umasankardash010@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to Our Company");
            message.setText("Dear " + FullName + ",\n\nWelcome to our company!,\n\nPlease Login with your email and password and update the profile.\nChange the password ASAP.,\n\nThank you.");

            Transport.send(message);

            // Insert empid into employee_leave_count table
            PreparedStatement psLeaveCount = con.prepareStatement("INSERT INTO employee_leave_count (empid) VALUES (?)");
            psLeaveCount.setString(1, EmployeeId);
            int rowsAffectedLeaveCount = psLeaveCount.executeUpdate();
            psLeaveCount.close();

            out.println("<script>");
            out.println("    alert(\"New employee added successfully. Welcome email sent.\");");
            out.println("    window.location.href='Add_Emp.jsp';");
            out.println("</script>");
        } else {
            out.println("Failed to insert data.");
        }

        ps.close();
    } else {
        out.println("<script>");
        out.println("    alert(\"Sorry! Maximum employee registration limit reached.\");");
        out.println("    window.location.href='Manager_Dashboard.jsp';");
        out.println("</script>");
    }

    con.close();
} catch(Exception e) {
    e.printStackTrace();
    out.println("Failed to register employee or send the welcome email.");
}
%>

