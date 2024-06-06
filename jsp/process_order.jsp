<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Processing</title>
</head>
<body>
    <%
        Connection connection = null;
        String message = ""; // Initialize a message variable

        try {
            // Retrieve data from the request parameters
            String customerName = request.getParameter("customerName");
            String movingDate = request.getParameter("movingDate");
            String pickupAddress = request.getParameter("pickupAddress");
            String deliveryAddress = request.getParameter("deliveryAddress");
            double distance = Double.parseDouble(request.getParameter("distance"));
            double charges = Double.parseDouble(request.getParameter("charges"));

            // Calculate the total amount based on your logic
            int fridgeQuantity = Integer.parseInt(request.getParameter("fridgeQuantity"));
            int fanQuantity = Integer.parseInt(request.getParameter("fanQuantity"));
            int tablesQuantity = Integer.parseInt(request.getParameter("tablesQuantity"));
            int sofaQuantity = Integer.parseInt(request.getParameter("sofaQuantity"));
            int luggageQuantity = Integer.parseInt(request.getParameter("luggageQuantity"));

            int fridgeAmount = fridgeQuantity * 200;
            int fanAmount = fanQuantity * 100;
            int tablesAmount = tablesQuantity * 300;
            int sofaAmount = sofaQuantity * 750;
            int luggageAmount = luggageQuantity * 150;

            double distanceAmount = distance * charges;

            double totalAmount = fridgeAmount + fanAmount + tablesAmount + sofaAmount + luggageAmount + distanceAmount;

            // Establish a database connection here
            String jdbcUrl = "jdbc:mysql://localhost:3306/movehome";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Create the SQL insert query
            String insertQuery = "INSERT INTO orders (customername, orderdate, pickupaddress, deliveryaddress, distancetraveled, totalamount) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, customerName);
            preparedStatement.setString(2, movingDate);
            preparedStatement.setString(3, pickupAddress);
            preparedStatement.setString(4, deliveryAddress);
            preparedStatement.setDouble(5, distance);
            preparedStatement.setDouble(6, totalAmount);

            // Execute the insert query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                message = "Order has been successfully placed."; // Set the success message
            } else {
                message = "Error: Order insertion failed."; // Set the error message
            }
        } catch (ClassNotFoundException | SQLException e) {
            message = "Error: " + e.getMessage();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                message = "Error closing database connection: " + e.getMessage();
            }
        }
    %>

    <!-- JavaScript to display an alert message -->
    <script>
        var message = '<%= message %>'; // Retrieve the message from JSP variable
        alert(message); // Display the message in an alert box
        window.location.href = "login.html"; // Redirect to another page after displaying the alert
    </script>
</body>
</html>