


$(document).ready(function() {
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
});

/*

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

*/

