<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>받은 제안</title>
    <link rel="stylesheet" href="../css/trade-offer-list.css">
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/font.css">
    <script src="../js/jquery-3.7.1.min.js"></script>
</head>
<body style="overflow-x: hidden">
    <!-- 헤더 -->
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
			    	username = (String) session.getAttribute("username");
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

    <!-- 메인 컨텐츠 -->
<main>
<div class="con">
<div id="tab-menu">
    <div id="tab-btn">
        <ul>
            <li class="active"><a href="#">내 상품</a></li>
            <li><a href="#">판매완료</a></li>
            <li><a href="#">내가 보낸 제안</a></li>
        </ul>
    </div>
    <div id="tab-cont">
    
        <div class="lastest-item">
							<%

    // SQL 쿼리 작성
    String query =  "SELECT " +
            "    p1.product_id, " +
            "    p1.pd_name, " +
            "    p1.pd_price, " +
            "    p1.pd_image, " +
            "    p1.trade_method, " +
            "    t.offer_id, " +
            "    t.details, " +
            "    t.sender_username, " +
            "    p2.product_id AS offered_pd_id, " +
            "    p2.pd_name AS offered_pd_name, " +
            "    p2.pd_price AS offered_pd_price, " +
            "    p2.pd_image AS offered_pd_image " +
            "FROM " +
            "    products p1 " +
            "LEFT JOIN " +
            "    trade_offers t ON p1.product_id = t.product_id " +
            "LEFT JOIN " +
            "    products p2 ON t.from_product_id = p2.product_id " +
            "WHERE " +
            "    p1.owner = ? " +
            "    AND p1.sold = 0";


    // 데이터베이스 연결 및 쿼리 실행
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {

        // 파라미터 설정
        stmt.setString(1, username);

        // 결과 처리
        try (ResultSet rs = stmt.executeQuery()) {
            boolean hasResults = false;

            while (rs.next()) {
                hasResults = true;

                // products 테이블의 정보
                int productId = rs.getInt("product_id");
                String pdName = rs.getString("pd_name");
                int pdPrice = rs.getInt("pd_price");
                String pdImage = rs.getString("pd_image");
                String tradeMethod = rs.getString("trade_method");
                String tradeIcons = "";

                // trade_offers 테이블의 정보
                int offerId = rs.getInt("offer_id");
                String details = rs.getString("details");
                String senderUsername = rs.getString("sender_username");

                // 제안된 상품 정보
                int offeredproductId = rs.getInt("offered_pd_id");
                String offeredPdName = rs.getString("offered_pd_name");
                int offeredPdPrice = rs.getInt("offered_pd_price");
                String offeredPdImage = rs.getString("offered_pd_image");
               
                
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
										
							                <div class="product-container">
							                    <div class="want-item">
							                        <a href="../html/item_info.jsp?product_id=<%=productId %>">
							                            <img src="<%= "../" + pdImage %>" alt="상품 이미지" class="pd-image">
							                            <h5 class="pd-name"><%= pdName %></h5>
							                            <p class="pd-price">
							                                <%= pdPrice %>원
							                                <%= tradeIcons.replaceAll("<img ", "<img style='width: 20px; height: 20px; margin-left:3px;'  ") %>
							                            </p>
							                        </a>
							                    </div>
							                
							                <%
							                
							                                if (offeredPdName == null || offeredPdImage == null) {
                	%>
                	
                	                    <div class="message">받은 제안이 없습니다.</div>
                	                    </div>
                	                    
                	<%
                	                    continue; // 다음 레코드로 이동
                	                }
							                %>
							                
							                
                
							                
							                <div class="offer-container">
							                <div class="offer-product-container">
							                    <div class="product-image">
							                        <img src="<%= "../" + offeredPdImage %>" alt="상품 이미지" class="product-img">
							                    </div>
							                    <div class="product-info">
							                        <h2><%= offeredPdName %></h2>
							                        <span class="price"><%= offeredPdPrice %>원</span>
							                        <p><span>설명:</span> <%= details %></p>
							                        <div><span>창고명:</span> <%= senderUsername %></div>
							                    </div>
							                    <div class="product-actions">
							                            <form action="accept_trade.jsp" method="POST" style="display: inline;">
							                                <input type="hidden" name="offer_id" value="<%= offerId %>">
							                                <input type="hidden" name="product_id" value="<%= productId %>">
							                                <input type="hidden" name="offered_product_id" value="<%= offeredproductId %>">
							                                <button class="action-btn accept">수락하기</button>
							                            </form>
							                            <form action="delete_trade.jsp" method="POST" style="display: inline;">
							                                <input type="hidden" name="offer_id" value="<%= offerId %>">
							                                <button class="action-btn delete">거절하기</button>
							                            </form>
							                            <a href="chat.jsp?user=<%= senderUsername %>" class="action-btn chat">대화하기</a>
							                        </div>
							                </div>
							                </div>
							                </div>
							        <%
							            }
							            if (!hasResults) {
							                out.println("<p>등록된 물품이 없습니다.</p>");
							            }
							        }
							    } catch (SQLException e) {
							        out.println("<p>상품 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
							    }
							%>

					    
					       
					       </div>

							<div class="lastest-item">
							<div class="sold-product-container">
							<%
							    try (Connection conn = DBConnection.getConnection();
							         PreparedStatement pstmt = conn.prepareStatement(
							        		 "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
										             "FROM products WHERE owner = ?" + " AND sold = 1")) { // owner 조건만 포함
							
							        pstmt.setString(1, username); // 현재 로그인 사용자 설정
							
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
					    
					    <div class="lastest-item">
							<%

  

							String query1 = "SELECT " +
									   "    p.product_id, "  +
						               "    p.pd_image, " +
						               "    p.pd_name, " +
						               "    p.pd_price, " +
						               "    p.trade_method, " +
						               "    t.details, " +
						               "    t.sender_username, " +
						               "    t.offer_id " +
						               "FROM " +
						               "    trade_offers t " +
						               "JOIN " +
						               "    products p ON t.product_id = p.product_id " +
						               "WHERE " +
						               "    t.sender_username = ?";
    // 데이터베이스 연결 및 쿼리 실행
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query1)) {
        // 파라미터 설정
        stmt.setString(1, username);

        // 결과 처리
        try (ResultSet rs = stmt.executeQuery()) {
            boolean hasResults = false;

            while (rs.next()) {
                hasResults = true;

                // products 테이블의 정보
                int productId = rs.getInt("p.product_id");
                String pdName = rs.getString("p.pd_name");
                int pdPrice = rs.getInt("p.pd_price");
                String pdImage = rs.getString("p.pd_image");
                String tradeMethod = rs.getString("p.trade_method");
                String tradeIcons = "";

                // trade_offers 테이블의 정보
                int offerId = rs.getInt("t.offer_id");
                String details = rs.getString("t.details");
                String senderUsername = rs.getString("t.sender_username");

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
 
							                <div class="offer-container">
							                <div class="offer-product-container">
							                    <div class="product-image">
							                        <img src="<%= "../" + pdImage %>" alt="상품 이미지" class="product-img">
							                    </div>
							                    <div class="product-info">
							                        <h2><%= pdName %></h2>
							                        <span class="price"><%= pdPrice %>원</span>
							                        <p><span>설명:</span> <%= details %></p>
							                        <div><span>창고명:</span> <%= senderUsername %></div>
							                    </div>
							                    <div class="product-actions">
							                            <form action="delete_trade.jsp" method="POST" style="display: inline;">
							                                <input type="hidden" name="offer_id" value="<%= offerId %>">
							                                <button class="action-btn delete">취소하기</button>
							                            </form>
							                        </div>
							                </div>
							                </div>
							                </div>
							        <%
							            }
							            if (!hasResults) {
							                out.println("<p>보낸 제안이 없습니다.</p>");
							            }
							        }
							    } catch (SQLException e) {
							        out.println("<p>상품 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
							    }
							%>

					    
					       
					       </div>
					    </div>
</main>

    <script src="../js/sidebar.js"></script>
    <script src="../js/trade-offer-list.js"></script>
</body>
</html>
