<%-- 
    Document   : dashboard
    Created on : 26 Oct, 2026, 6:30:39 AM
    Author     : SCMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String name = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h1>Sweet Cake Shop</h1>
    <h2>Welcome, <%= name %></h2>
    <p>What would you like to do today?</p>

    <a href="menu.jsp" class="btn">View Cakes</a>
    <a href="myOrders.jsp" class="btn">My Orders</a>
    <a href="logout.jsp" class="btn">Logout</a>
</div>
</body>
</html>
