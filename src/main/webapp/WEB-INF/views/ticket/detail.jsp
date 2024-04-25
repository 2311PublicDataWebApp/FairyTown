<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓</title>
<link rel="stylesheet" type="text/css" href="../resources/css/ride.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<form action="/ticket/detail.ft" method="post" name="ticketForm">
			
		<!-- 타이틀 영역 -->
			<div class="Title">
				<table class="title_tbl">
					<tr>
						<td class="titleSecond"><h4>티켓 상세</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
			<input type="hidden" name="ticketNo" value="${ticket.ticketNo }">
				<table class="table_ticket_detail">
					<tr>
						<td style="width:60%; text-align:center;">
						<img src="../resources/nuploadFiles/${ticket.ticketImgRename }" alt="이미지">
						</td>
						<td>
						<ul style="list-style:none;">
						<li style="font-size:1.5rem;"><b>${ticket.ticketName }</b></li>
						<li>${ticket.ticketDetail }</li>
						<li>${ticket.ticketCard }</li>
						<li>어른 : <fmt:formatNumber value="${ticket.ticketAdult}" type="number" pattern="#,##0"/>원</li>
						<li>청소년 : <fmt:formatNumber value="${ticket.ticketTeen}" type="number" pattern="#,##0"/>원</li>
						<li>유아 : <fmt:formatNumber value="${ticket.ticketChild}" type="number" pattern="#,##0"/>원</li>
						</ul>
						</td>
					</tr>
					
					<tr>
						<td colspan="5" align="center" style="padding-left:35%;" >
							<input type="reset" value="이전으로" class="btn btn-secondary" onClick="goBack();">
							<input type="button"  class="btn btn-dark" onClick="showTicketing(${ticket.ticketNo});" value="구매하기">
						</td>
					</tr>
				</table>
			</div>
		</form> 
	
		<script>
		//상세 페이지 사용 JS : showTicketing(), goBack()
			
			function goBack() {
				history.back();
			}
		
			function showTicketing(ticketNo){
				 location.href = "/ticketing/regist.ft?ticketNo="+ticketNo;
		    }	
	
			
		
		</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>