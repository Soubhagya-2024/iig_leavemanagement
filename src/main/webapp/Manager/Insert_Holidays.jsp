<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
String holidayName = request.getParameter("holidayName");
String holidayDate = request.getParameter("holidayDate");

try {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employeeleave", "system", "system");

    PreparedStatement ps = con.prepareStatement("INSERT INTO holidays (holiday_name, holiday_date) VALUES (?, ?)");

    ps.setString(1, holidayName);
    ps.setString(2, holidayDate);

    int rowsAffected = ps.executeUpdate();

    if (rowsAffected > 0) {
        out.println("<script>");
        out.println("    alert(\"Holiday added successfully!\");");
        out.println("    window.location.href='All_Holidays.jsp';"); // Redirect to Manager Dashboard after successful addition
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("    alert(\"Failed to add holiday.\");");
        out.println("    window.location.href='Add_Holiday.jsp';"); // Redirect back to Add Holiday page on failure
        out.println("</script>");
    }

    ps.close();
    con.close();
} catch(Exception e) {
    e.printStackTrace();
    out.println("<script>");
    out.println("    alert(\"Failed to add holiday. Please try again later.\");");
    out.println("    window.location.href='Add_Holiday.jsp';"); // Redirect back to Add Holiday page in case of exception
    out.println("</script>");
}
%>
