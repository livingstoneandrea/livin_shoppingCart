<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.database_utils.Db_connect" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: livin
  Date: 1/17/2020
  Time: 6:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout page | shopping cart</title>
</head>
<body>

<h3>Checkout</h3>
    <%
        String product_id[] = request.getParameterValues("product_id");
        String  product_qty[] = request.getParameterValues("qty");
        //int no = Integer.parseInt(product_id[1]);
        int product_count =0;
        double subtotal =0;
        double shipping_charge= 1.00;
        int i =0;
        if(product_qty!=null){
            for(String product :product_qty){
                if((product != null && product != "")){
                    product_count+= Integer.parseInt(product);
                }

            }
            Connection conn = null;

            try {
                conn = Db_connect.get_connection();
                String sql = "SELECT product_id ,product_price FROM products WHERE product_id = ?";
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                for(String p_id :product_id){
                    preparedStatement.setString(1,p_id);
                    ResultSet rs = preparedStatement.executeQuery();
                    if(rs.next()){
                        subtotal += Integer.parseInt(rs.getString("price")) * Integer.parseInt(product_qty[i]);
                    }
                    i++;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

    %>
    <form action="CheckoutServlet" method="post">
        <table>
            <thead><tr><th>Checkout !!</th></tr></thead>
            <tbody>
            <tr><td>No of products</td><td><%=product_qty.length%></td></tr>
            <tr><td>No of items</td><td><%=product_count %></td></tr>
            <tr><td>subtotal</td><td>$ <%=subtotal %></td></tr>
            <tr><td>Shipping</td><td>$ <%=shipping_charge %></td></tr>
            <tr><td>Grand total</td><td>$ <%=(subtotal + shipping_charge) %></td></tr>
            <tr><td >shipping adress</td><td><input type="text" name="shipping_address" placeholder="shipping address"></td></tr>
            <tr><td ><input type="submit" name="go_backBtn" value="Go back"></td><td><input name="place_orderBtn" type="submit" value="place Order"></td></tr>
            </tbody>
        </table>
    </form>
</body>
</html>
