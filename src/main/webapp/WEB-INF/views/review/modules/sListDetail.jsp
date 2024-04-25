<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${sList}" var="review" varStatus="status">
	<div class="modal fade" id="reviewModal${review.reviewNo}"
		tabindex="-1" role="dialog"
		aria-labelledby="reviewModalLabel${review.reviewNo}"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content" style="font-size: 14px;">
				<!-- 모달 헤더 -->
<%-- 				<div class="modal-header">
					<h5 class="modal-title" id="reviewModalLabel${review.reviewNo}"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div> --%>
				<!-- 모달 내용 -->
				<div class="modal-body">
					<div class="row">
						<!-- 왼쪽 영역: 사진 -->
						<div class="col-md-6">
							<!-- 사진을 표시하는 부분 -->
								
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
								
								
						</div>

						<!-- 오른쪽 영역: 텍스트 -->
						<div class="col-md-6">
							<div class="modal-text-content" style="padding: 30px;"> <!-- 텍스트 전체 영역  -->
								<!-- 티켓 유형, 조회수 -->
								<div
									class="d-flex justify-content-between align-items-center mb-2">
									<p>
										<strong>티켓 유형:</strong> ${review.ticketType}
									</p>
									<p>
										<strong>조회수:</strong> <span id="viewCount_${review.reviewNo}">${review.viewCount}</span>
									</p>
								</div>
								<!-- 작성자, 작성일 -->
								<div
									class="d-flex justify-content-between align-items-center mb-2">
									<!-- 작성자 -->
									<p>khuser01</p>
									<!-- 작성일 -->
									<p>${review.reviewDate}</p>
								</div>
								<!-- 리뷰 제목 -->
								<p>
									<strong>리뷰 제목:</strong> ${review.reviewTitle}
								</p>

								<!-- 구분선 (위) -->
								<hr
									style="border-top: 2px solid #ddd; margin-top: 15px; margin-bottom: 15px;">

								<!-- 본문 영역 -->
								<div>
									<br>
									<p>${review.reviewContent}</p>
								</div>

								<!-- 구분선 (아래) -->
								<hr
									style="border-top: 2px solid #ddd; margin-top: 15px; margin-bottom: 15px;">

								<!-- 유용해요 -->
								<br>
								<div class="like-button-container"
									onclick="toggleLike(this, ${review.reviewNo})">
									<i class="far fa-heart like-button"
										data-review-no="${review.reviewNo}"
										data-like-count="${review.likeCount}"></i> <span
										class="like-text">유용해요</span> <span class="like-count">${review.likeCount}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 모달 푸터 -->
<!-- 				<div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div> -->
			</div>
		</div>
	</div>
</c:forEach>