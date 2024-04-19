<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록 | 페어리 타운</title>
<!-- Favicon -->
<link href="../resources/dist/img/close.png" rel="shortcut icon"
    type="image/x-icon">
<!-- jQuery -->
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Bootstrap CSS 파일 링크 추가 -->
<link
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    rel="stylesheet"> 
<!-- Font Awesome 아이콘 라이브러리 -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Swiper CSS -->
<link rel="stylesheet"
    href="https://unpkg.com/swiper/swiper-bundle.min.css">
<style>
#container .mb-3 {
    width: 50%; /* 제목과 첨부파일 입력창의 너비를 설정 */
    margin: 0 auto; /* 가운데 정렬 */
    text-align: left; /* 제목과 첨부파일을 왼쪽 정렬 */
    margin-left: auto;
    margin-right: auto;
    max-width: 800px; /* 적절한 최대 너비 설정 */
}

/* Swiper 컨테이너 스타일 */
.swiper-container {
    width: 50%;
    height: 100%;
}

/* Swiper 슬라이드 스타일 */
.swiper-slide {
    text-align: center;
    font-size: 18px;
    background: #fff;
    /* Center slide text vertically */
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 본문 입력 영역 스타일 */
#review-write-content {
    width: 50%;
    margin-left: auto;
    margin-right: auto;
    max-width: 800px;
}
</style>
</head>
<body>
    <!-- 공통 / 헤더 -->
    <jsp:include page="../inc/header.jsp"></jsp:include>

    <div class="container">
        <div id="review-write">
            <h1>
                <b>리뷰 등록</b>
            </h1>
            <br>
            <br>
            <br>

            <div class="row">
                <!-- Swiper 영역 -->
                <div class="col-md-6">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <!-- 슬라이드 추가 -->
                            <div class="swiper-slide">Slide 1</div>
                            <div class="swiper-slide">Slide 2</div>
                            <div class="swiper-slide">Slide 3</div>
                        </div>
                        <!-- 추가적인 Swiper 컨트롤러 등을 넣을 수 있음 -->
                        <div class="swiper-pagination"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                    </div>
                </div>
                <!-- 본문 입력 영역 -->
                <div class="col-md-6" id="review-write-content">
                    <form action="/review/insert.ft" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <div class="row g-2 align-items-center">
                                <div class="col-auto">
                                    <select class="form-select" name="ticketType" id="ticketType">
                                        <c:forEach items="${ticketTypes}" var="type">
                                            <option value="${type}">${type}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" name="reviewTitle" placeholder="제목을 입력하세요">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="exampleFormControlTextarea1" class="form-label"></label>
                            <textarea class="form-control" name="reviewContent" id="reviewContent" rows="6"></textarea>
                        </div>
                        <div class="d-flex justify-content-center">
                            <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
	
<script>


document.addEventListener("DOMContentLoaded", function () {
    var swiper = new Swiper('.swiper-container', {
        // Swiper 옵션 설정
        loop: true, // 무한 루프
        slidesPerView: 1, // 한 번에 보여지는 슬라이드 수
        spaceBetween: 30, // 슬라이드 간의 간격

        // 페이징 버튼 설정
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },

        // 네비게이션 버튼 설정
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    // 서버에서 이미지 URL을 가져와 슬라이드에 추가하는 함수
    function fetchImages() {
        fetch('/api/images')
            .then(response => response.json())
            .then(images => {
                images.forEach(imageUrl => {
                    swiper.appendSlide('<div class="swiper-slide"><img src="' + imageUrl + '"></div>');
                });
            })
            .catch(error => console.error('Error fetching images:', error));
    }

    // 페이지 로드 시 이미지 로드
    fetchImages();
});

/* $(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "/api/getSlides", // 이미지 데이터를 반환하는 API 엔드포인트
        success: function(data) {
            data.forEach(function(slide) {
                $(".swiper-wrapper").append('<div class="swiper-slide">' + slide + '</div>');
            });

            // 슬라이드를 포함한 후에 Swiper를 초기화합니다.
            var swiper = new Swiper('.swiper-container', {
                // Swiper 설정
                pagination: {
                    el: '.swiper-pagination',
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
            });
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
}); */
</script>
	

    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <!-- 슬라이드를 생성하고 설정하는 스크립트 -->
<!--     <script src="/js/script.js"></script>
 -->	<!-- 공통 / 풋터 -->
</body>
</html>