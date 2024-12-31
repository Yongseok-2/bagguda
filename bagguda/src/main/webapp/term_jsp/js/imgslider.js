const slider = document.querySelector('.slider');
const slides = document.querySelectorAll('.slide');
const dots = document.querySelectorAll('.dot');
let currentIndex = 0;

function updateSlider() {
    // 슬라이더 이동
    slider.style.transform = `translateX(-${currentIndex * 100}%)`;
    
    // 인디케이터 활성화 상태 업데이트
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentIndex);
    });
}

function moveToNextSlide() {
    currentIndex = (currentIndex + 1) % slides.length;
    updateSlider();
}

// 인디케이터 클릭 이벤트
dots.forEach((dot, index) => {
    dot.addEventListener('click', () => {
        currentIndex = index;
        updateSlider();
    });
});

// 슬라이드 이동 간격 설정 (3초)
setInterval(moveToNextSlide, 3000);
