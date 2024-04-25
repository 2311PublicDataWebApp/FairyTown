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
	height: 70vh; /* 뷰포트 높이의 90%로 설정. */
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤이 생성되도록 설정. */
}

.swiper-container img {
	width: 100%; /* 이미지 너비를 부모 요소의 100%로 설정하여 부모 요소에 맞게 조절 */
    height: auto;
}

.swiper-container {
  width: 100%; /* Swiper 컨테이너의 가로 폭을 설정합니다. */
  height: 300px; /* Swiper 컨테이너의 세로 높이를 설정합니다. */
}

.swiper-slide img {
  width: 100%; /* 이미지를 슬라이드에 꽉 차게 표시합니다. */
  height: 100%; /* 이미지를 슬라이드에 꽉 차게 표시합니다. */
  object-fit: cover; /* 이미지가 슬라이드에 꽉 차게 보이도록 설정합니다. */
}


.swiper-button-next::after,
.swiper-button-prev::after {
 /*  display: none; */
}

#review-list {
	width: 1200px;
	margin: auto;
}

.review-item {
    cursor: pointer;
    width: 100%; /* 부모 요소의 너비에 맞게 조정 */
    height: 100%; /* 부모 요소의 높이에 맞게 조정 */
    object-fit: cover; /* 이미지를 썸네일 크기에 맞게 잘라내도록 설정 */
}

.icon-container {
    display: flex; /* 아이콘과 텍스트를 수평으로 정렬하기 위해 flexbox 사용 */
    align-items: center; /* 수직 정렬을 위해 아이콘과 텍스트를 세로로 가운데 정렬 */
}

.icon {
    width: 34px; /* 아이콘의 너비를 34px로 설정 */
    height: 34px; /* 아이콘의 높이를 34px로 설정 */
    margin-right: 5px; /* 아이콘과 텍스트 사이의 간격을 5px로 설정 */
}

.details {
/*     padding: 15px; /* 내부 요소 간격 조절 */
 
 }

/* 베스트 리뷰와 추천 리뷰 영역 */
.col-md-12.mb-4 {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    /* justify-content: space-between; */
}

.col-md-3.mb-2,
.col-md-9 {
    flex: 0 0 48%; /* 두 열의 너비를 반씩 차지하도록 설정. */
}

/* 추천 리뷰 아이템 간의 간격을 조정. */
.col-md-4.mb-2 {
    margin-bottom: 15px;
    
}

.col-md-3.mb-4.border.rounded.p-3 {
    width: 244.25px; /* 리뷰 아이템의 너비를 244.25px로 설정 */
    height: 338.45px; /* 리뷰 아이템의 높이를 367.15px로 설정 */
    margin: auto; /* 중앙 정렬을 위해 자동 마진 설정 */
    margin-bottom: 15px; /* 추천 아이템의 하단 여백과 동일하게 설정 */
}

/* 리뷰 아이템 컨테이너의 크기를 조정. */
.border.rounded.p-3 {
/*     width: 100%;
    height: auto;
    padding: 15px; */
}

/* 썸네일 이미지를 가운데 정렬. */
.thumbnail {
    text-align: center;
}

.thumbnail img {
    width: 210.25px; /* 썸네일 이미지를 부모 요소의 100% 너비로 조정 */
    height: 210.25px; /* 썸네일 이미지를 부모 요소의 100% 높이로 조정 */
    object-fit: cover; /* 이미지를 썸네일 크기에 맞게 잘라내도록 설정 */
    overflow: hidden; /* 이미지 오버플로우를 숨기기 위해 설정 */
    border-radius: 5px; /* 모서리를 10px 만큼 둥글게 설정 */
    
}

/* 조회수와 좋아요 아이콘을 수평으로 정렬. */
.thumbnail > div {
    display: flex;
    align-items: center;
    justify-content: flex-start;
}

/* 리뷰 제목을 좀 더 크게 표시. */
.title {
    font-size: 14px;
    margin-top:10px;
    margin-bottom: 5px;
}

/* 리뷰 날짜의 크기와 간격을 조정. */
.date {
    font-size: 11px;
    margin-top: 1px;
    color: #AAB2B9;
}

