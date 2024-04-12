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

		<form action="/admin/closemodify.ft" method="post" name="closeForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>운휴정보</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>휴무일 수정</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<input type="hidden" name="closeNo" value="closeNo">
				<table class="table_close">
					<tr>
						<td>놀이기구명＊ : </td>
						<td>
							<div class="select_ride">
								<select class="select_ride" name="rideName"  id="searchcon" value="${ride.rideName}">
<!-- 								<select class="select_ride" name="searchCondition"  id="searchcon"> -->
									<option value="all" 			<c:if test="${#searchcon == 'all'}">selected</c:if>>전체</option>
									<option value="flumeRide"		<c:if test="${#searchcon == 'flumeRide'}">selected</c:if>>후룸라이드</option>
									<option value="gyroDrop"		<c:if test="${#searchcon == 'gyroDrop'}">selected</c:if>>자이로드롭</option>
									<option value="gyroSwing"		<c:if test="${#searchcon == 'gyroSwing'}">selected</c:if>>자이로스윙</option>
									<option value="atlantis"		<c:if test="${#searchcon == 'atlantis'}">selected</c:if>>아틀란티스</option>
									<option value="cometExpress"	<c:if test="${#searchcon == 'cometExpress'}">selected</c:if>>신밧드의 모험</option>
								</select>
							</div>	
						</td>
					</tr>
					<tr>
						<td>날짜* : </td>
						<td><input type="date" name="closeDate" value="${ride.closeDate }"></td>
					</tr>
					<tr>
						<td>사유 : </td>
						<td>
							<select class="select_ride" name="closeReason"  id="searchcon">
<!-- 								<select class="select_ride" name="searchCondition"  id="searchcon"> -->
									<option value="all"			<c:if test="${#searchcon == 'all'}">selected</c:if>>전체</option>
									<option value="regular"		<c:if test="${#searchcon == 'regular'}">selected</c:if>>정기휴무</option>
									<option value="disaster"	<c:if test="${#searchcon == 'disaster'}">selected</c:if>>천재지변</option>
									<option value="outofOrder"	<c:if test="${#searchcon == 'outofOrder'}">selected</c:if>>기기수리</option>
									<option value="vacation"	<c:if test="${#searchcon == 'vacation'}">selected</c:if>>담당자부재</option>
									<option value="etc"			<c:if test="${#searchcon == 'etc'}">selected</c:if>>기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="reset" value="이전으로" onClick="goBack();">
							<input type="submit" value="등록하기" onclick="return submitAlert();">
						</td>
					</tr>
				</table>
			</div>
		</form>
	<script>
		//수정 페이지 사용 JS : goBack(), Checkform(), submitAlert()
	
		function goBack() {
			history.back();
		}

		function Checkform() {

				if (closeForm.rideName.value == "all") {

					closeForm.rideName.focus();
					alert("놀이기구를 선택해주세요.");

					return false;

				}

				if (closeForm.closeReason.value == "all") {

					closeForm.closeReason.focus();
					alert("사유를 선택해주세요.");

					return false;

				}
				if (closeForm.closeDate.value == "") {

					closeForm.closeDate.focus();
					alert("날짜를 선택해주세요.");

					return false;

				}
		}
		
		function submitAlert(){
			if(confirm("수정하시겠습니까?")){
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