var tabBtn = $("#tab-btn > ul > li");     // 각각의 버튼을 변수에 저장
var tabCont = $("#tab-cont > div");       // 각각의 콘텐츠를 변수에 저장

// 컨텐츠 내용을 숨기고, 첫 번째 콘텐츠만 표시
tabCont.hide().eq(0).css("display", "flex");

tabBtn.click(function () {
  var target = $(this);         // 클릭된 버튼을 변수에 저장
  var index = target.index();   // 클릭된 버튼의 인덱스를 변수에 저장
  
  // 버튼 활성화 상태 변경
  tabBtn.removeClass("active");
  target.addClass("active");

  // 모든 콘텐츠 숨기기
  tabCont.hide();

  // 선택된 콘텐츠를 flex로 표시
  tabCont.eq(index).css({
    display: "flex",          // 가로 정렬
    "flex-wrap": "wrap",      // 줄 바꿈 허용
    gap: "20px",              // 아이템 간 간격 설정 (선택 사항)
  });
});
