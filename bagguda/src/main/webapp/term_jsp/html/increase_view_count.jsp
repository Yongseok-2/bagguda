<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, termpackage.DBConnection" %>

<%
    String productId = request.getParameter("product_id");

    if (productId != null) {
        try {
            // 데이터베이스 연결
            Connection conn = DBConnection.getConnection();
            String query = "UPDATE products SET view_count = view_count + 1 WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, productId);

            int rowsUpdated = stmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                response.getWriter().write("Success");
            } else {
                response.getWriter().write("No rows updated");
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error");
        }
    } else {
        response.getWriter().write("No product_id provided");
    }
%>
