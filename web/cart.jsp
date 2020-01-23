<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.database_utils.Db_connect" %><%--
  Created by IntelliJ IDEA.
  User: livin
  Date: 1/17/2020
  Time: 6:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart page | shopping_cart</title>
</head>
<body>

<h3>Shopping cart</h3>
<form action="ShoppingCartServlet" method="post">
    <table border="1">
        <thead>
        <tr>
            <th>No</th><th>Product</th><th>price</th><th>quantity</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            try{
            conn = Db_connect.get_connection();
            ResultSet rs = conn.prepareStatement("SELECT*FROM products").executeQuery();
        %>
        <%
            while(rs.next()){
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td>$ <%=rs.getString(3)%></td>
            <td>
                <input type="hidden" name="product_id" value="<%=rs.getString(1)%>">
                <input type="text" name="qty" placeholder="0">
            </td>
        </tr>
        <%}%>
        <% }catch(Exception e){
              System.out.printf("Error : %s",e.getMessage());
            }
        %>
        <tr> <td colspan="2"><input  type="submit" value="logout"> </td><td><input type="submit" value="Check Out"> </td></tr>
        </tbody>
    </table>
</form>
</body>
</html>
