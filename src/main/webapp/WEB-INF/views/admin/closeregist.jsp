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
						<td class="titleSecond"><h4>휴무일 등록</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<table class="table_ride">
					<tr>
						<td>놀이기구명＊ : </td>
						<td>
							<div class="select_ride">
								<select class="select_ride" name="rideName"  id="searchcon">
<!-- 								<select class="select_ride" name="searchCondition"  id="searchcon"> -->
									<option value="all">전체</option>
									<option value="flumeRide">후룸라이드</option>
									<option value="gyroDrop">자이로드롭</option>
									<option value="gyroSwing">자이로스윙</option>
									<option value="atlantis">아틀란티스</option>
									<option value="cometExpress">신밧드의 모험</option>
								</select>
							</div>	
						</td>
					</tr>
					<tr>
						<td>날짜* : </td>
						<td><input type="date" name="closeDate"></td>
					</tr>
					<tr>
						<td>사유 : </td>
						<td>
							<select class="select_ride" name="closeReason"  id="searchcon">
<!-- 								<select class="select_ride" name="searchCondition"  id="searchcon"> -->
									<option value="all">전체</option>
									<option value="regular">정기휴무</option>
									<option value="disaster">천재지변</option>
									<option value="outofOrder">기기수리</option>
									<option value="vacation">담당자부재</option>
									<option value="etc">기타</option>
							</select>
						</td>
					</tr>
						<tr>
						<td colspan="5">
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
		//등록 페이지 사용 JS : goBack(), Checkform(), submitAlert()
	
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