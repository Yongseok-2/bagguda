<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%
    String username = (String) session.getAttribute("username");
    int offerId = Integer.parseInt(request.getParameter("offer_id"));
    int productId = Integer.parseInt(request.getParameter("product_id"));
    int offeredproductId = Integer.parseInt(request.getParameter("offered_product_id"));

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement selectStmt = conn.prepareStatement(
             "SELECT sender_username FROM trade_offers WHERE offer_id = ?");
         PreparedStatement insertStmt = conn.prepareStatement(
             "INSERT INTO accepted_trades (offer_id, receiver_username, offerer_username, product_id) VALUES (?, ?, ?, ?)");
         PreparedStatement deleteStmt = conn.prepareStatement(
             "DELETE FROM trade_offers WHERE offer_id = ?");
    		PreparedStatement updateStmt1 = conn.prepareStatement(
   	             "UPDATE products SET sold = 1 WHERE product_id = ?");
    		PreparedStatement updateStmt2 = conn.prepareStatement(
    	             "UPDATE products SET sold = 1 WHERE product_id = ?")) {

        // 1. 제안 정보를 가져오기
        selectStmt.setInt(1, offerId);
        try (ResultSet rs = selectStmt.executeQuery()) {
            if (rs.next()) {
                String offererUsername = rs.getString("sender_username");
                

                // 2. 거래 수락 정보를 accepted_trades 테이블에 삽입
                insertStmt.setInt(1, offerId);
                insertStmt.setString(2, username); // 현재 로그인 사용자
                insertStmt.setString(3, offererUsername); // 제안 보낸 사용자
                insertStmt.setInt(4, productId);
                insertStmt.executeUpdate();
                
                updateStmt1.setInt(1, offeredproductId);
                updateStmt1.executeUpdate();
                
             // 3. 제품의 sold 상태 업데이트
                updateStmt2.setInt(1, productId);
                updateStmt2.executeUpdate();

                
                // 4. 제안을 trade_offers 테이블에서 삭제
            	 deleteStmt.setInt(1, offerId);
                 deleteStmt.executeUpdate();
                

                // 5. 성공 메시지 출력 후 'trade_offer_list.jsp'로 리다이렉션
                out.println("<script>alert('거래를 수락했습니다.'); location.href='trade_offer_list.jsp';</script>");
            } else {
                out.println("<script>alert('유효하지 않은 제안입니다.'); location.href='trade_offer_list.jsp';</script>");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('거래를 수락하는 중 오류가 발생했습니다.'); location.href='trade_offer_list.jsp';</script>");
    }
%>
