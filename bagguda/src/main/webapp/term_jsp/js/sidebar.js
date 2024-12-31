function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');
    const isOpen = sidebar.classList.toggle('open'); // 사이드바 상태 토글

    // 오버레이 상태 업데이트
    if (isOpen) {
        overlay.classList.add('visible');
    } else {
        overlay.classList.remove('visible');
    }
}

// 버튼 클릭 시 사이드바 열기
document.querySelector('.btnLightBlue').addEventListener('click', function (e) {
    e.preventDefault(); // 기본 동작 방지
    toggleSidebar();
});

// 바깥 클릭 시 사이드바 닫기
document.addEventListener('click', function (e) {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');
    const isClickInside = sidebar.contains(e.target) || e.target.classList.contains('btnLightBlue');

    if (!isClickInside && sidebar.classList.contains('open')) {
        sidebar.classList.remove('open'); // 사이드바 닫기
        overlay.classList.remove('visible'); // 오버레이 숨기기
    }
});

document.querySelectorAll('.dropdown').forEach(dropdown => {
    dropdown.addEventListener('mouseenter', function () {
        const menu = this.querySelector('.dropdown-menu');
        if (menu) menu.style.display = 'block'; // 드롭다운 보이기
    });

    dropdown.addEventListener('mouseleave', function () {
        const menu = this.querySelector('.dropdown-menu');
        if (menu) menu.style.display = 'none'; // 드롭다운 숨기기
    });
});