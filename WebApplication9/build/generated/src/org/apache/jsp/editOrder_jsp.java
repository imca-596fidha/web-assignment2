package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class editOrder_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

int id, quantity;
String date;

try {
    id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cakeorder?sslMode=DISABLED",
            "root", "windows");
         PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM orders WHERE id=? AND user_id=? AND status='Placed'")) {

        ps.setInt(1, id);
        ps.setInt(2, (Integer) session.getAttribute("userId"));

        try (ResultSet rs = ps.executeQuery()) {
            if (!rs.next()) {
                response.sendRedirect("myOrders.jsp");
                return;
            }

            quantity = rs.getInt("quantity");
            date = rs.getDate("delivery_date").toString();
        }
    }
} catch (Exception e) {
    response.sendRedirect("myOrders.jsp");
    return;
}

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Edit Order</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"style.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>Edit Cake Order</h2>\n");
      out.write("\n");
      out.write("    <form action=\"updateOrder.jsp\" method=\"post\">\n");
      out.write("        <input type=\"hidden\" name=\"id\" value=\"");
      out.print( id );
      out.write("\">\n");
      out.write("\n");
      out.write("        Quantity:\n");
      out.write("        <input type=\"number\" name=\"quantity\"\n");
      out.write("               min=\"1\" max=\"20\" value=\"");
      out.print( quantity );
      out.write("\" required>\n");
      out.write("\n");
      out.write("        Delivery Date:\n");
      out.write("        <input type=\"date\" name=\"delivery_date\"\n");
      out.write("               value=\"");
      out.print( date );
      out.write("\" required>\n");
      out.write("\n");
      out.write("        <input type=\"submit\" value=\"Update Order\">\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    <a href=\"myOrders.jsp\">Back to Orders</a>\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
