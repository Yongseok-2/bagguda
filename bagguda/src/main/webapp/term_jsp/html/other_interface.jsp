<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> 

<%
    // URL에서 owner 값 가져오기
    String owner = request.getParameter("owner");

    if (owner == null) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='../index.jsp';</script>");
        return;
    }

    // 데이터베이스에서 해당 owner에 대한 정보를 가져오는 쿼리
    String query = "SELECT market_name, description, user_image FROM users WHERE id = ?";
    String marketName = "알 수 없음"; // 기본값
    String description = ""; // 기본값
    String userImage = ""; // 기본값

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setString(1, owner); // owner 값 설정
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                marketName = rs.getString("market_name");
                description = rs.getString("description");
                userImage = rs.getString("user_image");
            }
        }
    } catch (SQLException e) {
        out.println("<p>사용자 정보를 가져오는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
    }
%>

<%
	int itemCount = 0; // 상품 개수 기본값
	
	try (Connection conn = DBConnection.getConnection();
	     PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM products WHERE owner = ?")) {
	
	    countStmt.setString(1, owner); // 현재 사용자 ID 설정
	    try (ResultSet rs = countStmt.executeQuery()) {
	        if (rs.next()) {
	            itemCount = rs.getInt(1); // 첫 번째 컬럼에서 상품 개수 가져오기
	        }
	    }
	} catch (SQLException e) {
	    out.println("<p>상품 개수를 가져오는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= marketName %>의 창고</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/interface.css">
    <script src="../js/jquery-3.7.1.min.js"></script>
</head>
<body style="overflow-x: hidden">
    <!-- 상단 -->
    <header class="header">
        <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
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
                <li><a href="#" data-hover="찜">찜</a></li>
                <li><a href="trade-offer-list.jsp" data-hover="내 거래 관리">내 거래 관리</a></li>
                <li><a href="my_interface.jsp" data-hover="내 창고">내 창고</a></li>
            </ul>
        </div>
    </header>

    <main class="interface-main">
        <div class="interface-container">
            <div class="photo-container">
                <div class="empty-image">
                    <img src="<%= userImage != null ? "../" + userImage : "../images/default_image.jpg" %>" alt="<%= marketName %>" class="empty-image">
                </div>
                <div class="buttons">
                    <a href="#" class="chat-button">대화하기</a>
                </div>
            </div>
            <div class="interface-info-container">
                <div class="shop-name">
                    <h2 id="market-name-img"><%= marketName %></h2>
                    <label><input type="checkbox" /></label>
                </div>
                <textarea class="text-box" placeholder="<%= description != null ? description.replaceAll("\"", "&quot;") : "" %>"></textarea>
            </div>
            <div class="interface-second-container">
                <div class="shop-sum">
                    <div class="user-item">
					    <div class="user-item-count">물품</div>
					    <div class="num-link"><%= itemCount %></div> <!-- 상품 개수를 동적으로 표시 -->
					</div>

                    <div style="width: 1px; height: 65px; background-color: #ddd;"></div>
                    <div class="user-follower"><div class="user-follower-count">팔로워</div><div class="num">0</div></div>
                    <div style="width: 1px; height: 65px; background-color: #ddd;"></div>
                    <a href="#"><div class="user-review"><div class="user-review-count">거래후기</div><div class="review-num">0</div></div></a>
                </div>
                <div class="clover">
                    <div class="clover-title">클로버지수</div>
                    <div class="clover-point">53  /  100</div>
                </div>
                <div class="clover-bar">
                    <div class="progress2 progress-moved">
                      <div class="progress-bar2">
                      </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="user-product-container">
            <div id="tab-menu">
                <div id="tab-btn">
                    <ul>
                        <li class="active"><a href="#">전체상품</a></li>
                        <li><a href="#">판매완료</a></li>
                    </ul>    
                </div>
                <div id="tab-cont">
                    <div class="tab-item">
					    <%
					        try (Connection conn = DBConnection.getConnection();
					             PreparedStatement pstmt = conn.prepareStatement(
					                 "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
					                 "FROM products WHERE owner = ?" + " AND sold = 0")) { // owner 조건만 포함
					
					            pstmt.setString(1, owner); // owner 값 설정
					
					            try (ResultSet rs = pstmt.executeQuery()) {
					                boolean hasResults = false; // 결과 유무 확인
					
					                while (rs.next()) {
					                    hasResults = true; // 결과가 있으면 true로 설정
					
					                    String tradeMethod = rs.getString("trade_method"); // trade_method 값을 가져옴
					                    String tradeIcons = "";
					
					                    // trade_method가 ','로 구분된 값을 포함할 수 있기 때문에 이를 처리
					                    if (tradeMethod != null) {
					                        String[] methods = tradeMethod.split(","); // 콤마로 구분된 값을 배열로 분리
					
					                        // 'exchange'와 'sell' 값을 확인해서 각각 아이콘을 지정
					                        for (String method : methods) {
					                            if ("exchange".equalsIgnoreCase(method.trim())) {
					                                tradeIcons += "<img src='../images/trade-icon.svg' alt='물물교환 아이콘'> ";
					                            }
					                            if ("sell".equalsIgnoreCase(method.trim())) {
					                                tradeIcons += "<img src='../images/sell-icon.svg' alt='판매 아이콘'> ";
					                            }
					                        }
					                    }
					    %>
			                    <div class="product-container">
				                    <div class="want-item">
				                        <a href="html/item_info.jsp?product_id=<%= rs.getString("product_id") %>">
				                            <img src="<%= "../"+rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
				                            <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
				                            <p class="pd-price">
				                                <%= rs.getInt("pd_price") %> 원
				                                <%= tradeIcons.replaceAll("<img ", "<img style='width: 20px; height: 20px;' ") %>
				                            </p>
				                        </a>
				                    </div>
				                </div>
					    <%
					                }
					                if (!hasResults) {
					    %>
					                    <p>등록된 상품이 없습니다.</p>
					    <%
					                }
					            }
					        } catch (SQLException e) {
					            out.println("<p>상품 정보를 가져오는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
					        }
					    %>
					</div>
					<div class="tab-item">
							<div class="sold-product-container">
							<%
							    try (Connection conn = DBConnection.getConnection();
							         PreparedStatement pstmt = conn.prepareStatement(
							        		 "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
										             "FROM products WHERE owner = ?" + " AND sold = 1")) { // owner 조건만 포함
							
							        pstmt.setString(1, owner); // 현재 로그인 사용자 설정
							
							        try (ResultSet rs = pstmt.executeQuery()) {
							            boolean hasResults = false; // 결과 유무 확인
							
							            while (rs.next()) {
							                hasResults = true; // 결과가 있으면 true로 설정
							
							                String tradeMethod = rs.getString("trade_method"); // trade_method 값을 가져옴
							                String tradeIcons = "";
							
							                // trade_method가 ','로 구분된 값을 포함할 수 있기 때문에 이를 처리
							                if (tradeMethod != null) {
							                    String[] methods = tradeMethod.split(","); // 콤마로 구분된 값을 배열로 분리
							
							                    // 'exchange'와 'sell' 값을 확인해서 각각 아이콘을 지정
							                    for (String method : methods) {
							                        if ("exchange".equalsIgnoreCase(method.trim())) {
							                            tradeIcons += "<img src='../images/trade-icon.svg' alt='물물교환 아이콘' class='trade-icon'>"; // 교환 아이콘
							                        } else if ("sell".equalsIgnoreCase(method.trim())) {
							                            tradeIcons += "<img src='../images/sell-icon.svg' alt='판매 아이콘' class='trade-icon'>"; // 판매 아이콘
							                        }
							                    }
							                }
							        %>
							                
							                    <div class="want-item">
							                        <a href="../html/item_info.jsp?product_id=<%= rs.getInt("product_id") %>">
							                        <div class="image-container">
							                            <img src="<%= "../" + rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
													   	 <div class="text">판매완료</div>
													</div>
							                            <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
							                            <p class="pd-price">
							                                <%= rs.getInt("pd_price") %>원
							                                <%= tradeIcons.replaceAll("<img ", "<img style='width: 20px; height: 20px; margin-left:3px;'  ") %>
							                            </p>
							                        </a>
							                    </div>
							                
							        <%
							            }
							            if (!hasResults) {
							                out.println("<p>판매된 물품이 없습니다.</p>");
							            }
							        }
							    } catch (SQLException e) {
							        out.println("<p>상품 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
							    }
							%>
							</div>

					    </div>

                </div>
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
    </main>
    <script src="../js/sidebar.js"></script>
    <script src="../scripts.js"></script>
    <script src="../js/interface.js"></script>
</body>
</html>
