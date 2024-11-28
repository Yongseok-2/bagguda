const photoInput = document.getElementById("photo-input");
const customUploadBox = document.getElementById("custom-upload-box");
const photoPreview = document.getElementById("photo-preview");
const imageCountText = document.getElementById("image-count");

// 이미지 등록 버튼 클릭 시 파일 선택창 열기
customUploadBox.addEventListener("click", () => {
    photoInput.click();
});

// 파일 선택 시 처리
photoInput.addEventListener("change", () => {
    const files = Array.from(photoInput.files);
    photoPreview.innerHTML = ""; // 기존 사진 초기화

    if (files.length > 10) {
        alert("최대 10개의 사진만 업로드할 수 있습니다.");
        photoInput.value = ""; // 선택 초기화
        imageCountText.textContent = "물품 이미지(0/10)";
        return;
    }

    // 사진 미리보기 생성
    files.forEach((file) => {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.alt = "Uploaded photo";
            photoPreview.appendChild(img);
        };
        reader.readAsDataURL(file);
    });

    // 물품 이미지 개수 업데이트
    imageCountText.textContent = `물품 이미지(${files.length}/10)`;
});
 