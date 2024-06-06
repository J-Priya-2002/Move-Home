<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        p {
            margin: 10px 0;
            color: #666;
        }

        a {
            text-decoration: none;
            color: #0077cc;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
    
</head>
<body>
    
<%
    String id = request.getParameter("id");
    String name = "";
    String date = "";
    String pickupadd = "";
    String deliveryadd = "";
    String dist = "";
    String amt = "";
    String action = "";
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        String URL = "jdbc:mysql://localhost:3306/movehome";
        Class.forName("com.mysql.jdbc.Driver"); // Updated to newer class name for MySQL driver
        con = DriverManager.getConnection(URL, "root", "");
        
        String query = "SELECT * FROM orders WHERE orderid = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, id);
        
        rs = ps.executeQuery(); // Correctly execute the prepared statement

        if (rs.next()) {
            name = rs.getString("customername");
            date = rs.getString("orderdate");
            pickupadd = rs.getString("pickupaddress");
            deliveryadd = rs.getString("deliveryaddress");
            dist = rs.getString("distancetraveled");
            amt = rs.getString("totalamount");
            action = rs.getString("action");
        } else {
            name = "N/A";
            date = "N/A";
            pickupadd = "N/A";
            deliveryadd = "N/A";
            dist = "N/A";
            amt = "N/A";
            action = "N/A";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<div class="container">
    <h1>User Status</h1>
    <p>Order Number: <%= id %></p>
    <p>Customer Name: <%= name %></p>
    <p>Order Date: <%= date %></p>
    <p>Pickup Address: <%= pickupadd %></p>
    <p>Delivery Address: <%= deliveryadd %></p>
    <p>Distance Traveled: <%= dist %></p>
    <p>Total Amount: <%= amt %></p>
    <p>Action: <%= action %></p><br>
    <p><a href="http://localhost:8080/project/projects/Move_Home/JSP_Programs/src/main/webapp/move_home/jsp/login.html">Back</a></p>
</div>
</body>
</html>