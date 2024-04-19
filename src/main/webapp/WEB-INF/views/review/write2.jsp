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
/*  #review-h1 {
		        text-align: left;
		        } */ /* 리뷰 등록 텍스트 중앙 정렬 */
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

			<form action="/review/insert.ft" method="post"
				enctype="multipart/form-data">

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
							<input type="text" class="form-control" name="reviewTitle"
								placeholder="제목을 입력하세요">
						</div>
					</div>
				</div>
				    <div class="swiper-container">
        <div class="swiper-wrapper">
            <!-- 이미지 슬라이드를 추가할 위치 -->
        </div>
        <!-- 추가적인 Swiper 컨트롤러 등을 넣을 수 있음 -->
    </div>
				<div class="mb-3" style="margin-top: -20px;">
					<label for="exampleFormControlTextarea1" class="form-label"></label>
					<textarea class="form-control" name="reviewContent"
						id="reviewContent" rows="6"></textarea>
				</div>
				<div class="d-flex justify-content-center">
					<button type="submit" class="btn"
						style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
				</div>
			</form>
		</div>
	</div>

    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <!-- 슬라이드를 생성하고 설정하는 스크립트 -->
    <script src="script.js"></script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>