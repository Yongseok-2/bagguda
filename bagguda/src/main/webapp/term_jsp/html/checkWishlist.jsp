<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> 

<%
    String username = (String) session.getAttribute("username");
    String productId = request.getParameter("product_id");
    boolean isInWishlist = false;

    if (username != null && productId != null) {
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, productId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                isInWishlist = rs.getInt(1) > 0;
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    request.setAttribute("isInWishlist", isInWishlist);
%>
