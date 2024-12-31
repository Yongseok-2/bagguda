<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%

%>
<%
    // 로그인된 사용자 확인
    String username = (String) session.getAttribute("username");
    if (username == null) {
        out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
        return;
    }

    // 삭제할 offer_id 받아오기
    String offerIdStr = request.getParameter("offer_id");

    if (offerIdStr != null && !offerIdStr.isEmpty()) {
        try {
            int offerId = Integer.parseInt(offerIdStr); // offer_id를 정수로 파싱
            out.println("offer_id: " + offerId); // 디버깅용
            try (Connection conn = DBConnection.getConnection()) {
                // 1. accepted_trades 테이블에서 해당 offer_id 관련 데이터를 먼저 삭제
                String deleteAcceptedTradeSql = "DELETE FROM accepted_trades WHERE offer_id = ?";
                try (PreparedStatement deleteAcceptedStmt = conn.prepareStatement(deleteAcceptedTradeSql)) {
                    deleteAcceptedStmt.setInt(1, offerId);
                    deleteAcceptedStmt.executeUpdate(); // 해당 offer_id와 관련된 데이터 삭제
                }

                // 2. trade_offers 테이블에서 제안 삭제
                String deleteOfferSql = "DELETE FROM trade_offers WHERE offer_id = ? AND sender_username = ?";
                try (PreparedStatement deleteOfferStmt = conn.prepareStatement(deleteOfferSql)) {
                    deleteOfferStmt.setInt(1, offerId); // offer_id 설정
                    deleteOfferStmt.setString(2, username); // 현재 로그인된 사용자(받은 사람)만 삭제할 수 있도록 설정

                    // 쿼리 실행
                    int rowsAffected = deleteOfferStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<script>alert('제안이 삭제되었습니다.'); location.href='trade_offer_list.jsp';</script>");
                    } else {
                        out.println("<script>alert('삭제할 제안을 찾을 수 없습니다.'); location.href='trade_offer_list.jsp';</script>");
                    }
                }
            }
        } catch (NumberFormatException e) {
            out.println("<script>alert('잘못된 요청입니다.'); location.href='trade_offer_list.jsp';</script>");
        } catch (SQLException e) {
            out.println("<script>alert('삭제 중 오류가 발생했습니다: " + e.getMessage() + "'); location.href='trade_offer_list.jsp';</script>");
        }
    } else {
        out.println("<script>alert('잘못된 요청입니다.'); location.href='trade_offer_list.jsp';</script>");
    }
%>
