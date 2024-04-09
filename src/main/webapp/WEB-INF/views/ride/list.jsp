<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>놀이기구 조회</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="admin/ridelist.ft" method="post" name="rideForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>기구 조회</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				
				<table class="table_ride_list">
					<tr>
						<th>번호</th>
						<th>놀이기구명</th>
						<th>탑승제한</th>
						<th>운휴상태</th>
						<th>등록일</th>
					</tr>
				
					<tr>
						<td>설명 : </td>
						<td><input type="text" name="rideDescription" value="${ride.rideDescription}"></td>
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