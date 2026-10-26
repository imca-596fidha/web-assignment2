package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Customer Login</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"style.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>Customer Login</h2>\n");
      out.write("\n");
      out.write("    <form action=\"login.jsp\" method=\"post\">\n");
      out.write("        Email:\n");
      out.write("        <input type=\"email\" name=\"email\" required>\n");
      out.write("\n");
      out.write("        Password:\n");
      out.write("        <input type=\"password\" name=\"password\" required>\n");
      out.write("\n");
      out.write("        <input type=\"submit\" value=\"Login\">\n");
      out.write("    </form>\n");
      out.write("\n");

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

      out.write("\n");
      out.write("\n");
      out.write("    <p><a href=\"register.jsp\">Create an Account</a></p>\n");
      out.write("    <p><a href=\"index.jsp\">Back to Home</a></p>\n");
      out.write("</div>\n");
      out.write("\n");
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
