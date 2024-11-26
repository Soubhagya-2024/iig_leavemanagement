<%
    String sl_no = request.getParameter("sl_no");
    String action = request.getParameter("action");
    String empid = request.getParameter("empid");
    String leavetype = request.getParameter("leavetype");
    String email = request.getParameter("email");
    
    HttpSession session1 = request.getSession();
    session.setAttribute("sl_no", sl_no);
    session.setAttribute("action", action);
    session.setAttribute("empid", empid);
    session.setAttribute("leavetype", leavetype);
    session.setAttribute("email", email);
    response.sendRedirect("updateleavestatus.jsp");
%>
