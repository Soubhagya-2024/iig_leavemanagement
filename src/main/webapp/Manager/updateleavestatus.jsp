<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.mail.*,javax.mail.internet.*,java.util.Properties" %>


<%
    HttpSession session1 = request.getSession();
    String sl_no = (String) session1.getAttribute("sl_no");
    String action = (String) session1.getAttribute("action");
    String empid = (String) session1.getAttribute("empid");
    String leavetype = (String) session1.getAttribute("leavetype");

    if (sl_no != null && action != null && empid != null && leavetype != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

            String status = ""; // Initialize the status based on action
            if (action.equals("approve")) {
                status = "Approved";
            } else if (action.equals("reject")) {
                status = "Rejected";
            }

            String updateLeaveRequestQuery = "UPDATE leave_requests SET status = ? WHERE sl_no = ?";
            PreparedStatement leaveRequestStmt = con.prepareStatement(updateLeaveRequestQuery);
            leaveRequestStmt.setString(1, status);
            leaveRequestStmt.setString(2, sl_no);
            leaveRequestStmt.executeUpdate();

            // Retrieve employee email from employees table
            String retrieveEmailQuery = "SELECT email FROM employees WHERE empid = ?";
            PreparedStatement retrieveEmailStmt = con.prepareStatement(retrieveEmailQuery);
            retrieveEmailStmt.setString(1, empid);
            ResultSet rs = retrieveEmailStmt.executeQuery();

            String employeeEmail = "";
            if (rs.next()) {
                employeeEmail = rs.getString("email");
            }

            if (!employeeEmail.isEmpty()) {
                // Sending email to the employee based on status
                String subject = "";
                String messageBody = "";

                if (status.equals("Approved")) {
                    subject = "Leave Request Approval";
                    messageBody = "Your leave request for " + leavetype + " has been approved.\n\nThank you.";
                } else if (status.equals("Rejected")) {
                    subject = "Leave Request Rejection";
                    messageBody = "Your leave request for " + leavetype + " has been rejected.\n\nReason: [Please contact your Manager]\n\nThank you.";
                }

                // Email sending logic
                Properties emailProperties = new Properties();
                emailProperties.put("mail.smtp.auth", "true");
                emailProperties.put("mail.smtp.starttls.enable", "true");
                emailProperties.put("mail.smtp.host", "smtp.gmail.com");
                emailProperties.put("mail.smtp.port", "587");

                Session session3 = Session.getInstance(emailProperties, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("umasankardash010@gmail.com", "eulchexyxyvqjztn");
                        // Provide your email credentials here...
                    }
                });

                try {
                    Message message = new MimeMessage(session3);
                    message.setFrom(new InternetAddress("umasankardash010@gmail.com"));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(employeeEmail));
                    message.setSubject(subject);
                    message.setText(messageBody);
                    Transport.send(message);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }

            // Update leave count for approved leave
            if (status.equals("Approved")) {
                try {
                    Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

                    // Retrieve the daysBetween value from the leave_request table based on sl_no
                    String getDaysBetweenQuery = "SELECT daysBetween FROM leave_requests WHERE sl_no = ?";
                    PreparedStatement getDaysBetweenStmt = con.prepareStatement(getDaysBetweenQuery);
                    getDaysBetweenStmt.setString(1, sl_no); // Update sl_no as per your requirement
                    ResultSet daysBetweenResult = getDaysBetweenStmt.executeQuery();

                    double daysBetween = 0; // Default value if no daysBetween found
                    if (daysBetweenResult.next()) {
                        daysBetween = daysBetweenResult.getDouble("daysBetween");
                    }

                    // Use daysBetween in your update query logic
                    String updateLeaveCountQuery = "";
                    if (leavetype.equals("Casual")) {
                        updateLeaveCountQuery = "UPDATE employee_leave_count SET left_casual_leave = left_casual_leave - ?, total_used_casual_leave = total_used_casual_leave + ? WHERE empid = ?";
                    } else if (leavetype.equals("Sick Leave")) {
                        updateLeaveCountQuery = "UPDATE employee_leave_count SET left_sick_leave = left_sick_leave - ?, total_used_sick_leave = total_used_sick_leave + ? WHERE empid = ?";
                    } else if (leavetype.equals("Paid Leave")) {
                        updateLeaveCountQuery = "UPDATE employee_leave_count SET left_paid_leave = left_paid_leave - ?, total_used_paid_leave = total_used_paid_leave + ? WHERE empid = ?";
                    }

                    PreparedStatement updateLeaveCountStmt = con.prepareStatement(updateLeaveCountQuery);
                    updateLeaveCountStmt.setDouble(1, daysBetween); // Using daysBetween retrieved
                    updateLeaveCountStmt.setDouble(2, daysBetween); // Assuming used and deducted leaves are the same
                    updateLeaveCountStmt.setString(3, empid);
                    updateLeaveCountStmt.executeUpdate();
						
                    response.sendRedirect("Leave_Management.jsp");
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    // Handle exceptions
                }
            } else {
                // Redirect if any attribute is missing
                response.sendRedirect("Leave_Management.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions
        }
    } else {
        // Redirect if any attribute is missing
        response.sendRedirect("Leave_Management.jsp");
    }
%>
