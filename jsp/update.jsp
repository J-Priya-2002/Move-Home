<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User Status</title>
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

        h1 {
            color: #4CAF50;
        }

        form {
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }

        .update-button {
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }

        .update-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    Connection con = null;

    try {
        String userIdParam = request.getParameter("orderid");

        if (userIdParam != null && !userIdParam.isEmpty()) {
            int userId = Integer.parseInt(userIdParam);

            // You can retrieve the user's status from the database here.
            // Replace this with your database logic to fetch and update the status.

            String currentStatus = "Active"; // Replace this with actual database logic to fetch the status.

%>
            <h1 align="center" style='color:purple;'>Update User Status</h1>
            <form action="update_process.jsp" method="post">
                <input type="hidden" name="userId" value="<%= userId %>">
                <label for="status">Status:</label>
                <select id="status" name="status">
                    <option value="Active" <%= currentStatus.equals("Active") ? "selected" : "" %>>Active</option>
                    <option value="UnderProcessing" <%= currentStatus.equals("Under Processing") ? "selected" : "" %>>Under Processing</option>
                    <option value="Deactive" <%= currentStatus.equals("Deactive") ? "selected" : "" %>>Deactive</option>
                </select>
                <input class="update-button" type="submit" value="Update Status">
            </form>
<%
        } else {
%>
            <p>User ID is missing or invalid.</p>
<%
        }
    } catch (Exception e) {
    	out.println("Error: " + e.getMessage());
    } 
%>
</body>
</html>
