<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:forEach items="${myReviewList}" var="review" varStatus="status">
	<div class="modal fade" id="reviewModal${review.reviewNo}"
		tabindex="-1" role="dialog"
		aria-labelledby="reviewModalLabel${review.reviewNo}"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content" style="font-size: 14px;">
				<!-- 모달 내용 -->
				<div class="modal-body">
					<div class="row">
						<!-- 왼쪽 영역: 사진 -->
<div class="col-md-6" style="position: relative; overflow: hidden;">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <!-- 슬라이드 추가 -->
            <c:forEach items="${review.images}" var="image">
                <div class="swiper-slide">
                    <img src="../resources/ruploadFiles/${image.fileRename}">
                </div>
            </c:forEach>
        </div>
        <!-- 추가적인 Swiper 컨트롤러 등을 넣을 수 있음 -->
        <div class="swiper-pagination"></div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: black; z-index: -1;"></div>
</div>						
<%-- 						<div class="col-md-6">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <!-- 슬라이드 추가 -->
                                    <c:forEach items="${review.images}" var="image">
                                        <div class="swiper-slide">
                                            <img src="../resources/ruploadFiles/${image.fileRename}">
                                        </div>
                                    </c:forEach>
                                </div>
                                <!-- 추가적인 Swiper 컨트롤러 등을 넣을 수 있음 -->
                                <div class="swiper-pagination"></div>
                                <div class="swiper-button-prev"></div>
                                <div class="swiper-button-next"></div>
                            </div>
						</div> --%>
						<!-- 오른쪽 영역: 텍스트 -->
						<div class="col-md-6">
                            <div class="modal-text-content" style="padding: 30px;">
                                <!-- 티켓 유형, 조회수 -->
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="icon-container" style="display: flex; align-items: center;">
                                        <img src="../resources/dist/img/mainLogo.png" alt="Main Logo" class="icon" style="width: 34px; height: 34px; margin-right: 5px;">
                                        <p class="ticket-type" style="font-size: 14px; color: #7B848D; margin: 0; font-weight: bold;">${review.ticketType}</p>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <strong>조회수 :</strong>&nbsp; <span id="viewCount_${review.reviewNo}" style="font-size: 12px;  margin: 0;">${review.viewCount}</span>
                                    </div>
                                </div>
                                <!-- 작성자, 작성일, 구매옵션 영역 -->
                                <div class= "textbox1" style="background-color: #F8F9FA; padding: 10px; margin-bottom: 10px; font-size:12px">
                                    <!-- 작성자, 작성일 -->
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <!-- 작성자 -->
                                        <%-- <c:choose>
										    <c:when test="${not empty review.userId}"> --%>
										        <p style="font-weight:bold;">${review.realName}</p>
										    <%-- </c:when>
										    <c:otherwise>
										        <p style="font-weight:bold;">페어리용자</p>
										    </c:otherwise>
										</c:choose> --%>
                                         
                                        <!-- 작성일 -->
                                        <p>${review.reviewDate}</p>
                                    </div>
                                    <!-- 구매옵션 -->
                                    <p><span style="color: #7B848D;">구매옵션</span> &nbsp;&nbsp; ${review.ticketType}</p>
                                </div>
                                <!-- 구분선 (위) -->
                                <hr style="border-top: 2px solid #ddd; margin-top: 15px; margin-bottom: 15px;">
                                <!-- 본문 영역 -->
                                <div>
                                    <br>
                                    <p>${review.reviewContent}</p>
                                </div>
                                <!-- 구분선 (아래) -->
                                <hr style="border-top: 2px solid #ddd; margin-top: 15px; margin-bottom: 15px;">
                                <br>
                                <!-- 유용해요 -->
                                
                                <!-- 유용해요와 수정삭제 버튼을 가로로 배치하는 부분 -->
                                <div class="row mt-3">
                                    <div class="col-md-12 d-flex justify-content-between align-items-center">
                                        <!-- 유용해요 버튼 -->
                                        <div class="like-button-container" onclick="toggleLike(this, ${review.reviewNo})">
                                            <i class="far fa-heart like-button" data-review-no="${review.reviewNo}" data-like-count="${review.likeCount}"></i> <span class="like-text">유용해요</span> <span class="like-count">${review.likeCount}</span>
                                        </div>
                                        <!-- 수정 삭제 버튼 -->
                                        <div>
                                            <!-- 리뷰 수정 버튼 -->
                                            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="modifyReview(${review.reviewNo});">수정</button>
                                            <!-- 리뷰 삭제 버튼 -->
                                            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="deleteReview(${review.reviewNo});">삭제</button>
                                        </div>
                                    </div>
                                </div>
                                
								<!-- 이전 페이지로 이동하는 버튼 -->
<%-- 								<button type="button" class="btn btn-primary" onclick="goToPreviousPage(${currentPage})">이전으로</button> --%>
								
								<!-- 다음 페이지로 이동하는 버튼 -->
<%-- 								<button type="button" class="btn btn-primary" onclick="goToNextPage(${currentPage})">다음으로</button>                              --%>
								                                
                            </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</c:forEach>