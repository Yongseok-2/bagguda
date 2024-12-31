<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.*, java.time.format.DateTimeFormatter, java.time.temporal.ChronoUnit, termpackage.DBConnection" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세정보</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/item_info.css"> 
    <link rel="stylesheet" href="../css/font.css">
    <link rel="stylesheet" href="../css/item.css">
</head>
<body style="overflow-x: hidden">
    <header class="header">
    	<a href="../index.jsp"><img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar"></a>
        <div class="search-bar">
            <a href="../index.jsp"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
            <form id="searchForm" action="search_result.jsp" method="GET">
                <div class="search-input-container">
                    <input type="text" placeholder="물품명, 카테고리 등" class="search-input" id="searchInput" name="query">
                    <button type="submit" class="search-button" id="searchButton"><img src="../images/search.svg" alt="검색 아이콘"></button>
                </div>
            </form>
			<div class="icons">
			    <%
			    	String username = (String) session.getAttribute("username");
			        if (username != null) {
			    %>
			        <a href="my_interface.jsp"><span>'<%= username %>' 님  </span></a> <!-- 로그인한 사용자 아이디 표시 -->
			        <div style="width: 1px; height: 20px; background-color: #9b9b9b; margin: 20px 0; margin-right: 10px; margin-left: 20px;"></div>
			        <a href="logout.jsp"><input type="button" class="icons" value="로그아웃"/></a> <!-- 로그아웃 버튼 -->
			    <%
			        } else {
			    %>
			        <a href="login.html"><input type="button" class="icons" value="로그인"/></a>
			        <div style="width: 1px; height: 20px; background-color: #9b9b9b; margin: 20px 0; margin-right: 10px; margin-left: 20px;"></div>
			        <a href="create_account.html"><input type="button" class="icons" value="회원가입"/></a>
			    <%
			        }
			    %>
			</div>

        </div>
        <div class="row columns">
            <ul class="menu align-center expanded text-center SMN_effect-6">
                <a href="#" title="카테고리" class="button btnFade btnLightBlue">카테고리</a>
                <div class="overlay" id="overlay"></div>
                <div class="sidebar" id="sidebar">
                    <button class="close-btn" onclick="toggleSidebar()">×</button>
                    <h2>카테고리</h2>
	                <ul>
				        <li class="dropdown">
				            <a href="category_result.jsp?category=전자기기">전자기기</a>
				            <ul class="dropdown-menu">
				                <li><a href="category_result.jsp?category=스마트폰">스마트폰</a></li>
				                <li><a href="category_result.jsp?category=태블릿">태블릿</a></li>
				                <li><a href="category_result.jsp?category=노트북">노트북</a></li>
				                <li><a href="category_result.jsp?category=데스크탑">데스크탑</a></li>
				                <li><a href="category_result.jsp?category=스마트워치">스마트워치</a></li>
				                <li><a href="category_result.jsp?category=이어폰/헤드폰">이어폰/헤드폰</a></li>
				                <li><a href="category_result.jsp?category=카메라">카메라</a></li>
				                <li><a href="category_result.jsp?category=게임기">게임기</a></li>
				                <li><a href="category_result.jsp?category=드론">드론</a></li>
				                <li><a href="category_result.jsp?category=액세서리">액세서리</a></li>
				            </ul>
				        </li>
				        
				        <!-- 가전제품 -->
				        <li class="dropdown">
				            <a href="category_result.jsp?category=가전제품">가전제품</a>
				            <ul class="dropdown-menu">
				                <li><a href="category_result.jsp?category=냉장고">냉장고</a></li>
				                <li><a href="category_result.jsp?category=세탁기">세탁기</a></li>
				                <li><a href="category_result.jsp?category=에어컨">에어컨</a></li>
				                <li><a href="category_result.jsp?category=TV">TV</a></li>
				                <li><a href="category_result.jsp?category=전자레인지">전자레인지</a></li>
				                <li><a href="category_result.jsp?category=청소기">청소기</a></li>
				                <li><a href="category_result.jsp?category=공기청정기">공기청정기</a></li>
				                <li><a href="category_result.jsp?category=정수기">정수기</a></li>
				                <li><a href="category_result.jsp?category=믹서기">믹서기</a></li>
				                <li><a href="category_result.jsp?category=주방가전">주방가전</a></li>
				            </ul>
				        </li>
				        
				        <!-- 가구/인테리어 -->
				        <li class="dropdown">
				            <a href="category_result.jsp?category=가구/인테리어">가구/인테리어</a>
				            <ul class="dropdown-menu">
				                <li><a href="category_result.jsp?category=소파">소파</a></li>
				                <li><a href="category_result.jsp?category=책상">책상</a></li>
				                <li><a href="category_result.jsp?category=의자">의자</a></li>
				                <li><a href="category_result.jsp?category=침대">침대</a></li>
				                <li><a href="category_result.jsp?category=옷장">옷장</a></li>
				                <li><a href="category_result.jsp?category=선반">선반</a></li>
				                <li><a href="category_result.jsp?category=커튼">커튼</a></li>
				                <li><a href="category_result.jsp?category=조명">조명</a></li>
				                <li><a href="category_result.jsp?category=카펫">카펫</a></li>
				                <li><a href="category_result.jsp?category=액자">액자</a></li>
				            </ul>
				        </li>
				        
				        <!-- 남성 패션 -->
				        <li class="dropdown">
				            <a href="category_result.jsp?category=남성패션">남성 패션</a>
				            <ul class="dropdown-menu">
				                <li><a href="category_result.jsp?category=남성 의류">남성 의류</a></li>
				                <li><a href="category_result.jsp?category=남성 신발">남성 신발</a></li>
				                <li><a href="category_result.jsp?category=남성 가방">남성 가방</a></li>
				                <li><a href="category_result.jsp?category=넥타이">넥타이</a></li>
				                <li><a href="category_result.jsp?category=벨트">벨트</a></li>
				                <li><a href="category_result.jsp?category=지갑">지갑</a></li>
				                <li><a href="category_result.jsp?category=모자">모자</a></li>
				                <li><a href="category_result.jsp?category=시계">시계</a></li>
				                <li><a href="category_result.jsp?category=선글라스">선글라스</a></li>
				                <li><a href="category_result.jsp?category=남성 액세서리">남성 액세서리</a></li>
				            </ul>
				        </li>
				        
				        <!-- 여성 패션 -->
				        <li class="dropdown">
				            <a href="category_result.jsp?category=여성패션">여성 패션</a>
				            <ul class="dropdown-menu">
				                <li><a href="category_result.jsp?category=여성 의류">여성 의류</a></li>
				                <li><a href="category_result.jsp?category=여성 신발">여성 신발</a></li>
				                <li><a href="category_result.jsp?category=여성 가방">여성 가방</a></li>
				                <li><a href="category_result.jsp?category=귀걸이">귀걸이</a></li>
				                <li><a href="category_result.jsp?category=목걸이">목걸이</a></li>
				                <li><a href="category_result.jsp?category=팔찌">팔찌</a></li>
				                <li><a href="category_result.jsp?category=스카프">스카프</a></li>
				                <li><a href="category_result.jsp?category=모자">모자</a></li>
				                <li><a href="category_result.jsp?category=시계">시계</a></li>
				                <li><a href="category_result.jsp?category=여성 액세서리">여성 액세서리</a></li>
				            </ul>
				        </li>
				            <li class="dropdown">
					            <a href="category_result.jsp?category=도서/음반/DVD">도서/음반/DVD</a>
					            <ul class="dropdown-menu">
					                <li><a href="category_result.jsp?category=소설">소설</a></li>
					                <li><a href="category_result.jsp?category=교과서">교과서</a></li>
					                <li><a href="category_result.jsp?category=만화책">만화책</a></li>
					                <li><a href="category_result.jsp?category=잡지">잡지</a></li>
					                <li><a href="category_result.jsp?category=자기계발서">자기계발서</a></li>
					                <li><a href="category_result.jsp?category=학습서적">학습서적</a></li>
					                <li><a href="category_result.jsp?category=앨범(CD)">앨범(CD)</a></li>
					                <li><a href="category_result.jsp?category=DVD/블루레이">DVD/블루레이</a></li>
					                <li><a href="category_result.jsp?category=악보">악보</a></li>
					                <li><a href="category_result.jsp?category=전자책 리더기">전자책 리더기</a></li>
					            </ul>
					        </li>
					        
					        <!-- 반려동물 용품 -->
					        <li class="dropdown">
					            <a href="category_result.jsp?category=반려동물용품">반려동물 용품</a>
					            <ul class="dropdown-menu">
					                <li><a href="category_result.jsp?category=강아지용품">강아지용품</a></li>
					                <li><a href="category_result.jsp?category=고양이용품">고양이용품</a></li>
					                <li><a href="category_result.jsp?category=애완새 용품">애완새 용품</a></li>
					                <li><a href="category_result.jsp?category=수족관/어항">수족관/어항</a></li>
					                <li><a href="category_result.jsp?category=사료">사료</a></li>
					                <li><a href="category_result.jsp?category=간식">간식</a></li>
					                <li><a href="category_result.jsp?category=장난감">장난감</a></li>
					                <li><a href="category_result.jsp?category=이동장">이동장</a></li>
					                <li><a href="category_result.jsp?category=하우스/침대">하우스/침대</a></li>
					                <li><a href="category_result.jsp?category=위생용품">위생용품</a></li>
					            </ul>
					        </li>
					        
					        <!-- 생활용품 -->
					        <li class="dropdown">
					            <a href="category_result.jsp?category=생활용품">생활용품</a>
					            <ul class="dropdown-menu">
					                <li><a href="category_result.jsp?category=청소용품">청소용품</a></li>
					                <li><a href="category_result.jsp?category=주방용품">주방용품</a></li>
					                <li><a href="category_result.jsp?category=욕실용품">욕실용품</a></li>
					                <li><a href="category_result.jsp?category=수납용품">수납용품</a></li>
					                <li><a href="category_result.jsp?category=쓰레기통">쓰레기통</a></li>
					                <li><a href="category_result.jsp?category=빨래용품">빨래용품</a></li>
					                <li><a href="category_result.jsp?category=조리도구">조리도구</a></li>
					                <li><a href="category_result.jsp?category=샴푸/비누">샴푸/비누</a></li>
					                <li><a href="category_result.jsp?category=세제">세제</a></li>
					                <li><a href="category_result.jsp?category=향초">향초</a></li>
					            </ul>
					        </li>
					        
					        <!-- 취미/게임 -->
					        <li class="dropdown">
					            <a href="category_result.jsp?category=취미/게임">취미/게임</a>
					            <ul class="dropdown-menu">
					                <li><a href="category_result.jsp?category=콘솔 게임기">콘솔 게임기</a></li>
					                <li><a href="category_result.jsp?category=보드게임">보드게임</a></li>
					                <li><a href="category_result.jsp?category=퍼즐">퍼즐</a></li>
					                <li><a href="category_result.jsp?category=프라모델">프라모델</a></li>
					                <li><a href="category_result.jsp?category=악기">악기</a></li>
					                <li><a href="category_result.jsp?category=그림도구">그림도구</a></li>
					                <li><a href="category_result.jsp?category=수공예용품">수공예용품</a></li>
					                <li><a href="category_result.jsp?category=무선조종(RC) 기기">무선조종(RC) 기기</a></li>
					                <li><a href="category_result.jsp?category=레고">레고</a></li>
					                <li><a href="category_result.jsp?category=드론">드론</a></li>
					            </ul>
					        </li>
					        
					        <!-- 차량/자동차용품 -->
					        <li class="dropdown">
					            <a href="category_result.jsp?category=차량/자동차용품">차량/자동차용품</a>
					            <ul class="dropdown-menu">
					                <li><a href="category_result.jsp?category=자동차">자동차</a></li>
					                <li><a href="category_result.jsp?category=오토바이">오토바이</a></li>
					                <li><a href="category_result.jsp?category=자전거">자전거</a></li>
					                <li><a href="category_result.jsp?category=타이어">타이어</a></li>
					                <li><a href="category_result.jsp?category=차량용 액세서리">차량용 액세서리</a></li>
					                <li><a href="category_result.jsp?category=차량 정비도구">차량 정비도구</a></li>
					                <li><a href="category_result.jsp?category=내비게이션">내비게이션</a></li>
					                <li><a href="category_result.jsp?category=블랙박스">블랙박스</a></li>
					                <li><a href="category_result.jsp?category=차량용 청소기">차량용 청소기</a></li>
					                <li><a href="category_result.jsp?category=차량용 향수">차량용 향수</a></li>
					            </ul>
					        </li>                
				   </ul>
                </div>
                <li><a href="../index.jsp" data-hover="홈">홈</a></li>
                <li><a href="item.jsp" data-hover="물품 올리기">물품 올리기</a></li>
                <li><a href="wishlist.jsp" data-hover="찜">찜</a></li>
                <li><a href="trade_offer_list.jsp" data-hover="내 거래 관리">내 거래 관리</a></li>
                <li><a href="my_interface.jsp" data-hover="내 창고">내 창고</a></li>
            </ul>
        </div>
    </header>

    	<div class="main-content">
        <div class="item-info">
			<%
			    String productId = request.getParameter("product_id");
			    if (productId != null) {
			        Connection conn = null;
			        PreparedStatement pstmt = null;
			        ResultSet rs = null;
			
			        try {
			            conn = DBConnection.getConnection();
			            String query = "SELECT pd_name, pd_price, pd_image, pd_information, category, trade_method, owner, created_at, view_count " +
			                           "FROM products WHERE product_id = ?";
			            pstmt = conn.prepareStatement(query);
			            pstmt.setInt(1, Integer.parseInt(productId));
			            rs = pstmt.executeQuery();
			
			            if (rs.next()) {
			                String pdName = rs.getString("pd_name");
			                int pdPrice = rs.getInt("pd_price");
			                String pdImage = rs.getString("pd_image");
			                String pdInformation = rs.getString("pd_information");
			                String category = rs.getString("category");
			                String tradeMethod = rs.getString("trade_method");
			                String owner = rs.getString("owner");
			                Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
			                int viewCount = rs.getInt("view_count"); // 조회수 추가
			
			                // 현재 시간과 상품 등록 시간 비교
			                LocalDateTime createdAt = createdAtTimestamp.toLocalDateTime();
			                LocalDateTime now = LocalDateTime.now();
			                long secondsBetween = ChronoUnit.SECONDS.between(createdAt, now);
			                long minutesBetween = ChronoUnit.MINUTES.between(createdAt, now);
			                long hoursBetween = ChronoUnit.HOURS.between(createdAt, now);
			                long daysBetween = ChronoUnit.DAYS.between(createdAt, now);
			                long monthsBetween = ChronoUnit.MONTHS.between(createdAt, now);
			                long yearsBetween = ChronoUnit.YEARS.between(createdAt, now);
			
			                String timeAgo;
			
			                if (secondsBetween < 60) {
			                    timeAgo = secondsBetween + "초 전";
			                } else if (minutesBetween < 60) {
			                    timeAgo = minutesBetween + "분 전";
			                } else if (hoursBetween < 24) {
			                    timeAgo = hoursBetween + "시간 전";
			                } else if (daysBetween < 30) {
			                    timeAgo = daysBetween + "일 전";
			                } else if (monthsBetween < 12) {
			                    timeAgo = monthsBetween + "개월 전";
			                } else {
			                    timeAgo = yearsBetween + "년 전";
			                }
			%>
                            <!-- 상품 상세 정보 -->

			        <div class="product-header">
			            <!-- 왼쪽 이미지 영역 -->
					    <div class="photo-container">
					        <img src="<%= "../" + pdImage %>" alt="상품 이미지" class="product-image">
					    </div>
			            <!-- 세로 구분선 -->
			            <div style="width: 1px; height: 400px; background-color: #ddd; margin: 20px 0;
			            	 margin-right: 5px; margin-left: 15px;"></div>
			            <!-- 오른쪽 상품 정보 영역 -->
			            <div class="product-maininfo">
							<div class="info-top">
							    <%
							        // 'category' 값을 ','로 분리
							        String[] categoryParts = category.split(",");
							        String mainCategory = categoryParts[0]; // 대분류 카테고리
							        String subCategory = categoryParts.length > 1 ? categoryParts[1] : ""; // 소분류 카테고리 (없을 경우 빈 문자열)
							    %>
							    <!-- 대분류 카테고리 링크 -->
							    <a href="category_result.jsp?category=<%= java.net.URLEncoder.encode(mainCategory, "UTF-8") %>" class="category-link">
							        <%= mainCategory %>
							    </a>
							    <!-- 소분류 카테고리 링크 -->
							    <% if (!subCategory.isEmpty()) { %>
							        > 
							        <a href="category_result.jsp?category=<%= java.net.URLEncoder.encode(subCategory, "UTF-8") %>" class="category-link">
							            <%= subCategory %>
							        </a>
							    <% } %>
							    <div class="item-name"><%= pdName %></div>
							</div>

						<div class="info-middle">
						    <div class="trade-info">
						        <div class="trade-method-info" style="display: flex; flex-wrap: wrap;">
						            <% 
						            boolean hasSell = tradeMethod != null && tradeMethod.contains("sell");
						            boolean hasExchange = tradeMethod != null && tradeMethod.contains("exchange");
						
						            // 거래 방식에 맞는 아이콘 추가
						            if (hasSell) { 
						            %>
						                <div class="trade-icon">
						                    <img src="../images/sell-icon.svg" alt="판매 아이콘">
						                </div>
						            <% } 
						
						            if (hasExchange) { 
						            %>	
						                <div class="trade-icon">
						                    <img src="../images/trade-icon.svg" alt="교환 아이콘">
						                </div>
						            <% } 
						            %>
						        </div>
						        <div class="trade-details">

						            <div class="trade-price"><%= pdPrice %> 원</div>
						        </div>
						    </div>
						</div>




			                <div class="info-bottom">
<script>
document.addEventListener("DOMContentLoaded", function () {
    const productId = '<%= productId %>';  // JSP에서 상품 ID를 가져오기
    fetch('/asd/WishlistItemCountServlet?product_id=' + productId)  // 경로 수정
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Wishlist item count:', data.wishItemCount);

            // heart-count-item 요소 업데이트
            const heartCountElement = document.querySelector('.heart-count-item');
            if (heartCountElement) {
                heartCountElement.textContent = data.wishItemCount; // 서버로부터 받은 wishItemCount로 업데이트
            }
        })
        .catch(error => {
            console.error('Error fetching wishlist item count:', error);
        });
});

</script>

<!-- heart count 표시 -->
<div class="heart-count-icon">
    <img src="../images/fill-heart.svg" alt="찜 아이콘">
</div>
<div class="heart-count-item">0</div>  <!-- 초기값은 0으로 설정 -->




			                    <div class="divider"></div>
			                    <div class="view-count-icon"><img src="../images/fill-eye.svg"></div>
			                    <div class="view-count"><%= viewCount %></div>
			                    <div class="divider"></div>
			                    <div class="time-count-icon"><img src="../images/fill-clock.svg"></div>
			                    <div class="time-count"><%=timeAgo %></div>
			                    <a href="#" class="report-link">
			                        <div class="report-icon"><img src="../images/fill-report.svg"></div>
			                        <div class="report">신고하기</div>
			                    </a>
			                </div>
			                <div class="buttons">
<%
    boolean isInWishlist = false;

    if (username != null && productId != null) {
        try {
            Connection dbConnection = DBConnection.getConnection();
            String selectQuery = "SELECT is_in_wishlist FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement preparedStatement = dbConnection.prepareStatement(selectQuery);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, productId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                isInWishlist = resultSet.getBoolean("is_in_wishlist");
            }

            resultSet.close();
            preparedStatement.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<script>
    // 세션에서 로그인된 사용자 이름을 가져와 JavaScript 변수에 전달
    let loggedIn = '<%= session.getAttribute("username") != null ? "true" : "false" %>';
    let isInWishlistState = <%= isInWishlist ? "true" : "false" %>;
</script>

<a href="javascript:void(0);" 
   onclick="if(loggedIn === 'true'){toggleWishlist('<%= username %>', '<%= productId %>');} else {alert('로그인을 해야 이용하실 수 있습니다.');}" 
   class="heart-button-link" id="heartLink">
    <img src="<%= isInWishlist ? "../images/wishheart.svg" : "../images/heart.svg" %>" alt="찜" class="heart-button" id="heartButton">
</a>





	




	
								<div class="chat-button">
								    <a href="chat.jsp?owner=<%= owner %>">대화하기</a>
								</div>
								<%
								    // 현재 세션의 username 가져오기
								    String sessionUsername = (String) session.getAttribute("username");
								
								    // 버튼 표시 여부 확인
								    boolean isOwner = sessionUsername != null && sessionUsername.equals(owner);
								%>
								<% if (!isOwner) { %>
								    <a href="trade_offer.jsp?product_id=<%= productId %>&owner=<%= owner %>" class="trade-button">거래하기</a>
								<% } else { %>
								    <a href="#" class="trade-button" onclick="alert('본인이 등록한 상품입니다.'); return false;">거래하기</a>
								<% } %>


			                </div>
			                
			            </div>
			        </div>
			        <div class="product-subinfo">
			            <div class="infotext">
			                <div class="infotext-title"><h2>상품정보</h2></div>
			                <div class="infotext-text"><%=pdInformation %></div>
			            </div>
			            <div class="shopinfo">
			                <div class="shopinfo-title"><h2>창고정보</h2></div>
			                <div class="shopinfo-top">
			                <a href="other_interface.jsp?owner=<%= owner %>">
			                    <div class="shop-img"><img src="../images/account.svg"></div>
			                    <div class="shop-details">			                
			                        <div class="shop-name"><%=owner %>님의 창고</div> </a>  <!-- 나중에 nickname으로 바꿔야할거같음 -->
			                        <div class="shop-sum">
			                            <a href="other_interface.jsp?owner=<%= owner %>">물품<div class="user-item-count">2</div></a>
			                            <div class="divider-small"></div>
			                            <a href="#">팔로워<div class="user-follower-count">10</div></a>
			                            <div class="divider-small"></div>
			                            <a href="#">거래후기<div class="user-review-count">4</div></a>
			                        </div>
			                    </div>
			                </div>
			                <div class="clover">
			                    <div class="clover-title">클로버지수</div>
			                    <div class="clover-point">53 / 100</div>
			                </div>
			                <div class="clover-bar">
			                    <div class="progress2 progress-moved">
			                        <div class="progress-bar2"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
					<div class="simmilar">
    <div class="silmmiliar-title"><h2>비슷한 물품 추천</h2></div>
    <div class="lastest-item">
        <%
            if (productId != null && category != null) {
                PreparedStatement similarPstmt = null;
                ResultSet similarRs = null;
                try {
                    String similarQuery = "SELECT pd_name, pd_price, pd_image, product_id, trade_method FROM products " +
                                          "WHERE category = ? AND product_id != ? ORDER BY RAND() LIMIT 8";
                    similarPstmt = conn.prepareStatement(similarQuery);
                    similarPstmt.setString(1, category);
                    similarPstmt.setInt(2, Integer.parseInt(productId));
                    similarRs = similarPstmt.executeQuery();

                    while (similarRs.next()) {
                        String similarName = similarRs.getString("pd_name");
                        int similarPrice = similarRs.getInt("pd_price");
                        String similarImage = similarRs.getString("pd_image");
                        int similarId = similarRs.getInt("product_id");
          

                        String tradeIcons = ""; // 거래 아이콘 저장할 변수

                        if (tradeMethod != null) {
                            String[] methods = tradeMethod.split(","); // 거래 방식을 ','로 구분하여 배열로 분리
                            
                            // 각 거래 방식에 따라 아이콘을 추가
                            for (String method : methods) {
                                if ("exchange".equalsIgnoreCase(method.trim())) {
                                    tradeIcons += "<img src='../images/trade-icon.svg' alt='물물교환 아이콘' class='trade-icon'>";
                                } else if ("sell".equalsIgnoreCase(method.trim())) {
                                    tradeIcons += "<img src='../images/sell-icon.svg' alt='판매 아이콘' class='trade-icon'>";
                                }
                            }
                        }
        %>
                        <div class="product-container">
                            <div class="want-item">
                                <a href="item_info.jsp?product_id=<%= similarId %>">
                                    <img src="<%= "../" + similarImage %>" alt="<%= similarName %>" class="pd-image">
                                    <div class="item-details">
                                        <div class="pd-name"><%= similarName %></div>
                                        <div class="pd-price"><%= similarPrice %> 원
										<%= tradeIcons.replaceAll("<img ", "<img style='width: 20px; height: 20px;' ") %>
                                        </div>
                                    </div>
                                </a>
                                <!-- 거래 방식 아이콘 추가 -->

                            </div>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    out.println("<p>비슷한 물품을 가져오는 중 오류 발생: " + e.getMessage() + "</p>");
                } finally {
                    try { if (similarRs != null) similarRs.close(); } catch (SQLException ignored) {}
                    try { if (similarPstmt != null) similarPstmt.close(); } catch (SQLException ignored) {}
                }
            }
        %>
    </div>
</div>
<div style="flex: 0 0 auto;">
    <div class="container" id="stickyContainer">
        <button type="button" value="TOP" onclick="clickme()" style="width: 100%; height: 100%; background: white; border: none; color: #a6a6a6; font-size: 20px;">TOP</button>
    </div>
    <a href="wishlist.jsp">
    <div class="heart-container">
    	
    	    <img src="../images/heart.svg" alt="쏙">
        	<span class="heart-count">0</span> <!-- 하트 받은 개수 -->
    	

    </div>
    </a>
</div>


            <%
                        } else {
                            out.println("<p>상품 정보를 찾을 수 없습니다.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>데이터베이스 오류: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
                        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
                    }
                } else {
                    out.println("<p>상품 ID가 제공되지 않았습니다.</p>");
                }
            %>
        </div>
    </div>
<script>
function toggleWishlist(userId, productId) {
    fetch('AddToWishlistServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ user_id: userId, product_id: productId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 상태를 반전시키고 UI 업데이트
            isInWishlistState = !isInWishlistState;
            updateButtonUI();
        } else {
            alert("작업 중 오류가 발생했습니다.");
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert("서버 오류가 발생했습니다.");
    });
}

function updateButtonUI() {
    const heartButton = document.getElementById('heartButton');
    if (isInWishlistState) {
        heartButton.src = "../images/wishheart.svg";  // 찜한 상태 아이콘
    } else {
        heartButton.src = "../images/heart.svg";  // 기본 아이콘
    }
}

// 로그인 상태에 따라 버튼 비활성화
if (loggedIn === 'false') {
    document.getElementById('heartLink').style.pointerEvents = 'none';  // 클릭 비활성화
    document.getElementById('heartLink').style.opacity = '0.5';  // 비활성화된 버튼 스타일
}
</script>


    
    <script src="../js/sidebar.js"></script>
    <script src="../scripts.js"></script>
</body>
