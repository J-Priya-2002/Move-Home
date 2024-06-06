<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.math.BigDecimal" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center; 
            justify-content: center; 
            height: 100vh; 
        }

        a.btn {
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            padding: 10px 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        a.btn:hover {
            background-color: #45a049;
        }

        header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
        }

        h1 {
            color: #4CAF50;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dddddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e0e0e0;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
        }

        a:hover {
            text-decoration: underline;
        }

       p {
		    text-align: center;
		    color: red; 
		    font-weight: bold; 
		    font-size: 18px; 
		    margin-top: 10px; 
		}

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .logout-button-container {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    /* Style for the logout button */
    .logout-button {
        font-size: 24px;
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
    }

    /* Style for the logout button on hover */
    .logout-button:hover {
        background-color: #45a049;
    }
  
    </style>
</head>
<body>
<%
    Connection con = null;
    
    try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String URL = "jdbc:mysql://localhost:3306/movehome";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(URL, "root", "");
        
        // Check if the email and password exist in the database
        PreparedStatement ps = con.prepareStatement("SELECT name, email, password FROM admin WHERE email=? AND password=?");
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // If the user is found in the database, set the email in the session
            HttpSession mysession = request.getSession();
            mysession.setAttribute("email", email);
            
            // Retrieve and display users' details from the database
            String selectQuery = "SELECT * FROM orders";
            ResultSet resultSet = ps.executeQuery(selectQuery);

%>
            <h1 align="center" style='color:purple;'>You are Successfully Logged in</h1>
   
            <!-- Display users' details here (you can fetch this data from a database) -->
            <h2 align="center" style='color:blue;'>Order Details:</h2>
            <table>
                <tr>
                		<th>Order ID</th>
                    	<th>Customer Name</th>
			            <th>Moving Date</th>
			            <th>Pickup Address</th>
			            <th>Delivery Address</th>
			            <th>Distance (km)</th>
			            <th>Total Amount</th>
			            <th>Action</th>
	                </tr>
<%
			while (resultSet.next()) {
            	
%>
                <tr>
                	<td><%= resultSet.getString("orderid") %></td>
				    <td><%= resultSet.getString("customername") %></td>
				    <td><%= resultSet.getString("orderdate") %></td>
				    <td><%= resultSet.getString("pickupaddress") %></td>
				    <td><%= resultSet.getString("deliveryaddress") %></td>
				    <td><%= resultSet.getDouble("distancetraveled") %></td>
				    <td><%= resultSet.getDouble("totalamount") %></td>
				    <td><a href="update.jsp?orderid=<%= resultSet.getString("orderid") %>">status</a></td>
				</tr>
<%
            }
%>
            </table>
            <!-- Center-align the logout button -->
			<div class="logout-button-container">
			    <form action="admin.html" method="post">
			        <input class="logout-button" type="submit" value="Logout">
			    </form>
			</div>

<%
        } else {
%>
            <p>Username or Password is incorrect</p>
            <a href="admin.html" class="btn">Try Again</a>
<%
        }
    } 
    catch (Exception e) {
        e.printStackTrace();
    } 
%>
</body>
</html>
