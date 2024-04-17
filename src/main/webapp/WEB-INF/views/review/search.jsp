<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 | 페어리 타운</title>
    <!-- Favicon -->
    <link href="../resources/dist/img/close.png" rel="shortcut icon" type="image/x-icon">
    <!-- Bootstrap CSS 파일 링크 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Font Awesome 아이콘 라이브러리 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
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
</style>
</head>
<body>
<!-- 공통 / 헤더 -->
<jsp:include page="../inc/header.jsp"></jsp:include> 
   	
<div class="container">
    <div class="row">
        <h3><b>리뷰 <span style="opacity: 0.8; font-size: large;">${totalCounts}</span></b></h3>	        
        <h6 style="color: #AAB2B9;">페어리타운 방문객들의 생생한 리뷰를 확인해 보세요.</h6>
        <br><br><br>
        
			<!-- 리뷰 아이템 -->
			<c:forEach items="${sList}" var="review" varStatus="status">
			    <div class="col-md-3 mb-4 border rounded p-3" > <!-- 여백 추가 -->
			        <div class="review-item" data-toggle="modal" data-target="#reviewModal${review.reviewNo}">
			            <div class="thumbnail">
			                <h2>썸네일</h2>
			                <%-- <img src="${review.thumbnailUrl}" alt="Thumbnail"> --%>
			            </div>
			            <div class="details">
			                <p class="title">${review.reviewTitle}</p>
			                <h6 class="date">${review.reviewDate}</h6>
			                <p class="ticket-type">${review.ticketType}</p>
			            </div>
			        </div>
			    </div>
			    <!-- 한 줄에 4개씩 정렬하기 위해, 4번째 열마다 clearfix 클래스 추가 -->
			    <c:if test="${status.index % 4 == 3}">
			        <div class="clearfix"></div>
			    </c:if>
            
            <!-- 모달 창 -->
            <div class="modal fade" id="reviewModal${review.reviewNo}" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel${review.reviewNo}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="reviewModalLabel${review.reviewNo}"></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <!-- 모달 내용 -->
                        <div class="modal-body">
                            <p><strong>리뷰 제목:</strong> ${review.reviewTitle}</p>
                            <p><strong>리뷰 내용:</strong> ${review.reviewContent}</p>
                            <p><strong>작성일:</strong> ${review.reviewDate}</p>
                            <p><strong>티켓 유형:</strong> ${review.ticketType}</p>
							<!-- 유용해요-->
							<div class="like-button-container" onclick="toggleLike(this, ${review.reviewNo})">
							    <i class="far fa-heart like-button" data-review-no="${review.reviewNo}" data-like-count="${review.likeCount}"></i> 
							    <span class="like-text">유용해요</span> 
							    <span class="like-count">${review.likeCount}</span>
							</div>
                            <p><strong>조회수: ${review.viewCount} </strong></p>
                        </div>
                        <!-- 모달 푸터 -->
                        <div class="modal-footer">
<!--                             <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
 -->                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

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
</script>

<!-- 검색 영역 -->
<div class="d-flex flex-wrap justify-content-center align-items-center pb-5">
   <div class="d-flex col-md-6 justify-content-start">
       <form class="row g-1" action="/review/search.ft" method="get">
           <div class="col-auto">
               <select class="form-select" name="searchCondition">
               <option value="all" selected>전체</option>
<!-- 			                <option value="writer">작성자</option> -->
  <option value="title">제목</option>
  <option value="content">내용</option>
  <option value="tickettype">티켓 유형</option>
  
            
               </select>
           </div>
           <div class="col-auto">
               <div class="input-group">
                   <input class="form-control" type="search" name="searchKeyword">
                   <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
                            </div>
                        </div>
                    </form>
                </div>
                
<div class="d-flex col-md-6 justify-content-end">
         	<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showInsertForm();">글쓰기</button>
	</div>
</div>
<!-- ------------------ -->

<!-- 페이징 영역 -->
<div class="row mt-3 mb-5" style="margin-top:300px;">
    <div class="col-md-12">
        <nav aria-label="Page navigation example">                    
            <ul class="pagination justify-content-center" style="font-weight: 600; ">
                <c:if test="${pi.startNavi ne '1' }">
                    <li class="page-item">
                       <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                       </a>
                    </li>
                </c:if>
                <c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
                     <li class="page-item">
                         <a class="page-link rounded-circle mx-2" href="/review/list.ft?page=${p }" style="border: none; color: #313131;">
                             ${p }
                         </a>
                     </li>
                </c:forEach>
                <c:if test="${pi.endNavi ne pi.naviTotalCount }">
                    <li class="page-item">
                         <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.endNavi + 1 }" aria-label="Next">
                             <span aria-hidden="true">&raquo;</span>
                         </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

<!-- 공통 / 풋터 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

<!-- Bootstrap JavaScript 파일 링크 추가 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



</body>
</html>