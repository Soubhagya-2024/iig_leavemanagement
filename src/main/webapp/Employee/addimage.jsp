<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Image Upload</title>
</head>
<body>
    <h2>Upload Image</h2>
    <form action="saveImage.jsp" method="post" enctype="multipart/form-data">
        <input type="file" name="image" />
        <input type="submit" value="Upload" />
    </form>
</body>
</html>
