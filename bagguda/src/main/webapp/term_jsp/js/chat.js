// 채팅창 스크롤 위치 저장
function saveScrollPosition() {
  const chatBox = document.getElementById("chatMessages");
  if (chatBox) {
    sessionStorage.setItem('scrollPosition', chatBox.scrollTop);
  }
}

// 채팅창 스크롤 위치 복원
function restoreScrollPosition() {
  const chatBox = document.getElementById("chatMessages");
  if (chatBox) {
    const savedPosition = sessionStorage.getItem('scrollPosition');
    if (savedPosition) {
      chatBox.scrollTop = parseInt(savedPosition, 10);
    }
  }
}

// DOM 요소가 로드될 때 이벤트 연결
document.addEventListener('DOMContentLoaded', () => {
  const chatBox = document.getElementById("chatMessages");
  
  if (chatBox) {
    // 스크롤 이동 시 저장
    chatBox.addEventListener('scroll', saveScrollPosition);

    // 스크롤 상태 복원
    restoreScrollPosition();
  }
});
