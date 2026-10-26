<%-- 
    Document   : ordercake
    Created on : 26 Oct, 2026, 6:31:44 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String errorMessage = "";
String cakeName = "";
BigDecimal price = BigDecimal.ZERO;
int selectedCakeId = 0;

if ("POST".equalsIgnoreCase(request.getMethod())) {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        int cakeId = Integer.parseInt(request.getParameter("cakeId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        java.sql.Date deliveryDate =
            java.sql.Date.valueOf(request.getParameter("delivery_date"));

        if (quantity < 1 || quantity > 20 ||
            !deliveryDate.after(new java.sql.Date(System.currentTimeMillis()))) {
            throw new Exception("Enter a valid quantity and future delivery date.");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
            "root",
            "windows"
        );

        ps = con.prepareStatement("SELECT price FROM cakes WHERE id=?");
        ps.setInt(1, cakeId);
        rs = ps.executeQuery();

        if (!rs.next()) {
            throw new Exception("Cake not found.");
        }

        BigDecimal total = rs.getBigDecimal("price")
            .multiply(BigDecimal.valueOf(quantity));

        rs.close();
        rs = null;
        ps.close();
        ps = null;

        ps = con.prepareStatement(
            "INSERT INTO orders " +
            "(user_id,cake_id,quantity,delivery_date,total_price,status) " +
            "VALUES(?,?,?,?,?,'Placed')"
        );

        ps.setInt(1, (Integer) session.getAttribute("userId"));
        ps.setInt(2, cakeId);
        ps.setInt(3, quantity);
        ps.setDate(4, deliveryDate);
        ps.setBigDecimal(5, total);
        ps.executeUpdate();

        ps.close();
        ps = null;
        con.close();
        con = null;

        response.sendRedirect("myOrders.jsp");
        return;

    } catch (Exception e) {
        errorMessage = "Unable to place order: " + e.getMessage();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            // Close database resources
        }
    }
}

try {
    String idParameter = request.getParameter("id");

    if (idParameter == null) {
        idParameter = request.getParameter("cakeId");
    }

    selectedCakeId = Integer.parseInt(idParameter);

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
        "root",
        "windows"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT cake_name, price FROM cakes WHERE id=?"
    );

    ps.setInt(1, selectedCakeId);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        cakeName = rs.getString("cake_name");
        price = rs.getBigDecimal("price");
    } else {
        errorMessage = "Cake not found.";
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    errorMessage = "Unable to load cake details: " + e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Cake</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h2>Order Cake</h2>

    <% if (!errorMessage.equals("")) { %>
        <p><%= errorMessage %></p>
    <% } %>

    <% if (!cakeName.equals("")) { %>
        <p>Cake: <%= cakeName %></p>
        <p>Price: Rs. <%= price %></p>

        <form action="orderCake.jsp" method="post">
            <input type="hidden" name="cakeId"
                   value="<%= selectedCakeId %>">

            Quantity:
            <input type="number" name="quantity"
                   min="1" max="20" required>

            Delivery Date:
            <input type="date" name="delivery_date" required>

            <input type="submit" value="Place Order">
        </form>
    <% } %>

    <a href="menu.jsp">Back to Menu</a>
</div>

</body>
</html>