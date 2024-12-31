document.addEventListener("DOMContentLoaded", () => {
    const photoInput = document.getElementById("photo-input");
    const photoPreview = document.getElementById("photo-preview");
    const customUploadBox = document.getElementById("custom-upload-box");

    // 사진 추가 버튼 클릭 시 파일 선택 창 열기
    customUploadBox.addEventListener("click", () => {
        photoInput.click();
    });

    // 파일 선택 시 미리보기 생성
    photoInput.addEventListener("change", (event) => {
        const file = event.target.files[0];

        if (file) {
            if (!file.type.startsWith("image/")) {
                alert("이미지 파일만 업로드 가능합니다.");
                photoInput.value = ""; // 입력 필드 초기화
                return;
            }

            const reader = new FileReader();

            reader.onload = function (e) {
                // 기존 미리보기 영역 제거
                photoPreview.innerHTML = "";

                // 미리보기 이미지 컨테이너 생성
                const imgContainer = document.createElement("div");
                imgContainer.classList.add("img-preview");

                // 이미지 엘리먼트 생성
                const img = document.createElement("img");
                img.src = e.target.result;

                // 삭제 버튼 생성
                const deleteBtn = document.createElement("button");
                deleteBtn.textContent = "×";
                deleteBtn.classList.add("remove-btn");

                // 삭제 버튼 클릭 시 미리보기 삭제
                deleteBtn.addEventListener("click", () => {
                    photoPreview.innerHTML = "";
                    photoInput.value = "";
                });

                // 미리보기 컨테이너에 이미지와 삭제 버튼 추가
                imgContainer.appendChild(img);
                imgContainer.appendChild(deleteBtn);

                // 미리보기 영역에 추가
                photoPreview.appendChild(imgContainer);
            };

            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        }
    });
});



// 상위 카테고리에 따른 하위 카테고리 데이터
const subCategories = {
    전자기기: ["스마트폰", "태블릿", "노트북", "데스크탑", "스마트워치", "이어폰/헤드폰", "카메라", "게임기", "드론", "액세서리"],
    가전제품: ["냉장고", "세탁기", "에어컨", "TV", "전자레인지", "청소기", "공기청정기", "정수기", "믹서기", "주방가전"],
    가구_인테리어: ["소파", "책상", "의자", "침대", "옷장", "선반", "커튼", "조명", "카펫", "액자"],
    남성_패션: ["남성 의류", "남성 신발", "남성 가방", "넥타이", "벨트", "지갑", "모자", "시계", "선글라스", "남성 액세서리"],
    여성_패션: ["여성 의류", "여성 신발", "여성 가방", "귀걸이", "목걸이", "팔찌", "스카프", "모자", "시계", "여성 액세서리"],
    도서_음반_DVD: ["소설", "교과서", "만화책", "잡지", "자기계발서", "학습서적", "앨범(CD)", "DVD/블루레이", "악보", "전자책 리더기"],
    반려동물_용품: ["강아지용품", "고양이용품", "애완새 용품", "수족관/어항", "사료", "간식", "장난감", "이동장", "하우스/침대", "위생용품"],
    생활용품: ["청소용품", "주방용품", "욕실용품", "수납용품", "쓰레기통", "빨래용품", "조리도구", "샴푸/비누", "세제", "향초"],
    취미_게임: ["콘솔 게임기", "보드게임", "퍼즐", "프라모델", "악기", "그림도구", "수공예용품", "무선조종(RC) 기기", "레고", "드론"],
    차량_자동차용품: ["자동차", "오토바이", "자전거", "타이어", "차량용 액세서리", "차량 정비도구", "내비게이션", "블랙박스", "차량용 청소기", "차량용 향수"]
};



// 거래 희망 지역에 따른 하위 지역 데이터
const subLocations = {
    서울: ["강남구", "종로구", "강서구", "송파구", "중구"],
    경기: ["수원시", "성남시", "용인시", "고양시", "안산시"],
    인천: ["미추홀구", "부평구", "남동구", "서구", "연수구"],
    부산: ["해운대구", "부산진구", "동래구", "영도구", "사하구"],
    대구: ["중구", "동구", "북구", "달서구", "수성구"],
    광주: ["동구", "서구", "남구", "북구", "광산구"],
    대전: ["동구", "서구", "유성구", "중구", "대덕구"],
    울산: ["남구", "중구", "북구", "동구", "울주군"],
    강원: ["춘천시", "원주시", "강릉시", "속초시", "동해시"],
    충북: ["청주시", "충주시", "제천시", "음성군", "진천군"],
    충남: ["천안시", "공주시", "보령시", "아산시", "서산시"],
    전북: ["전주시", "익산시", "군산시", "남원시", "정읍시"],
    전남: ["여수시", "순천시", "광양시", "목포시", "나주시"],
    경북: ["포항시", "경주시", "구미시", "안동시", "영주시"],
    경남: ["창원시", "김해시", "진주시", "양산시", "거제시"],
    제주: ["제주시", "서귀포시"]
};


// 상위 선택 시 하위 옵션 업데이트 (공통 함수)
function updateOptions(container, data) {
    const mainSelect = container.querySelector("select:first-of-type");
    const subSelect = container.querySelector("select:last-of-type");

    // 선택된 상위 카테고리 값 가져오기
    const selectedValue = mainSelect.value;

    // 기존 하위 옵션 초기화
    subSelect.innerHTML = "<option value='' disabled selected>선택</option>";

    // 선택된 상위 값에 따른 하위 옵션 추가
    if (data[selectedValue]) {
        data[selectedValue].forEach(optionValue => {
            const option = document.createElement("option");
            option.value = optionValue;
            option.textContent = optionValue;
            subSelect.appendChild(option);
        });
        subSelect.disabled = false; // 활성화
    } else {
        subSelect.disabled = true; // 비활성화
    }
}

// 이벤트 리스너 등록
document.addEventListener("DOMContentLoaded", () => {
    // 아이템 카테고리 컨테이너 처리
    const categoryContainers = document.querySelectorAll(".item-cartegory-container");
    categoryContainers.forEach(container => {
        const mainSelect = container.querySelector("select:first-of-type");
        mainSelect.addEventListener("change", () => updateOptions(container, subCategories));
    });

    // 거래 희망 지역 컨테이너 처리
    const locationContainers = document.querySelectorAll(".location-select-container");
    locationContainers.forEach(container => {
        const mainSelect = container.querySelector("select:first-of-type");
        mainSelect.addEventListener("change", () => updateOptions(container, subLocations));
    });
});
