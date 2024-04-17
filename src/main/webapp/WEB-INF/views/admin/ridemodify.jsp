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

		<form action="/admin/ridemodify.ft" method="post" name="rideForm"  enctype="multipart/form-data" onSubmit="return Checkform()">
			
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
				<input type="hidden" name="rideImgNo" value="${ride.rideImgNo }">
				<input type="hidden" name="rideId" value="${ride.rideId }">
				<input type="hidden" name="rideImgName" value="${ride.rideImgName }">
				<input type="hidden" name="rideImgRename" value="${ride.rideImgRename }">
				<input type="hidden" name="rideImgFilepath" value="${ride.rideImgFilepath }">
				<input type="hidden" name="rideImgFilelength" value="${ride.rideImgFilelength }">
				<input type="hidden" name="rideImgThumbnail" value="${ride.rideImgThumbnail }">
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
						<td>  
							<input type="checkbox" id="Available" value="Y" name="rideStatus" onClick='checkOnlyOne(this)' <c:if test="${ride.rideStatus eq 'Y'}">checked</c:if>>
  							<label for="Available">정상운행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
  							<input type="checkbox" id="NotAvailable"  value="N" name="rideStatus" onClick='checkOnlyOne(this)'<c:if test="${ride.rideStatus eq 'N'}">checked</c:if>>
  							<label for="NotAvailable">임시휴무</label>
  						</td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td><input type="file" name="rideImgNo" value="${ride.rideImgName}"></td>
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
				
				<input type="button" value="이전으로" onClick="goBack();">
				<input type="submit" value="수정하기" onClick="submitAlert();">
				<input type="button" value="삭제하기" onClick="deleteRide(${ride.rideId});">
			</div>
		</form>
	
		<script>
			
		function goBack(){
			history.back();
		}
		
		function checkOnlyOne(element) {
			  
			  const checkboxes 
			      = document.getElementsByName("rideStatus");
			  
				  checkboxes.forEach((cb) => {
				    cb.checked = false;
				  })
				  
				  element.checked = true;
			}
		
				
			function deleteRide(rideId)=>{
				location.href="admin/ridedelete.ft?rideId="+rideId;
			}
			
			function Checkform() {

				if (ticketForm.ticketName.value == "") {
					ticketForm.ticketName.focus();
					alert("티켓 이름을 입력해주세요.");
					return false;
				}

				if (ticketForm.ticketAdult.value == "") {
					ticketForm.ticketAdult.focus();
					alert("어른 가격을 등록해주세요.");
					return false;
				}
		}
		
		function submitAlert(){
			if(confirm("등록하시겠습니까?")){
				return true;
			} else{
				return false;
			}
		}
		</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>