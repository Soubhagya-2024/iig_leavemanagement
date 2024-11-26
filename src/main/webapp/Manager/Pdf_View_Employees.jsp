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



 {
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");
        String query = "SELECT * FROM employees ";
        PreparedStatement pstmt = con.prepareStatement(query);
       
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
      
        
        Paragraph leaveHistoryHeading = new Paragraph("All Employee Details :", FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD));
        leaveHistoryHeading.setAlignment(Element.ALIGN_LEFT);
        leaveHistoryHeading.setSpacingAfter(20);
        document.add(leaveHistoryHeading);
        // Creating a table for leave history
        PdfPTable table = new PdfPTable(10);
        table.setWidthPercentage(100);

        // Adding table headers with formatting
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
        PdfPCell headerCell;
        String[] headers = {"Sl_No", "Emp ID", "Name", "Email", "Mobile","Location", "Qualification", "Department","DOB","DOJ"};
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
            table.addCell(new Phrase(rs.getString("empid"), cellFont));
            table.addCell(new Phrase(rs.getString("fullname"), cellFont));
            table.addCell(new Phrase(rs.getString("email"), cellFont));
            table.addCell(new Phrase(rs.getString("mobile"), cellFont));
            table.addCell(new Phrase(rs.getString("location"), cellFont));
            table.addCell(new Phrase(rs.getString("qualification"), cellFont));
            table.addCell(new Phrase(rs.getString("department"), cellFont));
            table.addCell(new Phrase(rs.getString("dob"), cellFont));
            table.addCell(new Phrase(rs.getString("doj"), cellFont));
            slNo++;
        }

        document.add(table);
        document.close();

        // Setting up response for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Employee details.pdf");

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
} 

%>
