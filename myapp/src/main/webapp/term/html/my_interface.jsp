<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // 세션에서 로그인 정보 확인
    String username = (String) session.getAttribute("username");

    if (username == null) {  // 로그인하지 않은 경우
        response.sendRedirect("login.html");  // 로그인 페이지로 리디렉션
        return;  // 로그인되지 않은 경우 페이지 처리를 멈춤
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/interface.css">
</head>
<body>
    <!-- 상단 -->
    <header class="header">
        <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
        <div class="search-bar">
            <a href="../index.html"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
            <form id="searchForm" action="search_result.html" method="GET">
                <div class="search-input-container">
                    <input type="text" placeholder="🔍 물품명, 장터명, 카테고리 태그 등" class="search-input" id="searchInput" name="query">
                    <button type="submit" class="search-button" id="searchButton">🔍</button>
                </div>
            </form>
            <div class="icons">
                <a href="../html/bookmark.html"><span><img src="../images/bookmark01.png" alt="북마크" class="icons"></span></a>
                <span><img src="../images/favorite01.png" alt="즐겨찾기" class="icons"></span>
                <a href="../html/my_interface.jsp"><span><img src="../images/interpace01.png" alt="내정보" class="icons"></span></a>
                <a href="../html/login.html"><input type="button" class="icons" value="로그인"/></a>
            </div>
        </div>
    </header>

    <main class="interface-main">
        <div class="interface-container">
            <div class="interface-img-container">
                <div class="interface-img" id="profileImage">
                    <span class="change-text" id="changeText">이미지 변경</span>
                </div>
                <input type="file" id="imageInput" style="display: none;" accept="image/*">
                <h3 id="market-name-img">장터1231412호</h3>
                <div class="interface-star">
                    <img src="../images/star01.png" width="15" height="14" alt="별점">
                    <img src="../images/star01.png" width="15" height="14" alt="별점">
                    <img src="../images/star01.png" width="15" height="14" alt="별점">
                    <img src="../images/star01.png" width="15" height="14" alt="별점">
                    <img src="../images/star01.png" width="15" height="14" alt="별점">
                </div>
            </div>
            <div class="interface-name-container">
                <div class="interface-name">
                    <h3 id="market-name-text">장터1231412호
                        <button id="update-name-button" class="update-button">장터명 수정</button>
                    </h3>
                    <p id="market-description"></p>
                    <textarea id="description-editor" class="description-editor" maxlength="1000" style="display: none;"></textarea>
                    <button id="edit-description-button" class="update-button">소개글 수정</button>
                </div>
            </div>
        </div>
    </main>

    <script src="../scripts.js"></script>
    <script src="../js/interface.js"></script>
    <div style="flex: 0 0 auto;">
        <div class="container" id="stickyContainer">
            <button type="button" value="Top" onclick="clickme()" style="width: 100%; margin-bottom: 10px; padding: 5px; border-radius: 5px; background: white; border: 1px solid #0880F8;">Top</button>
            <div class="heart-container">
                <div class="heart">❤️</div>
                <span class="heart-count">2</span> <!-- 하트 받은 개수 -->
            </div>
            <hr class="divider"> <!-- 구분선 -->
            
            <div class="recent-viewed">최근 본 상품</div>
            <ul id="recentViewedList"></ul> <!-- 최근 본 상품 목록 -->
            <ul id="delete-btn"></ul>
            <!-- 전체 삭제 버튼 -->
        </div>
    </div>

</body>
</html>
