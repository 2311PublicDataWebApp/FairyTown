<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페어리 타운 | 내가 등록한 리뷰</title>
<!-- Favicon -->
<link href="../resources/dist/img/close.png" rel="shortcut icon"
	type="image/x-icon">
<!-- Bootstrap CSS 파일 링크 추가 -->
 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet"> 
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Font Awesome 아이콘 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>



	<div id="reviewListContainer" class="container"
		style="max-width: 1170px; margin: auto;">
		<div class="row">
			<!--         <div class="col-md-12">
 -->
			<h4 style="text-align: center;">
				<b>내가 등록한 리뷰</b>
			</h4>
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style="margin-bottom: 20px;"></div>
			<div id="rListContainer" class="row">

				<c:choose>
					<c:when test="${myReviewList ne null }">

						<c:forEach items="${myReviewList}" var="review" varStatus="status">
							<div class="col-md-3 mb-4 border rounded p-3">
								<!-- 여백 추가 -->
								<div class="review-item" data-toggle="modal"
									data-target="#reviewModal${review.reviewNo}">
									<div class="thumbnail" style="margin-bottom: 10px;">
										<!-- 썸네일 -->
										<c:choose>
											<c:when
												test="${review.images ne null && review.images[0].fileName ne null}">
												<!-- review.images가 비어있지 않고 첫 번째 이미지의 fileName이 존재하는 경우 -->
												<img
													src="../resources/ruploadFiles/${review.images[0].fileRename}"
													alt="Thumbnail">
											</c:when>
											<c:otherwise>
												<!-- review.images가 비어 있거나 첫 번째 이미지의 fileName이 없는 경우 -->
												<img src="../resources/dist/img/opening.png"
													alt="Default Thumbnail">
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
										<div class="icon-container"
											style="display: flex; align-items: center;">
											<img src="../resources/dist/img/mainLogo.png" alt="Main Logo"
												class="icon"
												style="width: 34px; height: 34px; margin-right: 5px;">
											<p class="ticket-type"
												style="font-size: 12px; color: #7B848D; margin: 0; font-weight: bold;">${review.ticketType}</p>
										</div>

									</div>
								</div>
							</div>
							<!-- 한 줄에 4개씩 정렬하기 위해, 4번째 열마다 clearfix 클래스 추가 -->
							<c:if test="${status.index % 4 == 3}">
								<div class="clearfix"></div>
							</c:if>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<h6 style="font-size: 40px; color: black; text-align: center;">등록한
							리뷰가 없습니다.</h6>
						<br>
						<br>
						<br>
						<br>
						<br>
						<!-- 리뷰 작성하기 -->
						<div class="d-flex justify-content-center align-items-center">
							<!-- 클릭 이벤트 추가하여 모달 열기 -->
							<button type="button" class="btn"
								style="background-color: #FAFAFA; border-color: #e9ecef;"
								onclick="window.location.href = '/review/list.ft';">리뷰
								작성하러 가기</button>
							<!-- onclick="openReviewModal();">리뷰 작성하기</button> -->
							<!-- 모달 창(myReviewList Detail) -->
							<%-- 		<jsp:include page="modules/writeReviewModal.jsp" />
		<jsp:include page="./modify.jsp" />
 		<jsp:include page="./modules/myReviewListDetail.jsp" /> --%>
						</div>
					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</div>
	<!--         </div>
 -->


	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	
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
		 $('#reviewModal'+reviewNo).html("");
	//    $('[id^=reviewModal]').modal('hide');
	    // 모달 배경 제거
	    $('.modal-backdrop').remove();
	    // 새 모달 열기
	    $('#reviewModal' + reviewNo).modal('show');
	}  
	
	// 리뷰 작성하기 모달 열기
	function openReviewModal() {
			var userId = $("input[name='userId']").val();
			if (userId == "") {
				alert("로그인이 필요합니다.");
	    }else{  
	    // 세션이 있을 경우 모달 열기
	    $('#writeReviewModal').modal('show');
	    }
	}
	
	
	
/* 	function openReviewModal() {
	    // 세션 상태 확인 요청 보내기
	    fetch('/checkSession')
	    .then(response => response.text())
	    .then(data => {
	        if (data === 'login_required') {
	            // 로그인이 필요한 알림 표시
	            alert("로그인이 필요합니다.");
	        } else {
	            // Bootstrap modal 열기
	            $('#writeReviewModal').modal('show');
	        }
	    })
	    .catch(error => console.error('Error:', error));
	} */
	
	
	
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
    
/*  	function showReviewModal(reviewNo, event, obj) {
	    // 이벤트 전파 막기
	    event.preventDefault();
// 	    $(obj).parents(".modal").attr("display", "none");
		 // 모든 모달을 닫음
	    $('[id^=reviewModal]').modal('hide');
	    // 모달 배경 제거
	    $('.modal-backdrop').remove();
	    // 새 모달 열기
	    $('#reviewModal' + reviewNo).modal('show');
	}   */
    
    // =========
    // 수정하기
    // =========
	function modifyReview(reviewNo) {
		// 수정할 리뷰 번호를 서버로 전달하여 수정 폼을 받아온다.
	    // 이 부분에서 Ajax 요청을 사용하면 좋습니다.
	    // Ajax를 사용하면 페이지 새로고침 없이 서버로부터 데이터를 받아올 수 있습니다.
	    // 받아온 수정 폼을 모달로 표시하거나 적절한 위치에 표시할 수 있습니다.
	    // 예를 들어, Bootstrap 모달을 사용하면 좋습니다.
	    
		 // 모든 모달을 닫음
//	    $('[id^=reviewModal]').modal('hide');
//		var reviewNo = "${review.reviewNo }";
		$('#reviewModal'+reviewNo).css('display', 'none');
// 		$('#reviewModal'+reviewNo).html("");
	    // 모달 배경 제거
	    $('.modal-backdrop').remove();
		$('#modifyReviewModal'+reviewNo).modal('show');
	    
		
//		location.href = "/review/modify.ft?reviewNo=" + reviewNo;
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