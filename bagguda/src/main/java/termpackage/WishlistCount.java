package termpackage;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/WishlistCount")
public class WishlistCount extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSON 응답을 위한 Content-Type 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userId = (String) request.getSession().getAttribute("username"); // 세션에서 사용자 ID 가져오기
        int wishCount = 0;

        try {
            // MySQL 데이터베이스 연결
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sample", "root", "root");
            
            // 'is_in_wishlist'가 1인 항목만 계산하는 쿼리
            String query = "SELECT COUNT(*) AS wish_count FROM wishlist WHERE user_id = ? AND is_in_wishlist = 1";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            
            // 쿼리 실행
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                wishCount = rs.getInt("wish_count"); // 결과 가져오기
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSON 응답 생성
        String jsonResponse = "{\"wishCount\": " + wishCount + "}";
        response.getWriter().write(jsonResponse);
    }
}
