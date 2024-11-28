<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> <!-- 세션을 사용할 수 있도록 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">
</head>
<body>
<header class="header">
    <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
    <div class="search-bar">
        <a href="../index.jsp"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
        <form id="searchForm" action="search_result.html" method="GET">
            <div class="search-input-container">
                <input type="text" placeholder="🔍 물품명, 장터명, 카테고리 태그 등" class="search-input" id="searchInput" name="query">
                <button type="submit" class="search-button" id="searchButton">🔍</button>
            </div>
        </form>
        <div class="icons">
            <a href="../html/bookmark.jsp"><img src="../images/bookmark01.png" alt="북마크" class="icons"></a>
            <a href="#"><img src="../images/favorite01.png" alt="즐겨찾기" class="icons"></a>
            <a href="../html/my_interface.jsp"><img src="../images/interpace01.png" alt="내정보" class="icons"></a>

            <% 
            // 세션에서 username 가져오기
            String username = (String) session.getAttribute("username"); // 세션에서 사용자 이름 가져오기
            if (username != null) { 
            %>
                <span class="username-display"><%= username %></span>
                <a href="../html/logout.jsp">
                    <input type="button" class="logout-button" value="로그아웃">
                </a>
            <% 
            } else { 
            %>
                <a href="../html/login.html">
                    <input type="button" class="login-button" value="로그인">
                </a>
            <% 
            } 
            %>
        </div>
    </div>
    <nav class="manu-bar">
        <button class="category-btn">카테고리</button>
        <a href="../index.jsp#my-wants">내가 원해요</a>
        <a href="../index.jsp#others-wants">상대방이 원해요</a>
        <a href="#">급상승</a>
        <a href="#">쏙</a>
        <a href="#">이벤트</a>
        <a href="item.html">상품등록</a>
    </nav>
</header>

<main class="main">
    <% 
        // 검색어 가져오기
        String searchQuery = request.getParameter("query");

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // 검색어 기반 쿼리, other_wants 제외
                    String sql = "SELECT product_name, product_price, product_image FROM products " +
                                 "WHERE product_name LIKE ? AND category != 'others_wants'";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + searchQuery.trim() + "%");
                    rs = pstmt.executeQuery();

                    boolean hasResults = false;
                    if (rs.isBeforeFirst()) {
        %>
        <h2>검색 결과: "<%= searchQuery %>"</h2>
        <section class="search-results">
            <div class="wants-container"> <!-- wants-container를 한 번만 정의 -->
            <% 
                        } // 첫 번째 결과 출력 전에 검색어 표시
                        
            while (rs.next()) {
                hasResults = true;
        %>
            <div class="want-item">
                <img src="../<%= rs.getString("product_image") %>" alt="상품 이미지" class="product-image">
                <h5 class="product-name"><%= rs.getString("product_name") %></h5>
                <p class="product-price">₩<%= rs.getInt("product_price") %></p>
                <a href="#" class="trade-button">거래하기</a>
            </div>
        <% 
                    }
                    if (!hasResults) {
        %>
        <p>검색 결과가 없습니다.</p>
        <% 
                    }
                } catch (SQLException e) {
                    out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>DB 연결 실패</p>");
            }
        } else {
            out.println("<p>검색어를 입력해주세요.</p>");
        }
    %>
            </div> <!-- wants-container 끝 -->
        </section>
    </main>

    <script src="../scripts.js"></script>
</body>
</html>
