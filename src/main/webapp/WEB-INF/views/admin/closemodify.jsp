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
<!-- 				<input type="hidden" name="rideId" value="rideId"> -->
				<table class="table_close">
					<tr>
						<td>놀이기구명 <sup style="color: red">*</sup> : </td>
						<td>
								<select class="select_ride" name="rideId"  id="searchcon">
										<option value="all">전체</option>
											<c:if test="${fn:length(close) != 0 }">
												<c:forEach var="close" items="${close}" varStatus="i">
													<option value="${close.rideId}" <c:if test="${rideId == close.rideId}">selected</c:if>>${close.rideName}</option>
												</c:forEach>
											</c:if>
								</select>
						</td>
					
					</tr>
					<tr>
						<td>날짜 <sup style="color: red">*</sup>  : </td>
						<td><input type="date" name="closeDate" value="${close.closeDate }"></td>
					</tr>
					<tr>
						<td>사유 : </td>
						<td>
						<c:set var="cReason" value="${close.closeReason }" />
							<select class="select_ride" name="closeReason" id="searchcon">
							    <c:choose>
							        <c:when test="${closeReason == 'all'}">
							            <option value="all" selected>전체</option>
							        </c:when>
							        <c:when test="${closeReason == 'regular'}">
							            <option value="regular" selected>정기휴무</option>
							        </c:when>
							        <c:when test="${closeReason == 'disaster'}">
							            <option value="disaster" selected>천재지변</option>
							        </c:when>
							        <c:when test="${closeReason == 'outoforder'}">
							            <option value="outoforder" selected>기기수리</option>
							        </c:when>
							        <c:when test="${closeReason == 'vacation'}">
							            <option value="vacation" selected>담당자부재</option>
							        </c:when>
							        <c:when test="${closeReason == 'etc'}">
							            <option value="etc" selected>기타</option>
							        </c:when>
							    </c:choose>
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