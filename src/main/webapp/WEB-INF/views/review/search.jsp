<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 | 페어리 타운</title>
<!-- Favicon -->
<link href="../resources/dist/img/close.png" rel="shortcut icon"
	type="image/x-icon">
<!-- Bootstrap CSS 파일 링크 추가 -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
 -->
 <link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet"> 
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Font Awesome 아이콘 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Swiper CSS -->
<!-- <link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css"> -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.css"
/>	
<style>
#review-list {
	width: 1200px;
	margin: auto;
}

.review-item {
	cursor: pointer;
}

liked {
	color: red; /* 좋아요가 활성화된 경우 색상 변경 */
}

.like-button-container:hover {
	cursor: pointer;
}

.modal-lg {
	max-width: 90%;
}

.modal-content {
	height: 80vh; /* 뷰포트 높이의 90%로 설정합니다. */
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤이 생성되도록 설정합니다. */
}

.icon-container {
	display: flex; /* 아이콘과 텍스트를 수평으로 정렬하기 위해 flexbox 사용 */
	align-items: center; /* 수직 정렬을 위해 아이콘과 텍스트를 세로로 가운데 정렬 */
}

.icon {
	width: 40px; /* 아이콘의 너비를 설정합니다. */
	height: 40px; /* 아이콘의 높이를 설정합니다. */
	margin-right: 5px; /* 아이콘과 텍스트 사이의 간격을 설정합니다. */
}

.ticket-type {
	font-size: 12px; /* 텍스트의 글꼴 크기를 설정합니다. */
	margin: 0; /* 기본 마진을 제거합니다. */
}

.title {
	margin-bottom: 5px; /* reviewtitle 아래의 간격을 조정합니다. */
}

.date {
	margin-top: 5px; /* reviewdate 위의 간격을 조정합니다. */
	color: #AAB2B9;
	font-size: 10px;
}	
.thumbnail {
    width: 296px; /* 원하는 크기로 설정 */
    height: 296px; /* 원하는 크기로 설정 */
    overflow: hidden;
}
.thumbnail img {
    width: 100%; /* 이미지 너비를 부모 요소의 100%로 설정하여 부모 요소에 맞게 조절 */
    height: auto; /* 이미지 높이를 자동으로 조절하여 비율을 유지 */
    /* 또는 필요한 경우 너비와 높이 값을 직접 설정할 수 있습니다.
    width: 200px; 
    height: 150px; */
}
.swiper-container img {
	width: 100%; /* 이미지 너비를 부모 요소의 100%로 설정하여 부모 요소에 맞게 조절 */
    height: auto;
}

.swiper-button-next::after,
.swiper-button-prev::after {
 /*  display: none; */
}

</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp" />

	<div class="container">
		<div class="row">

<!-- 베스트 리뷰 및 추천 리뷰 영역 -->
<div class="col-md-12 mb-4">
    <div class="row">
        <!-- 베스트 리뷰 영역 -->
        <div class="col-md-3">
            <h4><b>베스트 리뷰</b></h4>
            <!-- 베스트 리뷰를 나타내는 내용 추가 -->
            <c:choose>
                <c:when test="${bestReview ne null }">
                    <div class="col-md-12 mb-4 border rounded p-3">
                        <div class="review-item" data-toggle="modal" data-target="#reviewModal${bestReview.reviewNo}">
                            <div class="thumbnail">
                                <c:choose>
                                    <c:when test="${not empty bestReview.images}">
                                        <img src="../resources/nUploadFiles/${bestReview.images.get(0).fileRename}" alt="thumbnail">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="../resources/default-thumbnail.jpg" alt="thumbnail">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="details">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="title">${bestReview.reviewTitle}</p>
                                    </div>
                                </div>
                                <h6 class="date" style="color: #AAB2B9; font-size: 10px">${bestReview.reviewDate}</h6>
                                <div class="icon-container">
                                    <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon">
                                    <p class="ticket-type" style="font-size: 12px;">${bestReview.ticketType}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <h6>베스트 리뷰가 없습니다.</h6>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 추천 리뷰 영역 -->
        <div class="col-md-9">
            <h4><b>추천 리뷰</b></h4>
            <div class="row">
                <c:forEach items="${lList}" var="review" varStatus="status">
                    <div class="col-md-4 mb-4 border rounded p-3">
                        <div class="review-item" data-toggle="modal" data-target="#reviewModal${review.reviewNo}">
                            <div class="thumbnail">
                                <c:choose>
                                    <c:when test="${review.images ne null && review.images[0].fileName ne null}">
                                        <img src="../resources/ruploadFiles/${review.images[0].fileRename}" alt="Thumbnail">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="../resources/dist/img/opening.png" alt="Default Thumbnail">
                                    </c:otherwise>
                                </c:choose>              
                            </div>
                            <div class="details">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="title">${review.reviewTitle}</p>
                                    </div>
                                </div>
                                <h6 class="date" style="color: #AAB2B9; font-size: 10px">${review.reviewDate}</h6>
                                <div class="icon-container">
                                    <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon">
                                    <p class="ticket-type" style="font-size: 12px;">${review.ticketType}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${lList eq null }">
                    <h6>추천 리뷰가 없습니다.</h6>
                </c:if> 
            </div>
        </div>
    </div>
