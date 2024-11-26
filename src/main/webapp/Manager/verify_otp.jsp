 <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Random"%>
<%@page import="javax.mail.*, javax.mail.internet.*, java.util.Properties"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>

<%
// Get the entered OTP and reset employee ID from the form
String userOTP = request.getParameter("userOTP");
String resetEmpID = request.getParameter("resetEmpID");

// Get the stored OTP and reset employee ID from the session
Integer storedOTP = (Integer) session.getAttribute("resetOTP");
String storedEmpID = (String) session.getAttribute("resetEmpID");

// Verify if the entered OTP matches the stored OTP and employee ID
if (storedOTP != null && storedOTP.toString().equals(userOTP) && resetEmpID.equals(storedEmpID)) {
    // Valid OTP, allow password reset or other actions
	 %>
     <script>
         alert("Otp Validation Successfully !! ");
         window.location.replace("New_Password.jsp");
     </script>
<%
} else {
    // Invalid OTP, handle accordingly
	 %>
     <script>
         alert("Invalid OTP. Please try again. ");
         window.location.replace("Enter_otp.jsp");
     </script>
<%
}
%>
