<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.mail.*, javax.mail.internet.*, java.util.Properties, java.io.*, java.util.*, java.time.LocalDate, java.time.temporal.ChronoUnit" %>

<%
    String Empid = request.getParameter("empid");
    String fullname = request.getParameter("fullname");
    String LeaveType = request.getParameter("leaveType");
    String StartDate = request.getParameter("startDate");
    String EndDate = request.getParameter("endDate");
    String Reason = request.getParameter("reason");
    String Duration = request.getParameter("duration");

    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

        // Calculate holidays count between start and end dates
        PreparedStatement psHolidays = con.prepareStatement("SELECT COUNT(*) FROM holidays WHERE holiday_date BETWEEN ? AND ?");
        psHolidays.setString(1, StartDate);
        psHolidays.setString(2, EndDate);
        ResultSet rsHolidays = psHolidays.executeQuery();
        int holidaysCount = 0;

        if (rsHolidays.next()) {
            holidaysCount = rsHolidays.getInt(1);
        }

        rsHolidays.close();
        psHolidays.close();

        // Calculate total days excluding weekends and holidays
        LocalDate startDate = LocalDate.parse(StartDate);
        LocalDate endDate = LocalDate.parse(EndDate);
        long totalDays = ChronoUnit.DAYS.between(startDate, endDate) + 1; // +1 to include both start and end dates

        // Calculate working days excluding holidays
        double daysBetween = 0.0;

        if (Duration.equals("Full Day")) {
            daysBetween = totalDays - holidaysCount; // Full days minus holidays
        } else if (Duration.equals("First Half") || Duration.equals("Second Half")) {
            daysBetween = 0.5; // For half-day leaves
        } else {
            // Handle other cases if needed, currently setting it as default 0.0
            daysBetween = 0.0;
        }

        // Prepare and execute INSERT query
        PreparedStatement ps = con.prepareStatement("INSERT INTO leave_requests (empid, fullname, leavetype, startdate, enddate, duration, reason, daysBetween) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, Empid);
        ps.setString(2, fullname);
        ps.setString(3, LeaveType);
        ps.setString(4, StartDate);
        ps.setString(5, EndDate);
        ps.setString(6, Duration);
        ps.setString(7, Reason);
        ps.setDouble(8, daysBetween); // Set the days count

        int rowsAffected = ps.executeUpdate();
        ps.close();

        // Sending emails...
        // ... (email sending code remains unchanged)

        if (rowsAffected > 0) {
            // Email sending logic
            // Replace with your email sending code
           
            String managerEmail = "udash2022@gift.edu.in"; // Replace with the manager's email
            String subject = "New Leave Request: " + LeaveType;
            String messageBody = "Leave Request Details:\n\n" +
                    "Employee Name: " + fullname + "\n" +
                    "Employee ID: " + Empid + "\n" +
                    "Leave Type: " + LeaveType + "\n" +
                    "Start Date: " + StartDate + "\n" +
                    "End Date: " + EndDate + "\n" +
                    "Reason: " + Reason + "\n\n" +
                    "Please review and approve this leave request at your earliest convenience.\n\n" +
                    "Thank you.";

            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");
            properties.put("mail.smtp.user", "umasankardash010@gmail.com");
            properties.put("mail.smtp.password", "eulchexyxyvqjztn");

            Session session3 = Session.getInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("umasankardash010@gmail.com", "eulchexyxyvqjztn");
                }
            });

            try {
                Message message = new MimeMessage(session3);
                message.setFrom(new InternetAddress("umasankardash010@gmail.com"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(managerEmail));
                message.setSubject(subject);
                message.setText(messageBody);
                Transport.send(message);

                String employeeEmail = (String) session.getAttribute("email");
                String employeeSubject = "Leave Request Confirmation: " + LeaveType;
                String employeeMessageText = "Dear " + fullname + ",\n\n" +
                        "Your leave request for " + LeaveType + " has been submitted successfully.\n" +
                        "Start Date: " + StartDate + "\n" +
                        "End Date: " + EndDate + "\n\n" +
                        "You will be notified once your request is approved.\n\n" +
                        "Kindly call 9348574448 immediately to report if it is not done by you.\n\n" +
                        "Thank you.";

                try {
                    Message employeeMessage = new MimeMessage(session3);
                    employeeMessage.setFrom(new InternetAddress("umasankardash010@gmail.com"));
                    employeeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(employeeEmail));
                    employeeMessage.setSubject(employeeSubject);
                    employeeMessage.setText(employeeMessageText);
                    Transport.send(employeeMessage);
                    out.println("<script>alert('Leave request sent successfully! Waiting for Manager approval.'); window.location.href='Leave_request_1.jsp';</script>");
                } catch (MessagingException e) {
                    out.println("Failed to send email to employee: " + e.getMessage());
                    e.printStackTrace();
                }

            } catch (MessagingException e) {
                out.println("Failed to send email to manager: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            out.println("Failed to insert data.");
        }
    } catch (SQLException e) {
        out.println("SQL Error occurred: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        out.println("Error occurred: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            out.println("Error closing connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
%>
