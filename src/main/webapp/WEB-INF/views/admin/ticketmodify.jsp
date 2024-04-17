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

		<form action="/admin/ticketmodify.ft" method="post" name="ticketForm" enctype="multipart/form-data">
			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>티켓 관리</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>티켓 수정</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<input type="hidden" name="ticketNo" value="${ticket.ticketNo }">
				<input type="hidden" name="ticketImgNo" value="${ticket.ticketImgNo }">
				<input type="hidden" name="ticketImgName" value="${ticket.ticketImgName }">
				<input type="hidden" name="ticketImgRename" value="${ticket.ticketImgRename }">
				<input type="hidden" name="ticketImgFilepath" value="${ticket.ticketImgFilepath }">
				<input type="hidden" name="ticketImgFilelength" value="${ticket.ticketImgFilelength }">
				
				<table class="table_close">
					<tr>
						<td>티켓명＊ : </td>
						<td>
							<input type="text" name="ticketName" value="${ticket.ticketName }">
						</td>
					</tr>
					<tr>
					<td>티켓설명 : </td>
						<td>
							<textarea cols="50" name="ticketDetail" >${ticket.ticketDetail }</textarea>
						</td>
					</tr>
					<tr>
						<td>제휴카드 : </td>
						<td>
							<input type="text" name="ticketCard" value="${ticket.ticketCard }">
						</td>
					</tr>
					<tr>
						<td>어른가격* : </td>
						<td><input type="number" name="ticketAdult" value="${ticket.ticketAdult }"></td>
					</tr>
					<tr>
						<td>청소년 가격 : </td>
						<td><input type="number" name="ticketTeen" value="${ticket.ticketTeen }"></td>
					</tr>
					<tr>
						<td>어린이 가격 : </td>
						<td><input type="number" name="ticketChild" value="${ticket.ticketChild }"></td>
					</tr>
					<tr>
						<td>사용상태 : </td>
						<td>  
							<input type="checkbox" id="using" value="Y" name="ticketStatus" onClick='checkOnlyOne(this)' <c:if test="${ticket.ticketStatus eq 'Y'}">checked</c:if>>
  							<label for="using">사용함</label>
  							<input type="checkbox" id="discard"  value="N" name="ticketStatus" onClick='checkOnlyOne(this)' <c:if test="${ticket.ticketStatus eq 'N'}">checked</c:if>>
  							<label for="discard">사용안함</label>
  						</td>
					</tr>
					<tr>
						<td>이미지 : </td>
						<td>
							<img src="../resources/nuploadFiles/${ticket.ticketImgRename }" alt="이미지"><br>
							<input type="file" name="reloadFile">
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="reset" value="이전으로" onClick="goBack();">
							<input type="submit" value="수정하기" onclick="return submitAlert();">
							<input type="button" value="삭제하기" onclick="deleteTicket(${ticket.ticketNo});">
						</td>
					</tr>
				</table>
			</div>
		</form>
	<script>
		//수정 페이지 사용 JS : goBack(), Checkform(), submitAlert(),checkOnlyOne()
	
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
			if(confirm("수정하시겠습니까?")){
				return true;
			} else{
				return false;
			}
		}
		
		function deleteTicket(ticketNo){
			if(confirm("삭제하시겠습니까?")){
				location.href = "/admin/ticketdelete.ft?ticketNo="+ticketNo;
				alert("정상적으로 삭제되었습니다.");
			}else{
				alert("삭제를 취소하셨습니다.");
			}
		}
		
		</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>