<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.IOException" %>

<%
    String username = (String) session.getAttribute("username");


	if (username == null) {
	    // 로그인이 안된 경우 경고 문구와 리다이렉트 설정
	    out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
	    return; // 이후 코드 실행 방지
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/item.css">
    <link rel="stylesheet" href="../css/font.css">
</head>
<body style="overflow-x: hidden">

    <!-- 상단 -->
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

<main>
    <div class="item-interface-container">
        <h2>물품 정보</h2>

        <form action="item_process.jsp" method="POST" enctype="multipart/form-data">
            <!-- 물품 이미지 업로드 -->
            <div class="item-img">
                <span id="image-count">물품 이미지</span>
                <div class="photo-upload-container">
                    <div class="upload-box" id="custom-upload-box"><img src="../images/add-photo.svg" alt="이미지등록">이미지 등록</div>
                    <input type="file" id="photo-input" name="pd_image" accept="image/*" multiple hidden>
                </div>
                <div id="photo-preview"></div>
            </div>

            <!-- 물품명 -->
            <div class="item-input-container">
                <span id="image-count">물품명</span>
                <input type="text" placeholder="물품명을 입력해주세요" class="item-input" name="pd_name" required>
            </div>

            <!-- 가격 -->
			<div class="item-input-container">
			    <span id="image-count">가격</span>
			    <input type="text" placeholder="가격을 입력해주세요" class="item-input" name="pd_price" 
			        id="priceInput"oninput="validatePrice()"required>
			</div>

            <!-- 설명 -->
            <div id="details">
                <span id="image-count">물품 설명</span>
                <textarea id="item_details" name="pd_information" rows="4" cols="50" placeholder="물품에 대한 자세한 설명을 적어주세요."></textarea>
            </div>

            <!-- 카테고리 및 상태 선택 -->
			<div class="item-cartegory-container">
			    <span id="image-count">카테고리</span>
			    
			    <!-- 첫 번째 상위 카테고리 선택 -->
			    <select class="item-cartegory" name="category[]">
			        <option value="" disabled selected>선택</option>
			        <option value="전자기기">전자기기</option>
			        <option value="가전제품">가전제품</option>
			        <option value="가구_인테리어">가구/인테리어</option>
			        <option value="남성_패션">남성 패션</option>
			        <option value="여성_패션">여성 패션</option>
			        <option value="도서_음반_DVD">도서/음반/DVD</option>
			        <option value="반려동물_용품">반려동물 용품</option>
			        <option value="생활용품">생활용품</option>
			        <option value="취미_게임">취미/게임</option>
			        <option value="차량_자동차용품">차량/자동차용품</option>
			    </select>
			
			    <span class="separator"> > </span> <!-- 선택들 사이에 > 기호 추가 -->
			
			    <!-- 두 번째 하위 카테고리 선택 -->
			    <select class="item-cartegory" name="category[]" disabled>
			        <option value="" disabled selected>선택</option>
			    </select>
			</div>



            <!-- 거래 방식 -->
            <div class="item-trade-container">
                <span id="image-count">거래방식</span>
                <div class="trade-title-container">
                    <div class="trade-system">
					    <div class="trade-system-checkbox">
					        <div class="meet">
					            <input type="checkbox" id="meet-checkbox" name="trade_system[]" value="meet"> 직거래
					        </div>
					        <div class="post">
					            <input type="checkbox" id="post-checkbox" name="trade_system[]" value="post"> 택배
					        </div>
					    </div>
					</div>
				<div class="trade-method">
				    <div class="exchange">
				        <div class="trade-box">
				            <label id="trade-icon">
				                <input type="checkbox" id="trade-checkbox" name="trade_method[]" value="exchange"> 
				                <img src="../images/trade-icon.svg" alt="물물교환 아이콘" id="trade-icon">
				                물물교환
				            </label>
				        </div>
				    </div>
				    <div class="sell">
				        <div class="sell-box">
				            <label id="sell-icon">
				                <input type="checkbox" id="sell-checkbox" name="trade_method[]" value="sell">
				                <img src="../images/sell-icon.svg" alt="판매 아이콘" id="sell-icon">
				                판매
				            </label>
				        </div>
				    </div>
				</div>

                </div>
            </div>

            <!-- 물품 상태 -->
            <div class="item-condition">
                <span id="image-count">물품 상태</span>
                <fieldset>
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="pd_status" value="new_item" required>
                            <span>새 물품(미사용)</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="no_usage">
                            <span>사용감 없음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="light_usage">
                            <span>사용감 적음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="heavy_usage">
                            <span>사용감 많음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="broken">
                            <span>고장/파손 물품</span>
                        </label>
                    </div>
                </fieldset>
            </div>

            <!-- 거래 희망 지역 -->

			<div class="location-select-container">
			    <span id="image-count">거래 희망 지역</span>
			    <select class="location-select" id="main-location" name="location_1" onchange="updateSubLocations()">
			        <option value="" disabled selected>선택</option>
					    <option value="서울">서울</option>
					    <option value="경기">경기</option>
					    <option value="인천">인천</option>
					    <option value="부산">부산</option>
					    <option value="대구">대구</option>
					    <option value="광주">광주</option>
					    <option value="대전">대전</option>
					    <option value="울산">울산</option>
					    <option value="강원">강원</option>
					    <option value="충북">충북</option>
					    <option value="충남">충남</option>
					    <option value="전북">전북</option>
					    <option value="전남">전남</option>
					    <option value="경북">경북</option>
					    <option value="경남">경남</option>
					    <option value="제주">제주</option>
			    </select>
			    <span class="separator"> > </span>
			    <select class="location-select" id="sub-location" name="location_2" disabled>
			        <option value="" disabled selected>선택</option>
			    </select>
			</div>

            <!-- 제출 버튼 -->
            <div id="upload-container">
                <button id="upload-button" type="submit">상품 등록</button>
            </div>
        </form>
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
<script>
    function validatePrice() {
        const input = document.getElementById('priceInput');
        // 숫자만 허용하도록 정규표현식 적용
        input.value = input.value.replace(/[^0-9]/g, '');
    }
</script>
    <script src="../scripts.js"></script>
    <script src="../js/itemscripts.js"></script>
    <script src="../js/sidebar.js"></script>
</body>
</html>
