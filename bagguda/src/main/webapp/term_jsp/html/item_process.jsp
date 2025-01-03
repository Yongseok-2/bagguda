<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 처리</title>
    <script type="text/javascript">

    </script>
</head>
<body>
<%
    // 세션에서 로그인한 사용자의 아이디를 가져옴
    String owner = (String) session.getAttribute("username");  // 세션에서 사용자 아이디 가져오기

    // 만약 세션에 아이디가 없으면 로그인 페이지로 리다이렉트
    if (owner == null) {
        response.sendRedirect("login.html");  // 로그인 페이지로 리다이렉트
        return;
    }

    // 파일 업로드 처리
    String uploadPath = "D:\\term\\asd\\src\\main\\webapp\\term_jsp\\upload"; // 파일 저장 경로
    int maxSize = 5 * 1024 * 1024; // 5MB 제한
    String encoding = "UTF-8";

    MultipartRequest multi = null;

    try {
        multi = new MultipartRequest(request, uploadPath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 업로드된 파일명 및 데이터 수집
        Enumeration files = multi.getFileNames();
        List<String> pd_images = new ArrayList<>(); // 여러 이미지 파일을 저장할 리스트

        while (files.hasMoreElements()) {
            String fileInputName = (String) files.nextElement();
            String pd_image = multi.getFilesystemName(fileInputName); // 저장된 파일명
            if (pd_image != null) {
                pd_images.add("upload/" + pd_image); // 상대 경로 저장
            }
        }

        // 폼 데이터 수집
        String pd_name = multi.getParameter("pd_name");
        int pd_price = Integer.parseInt(multi.getParameter("pd_price"));
        String pd_information = multi.getParameter("pd_information");
        String[] categories = multi.getParameterValues("category[]");
        String pd_status = multi.getParameter("pd_status");
        String[] trade_methods = multi.getParameterValues("trade_method[]");
        String[] trade_systems = multi.getParameterValues("trade_system[]");
        String location_1 = multi.getParameter("location_1"); // 거래 희망 지역 1
        String location_2 = multi.getParameter("location_2"); // 거래 희망 지역 2
        String[] locations = multi.getParameterValues("location_1[]");
        // 체크박스 상태 확인
        
        String trade_method = (trade_methods != null) ? String.join(",", trade_methods) : "";
        String trade_system = (trade_systems != null) ? String.join(",", trade_systems) : "";
        String category = (categories != null) ? String.join(",", categories) : "";
		String location = (locations != null) ? String.join(",", locations) : "";
		
        // 물물교환 가격 처리
        String trade_price = multi.getParameter("trade_price");
        String trade_max_price = multi.getParameter("trade_max_price");

        // 판매 가격 처리
        String sell_price = multi.getParameter("sell_price");

        // DB 저장
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                // SQL 작성 및 실행
                String sql = "INSERT INTO products (pd_name, pd_price, pd_image, pd_information, owner, pd_status, category, trade_method, trade_system, location_1, location_2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 자동 생성된 키 반환 설정
                stmt.setString(1, pd_name);
                stmt.setInt(2, pd_price);
                stmt.setString(3, String.join(",", pd_images));
                stmt.setString(4, pd_information);
                stmt.setString(5, owner);
                stmt.setString(6, pd_status);
                stmt.setString(7, category);  // 다중 선택값 저장
                stmt.setString(8, trade_method);  // 다중 선택값 저장
                stmt.setString(9, trade_system);
                stmt.setString(10, location_1);  // 다중 선택값 저장
                stmt.setString(11, location_2);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // 마지막으로 삽입된 product_id 가져오기
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    int productId = -1;
                    if (generatedKeys.next()) {
                        productId = generatedKeys.getInt(1);
                    }

                    if (productId > 0) {
                        // 상품 정보 페이지로 리다이렉트
                        out.println("<script type='text/javascript'>");
                        out.println("alert('상품 등록에 성공하셨습니다.');");
                        out.println("window.location.href = 'item_info.jsp?product_id=" + productId + "';");
                        out.println("</script>");
                    } else {
                        out.println("<p>상품 등록 실패. ID를 가져올 수 없습니다.</p>");
                    }
                } else {
                    out.println("<p>상품 등록 실패. 다시 시도해 주세요.</p>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>SQL 에러 발생: " + e.getMessage() + "</p>");
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>파일 업로드 에러: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
