<%-- 
    Document   : cancelOrder
    Created on : 26 Oct, 2026, 6:35:03 AM
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

Connection con = null;
PreparedStatement ps = null;

try {
    int id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
        "root",
        "windows"
    );

    String sql =
        "UPDATE orders SET status='Cancelled' " +
        "WHERE id=? AND user_id=? AND status='Placed'";

    ps = con.prepareStatement(sql);

    ps.setInt(1, id);
    ps.setInt(2, (Integer) session.getAttribute("userId"));

    int result = ps.executeUpdate();

    if (result > 0) {
        response.sendRedirect("myOrders.jsp");
        return;
    } else {
        out.println("<h3>Order not found or already cancelled.</h3>");
    }

} catch (Exception e) {
    out.println("<h3>Unable to cancel order: "
        + e.getMessage() + "</h3>");

} finally {
    try {
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        // Close database resources
    }
}
%>

<br>
<a href="myOrders.jsp">Back to My Orders</a>