package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Customer Registration</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"style.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>Customer Registration</h2>\n");
      out.write("\n");
      out.write("    <form method=\"post\">\n");
      out.write("        Name:\n");
      out.write("        <input type=\"text\" name=\"name\" required>\n");
      out.write("\n");
      out.write("        Email:\n");
      out.write("        <input type=\"email\" name=\"email\" required>\n");
      out.write("\n");
      out.write("        Password:\n");
      out.write("        <input type=\"password\" name=\"password\" required>\n");
      out.write("\n");
      out.write("        <input type=\"submit\" value=\"Register\">\n");
      out.write("    </form>\n");
      out.write("\n");

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

      out.write("\n");
      out.write("\n");
      out.write("<br><br>\n");
      out.write("<a href=\"index.jsp\">Back to Home</a>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>");
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
