<%-- 
    Document   : login
    Created on : 26 Oct, 2026, 6:30:04 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h2>Customer Login</h2>

    <form action="login.jsp" method="post">
        Email:
        <input type="email" name="email" required>

        Password:
        <input type="password" name="password" required>

        <input type="submit" value="Login">
    </form>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
            "root",
            "windows"
        );

        ps = con.prepareStatement(
            "SELECT id, name FROM users WHERE email=? AND password=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);

        rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("userId", rs.getInt("id"));
            session.setAttribute("userName", rs.getString("name"));

            if (rs != null) rs.close();
            rs = null;
            if (ps != null) ps.close();
            ps = null;
            if (con != null) con.close();
            con = null;

            response.sendRedirect("dashboard.jsp");
            return;
        } else {
            out.println("<p>Invalid email or password.</p>");
        }

    } catch (Exception e) {
        out.println("<p>Login error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            // Resource cleanup
        }
    }
}
%>

    <p><a href="register.jsp">Create an Account</a></p>
    <p><a href="index.jsp">Back to Home</a></p>
</div>

</body>
</html>