<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 놀이기구</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="/admin/rideregist.ft" method="post" name="rideForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>기구 등록</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<table class="table_ride">
					<tr>
						<td>놀이기구명 : </td>
						<td><input type="text" name="rideName" placeholder="놀이기구 이름을 입력해주세요"></td>
					</tr>
					<tr>
						<td>설명 : </td>
						<td><input type="text" name="rideDescription"></td>
					</tr>
					<tr>
						<td>탑승인원 : </td>
						<td><input type="number" name="rideCount"></td>
					</tr>
					<tr>
						<td>탑승제한 : </td>
						<td><input type="text" name="rideLimit"></td>
					</tr>
					<tr>
						<td>운휴정보 : </td>
						<td><input type="text" name="rideStatus"></td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td><input type="file" name="rideImgName"></td>
					</tr>	
					<tr>
						<td>X좌표 : </td>
						<td><input type="text" name="rideX" placeholder="소수점 포함 12자까지 입력 가능합니다."></td>
					</tr>
					<tr>
						<td>Y좌표 : </td>
						<td><input type="text" name="rideY" placeholder="소수점 포함 12자까지 입력 가능합니다."></td>
					</tr>
				</table>
				
				<input type="reset" value="이전으로" onClick="goBack();">
				<input type="submit" value="등록하기">
			</div>
			
		</form>
	
	
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script>
			// 상세 페이지 사용 JS : goBack(),showModify()
				function goBack(){
				history.back();
			}
			
			
			</script>
</body>
</html>