<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 티켓 관리</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="/admin/ticketregist.ft" method="post" name="ticketForm">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>티켓 관리</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>티켓 등록</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<table class="table_ride">
					<tr>
						<td>티켓명＊ : </td>
						<td>
							<input type="text" name="ticketName" placeholder="티켓명을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<td>티켓설명 : </td>
						<td>
							<textarea cols="50" name="ticketDetail" >티켓 설명을 입력해주세요.</textarea>
						</td>
					</tr>
					<tr>
						<td>제휴카드 : </td>
						<td>
							<input type="text" name="ticketCard" placeholder="제휴 카드를 등록해주세요">
						</td>
					</tr>
					<tr>
						<td>어른가격* : </td>
						<td><input type="number" name="ticketAdult"></td>
					</tr>
					<tr>
						<td>청소년 가격 : </td>
						<td><input type="number" name="ticketTeen"></td>
					</tr>
					<tr>
						<td>어린이 가격 : </td>
						<td><input type="number" name="ticketChild"></td>
					</tr>
					<tr>
						<td>사용상태 : </td>
						<td>  
							<input type="checkbox" id="usingTicket" value="usingTicket" name="ticketStatus" onClick='checkOnlyOne(this)' checked>
  							<label for="usingTicket">사용함</label>
  							<input type="checkbox" id="discardTicket"  value="discardTicket" name="ticketStatus" onClick='checkOnlyOne(this)'>
  							<label for="discardTicket">사용안함</label>
  						</td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td>
							<input type="file" name="uploadFile">
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
		//등록 페이지 사용 JS : goBack(), Checkform(), submitAlert(),checkOnlyOne()
		
		function checkOnlyOne(element) {
  
		  const checkboxes 
		      = document.getElementsByName("ticketStatus");
		  
			  checkboxes.forEach((cb) => {
			    cb.checked = false;
			  })
			  
			  element.checked = true;
		}
	
		function goBack() {
			history.back();
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