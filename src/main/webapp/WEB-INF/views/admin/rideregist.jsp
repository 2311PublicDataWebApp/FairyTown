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

	<form action="/admin/rideregist.ft" method="post" name="rideForm"
		enctype="multipart/form-data" onSubmit="return Checkform()">

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
					<td>놀이기구명 <sup style="color: red">*</sup> :
					</td>
					<td><input type="text" name="rideName"
						placeholder="놀이기구명을 입력해주세요"></td>
				</tr>
				<tr>
					<td>설명 :</td>
					<td><input type="text" name="rideDescription"></td>
				</tr>
				<tr>
					<td>탑승인원 :</td>
					<td><input type="number" name="rideCount" style="width: 50px;"
						value="0">&nbsp; 명</td>
				</tr>
				<tr>
					<td>탑승제한 <sup style="color: red">*</sup> :
					</td>
					<td><input type="text" name="rideLimit"></td>
				</tr>
				<tr>
					<td>운휴정보 :</td>
					<td><input type="checkbox" id="Available" value="Y" name="rideStatus" onClick='checkOnlyOne(this)' checked> 
						<label for="Available">정상운행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
						<input type="checkbox" id="NotAvailable" value="N" name="rideStatus" onClick='checkOnlyOne(this)'> 
						<label for="NotAvailable">임시휴무</label></td>
				</tr>
				<tr id="fileInputs">
					<td>첫번째 이미지 :</td>
					<td>
						<input type="file" name="uploadFile">
						<button type="button" onclick="addFileInput();">파일 추가</button>
					</td>
				</tr>

			
					<tr>
					<td>X좌표 :</td>
					<td><input type="text" name="rideX"
						placeholder="소수점 포함 12자까지 입력 가능합니다."></td>
				</tr>
				<tr>
					<td>Y좌표 :</td>
					<td><input type="text" name="rideY"
						placeholder="소수점 포함 12자까지 입력 가능합니다."></td>
				</tr>
			</table>

			<input type="reset" value="이전으로" onClick="goBack();"> <input
				type="submit" value="등록하기" onClick="submitAlert();">
		</div>

	</form>


	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<script>
			// 상세 페이지 사용 JS : goBack(),submitAlert(), Checkform()

				var maxFileInputs = 3; // 최대 파일 입력란 개수
		var fileInputCount = 1; // 현재 파일 입력란 개수

		function addFileInput() {
			if (fileInputCount < maxFileInputs) {
				var fileInputsDiv = document.getElementById("fileInputs");
				var newFileInput = document.createElement("input");
				newFileInput.type = "file";
				newFileInput.name = "uploadFile"; // 이 이름은 서버에서 파일을 처리할 때 사용됩니다.
				var newRow = document.createElement("tr");
				var newTd1 = document.createElement("td");
				var newTd2 = document.createElement("td");
				newTd1.textContent = "추가이미지 :";
				newTd2.appendChild(newFileInput);
				newRow.appendChild(newTd1);
				newRow.appendChild(newTd2);
				fileInputsDiv.parentNode.insertBefore(newRow, fileInputsDiv.nextSibling);
				fileInputCount++;
			} else {
				alert("최대 " + maxFileInputs + "개까지만 추가할 수 있습니다.");
			}
		}
		
		function checkOnlyOne(element) {
			  
			  const checkboxes 
			      = document.getElementsByName("rideStatus");
			  
				  checkboxes.forEach((cb) => {
				    cb.checked = false;
				  })
				  
				  element.checked = true;
			}
		
			function goBack(){
				history.back();
			}
		
			function Checkform() {

				if (rideForm.rideName.value == "") {
					rideForm.rideName.focus();
					alert("놀이기구 이름을 입력해주세요.");
					return false;
				} 
				if (rideForm.rideLimit.value == "") {
					rideForm.rideLimit.focus();
					alert("탑승 제한을 등록해주세요.");
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
</body>
</html>