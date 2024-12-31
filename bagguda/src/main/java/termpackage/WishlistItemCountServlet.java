package termpackage;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WishlistItemCountServlet")  // 서블릿 경로 수정
public class WishlistItemCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSON 응답을 위한 Content-Type 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String productId = request.getParameter("product_id"); // 상품 ID를 요청 파라미터로 받기
        int wishItemCount = 0; // 변수명을 wishItemCount로 변경

        try {
            // MySQL 데이터베이스 연결
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sample", "root", "root");

            // 'is_in_wishlist'가 1인 항목만 계산하는 쿼리
            String query = "SELECT COUNT(*) AS wish_item_count FROM wishlist WHERE product_id = ? AND is_in_wishlist = 1"; // SQL 쿼리에서도 변수명 변경
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, productId);  // 상품 ID를 쿼리 파라미터로 전달
            
            // 쿼리 실행
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                wishItemCount = rs.getInt("wish_item_count"); // 결과 가져오기
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSON 응답 생성
        String jsonResponse = "{\"wishItemCount\": " + wishItemCount + "}"; // JSON 키값 변경
        response.getWriter().write(jsonResponse); // JSON 응답 반환
    }
}
