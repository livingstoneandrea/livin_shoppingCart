package org.example;

import com.database_utils.Db_connect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shipping_address = request.getParameter("shipping_address");
        String go_back =request.getParameter("go_backBtn");
        String place_orderBtn  =request.getParameter("place_orderBtn");
        if(go_back!=null){
            request.getRequestDispatcher("/cart.jsp").forward(request,response);
            //request.getSession().invalidate();
        }else if(place_orderBtn!=null){
            process_order(shipping_address,request,response);
        }else{

        }
        //request.getRequestDispatcher("").forward(request,response);
    }

    private void go_back() {


    }

    private void process_order(String shipping_addr ,HttpServletRequest request, HttpServletResponse response){
        Connection conn =null;
        try{
            conn = Db_connect.get_connection();

            String sql = "INSERT INTO orders(order_address,order_charges) VALUES(?,?)";
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1,shipping_addr);
            preparedStatement.setDouble(2,40.0);
            //preparedStatement.setDate(3, new Date().toLocalDate());

            preparedStatement.execute();
            request.getRequestDispatcher("/info.html").forward(request,response);

        }catch (Exception e){
            e.printStackTrace();
        }


    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
