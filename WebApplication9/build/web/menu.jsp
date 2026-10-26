<%-- 
    Document   : menu
    Created on : 26 Oct, 2026, 6:31:09 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cake Menu</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Our Cake Menu</h1>

<table>
<tr>
    <th>ID</th>
    <th>Cake Name</th>
    <th>Description</th>
    <th>Price</th>
    <th>Action</th>
</tr>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
        "root",
        "windows"
    );

    st = con.createStatement();
    rs = st.executeQuery("SELECT * FROM cakes");

    while (rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("cake_name") %></td>
    <td><%= rs.getString("description") %></td>
    <td>Rs. <%= rs.getBigDecimal("price") %></td>
    <td>
        <a href="orderCake.jsp?id=<%= rs.getInt("id") %>">
            Order Now
        </a>
    </td>
</tr>

<%
    }

} catch (Exception e) {
    out.println("<tr><td colspan='5'>Error: "
        + e.getMessage() + "</td></tr>");

} finally {
    try {
        if (rs != null) rs.close();
        if (st != null) st.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        // Close database resources
    }
}
%>

</table>

<br>
<a href="dashboard.jsp" class="btn">Back to Dashboard</a>

</body>
</html>