<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

String empid = (String) session.getAttribute("empid");
String fullname = (String) session.getAttribute("fullname");

if (empid != null) {
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
        String query = "SELECT DATE_FORMAT(postingdate, '%Y-%m-%d %H:%i:%s') AS postingdate, leavetype, status,duration, startdate, enddate, reason FROM leave_requests WHERE empid = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, empid);
        ResultSet rs = pstmt.executeQuery();

        // Creating a PDF document
        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);

        document.open();

        // Adding company information
        Paragraph companyInfo = new Paragraph("IIG TECHNOLOGY", FontFactory.getFont(FontFactory.HELVETICA, 18, Font.BOLD, BaseColor.BLACK));
        companyInfo.setAlignment(Element.ALIGN_CENTER);
        companyInfo.setSpacingAfter(10);
        document.add(companyInfo);

        // Adding employee details
        Paragraph employeeDetails = new Paragraph();
        employeeDetails.add(new Chunk("Employee Name: ", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
        employeeDetails.add(new Chunk(fullname, FontFactory.getFont(FontFactory.HELVETICA, 12)));
        employeeDetails.add(Chunk.NEWLINE);
        employeeDetails.add(new Chunk("Employee ID: ", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD)));
        employeeDetails.add(new Chunk(empid, FontFactory.getFont(FontFactory.HELVETICA, 12)));
        employeeDetails.setAlignment(Element.ALIGN_LEFT);
        employeeDetails.setSpacingAfter(20);
        document.add(employeeDetails);
        
        Paragraph leaveHistoryHeading = new Paragraph("Leave History :", FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD));
        leaveHistoryHeading.setAlignment(Element.ALIGN_LEFT);
        leaveHistoryHeading.setSpacingAfter(20);
        document.add(leaveHistoryHeading);
        // Creating a table for leave history
        PdfPTable table = new PdfPTable(8);
        table.setWidthPercentage(100);

        // Adding table headers with formatting
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
        PdfPCell headerCell;
        String[] headers = {"Sl_No", "Applying Date", "Leave Type", "From Date", "To Date","Duration", "Reason", "Status"};
        for (String header : headers) {
            headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setBackgroundColor(BaseColor.BLUE);
            table.addCell(headerCell);
        }

        // Populating table with retrieved data
        Font cellFont = FontFactory.getFont(FontFactory.HELVETICA, 10);
        int slNo = 1;
        while (rs.next()) {
            table.addCell(new Phrase(String.valueOf(slNo), cellFont));
            table.addCell(new Phrase(rs.getString("postingdate"), cellFont));
            table.addCell(new Phrase(rs.getString("leavetype"), cellFont));
            table.addCell(new Phrase(rs.getString("startdate"), cellFont));
            table.addCell(new Phrase(rs.getString("enddate"), cellFont));
            table.addCell(new Phrase(rs.getString("duration"), cellFont));
            table.addCell(new Phrase(rs.getString("reason"), cellFont));
            table.addCell(new Phrase(rs.getString("status"), cellFont));
            slNo++;
        }

        document.add(table);
        document.close();

        // Setting up response for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Leave_report_" + session.getAttribute("fullname") + ".pdf");

        // Writing PDF content to the response output stream
        OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();

        // Closing database connections
        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
} else {
    response.sendRedirect("Login.jsp");
}
%>
