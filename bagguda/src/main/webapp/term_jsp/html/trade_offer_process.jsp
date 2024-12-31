<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>

<%
	request.setCharacterEncoding("UTF-8");

    String username = (String) session.getAttribute("username");

    if (username == null) {
        // 로그인이 안된 경우 경고 문구와 리다이렉트 설정
        out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
        return; // 이후 코드 실행 방지
    }
    
    String productId = request.getParameter("product_id");
    if (productId == null) {
        out.println("<p>상품 정보가 없습니다.</p>");
        return;
    }

    // product_id가 세션에 없는 경우 처리
    if (productId == null) {
        out.println("<script>alert('상품 정보가 세션에 없습니다.'); history.back();</script>");
        return;
    }

    String from_productId = request.getParameter("selectedProduct");
    String details = request.getParameter("details");
    String owner = request.getParameter("owner");  // URL에서 owner를 받아옴

    if (from_productId == null || details == null || owner == null) {
        out.println("<script>alert('필수 데이터가 누락되었습니다.'); location.href='trade_offer_process.jsp';</script>");
        return;
    }

    // trade_offers 테이블에 제안 정보 저장
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
             "INSERT INTO trade_offers (sender_username, receiver_username, product_id, from_product_id, details, status) " +
             "VALUES (?, ?, ?, ?, ?, ?)")) {
        
        pstmt.setString(1, username); // 보내는 사람 (로그인한 사용자)
        pstmt.setString(2, owner); // 받는 사람 (상품 소유자, URL에서 전달받음)
        pstmt.setInt(3, Integer.parseInt(productId)); // product_id
        pstmt.setInt(4, Integer.parseInt(from_productId)); // product_id
        pstmt.setString(5, details); // 추가 메시지
        pstmt.setString(6, "pending"); // 상태: 'pending' 기본값

        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<script>alert('제안이 성공적으로 전송되었습니다!'); location.href='../html/trade_offer_list.jsp';</script>");
        } else {
            out.println("<script>alert('제안을 전송하는 데 실패했습니다. 다시 시도해주세요.');</script>");
        }
    } catch (SQLException e) {
        out.println("<script>alert('데이터베이스 오류: " + e.getMessage() + "');</script>");
    }
%>
