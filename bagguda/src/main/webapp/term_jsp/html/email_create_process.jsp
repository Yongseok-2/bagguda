<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="termpackage.DBConnection" %>
<!DOCTYPE html>
<html>
<head>	
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
</head>
<body>
<%
    String userId = request.getParameter("id");
    String userPw = request.getParameter("pw");
    String confirmPw = request.getParameter("confirm_pw");

    // 유효성 검사
    if (userId == null || userId.trim().isEmpty() || userPw == null || userPw.trim().isEmpty() || confirmPw == null || confirmPw.trim().isEmpty()) {
        out.println("<script>alert('아이디, 비밀번호, 비밀번호 확인을 모두 입력해주세요.'); history.back();</script>");
        return;
    }

    // 영어와 숫자만 허용하는 정규식
    if (!userId.matches("^[a-zA-Z0-9]+$")) {
        out.println("<script>alert('아이디는 영어와 숫자만 입력할 수 있습니다.'); history.back();</script>");
        return;
    }

    if (!userPw.equals(confirmPw)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        
        // 아이디 중복 체크
        String checkSql = "SELECT id FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            out.println("<script>alert('이미 사용 중인 아이디입니다.'); history.back();</script>");
            return;
        }
        
        // 비밀번호 암호화
        String hashedPw = BCrypt.hashpw(userPw, BCrypt.gensalt());

        // 암호화된 비밀번호를 데이터베이스에 저장
        String sql = "INSERT INTO users (id, pw, market_name, description, user_image) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, hashedPw);

        // market_name은 번호 기반 자동 증가 로직으로 생성
        String getMaxMarketNameSql = "SELECT IFNULL(MAX(CAST(SUBSTRING_INDEX(market_name, '창고', 1) AS UNSIGNED)), 0) + 1 AS nextNumber FROM users";
        PreparedStatement maxMarketNameStmt = conn.prepareStatement(getMaxMarketNameSql);
        ResultSet marketNameRs = maxMarketNameStmt.executeQuery();
        int nextMarketNumber = 1; // 기본값
        if (marketNameRs.next()) {
            nextMarketNumber = marketNameRs.getInt("nextNumber");
        }
        String marketName = nextMarketNumber + "창고";

        // description 기본값
        String description = "이 부분은 설명입니다";
        
        // user_image 기본값
        String userImage = "images/default_image.png";

        pstmt.setString(3, marketName);
        pstmt.setString(4, description);
        pstmt.setString(5, userImage);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 회원가입 성공 후 로그인 상태 유지
            session.setAttribute("username", userId);
            out.println("<script>alert('회원가입이 완료되었습니다, " + userId + "님!'); window.location.href = 'my_interface.jsp';</script>");
        } else {
            out.println("<script>alert('회원가입에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('에러가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
