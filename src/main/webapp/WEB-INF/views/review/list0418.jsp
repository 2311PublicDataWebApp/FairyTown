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
</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<h3>
				<b>리뷰 <span style="opacity: 0.8; font-size: large;">${totalCount}</span></b>
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
			<jsp:include page="modules/searchForm.jsp"></jsp:include>

			<!-- 리뷰 작성하기 -->
			 <div class="d-flex col-md-6 justify-content-end">
				<button type="button" class="btn"
					style="background-color: #FAFAFA; border-color: #e9ecef;"
					onclick="showInsertForm();">리뷰 작성하기</button>
			</div> 
		</div>
		<!-- ------------------ -->
			<!-- 구분선 -->
			<hr class="muidivider">
			<div style="margin-bottom: 20px;"></div>
			

			<!-- 리뷰 아이템 -->
			<!-- 모듈로 담아서 메인에 쓰면 될 듯. -->
			<c:forEach items="${rList}" var="review" varStatus="status">
				<div class="col-md-3 mb-4 border rounded p-3">
					<!-- 여백 추가 -->
					<div class="review-item" data-toggle="modal"
						data-target="#reviewModal${review.reviewNo}">
						<div class="thumbnail">
							<h2>썸네일</h2>
							<%-- <img src="${review.thumbnailUrl}" alt="Thumbnail"> --%>
						</div>
						<div class="details">
							<%-- <p class="title">${review.reviewTitle}</p>
							<p class="viewCount">${review.viewCount }</p>  --%>
							<div class="row">
							    <div class="col-sm-6">
							        <p class="title">${review.reviewTitle}</p>
							    </div>
							    <%-- <div class="col-sm-6 text-right">
							        <span class="viewCount" style="font-size: 11px;">
							            <i class="fas fa-eye"></i> ${review.viewCount}
							        </span>
							    </div> --%>
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

		<!-- 모달 창 -->
		<jsp:include page="./modules/reviewModal.jsp"></jsp:include>

		<!-- 페이징 영역 -->
		<jsp:include page="modules/pagination.jsp"></jsp:include>

	</div>

	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>

	<!-- Bootstrap JavaScript 파일 링크 추가 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
	
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
    function showInsertForm() {
        // 모달 창 표시
        $("#myModal").css("display", "block");
    }
    
/* 	function showInsertForm() {
		// 리뷰 작성하기 페이지 이동
		location.href="/review/insert.ft"; 
	}*/
	
	</script>
</body>
</html>