</div>

		<!-- 모달 창(detail) -->
		<jsp:include page="./modules/lListDetail.jsp" />


		
			<h3>
				<b>리뷰 <span style="opacity: 0.8; font-size: large;">${totalCounts}</span></b>
			</h3>
			<h6 style="color: #AAB2B9; font-size: medium">페어리타운 방문객들의 생생한 리뷰를 확인해 보세요.</h6>
			<!-- 구분선 -->
			<hr class="muidivider" style="border-width: 4px;">
			 <!-- 여백 추가 -->
			<div style="margin-bottom: 20px;"></div>
		<!-- 검색 폼, 리뷰 작성하기 -->
		<div
			class="d-flex flex-wrap justify-content-center align-items-center pb-5">
			<!-- 검색 폼 -->
			<jsp:include page="modules/searchForm.jsp" />
			<!-- 모달 창(detail) -->
			<jsp:include page="./modules/sListDetail.jsp" />

			<!-- 리뷰 작성하기 -->
			 <div class="d-flex col-md-6 justify-content-end">
			 <!-- 클릭 이벤트 추가하여 모달 열기 -->
                <button type="button" class="btn"
                        style="background-color: #FAFAFA; border-color: #e9ecef;"
                        onclick="openReviewModal();">리뷰 작성하기</button>
<!-- 				<button type="button" class="btn"
					style="background-color: #FAFAFA; border-color: #e9ecef;"
					onclick="showInsertForm();">리뷰 작성하기</button> -->
			</div>
			
		<!-- 모달 창(write) -->
		<jsp:include page="modules/writeReviewModal.jsp" />
			 
		</div>
		<!-- ------------------ -->
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style="margin-bottom: 20px;"></div>
			

			<!-- 리뷰 아이템 -->
			<!-- 이 부분 모듈로 담아서 메인에 쓰면 될 듯. -->
			<c:forEach items="${sList}" var="review" varStatus="status">
				<div class="col-md-3 mb-4 border rounded p-3">
					<!-- 여백 추가 -->
					<div class="review-item" data-toggle="modal"
						data-target="#reviewModal${review.reviewNo}">
						<div class="thumbnail">
							<!-- 썸네일 -->
							<c:choose>
 							    <c:when test="${review.images ne null && review.images[0].fileName ne null}">							    
							        <!-- review.images가 비어있지 않고 첫 번째 이미지의 fileName이 존재하는 경우 -->
							        <img src="../resources/ruploadFiles/${review.images[0].fileRename}" alt="Thumbnail">
							    </c:when>
							    <c:otherwise>
							        <!-- review.images가 비어 있거나 첫 번째 이미지의 fileName이 없는 경우 -->
							        <img src="../resources/dist/img/opening.png" alt="Default Thumbnail">
							    </c:otherwise>
							</c:choose>				
					   </div>
							
						<div class="details">
							<div class="row">
							    <div class="col-sm-6">
							        <p class="title">${review.reviewTitle}</p>
							    </div>
							</div>
							<h6 class="date" style="color: #AAB2B9; font-size: 10px">${review.reviewDate}</h6>
							<div class="icon-container">
								<img src="../resources/dist/img/mainLogo.png" alt="Main Logo"
									class="icon">
								<p class="ticket-type" style="font-size: 12px;">${review.ticketType}</p>
							</div>
						</div>
					</div>
				</div>
				<!-- 한 줄에 4개씩 정렬하기 위해, 4번째 열마다 clearfix 클래스 추가 -->
				<c:if test="${status.index % 4 == 3}">
					<div class="clearfix"></div>
				</c:if>
			</c:forEach>
		</div>

		
		<!-- 모달 창(detail) -->
		<jsp:include page="./modules/rListDetail.jsp" />

		<!-- 페이징 영역 -->
		<jsp:include page="modules/pagination.jsp" />

	</div>
	
	
	

	
	
	

	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp" />

	<!-- Bootstrap JavaScript 파일 링크 추가 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	    <!-- Swiper JS -->
	    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.js"></script>
	    
<!--     <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
 -->    <!-- 슬라이드를 생성하고 설정하는 스크립트 -->
