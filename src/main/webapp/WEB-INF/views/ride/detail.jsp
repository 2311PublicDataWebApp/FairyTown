<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구</title>
<link rel="stylesheet" type="text/css" href="../resources/css/ride.css">
<style>
body {
	margin: 0 auto;
}
</style>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<form action="/ride/detail.ft" method="post" name="rideForm">
		<input type="hidden" name="rideId" value="${rList.rideId}"> <input
			type="hidden" name="rideName" value="${rList.rideName}"> <input
			type="hidden" name="rideDescription" value="${rList.rideDescription}">
		<input type="hidden" name="rideCount" value="${rList.rideCount}">
		<input type="hidden" name="rideStatus" value="${rList.rideStatus}">
		<input type="hidden" name="rideLimit" value="${rList.rideLimit}">
		<c:if test="${user.userId eq null }">
			<button type="button" class="btn"
				style="background-color: #FAFAFA; border-color: #e9ecef;"
				onclick="showCourse();">나만의 코스</button>
		</c:if>
		<!-- 타이틀 영역 -->
		<table class="title_tbl" align="center">
				<!-- 배너 -->
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style=" z-index:1; margin-top: -155px;margin-top: -155px; width: 1900px; margin-left:-310px;">
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				  </div>
				  <div class="carousel-inner">
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
					  <div class="carousel-inner">
					    <c:forEach var="img" items="${rImg}" begin='0' end='0'>
					      <div class="carousel-item active">
					        <img src="../resources/nuploadFiles/${img.rideImgRename}" style="width: 100%; height: 650px;" alt="...">
					      </div>
					    </c:forEach>
					    <c:forEach var="img" items="${rImg}" begin='1' end='2'>
					      <div class="carousel-item">
					        <img src="../resources/nuploadFiles/${img.rideImgRename}" style="width: 100%; height: 650px;" alt="...">
					      </div>
					      <div class="carousel-item">
					        <img src="../resources/nuploadFiles/${img.rideImgRename}" style="width: 100%; height: 650px;" alt="...">
					      </div>
					    </c:forEach>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div></div></div>
                    	</td>
                    </tr>
			<tr>
				<td colspan="2">
					<div class="attr_title">
						<h2>${rList.rideName }</h2>
					</div>
					<div class="attr_desc">
						<p>${rList.rideDescription }</p>
					</div>
				</td>
			</tr>
			<tr class="attr_all">
				<td align="center"
					style="width: 800px; border-right: 1px solid gray;">
					<div class="attr_desc_left">
						<p>
							탑승 인원 : <b>${rList.rideCount }</b>
						</p>
						<pre style="font-family: suite;'">${rList.rideLimit}</pre>
					</div>
				</td>
				<td align="center">오늘 <b>${rList.rideName }</b> 은/는<br> <c:set
						var="rStatus" value="${rList.rideStatus }" /> <c:if
						test="${rStatus eq 'Y' }">
						<span class="list_fifth_td">정상운행(10:00 ~ 22:00)</span>
					</c:if> <c:if test="${rStatus eq 'N'}">
						<span class="list_third_td">임시휴무</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="desc_btn" style="margin: 100px 0px 0px 45%;">
						<input type="reset" value="이전으로" onClick="goBack();"> <input
							type="submit" value="예약하기" />
						<div id="courseBtn">
							<c:choose>
								<c:when test="${empty cList}">
									<button type="button" id="addCourse_btn" class="btn"
										style="background-color: #FAFAFA; border-color: #e9ecef; margin: 30px 0 0 250px; padding: 10px 10px">코스
										찜</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="deleteCourse_btn" class="btn"
										style="background-color: #ACE0F8; border: none; color: white; margin: 30px 0 0 250px; padding: 10px 10px">코스
										찜</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script>
		//상세 페이지 사용 JS : goBack()

		//상세 페이지 사용 JS : goBack()

		function goBack() {
			history.back();
		}

		function showBooking(rideId) {
			location.href = "/booking/basic.ft";
		}

		function showCourse() {
			location.href = "/ride/course.ft";
		}

		$(document)
				.on(
						"click",
						"#addCourse_btn",
						function() {
							var rideId = $
							{
								rList.rideId
							}
							;

							var data = {
								'rideId' : rideId,
							};

							$
									.ajax({
										url : "/ride/addCourse.ft",
										type : "post",
										data : data,
										success : function(result) {
											var courseBtn = $("#courseBtn");
											courseBtn.html("");
											var btnVal = '<button type="button" id="deleteCourse_btn" class="btn" style="background-color: #ACE0F8; border: none; color:white; margin:30px 0 0 250px; padding: 10px 10px">코스 찜</button>'
											courseBtn.append(btnVal);
										},
										error : function() {

										}
									});
						});
		$(document)
				.on(
						"click",
						"#deleteCourse_btn",
						function() {
							var rideId = $
							{
								rList.rideId
							}
							;

							var data = {
								'rideId' : rideId,
							};

							$
									.ajax({
										url : "/ride/deleteCourse.ft",
										type : "post",
										data : data,
										success : function(result) {
											var courseBtn = $("#courseBtn");
											courseBtn.html("");
											var btnVal = '<button type="button" id="addCourse_btn" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef; margin:30px 0 0 250px; padding: 10px 10px">코스 찜</button>'
											courseBtn.append(btnVal);
										},
										error : function() {

										}
									});
						});
		$("#addCourse_btn").click(function() {
		});
		$("#deleteCourse_btn").click(function() {
		});
	</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>