package org.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

//    public class LoginServlet(){
//        super();
//    }
    public static Connection get_connection() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/hotel_bookingSystem" , "root", "@livingstone7");
        System.out.println("succesfully connected");
        return connection;
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         String username = request.getParameter("username");
          String passwd  = request.getParameter("password");
          try {
              Connection conn = get_connection();
              PreparedStatement stmt = conn.prepareStatement("SELECT*FROM users WHERE login_name =? and login_pass =?");
              stmt.setString(1, username);
              stmt.setString(2, passwd);

              ResultSet rs = stmt.executeQuery();
             if (rs.next()) {
                  RequestDispatcher rd = request.getRequestDispatcher("/cart.jsp");
                  rd.forward(request, response);

              } else {
                  PrintWriter writer = response.getWriter();
                  writer.println("<h3>Invallid username or password</h3>");
              }

          }catch (SQLException e) {
              e.printStackTrace();
          } catch (ClassNotFoundException e) {
              e.printStackTrace();
         }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
