<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구 수정 및 삭제</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="admin/ridemodify.ft" method="post" name="rideForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>기구 수정 및 삭제</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<input type="hidden" name="rideNo">
				<table class="table_ride">
					<tr>
						<td>놀이기구명 : </td>
						<td><input type="text" name="rideName" value="${ride.rideName}"></td>
					</tr>
					<tr>
						<td>설명 : </td>
						<td><input type="text" name="rideDescription" value="${ride.rideDescription}"></td>
					</tr>
					<tr>
						<td>탑승인원 : </td>
						<td><input type="number" name="rideCount" value="${ride.rideCount}"></td>
					</tr>
					<tr>
						<td>탑승제한 : </td>
						<td><input type="text" name="rideLimit" value="${ride.rideLimit}"></td>
					</tr>
					<tr>
						<td>운휴정보 : </td>
						<td><input type="text" name="rideClose" value="${ride.rideClose}"></td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td><input type="file" name="rideImgNo" value="${ride.rideImgNo}"></td>
					</tr>	
					<tr>
						<td>X좌표 : </td>
						<td><input type="text" name="rideX"  value="${ride.rideX}"></td>
					</tr>
					<tr>
						<td>Y좌표 : </td>
						<td><input type="text" name="rideY"  value="${ride.rideY}"></td>
					</tr>
				</table>
				
				<input type="reset" value="이전으로">
				<input type="submit" value="수정하기">
				<input type="button" value="삭제하기" onClick="deleteRide(${ride.rideNo});">
			</div>
		</form>
	
		<script>
			function deleteRide(rideNo)=>{
				location.href="ridedelete"
			}
		</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>