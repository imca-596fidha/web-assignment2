<%-- 
    Document   : editOrder
    Created on : 26 Oct, 2026, 6:40:07 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

int id = 0;
int quantity = 1;
String deliveryDate = "";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
        "root",
        "windows"
    );

    ps = con.prepareStatement(
        "SELECT * FROM orders " +
        "WHERE id=? AND user_id=? AND status='Placed'"
    );

    ps.setInt(1, id);
    ps.setInt(2, (Integer) session.getAttribute("userId"));

    rs = ps.executeQuery();

    if (rs.next()) {
        quantity = rs.getInt("quantity");
        deliveryDate = rs.getDate("delivery_date").toString();
    } else {
        rs.close();
        rs = null;
        ps.close();
        ps = null;
        con.close();
        con = null;

        response.sendRedirect("myOrders.jsp");
        return;
    }

} catch (Exception e) {
    out.println("<h3>Unable to load order details: "
        + e.getMessage() + "</h3>");
    return;

} finally {
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        // Close database resources
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Cake Order</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">

    <h2>Edit Cake Order</h2>

    <form action="updateOrder.jsp" method="post">

        <input type="hidden" name="id" value="<%= id %>">

        Quantity:
        <input type="number" name="quantity"
               min="1" max="20"
               value="<%= quantity %>" required>

        Delivery Date:
        <input type="date" name="delivery_date"
               value="<%= deliveryDate %>" required>

        <input type="submit" value="Update Order">

    </form>

    <a href="myOrders.jsp">Back to Orders</a>

</div>

</body>
</html>