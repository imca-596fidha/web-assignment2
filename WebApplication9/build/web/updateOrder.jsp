<%-- 
    Document   : updateOrder
    Created on : 26 Oct, 2026, 6:33:45 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

if (!"POST".equalsIgnoreCase(request.getMethod())) {
    response.sendRedirect("myOrders.jsp");
    return;
}

try {
    int id = Integer.parseInt(request.getParameter("id"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    Date deliveryDate = Date.valueOf(request.getParameter("delivery_date"));

    if (quantity < 1 || quantity > 20 ||
        !deliveryDate.after(new Date(System.currentTimeMillis()))) {
        throw new IllegalArgumentException("Invalid order details");
    }

    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
            "root", "windows");
         PreparedStatement ps = con.prepareStatement(
            "UPDATE orders o JOIN cakes c ON o.cake_id=c.id " +
            "SET o.quantity=?,o.delivery_date=?,o.total_price=c.price * ? " +
            "WHERE o.id=? AND o.user_id=? AND o.status='Placed'")) {

        ps.setInt(1, quantity);
        ps.setDate(2, deliveryDate);
        ps.setInt(3, quantity);
        ps.setInt(4, id);
        ps.setInt(5, (Integer) session.getAttribute("userId"));

        ps.executeUpdate();
    }

    response.sendRedirect("myOrders.jsp");
    return;

} catch (Exception e) {
    out.println("<h2>Unable to update order. Check your details.</h2>");
}
%>
<a href="myOrders.jsp">Back to Orders</a>