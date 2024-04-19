<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="/ride/detail.ft" method="post" name="rideForm">
			
		<!-- 타이틀 영역 -->
			<div class="Title">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>놀이기구 상세</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
<!-- 			<input type="hidden" name="rideNo" value="rideNo"> -->
				<table class="table_ride">
					<tr>
						<td>놀이기구명＊ : </td>
						<td>
							<span>${ride.rideName }</span>
						</td>
					</tr>
					<tr>
						<td>놀이기구설명 : </td>
						<td><span>${ride.rideDetail }</span>
					</tr>
					<tr>
						<td>제휴카드 : </td>
						<td>
							<span>${ride.rideCard }</span>
						</td>
					</tr>
					
					<tr>
						<td>어른 가격* : </td>
						<td>
							<span>${ride.rideAdult}</span>
						</td>
					</tr>
					<tr>
						<td>청소년 가격 : </td>
						<td>
							<span>${ride.rideTeen}</span>
						</td>
					</tr>
					<tr>
						<td>어린이 가격 : </td>
						<td>
							<span>${ride.rideChild}</span>
						</td>
					</tr>
					<tr>
						<td>사용상태 : </td>
						<td>
							<span>${ride.rideStatus}</span>
						</td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td>
<%-- 							<span>${rImg.rideImgName}</span> --%>
						</td>
					</tr>
					
					
					<tr>
						<td colspan="5">
							<input type="reset" value="이전으로" onClick="goBack();">
							<input type="button" value="예약하기" onClick="showBooking();">
						</td>
					</tr>
				</table>
			</div>
		</form> 
	
		<script>
		//상세 페이지 사용 JS : goBack()
			
			function goBack() {
				history.back();
			}

			function showBooking(rideId){
		        location.href = "/booking/basic.ft";
		    }	
	
		
			
		
		</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>