<!--     <script src="/js/script.js"></script> -->	

	<script>
	
	// 리뷰 작성하기 모달 열기 함수
	function openReviewModal() {
	    $('#writeReviewModal').modal('show'); // Bootstrap modal 열기
	}
	
	
	// swiper
	
	document.addEventListener("DOMContentLoaded", function () {
	    var swiper = new Swiper('.swiper-container', {
	        // Swiper 옵션 설정
	        loop: false, // 무한 루프
	        slidesPerView: 'auto', // 한 번에 보여지는 슬라이드 수
	  //      slidesPerGroup: 1,
	        spaceBetween: 30, // 슬라이드 간의 간격
	        watchOverflow : true, // 슬라이드가 1개 일 때 pager, button 숨김 여부 설정
			cssMode: true,
	        
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

	    // 이전 버튼 아이콘 변경
	    var prevButton = document.querySelector('.swiper-button-prev');
	    prevButton.querySelector('.swiper-button-prev-icon').classList.remove('swiper-button-prev-icon');
	    prevButton.querySelector('svg').classList.add('custom-prev-icon'); // 변경할 클래스 이름

	    // 다음 버튼 아이콘 변경
	    var nextButton = document.querySelector('.swiper-button-next');
	    nextButton.querySelector('.swiper-button-next-icon').classList.remove('swiper-button-next-icon');
	    nextButton.querySelector('svg').classList.add('custom-next-icon'); // 변경할 클래스 이름
	});
	
    
	// ===============
	// 좋아요 토글 함수
	// ===============
	function toggleLike(element, reviewNo) {
	 // 좋아요 버튼 요소 가져오기
	 var likeButton = element.querySelector(".like-button");
	 // 좋아요 수 표시 요소 가져오기
	 var likeCountElement = element.querySelector(".like-count");
	 // 현재 좋아요 수 가져오기
	 var currentLikeCount = parseInt(likeCountElement.innerText);
	
	 // 좋아요 상태를 토글하고 토글된 상태를 변수에 저장
	 // (* far:빈하트, fas:꽉찬하트)
	 var liked = likeButton.getAttribute("data-prefix") === 'far' ? true : false;
	
	 // AJAX 요청을 보내서 좋아요 상태를 서버에 업데이트
	 $.ajax({
	     type: "POST", // POST 메서드 사용
	     url: "/review/like/" + reviewNo, // 좋아요 요청 URL
	     data: { liked: liked }, // 좋아요 상태를 서버로 전송
	     success: function (response) {
	         if (response === 'Success') {
	             // 좋아요 수 업데이트 성공 시 UI 업데이트
	             var newLikeCount = liked ? currentLikeCount + 1 : currentLikeCount - 1;
	             likeCountElement.innerText = newLikeCount;
	             // 좋아요 버튼 클래스 토글 (* far:빈하트, fas:꽉찬하트)
	             if(liked) {
		                likeButton.classList.toggle('fas');
	             }else{
		                likeButton.classList.toggle('far');
	             }
	         } else {
	             // 실패한 경우 좋아요 상태를 이전 상태로 되돌림
	             likeButton.classList.toggle('far', liked);
	             likeButton.classList.toggle('fas', !liked);
	         }
	     },
	     error: function (xhr, status, error) {
	         // 오류가 발생한 경우
	         console.error("좋아요 상태 업데이트 오류:", error);
	         // 실패한 경우 좋아요 상태를 이전 상태로 되돌림
	         likeButton.classList.toggle('far', liked);
	         likeButton.classList.toggle('fas', !liked);
	     }
	 });
	}
	
	
	// ============================
	// 리뷰 아이템 클릭 시 조회수 업데이트
	// ============================
	$(".review-item").click(function() {
	    // data-target 속성에서 리뷰 번호 가져오기
	    var target = $(this).data("target");
	    //console.log("target:", target); // 확인용 로그
	    // 리뷰 번호가 포함된 target 속성에서 번호 추출
	    var reviewNo = target.replace("#reviewModal", "");
	    //console.log("reviewNo:", reviewNo); // 확인용 로그
	    // 조회수 업데이트 함수 호출
	    updateViewCount(reviewNo);
	});
	
    // ============================
    // 조회수 업데이트 Ajax 요청
    // ============================
    function updateViewCount(reviewNo) {
        $.ajax({
            type: "POST",
            url: "/review/updateViewCount/"+reviewNo,
            success: function(response) {
                // 서버에서 응답이 왔을 때 수행할 작업
                // 여기에 필요한 경우 UI 업데이트 등의 작업을 추가할 수 있습니다.

                // 화면에 조회수 업데이트
                var viewCountSpan = $("#viewCount_" + reviewNo);
                var newViewCount = parseInt(viewCountSpan.text()) + 1;
                viewCountSpan.text(newViewCount);

                console.log("조회수 업데이트 성공 : "+ newViewCount); // 현재 조회수 표시
                console.log("리뷰 번호: ",reviewNo);
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 수행할 작업
                console.log("update failed!")
            }
        });
    }
 
    // 작성하기
/*     function showInsertForm() {
        // 모달 창 표시
        $("#myModal").css("display", "block");
    } */
    
/*  	function showInsertForm() {
		// 리뷰 작성하기 페이지 이동
		location.href="/review/insert.ft"; 
	} */
	
	</script>
</body>
</html>