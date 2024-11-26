<%@ page import="java.io.*, java.nio.file.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image to PDF Converter</title>
</head>
<body>

    <h2>Image to PDF Converter</h2>

    <form action="convert.jsp" method="post" enctype="multipart/form-data">
        <label for="imageFile">Choose an image file:</label>
        <input type="file" name="imageFile" accept="image/*" required>
        <br>
        <input type="submit" value="Convert to PDF">
    </form>

</body>
</html>
