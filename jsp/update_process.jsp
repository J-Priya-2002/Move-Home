<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User Status</title>
</head>
<body>
    <%
        Connection con = null;

        try {
            String userIdParam = request.getParameter("userId");
            String newStatus = request.getParameter("status");

            if (userIdParam != null && !userIdParam.isEmpty()) {
                int userId = Integer.parseInt(userIdParam);

                // Establish a database connection (You should configure your database connection details)
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movehome", "root", "");

                // Prepare an SQL update statement
                String updateQuery = "UPDATE orders SET action = ? WHERE orderid = ?";
                PreparedStatement pstmt = con.prepareStatement(updateQuery);

                // Set the parameters for the update statement
                pstmt.setString(1, newStatus);
                pstmt.setInt(2, userId);

                // Execute the update statement
                int rowsUpdated = pstmt.executeUpdate();

                // Close resources
                pstmt.close();
                con.close();

                if (rowsUpdated > 0) {
    %>
                    <script>
                        alert("Successfully Updated!");
                        window.location.href = "admin.html";
                    </script>
    <%
                } else {
    %>
                    <script>
                        alert("Error: Update failed. Please try again later.");
                        window.location.href = "http://localhost:8081/project/projects/Move_Home/JSP_Programs/move_home/jsp/admin.jsp";
                    </script>
    <%
                }
            } else {
    %>
                <script>
                    alert("User ID is missing or invalid.");
                    window.location.href = "admin.html";
                </script>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error : " + e); // Redirect to an error page
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
