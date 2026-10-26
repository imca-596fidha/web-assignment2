<%-- 
    Document   : myOrders.jsp
    Created on : 26 Oct, 2026, 6:32:58 AM
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
    <title>My Cake Orders</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>My Cake Orders</h1>

<table>
<tr>
    <th>Order ID</th>
    <th>Cake Name</th>
    <th>Quantity</th>
    <th>Delivery Date</th>
    <th>Total Price</th>
    <th>Status</th>
    <th>Actions</th>
</tr>

<%
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

    String sql =
        "SELECT o.*, c.cake_name FROM orders o " +
        "JOIN cakes c ON o.cake_id = c.id " +
        "WHERE o.user_id = ? ORDER BY o.id DESC";

    ps = con.prepareStatement(sql);

    ps.setInt(1, (Integer) session.getAttribute("userId"));

    rs = ps.executeQuery();

    while (rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>

    <td><%= rs.getString("cake_name") %></td>

    <td><%= rs.getInt("quantity") %></td>

    <td><%= rs.getDate("delivery_date") %></td>

    <td>Rs. <%= rs.getBigDecimal("total_price") %></td>

    <td><%= rs.getString("status") %></td>

    <td>
        <% if ("Placed".equals(rs.getString("status"))) { %>

            <a href="editOrder.jsp?id=<%= rs.getInt("id") %>">
                Edit
            </a>

            <form action="cancelOrder.jsp" method="post">
                <input type="hidden" name="id"
                       value="<%= rs.getInt("id") %>">
                <input type="submit" value="Cancel">
            </form>

        <% } else { %>
            No actions
        <% } %>
    </td>
</tr>

<%
    }

} catch (Exception e) {

    out.println("<tr><td colspan='7'>Database Error: "
        + e.getMessage() + "</td></tr>");

} finally {

    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        // Database resource cleanup
    }
}
%>

</table>

<br>

<a href="menu.jsp" class="btn">Order More Cakes</a>

<a href="dashboard.jsp" class="btn">Dashboard</a>

</body>
</html>