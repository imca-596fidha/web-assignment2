<%-- 
    Document   : register
    Created on : 26 Oct, 2026, 6:29:27 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>




<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h2>Customer Registration</h2>

    <form method="post">
        Name:
        <input type="text" name="name" required>

        Email:
        <input type="email" name="email" required>

        Password:
        <input type="password" name="password" required>

        <input type="submit" value="Register">
    </form>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
            "root",
            "windows"
        );

        String sql =
            "INSERT INTO users(name, email, password) VALUES(?,?,?)";

        ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);

        ps.executeUpdate();

        out.println("<h3>Registration Successful!</h3>");
        out.println("<a href='login.jsp'>Login Now</a>");

    } catch (Exception e) {

        out.println("<p>Registration failed.</p>");
        out.println("<p>" + e.getMessage() + "</p>");

    } finally {

        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("Database closing error.");
        }
    }
}
%>

<br><br>
<a href="index.jsp">Back to Home</a>

</div>
</body>
</html>