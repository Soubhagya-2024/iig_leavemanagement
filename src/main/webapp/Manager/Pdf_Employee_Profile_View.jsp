<%@ page import="java.sql.*, javax.servlet.http.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

String empid = request.getParameter("empid");

if (empid != null) {
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeleave", "system", "system");

        // Retrieve leave requests
        String queryLeaveRequests = "SELECT DATE_FORMAT(postingdate, '%Y-%m-%d %H:%i:%s') AS postingdate, leavetype, status, duration, startdate, enddate, reason FROM leave_requests WHERE empid = ?";
        PreparedStatement pstmtLeaveRequests = con.prepareStatement(queryLeaveRequests);
        pstmtLeaveRequests.setString(1, empid);
        ResultSet rsLeaveRequests = pstmtLeaveRequests.executeQuery();

        // Retrieve personal information
        String queryPersonalInfo = "SELECT * FROM employees WHERE empid = ?";
        PreparedStatement pstmtPersonalInfo = con.prepareStatement(queryPersonalInfo);
        pstmtPersonalInfo.setString(1, empid);
        ResultSet rsPersonalInfo = pstmtPersonalInfo.executeQuery();
        
        
        String queryLeaveCount = "SELECT total_casual_leave, total_sick_leave, total_paid_leave, total_used_casual_leave, total_used_sick_leave, total_used_paid_leave, left_casual_leave, left_sick_leave, left_paid_leave FROM employee_leave_count WHERE empid = ?";
        PreparedStatement pstmtLeaveCount = con.prepareStatement(queryLeaveCount);
        pstmtLeaveCount.setString(1, empid);
        ResultSet rsLeaveCount = pstmtLeaveCount.executeQuery();


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

        // Adding personal information to the table
         Paragraph employeeinfo = new Paragraph("Personal Information :", FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD));
         employeeinfo.setAlignment(Element.ALIGN_LEFT);
         employeeinfo.setSpacingAfter(20);
        document.add(employeeinfo);
        PdfPTable employeeTable = new PdfPTable(2);
        employeeTable.setWidthPercentage(100);
        Font cellFont = FontFactory.getFont(FontFactory.HELVETICA, 10);
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
        PdfPCell headerCell;
        String[] headersEmployee = {"Attribute", "Value"};
        for (String header : headersEmployee) {
            headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setBackgroundColor(BaseColor.BLUE);
            employeeTable.addCell(headerCell);
        }

        // Adding employee information to the table
        if (rsPersonalInfo.next()) {
            employeeTable.addCell(new Phrase("Emp ID", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("empid"), cellFont));
            employeeTable.addCell(new Phrase("Name", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("fullname"), cellFont));
            employeeTable.addCell(new Phrase("Email", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("email"), cellFont));
            
            employeeTable.addCell(new Phrase("Mobile", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("mobile"), cellFont));
            employeeTable.addCell(new Phrase("Location", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("location"), cellFont));
            employeeTable.addCell(new Phrase("Qualification", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("qualification"), cellFont));
            employeeTable.addCell(new Phrase("Department", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("department"), cellFont));
            employeeTable.addCell(new Phrase("Date Of Birth", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("dob"), cellFont));
            employeeTable.addCell(new Phrase("Date Of Joining", cellFont));
            employeeTable.addCell(new Phrase(rsPersonalInfo.getString("doj"), cellFont));
        }

        document.add(employeeTable);
        
        //adding leave count table
        
       
         Paragraph leavecount = new Paragraph("Leave Balance :", FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD));
         leavecount.setAlignment(Element.ALIGN_LEFT);
         leavecount.setSpacingAfter(20);
        document.add(leavecount);
        PdfPTable counteTable = new PdfPTable(4);
        counteTable.setWidthPercentage(100);
        
        String[] headersCount = {"#","Casual Leave", "Sick Leave", "Paid Leave"};
        for (String header : headersCount) {
            headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setBackgroundColor(BaseColor.BLUE);
            counteTable.addCell(headerCell);
        }

        // Adding employee information to the table
        if (rsLeaveCount.next()) {
        	counteTable.addCell(new Phrase("Total Leave", cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_casual_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_sick_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_paid_leave"), cellFont));
        	counteTable.addCell(new Phrase("Used Leave", cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_used_casual_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_used_sick_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("total_used_paid_leave"), cellFont));
        	counteTable.addCell(new Phrase("Remaining Leave", cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("left_casual_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("left_sick_leave"), cellFont));
        	counteTable.addCell(new Phrase(rsLeaveCount.getString("left_paid_leave"), cellFont));
     
        }

        document.add(counteTable);

        // Adding leave history table
         Paragraph leaveHistoryHeading = new Paragraph("Leave History :", FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD));
        leaveHistoryHeading.setAlignment(Element.ALIGN_LEFT);
        leaveHistoryHeading.setSpacingAfter(20);
        document.add(leaveHistoryHeading);
        PdfPTable leaveTable = new PdfPTable(8);
        leaveTable.setWidthPercentage(100);

        String[] headers = {"Sl_No", "Applying Date", "Leave Type", "From Date", "To Date", "Duration", "Reason", "Status"};
        for (String header : headers) {
            headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setBackgroundColor(BaseColor.BLUE);
            leaveTable.addCell(headerCell);
        }

        int slNo = 1;
        while (rsLeaveRequests.next()) {
            leaveTable.addCell(new Phrase(String.valueOf(slNo), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("postingdate"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("leavetype"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("startdate"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("enddate"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("duration"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("reason"), cellFont));
            leaveTable.addCell(new Phrase(rsLeaveRequests.getString("status"), cellFont));
            slNo++;
        }

        document.add(leaveTable);
        document.close();

        // Setting up response for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Leave_report_" + rsPersonalInfo.getString("fullname") + ".pdf");

        // Writing PDF content to the response output stream
        OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();

        // Closing ResultSets, PreparedStatements, and Connection
        rsLeaveRequests.close();
        pstmtLeaveRequests.close();
        rsPersonalInfo.close();
        pstmtPersonalInfo.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
} else {
    response.sendRedirect("Login.jsp");
}
%>
