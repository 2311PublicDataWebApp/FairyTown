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
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<div class="all_list">
		<!--  타이틀 영역 -->
		<div class="title">
			<table class="title_tbl">
				<tr>
					<td class="titleFirst"><h2>놀이기구</h2></td>
				</tr>
			</table>
		</div>

		<!-- 컨텐츠 영역 -->
		<div class="content_top">

				<p class="title_rotate">대표!</p>
			<div class="imgbox">
				
				<div class="img_first">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> 
					<c:forEach var="img" items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 363px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>대표첫번째</p>
						</div>
					</a>
				</div>

				<div class="img_second">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 363px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>대표두번째</p>
						</div>
					</a>
				</div>

				<div class="img_third">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 363px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>대표세번째</p>
						</div>
					</a>
				</div>
			</div>
		</div>

 		<hr style="margin:8rem 3rem 4rem 22rem; width:58%;">
		<h4>전체 놀이기구</h4>
		<!-- 목록 영역 -->
		<div class="content_mid">
			<div class="content_item_box">
				<div class="img_first">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체첫번째</p>
						</div>
					</a>
				</div>

				<div class="img_second">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체두번째</p>
						</div>
					</a>
				</div>

				<div class="img_third">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체세번째</p>
						</div>
					</a>
				</div>
				
			</div>
			
			
			<div class="content_item_box cit_bottom">
				<div class="img_first">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체네번째</p>
						</div>
					</a>
				</div>

				<div class="img_second">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체다섯번째</p>
						</div>
					</a>
				</div>

				<div class="img_third">
					<a href="/ride/detail.ft?rideId=${ride.rideId }"> <c:forEach var="img"
							items="${rImg}">
							<img src="../resources/nuploadFiles/${img.rideImgRename}"
								style="width: 264px; height: 180px;" alt="이미지">
						</c:forEach>
						<div class="hover">
							<p>전체여섯번째</p>
						</div>
					</a>
				</div>
				
			
			</div>
				<div class="categories_more">
				<a href="#">
					Load More
				</a>
				</div>
		</div>
	</div>


	</div>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>