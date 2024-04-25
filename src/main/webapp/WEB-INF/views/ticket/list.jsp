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

		<!--  타이틀 영역 -->
			<div class="Title">
				<table class="title_tbl">
					<tr>
						<td class="titleSecond"><h4>티켓 목록</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				<!-- 목록 영역 -->
				<table class="table_ticket_list">
									
					<!-- 	등록된 티켓이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(tList) != 0 }">
								<c:forEach items="${tList }" var="ticket" varStatus="i">
										<tr>
										<td align="left" style="width:10%">
										<a href="/ticket/detail.ft?ticketNo=${ticket.ticketNo}">
										<img src="../resources/nuploadFiles/${ticket.ticketImgRename }" alt="이미지"></a><br>
										</td>
										<td  style="color: black; width:45%">
										<a href="/ticket/detail.ft?ticketNo=${ticket.ticketNo}">
											<ul style="list-style-type:none;">
												<li style="color:black;"><h3>${ticket.ticketName}</h3></li>
												<li style="color:black; width:80%;">${ticket.ticketName}은? <br>${ticket.ticketDetail}</li>
											<li style="color:black;">어른 기준 가격 : <fmt:formatNumber value="${ticket.ticketAdult}" type="number" pattern="#,##0"/> 원</li>
												   <c:choose>
									                <c:when test="${empty ticket.ticketCard}" >
									                    제휴카드 : 없음
									                </c:when>
									                <c:otherwise>
									                    제휴카드 : ${ticket.ticketCard }
									                </c:otherwise>
									            </c:choose>
											</ul>
											</a>
										</td>
										<td>
											<ul style="list-style-type:none;">
												<li><input type="hidden" name="ticketNo" value="${ticket.ticketNo} "></li>
												<li></li>
												<li><input type="button" class="btn  btn-outline-secondary" style="font-size:1.2rem; padding:10px 15px;" onClick="showDetail(${ticket.ticketNo});" value="상세보기"></li>
												<li><input type="button" class="btn btn-dark" style="font-size:1.2rem; margin-top:10px; padding:10px 15px;" onClick="showTicketing(${ticket.ticketNo});" value="구매하기"></li>
											</ul>
										</td>
									</tr>
								
								</c:forEach>

							</c:when>
							<c:otherwise>
								<tr>
									<td class="list_fifth_td" colspan="3">
										<p class="nullmsg_list">
											판매 중인 티켓이 없습니다.<br>
										</p>
										<input type="button" name="showMain" onClick="showMain();" value="구경하러 가기">
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
				</table>
			</div>
	<script>
		
		//티켓 페이지 사용 JS : showMain()
			function showMain() {
		        location.href = "/";
		    }	
	
			function showTicketing(ticketNo){
		        location.href = "/ticketing/regist.ft?ticketNo="+ticketNo;
		    }	
			
			function showDetail(ticketNo){
		        location.href = "/ticket/detail.ft?ticketNo="+ticketNo;
		    }	
	
	
	</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>