/* 티켓 타입의 크기를 조정합니다. */
.ticket-type {
    font-size: 12px;
    color: #AAB2B9;
    font-weight: bold;
}

/* 추천 리뷰가 없을 경우의 메시지 스타일을 조정. */
h6 {
    font-size: 14px;
    color: #AAB2B9;
}

.row.justify-content-center .col-md-4 {
    flex: 0 0 25%; /* 아이템의 크기를 25%로 지정하여 4개의 아이템이 한 줄에 들어가도록 함 */
    max-width: 25%; /* 최대 너비를 25%로 지정하여 아이템의 크기를 조절함 */
    margin-bottom: 15px; /* 아이템 간격 조절 */
}





</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp" />

	<div id="reviewListContainer" class="container" style="max-width: 1170px; margin: auto;">
		<div class="row">

		<!-- 베스트 리뷰 및 추천 리뷰 영역 -->
		<div class="col-md-12 mb-4">
		    <div class="row">
		    
		        <!-- 베스트 리뷰 영역 -->
		        <div class="col-md-4 mb-2 ">
		            <h4 style="text-align: center;"><b>베스트 리뷰</b></h4>
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style="margin-bottom: 20px;"></div>
		            <c:choose>
		                <c:when test="${bestReview ne null }">
		                    <div class="border rounded p-3" style="width: 234.73px; height: 338.45px; align-items: center;">
		                        <div class="review-item" data-toggle="modal" data-target="#reviewModal${bestReview.reviewNo}">
		                            <div class="thumbnail" style="position: relative; margin-bottom: 15px;">
		                                <c:choose>
		                                    <c:when test="${not empty bestReview.images}">
		                                        <img src="../resources/ruploadFiles/${bestReview.images[0].fileRename}" alt="Thumbnail" style="width: 100%; border-radius: 5px;">
		                                    </c:when>
		                                    <c:otherwise>
		                                        <img src="../resources/dist/img/opening.png" alt="thumbnail" style="width: 100%; border-radius: 5px;">
		                                    </c:otherwise>
		                                </c:choose>
		                                <div style="position: absolute; top: 5px; left: 5px; background-color: rgba(255, 255, 255, 0.7); padding: 5px; font-size: 12px; display: flex; align-items: center; border-radius: 5px;">
		                                    <svg width="18" height="18" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;">
		                                        <path d="M8.904 4.904a6.207 6.207 0 0 0-3.382 1.127A6.863 6.863 0 0 0 3.19 8.889a6.868 6.868 0 0 0 2.327 2.875 6.21 6.21 0 0 0 3.387 1.14 6.202 6.202 0 0 0 3.388-1.139 6.862 6.862 0 0 0 2.326-2.876 6.856 6.856 0 0 0-2.332-2.86 6.2 6.2 0 0 0-3.382-1.125Zm0 6.544a2.255 2.255 0 0 1-1.305-.437 2.51 2.51 0 0 1-.862-1.14 2.709 2.709 0 0 1-.13-1.46c.093-.49.317-.94.647-1.293a2.32 2.32 0 0 1 1.205-.693c.457-.098.93-.05 1.361.14.431.188.8.51 1.062.923a2.7 2.7 0 0 1 .232 2.383 2.558 2.558 0 0 1-.517.834 2.358 2.358 0 0 1-.777.554c-.29.128-.602.192-.916.19Z" fill="#000"/>
		                                    </svg>
		                                    ${bestReview.viewCount}
		                                </div>
		                            </div>
		                            <div class="details">
		                                <div class="row">
		                                    <div class="col-sm-12">
		                                        <p class="title" style="">${bestReview.reviewTitle}</p>
		                                    </div>
		                                </div>
		                                <h6 class="date" style="color: #AAB2B9; font-size: 11px; margin-bottom: 5px;">${bestReview.reviewDate}</h6>
										<div class="icon-container" style="display: flex; align-items: center;">
										    <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon" style="width: 34px; height: 34px; margin-right: 5px;">
										    <p class="ticket-type" style="font-size: 12px; color: #7B848D; margin: 0; font-weight: bold;">${bestReview.ticketType}</p>
										</div>
		
		
		                            </div>
		                        </div>
		                    </div>
		                </c:when>
		                <c:otherwise>
		                    <h6 style="font-size: 14px; color: #AAB2B9;">베스트 리뷰가 없습니다.</h6>
		                </c:otherwise>
		            </c:choose>
		        </div>
		        
		        <!-- 추천 리뷰 영역 -->
		        <div class="col-md-8">
		            <h4 style="text-align: center; width:750px;"><b>추천 리뷰</b></h4>
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style="margin-bottom: 20px;"></div>
		            <div class="row">
		                <c:forEach items="${lList}" var="review" varStatus="status">
		                    <div class="col-md-4 mb-2">
		                        <div class="border rounded p-3" style=" width: 244.25px; height: 340.45px; margin-bottom: 7.5px;">
		                            <div class="review-item" data-toggle="modal" data-target="#reviewModal${review.reviewNo}">
		                                <div class="thumbnail" style="position: relative; margin-bottom: 15px;">
		                                    <c:choose>
		                                        <c:when test="${review.images ne null && review.images[0].fileName ne null}">
		                                            <img src="../resources/ruploadFiles/${review.images[0].fileRename}" alt="Thumbnail" style="border-radius: 5px;">
		                                        </c:when>
		                                        <c:otherwise>
		                                            <img src="../resources/dist/img/opening.png" alt="Default Thumbnail" style="border-radius: 5px;">
		                                        </c:otherwise>
		                                    </c:choose> 
		                                    <div style="position: absolute; top: 5px; left: 5px; background-color: rgba(255, 255, 255, 0.7); padding: 5px; font-size: 12px; display: flex; align-items: center; border-radius: 5px;">
		                                        <!-- 빨간색 하트 아이콘 -->
		                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;">
		                                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" fill="red"/>
		                                        </svg>
		                                        <!-- 좋아요 수 -->
		                                        <span>${review.likeCount}</span>
		                                    </div>            
		                                </div>
		                                <div class="details">
		                                    <div class="row">
		                                        <div class="col-sm-12">
		                                            <p class="title" style="font-size: 14px; margin-bottom: 10px;">${review.reviewTitle}</p>
		                                        </div>
		                                    </div>
		                                    <h6 class="date" style="color: #AAB2B9; font-size: 11px; margin-bottom: 5px;">${review.reviewDate}</h6>
		                                    <div class="icon-container" style="display: flex; align-items: center;">
											    <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon" style="width: 34px; height: 34px; margin-right: 5px;">
											    <p class="ticket-type" style="font-size: 12px; color: #7B848D; margin: 0; font-weight: bold;">${review.ticketType}</p>
											</div>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </c:forEach>
		                <c:if test="${lList eq null }">
		                    <h6 style="font-size: 14px; color: #AAB2B9;">추천 리뷰가 없습니다.</h6>
		                </c:if> 
		            </div>
		        </div>
		    </div>
		</div>

		<!-- 모달 창(detail) -->
		<jsp:include page="./modules/lListDetail.jsp" />

		 <!-- 여백 추가 -->
		<div id = sortStop style="margin-bottom: 20px;"></div>
		
		
			<h3>
				<b>리뷰 <span style="opacity: 0.8; color:#7B848D; font-size: large;">${totalCount}</span></b>
			</h3>
			<h6 style="color: #AAB2B9; font-size: medium">페어리타운 방문객들의 생생한 리뷰를 확인해 보세요.</h6>
			<!-- 구분선 -->
			<hr class="muidivider" style="border-width: 4px;">
			 <!-- 여백 추가 -->
			<div style="margin-bottom: 20px;"></div>
			
		<!-- 검색 폼, 정렬 메뉴, 리뷰 작성하기 -->
		<div class="d-flex flex-wrap justify-content-between align-items-center pb-4">
		    <!-- 검색 폼 -->
		    <jsp:include page="modules/searchForm.jsp" />
		    <!-- 모달 창(detail) -->
		    <jsp:include page="./modules/sListDetail.jsp" />
		
		    <!-- 리뷰 작성하기 -->
		    <div class="d-flex col-md-6 justify-content-end align-items-center">
		        <!-- 클릭 이벤트 추가하여 모달 열기 -->
		        <button type="button" class="btn"
		                style="background-color: #FAFAFA; border-color: #e9ecef;"
		                onclick="openReviewModal();">리뷰 작성하기</button>
		    </div>
		    
		    <!-- 정렬 메뉴 -->
		    <div class="d-flex col-md-6 justify-content-start align-items-center" style="margin-top: 5px;">
		        <div class="">
		            <select class="form-select" name="sortType" id="sortType">
		                <option value="recentReviewSort" <c:if test="${pi.type == 'recentReviewSort' }">selected</c:if>>최신순</option>
		                <option value="viewCountSort" <c:if test="${pi.type == 'viewCountSort' }">selected</c:if>>조회수순</option>
		                <option value="likeCountSort" <c:if test="${pi.type == 'likeCountSort' }">selected</c:if>>유용해요순</option>
		            </select>
		        </div>
		    </div>
		
		    <!-- 모달 창(write) -->
		    <jsp:include page="modules/writeReviewModal.jsp" />
		</div>
		
		
		<!-- ------------------ -->
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style=" margin-bottom: 10px;"></div>
			
		<div id="rListContainer" class="row">
			<!-- 리뷰 아이템 -->
			<!-- 이 부분 모듈로 담아서 메인에 쓰면 될 듯. -->
			<c:forEach items="${rList}" var="review" varStatus="status">
				<div class="col-md-3 mb-4 border rounded p-3">
					<!-- 여백 추가 -->
					<div class="review-item" data-toggle="modal"
						data-target="#reviewModal${review.reviewNo}">
						<div class="thumbnail" style="margin-bottom:10px;">
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
							    <div class="col-sm-12">
							        <p class="title" style="">${review.reviewTitle}</p>
							    </div>
							</div>
							<h6 class="date" style="color: #AAB2B9; font-size: 10px">${review.reviewDate}</h6>
							<div class="icon-container" style="display: flex; align-items: center;">
							    <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon" style="width: 34px; height: 34px; margin-right: 5px;">
							    <p class="ticket-type" style="font-size: 12px; color: #7B848D; margin: 0; font-weight: bold;">${review.ticketType}</p>
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
			
