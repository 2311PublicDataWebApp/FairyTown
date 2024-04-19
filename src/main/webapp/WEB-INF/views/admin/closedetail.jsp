<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 휴무일 정보</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="/admin/closeregist.ft" method="post" name="closeForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>운휴정보</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>휴무일 상세정보</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
			<input type="hidden" name="rideId" value="rideId">
				<table class="table_close">
					<tr>
						<td>놀이기구명 <sup style="color: red">*</sup>: </td>
						<td>
							<span>${close.rideName }</span>
						</td>
					</tr>
					<tr>
						<td>날짜 <sup style="color: red">*</sup>: </td>
						<td><span>${close.closeDate }</span>
					</tr>
					<tr>
						<td>사유 : </td>
						<td>
							<span>${close.closeReason }</span>
							
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="reset" value="이전으로" onClick="goBack();">
							<input type="button" value="수정하기" onclick="modifyClose(${close.rideId});">
							<input type="button" value="삭제하기" onclick="deleteClose(${close.rideId});">
						</td>
					</tr>
				</table>
			</div>
		</form>
	
		<script>
		//상세 페이지 사용 JS : Checkalert(),goBack()
		
			function deleteClose(rideId){
					if(confirm("삭제하시겠습니까?")){
						location.href = "/admin/closedelete.ft?rideId="+rideId;
						alert("정상적으로 삭제되었습니다.");
					}else{
						alert("삭제를 취소하셨습니다.");
					}
				}

			function modifyClose(rideId){
						location.href = "/admin/closemodify.ft?rideId="+rideId;
				}
		
		
			function goBack() {
				history.back();
			}

	
			
		
		</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>