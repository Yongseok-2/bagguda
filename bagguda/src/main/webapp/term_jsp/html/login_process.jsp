<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %> <!-- BCrypt 라이브러리 임포트 -->
<%
    // 데이터베이스 연결 정보
    String jdbcURL = "jdbc:mysql://localhost:3306/sample"; // 데이터베이스 URL
    String jdbcUsername = "root"; // 사용자명
    String jdbcPassword = "root"; // 비밀번호

    // 클라이언트에서 전달받은 로그인 정보
    String username = request.getParameter("id");
    String password = request.getParameter("pw"); // 사용자가 입력한 비밀번호

    String message = ""; // 결과 메시지 저장
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
        Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // SQL 쿼리 실행: 아이디로 사용자 정보 가져오기
        String sql = "SELECT pw FROM users WHERE id = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();

        // 로그인 검증
        if (resultSet.next()) {
            String hashedPassword = resultSet.getString("pw"); // DB에 저장된 해시된 비밀번호

            // 입력 비밀번호와 해시된 비밀번호 비교
            if (BCrypt.checkpw(password, hashedPassword)) {
                session.setAttribute("username", username); // 세션에 로그인한 사용자 정보 저장

                // JavaScript alert 메시지 출력 후 리다이렉트
                out.println("<script>");
                out.println("alert('안녕하세요, " + username + "님!');");
                out.println("location.href = '../index.jsp';"); // 리다이렉트
                out.println("</script>");
            } else {
                message = "<h1>로그인 실패</h1><p>아이디 또는 비밀번호를 확인하세요.</p><a href='login.html'>다시 시도</a>";
            }
        } else {
            message = "<h1>로그인 실패</h1><p>아이디 또는 비밀번호를 확인하세요.</p><a href='login.html'>다시 시도</a>";
        }

        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
        message = "<h1>오류 발생</h1><p>문제가 발생했습니다: " + e.getMessage() + "</p>";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 결과</title>
</head>
<body>
    <%= message %>
</body>
</html>