</div>
		
		<!-- 모달 창(rList detail) -->		
		
 		<jsp:include page="./modules/rListDetail.jsp" />
 
 
 
 
 
		<!-- 페이징 영역 -->
	<div class="row mt-3 mb-5" style="margin-top:300px;">
    <div class="col-md-12">
        <nav aria-label="Page navigation example">                    
            <ul id="pageul" class="pagination justify-content-center" style="font-weight: 600; ">
                <c:if test="${pi.startNavi ne '1' }">
                    <li class="page-item">
                        <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.startNavi - 1 }&sortType=${pi.type }" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
                    <li class="page-item">
                        <a class="page-link rounded-circle mx-2" href="/review/list.ft?page=${p }&sortType=${pi.type }" style="border: none; color: #313131;">
                            ${p }
                        </a>
                    </li>
                </c:forEach>
                <c:if test="${pi.endNavi ne pi.naviTotalCount }">
                    <li class="page-item">
                        <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.endNavi + 1 }&sortType=${pi.type }" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
<%-- 		<jsp:include page="modules/pagination.jsp" />
 --%>
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

	
/* 	$(document).ready(function() {
	    // 페이지가 로드될 때 초기 정렬 상태를 최신순으로 설정
	    sortReviews("recentReviewSort");
	}); */

	
	// 페이지 클릭 시 스크롤을 특정 부분으로 이동시키는 함수
	function scrollToSortStop() {
	    var sortStopElement = document.getElementById('sortStop');
	    if (sortStopElement) {
	        sortStopElement.scrollIntoView({ behavior: 'auto' });
	    }
	}

	// 정렬 옵션 변경 시 이벤트 핸들러
	$("#sortType").on("change", function() {
	    // 선택된 정렬 옵션 값 가져오기
	    var sortType = $("#sortType option:selected").val();
	    // 첫 번째 페이지로 리뷰 정렬
	   	location.href = "/review/list.ft?page=1&sortType="+sortType;
// 	    sortReviews(1, sortType); 
	});

	
	
	// 상세 보기 모달을 열기 위한 함수
	function showSortedReviewModal(reviewNo, event, element) {
	    // 이벤트의 기본 동작을 막음
	    event.preventDefault();
	    
	    // 해당 리뷰의 모달 창을 보여줌
	    $("#reviewModal" + reviewNo).modal("show");
	    
	    // 클릭한 아이템이 위치한 곳으로 스크롤 이동
	    $('html, body').animate({
	        scrollTop: $(element).offset().top
	    }, 500);
	}
	
	
	
	// 리뷰를 정렬하여 페이징 및 리뷰 목록 업데이트
	function sortReviews(page, sortType) {
	    $.ajax({
	        url: "/review/sortedList.ft",
	        type: "GET",
	        data: {
	            "page" : page,
	            "sortType": sortType
	        },
	        success: function(response) {
	            // 리뷰 목록을 표시할 컨테이너 선택
	            var reviewListContainer = $("#rListContainer");
	            // 기존 리뷰 목록 초기화
	            reviewListContainer.html("");
/* 	            reviewListContainer.empty();  */
 
	            // 페이징 영역 선택
	            var ul = $("#pageul");
	            // 기존 페이징 영역 초기화
	            ul.html("");
	            var li;
	            var a;
	            var span;
	            
	            // 응답으로부터 리뷰 목록 및 페이징 정보 추출
	            var reviews = response.sortList;
	            var pi = response.pi;
	            
	            // 리뷰가 존재하는 경우
	            if (reviews.length > 0) {
	            	
	            	// 클릭 이벤트를 한 번만 등록
	              /*   if (!isClickEventRegistered) {
	                    reviewListContainer.on("click", ".col-md-3", function() {
	                        // 해당 리뷰의 모달 창을 보여줌
	                        var reviewNo = $(this).data("reviewNo");
	                        $("#reviewModal" + reviewNo).modal("show");
	                    });
	                    isClickEventRegistered = true;
	                } */ 
	            	
	                // 각 리뷰에 대해 반복하여 목록 생성
	                reviews.forEach(function(review) {
	                    var reviewItem = $("<div class='col-md-3 mb-4 border rounded p-3'>");
	                    	reviewItem.data("reviewNo", review.reviewNo); // 리뷰 번호 데이터 저장
	                    var thumbnail = $("<div class='thumbnail' style='margin-bottom:10px;'>");
	                    var thumbnailImage;
	                    // 리뷰에 이미지가 있는 경우 썸네일로 사용, 없으면 기본 이미지로 대체
	                    if (review.images != null && review.images.length > 0 && review.images[0].fileName != null) {
	                        thumbnailImage = $("<img src='../resources/ruploadFiles/" + review.images[0].fileRename + "' alt='Thumbnail'>");
	                    } else {
	                        thumbnailImage = $("<img src='../resources/dist/img/opening.png' alt='Default Thumbnail'>");
	                    }
	                    thumbnail.append(thumbnailImage);
	                    
	                    var details = $("<div class='details'>");
	                    var title = $("<p class='title'>" + review.reviewTitle + "</p>");
	                    var date = $("<h6 class='date' style='color: #AAB2B9; font-size: 10px'>" + review.reviewDate + "</h6>");
	                    var iconContainer = $("<div class='icon-container' style='display: flex; align-items: center;'>");
	                    var mainLogo = $("<img src='../resources/dist/img/mainLogo.png' alt='Main Logo' class='icon' style='width: 34px; height: 34px; margin-right: 5px;'>");
	                    var ticketType = $("<p class='ticket-type' style='font-size: 12px; color: #7B848D; margin: 0; font-weight: bold;'>" + review.ticketType + "</p>");
	                    
	                    iconContainer.append(mainLogo);
	                    iconContainer.append(ticketType);
	                    
	                    details.append(title);
	                    details.append(date);
	                    details.append(iconContainer);
	                    
	                    reviewItem.append(thumbnail);
	                    reviewItem.append(details);
	                    
	                    /* reviewItem.on("click", function() {
	                        detailReview(review.reviewNo); // 리뷰 클릭 시 상세 페이지로 이동
	                    }); */
	                    reviewItem.on("click", function() {
	                        // 해당 리뷰의 모달 창을 보여줌
	                        $("#reviewModal" + review.reviewNo).modal("show");

	                        // 클릭한 아이템이 위치한 곳으로 스크롤 이동
	                        var targetElement = $("#reviewModal" + review.reviewNo);
	     
	                    });
	                    
	                    // 리뷰 아이템에 마우스 호버 이벤트 추가
	                    reviewItem.hover(function() {
	                        $(this).css('cursor', 'pointer'); // 마우스 모양을 포인터로 변경
	                    });
			             reviewListContainer.append(reviewItem);
	                });
	                
	                // 페이징 버튼 생성
	                if (pi.startNavi != 1) {
	                    li = $("<li class='page-item'>");
	                    a = $("<a onclick='sortReviews("+(pi.startNavi-1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Previous'>");
	                    span = "<span aria-hidden='true'>&laquo;</span>";
	                    a.append(span);
	                    li.append(a);
	                    ul.append(li);
	                }
	                
	                for (var p = pi.startNavi; p <= pi.endNavi; p++) {
	                    li = $("<li class='page-item'>");
	                    a = $("<a onclick='sortReviews("+p+", \""+sortType+"\"); scrollToSortStop();' class='page-link rounded-circle mx-2' href='javascript:void(0);' style='border: none; color: #313131;'>");

/* 	                    a = $("<a onclick='sortReviews("+p+", \""+sortType+"\");' class='page-link rounded-circle mx-2' href='javascript:void(0);' style='border: none; color: #313131;'>");
 */	                    span = p;
	                    a.append(span);
	                    li.append(a);
	                    ul.append(li);
	                }
	                
	                if (pi.endNavi != pi.naviTotalCount) {
	                    li = $("<li class='page-item'>");
	                    a = $("<a onclick='sortReviews("+(pi.endNavi+1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Next'>");
	                    span = "<span aria-hidden='true'>&raquo;</span>";
	                    a.append(span);
	                    li.append(a);
	                    ul.append(li);
	                }
	            } else {
	                // 리뷰가 없는 경우에 대한 처리
	            }
	        },
	        error: function() {
	            // 에러 발생 시 처리
	            alert("Ajax 통신 실패")
	        }
	    });
	}

	// 리뷰 상세 페이지로 이동하는 함수
/* 	function detailReview(reviewNo) {
	    location.href = "/review/detail.ft?reviewNo=" + reviewNo;
	}  */

	
	
	// 이전 페이지로 이동하는 함수
	function goToPreviousPage(currentPage) {
	    // 현재 페이지에서 1을 빼서 이전 페이지 번호를 계산
	    var previousPage = currentPage - 1;
	    // 현재 URL에서 "/review/previous"를 호출하도록 설정하고 currentPage를 전달하여 이전 페이지로 이동
	    window.location.href = "/review/previous?currentPage=" + previousPage;
	}

	// 다음 페이지로 이동하는 함수
	function goToNextPage(currentPage) {
	    // 현재 페이지에서 1을 더하여 다음 페이지 번호를 계산
	    var nextPage = currentPage + 1;
	    // 현재 URL에서 "/review/next"를 호출하도록 설정하고 currentPage를 전달하여 다음 페이지로 이동
	    window.location.href = "/review/next?currentPage=" + nextPage;
	}

	
 	function showReviewModal(reviewNo, event, obj) {
	    // 이벤트 전파 막기
	    event.preventDefault();
// 	    $(obj).parents(".modal").attr("display", "none");
		 // 모든 모달을 닫음
	    $('[id^=reviewModal]').modal('hide');
	    // 모달 배경 제거
	    $('.modal-backdrop').remove();
	    // 새 모달 열기
	    $('#reviewModal' + reviewNo).modal('show');
	}  
	
	// 리뷰 작성하기 모달 열기 함수
	function openReviewModal() {
	    $('#writeReviewModal').modal('show'); // Bootstrap modal 열기
	}
	
	// =================
	// Swiper
	// =================
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

	    // 다음 버튼 아이콘 변경
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
    
    // =========
    // 수정하기
    // =========
	function modifyReview(reviewNo) {
		var reviewNo = "${review.reviewNo }";
		location.href = "/review/modify.ft?reviewNo=" + reviewNo;
	}	

    // =========
    // 삭제하기
    // =========
	function deleteReview(reviewNo) {
		if (confirm("리뷰를 삭제하시겠습니까?")) {
			location.href = "/review/delete.ft?reviewNo=" + reviewNo;
		}
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