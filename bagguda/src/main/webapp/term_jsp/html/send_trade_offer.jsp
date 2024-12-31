<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String selectedProduct = request.getParameter("selectedProduct");
    String message = request.getParameter("message");
    String userId = "user123";  // 예시: 로그인한 사용자의 아이디 (실제 구현 시 세션에서 가져오기)

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // DB 연결
        DBConnection dbConnection = new DBConnection();
        conn = dbConnection.getConnection();
        
        // 제안 정보를 저장하는 SQL 쿼리
        String sql = "INSERT INTO trade_offers (user_id, selected_product, message, offer_date) VALUES (?, ?, ?, NOW())";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userId);  // 현재 로그인한 사용자 ID
        stmt.setString(2, selectedProduct);  // 선택된 상품
        stmt.setString(3, message);  // 작성된 메시지
        
        int result = stmt.executeUpdate();
        
        if (result > 0) {
            out.println("제안이 성공적으로 보내졌습니다.");
        } else {
            out.println("제안 보내기에 실패했습니다.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("DB 오류가 발생했습니다.");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
