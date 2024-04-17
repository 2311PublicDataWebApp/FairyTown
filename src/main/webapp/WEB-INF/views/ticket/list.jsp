<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<!--  타이틀 영역 -->
			<div class="Title">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>티켓 관리</h2></td> 
					</tr>
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
										<td>
										<a href="/ticket/detail.ft?ticketNo=${ticket.ticketNo}">
										<img src="../resources/nuploadFiles/${ticket.ticketImgRename }" alt="이미지"></a><br>
										</td>
										<td>
											<ul style="list-style-type:none;">
												<li>${ticket.ticketName}</li>
												<li>${ticket.ticketDetail}</li>
												<li>${ticket.ticketAdult }</li>
												<li>${ticket.ticketCard }</li>
											</ul>
										</td>
										<td>
											<ul style="list-style-type:none;">
												<li><input type="hidden" name="ticketNo" value="${ticket.ticketNo} "></li>
												<li></li>
												<li><input type="button"  onClick="showTicketing(${ticket.ticketNo});" value="구매하기"></li>
											</ul>
										</td>
									</tr>
								
								</c:forEach>

									<tr class="pgn">
									    <td colspan="3">
									        <c:if test="${pi.startNavi ne 1}">
									            <a href="/ticket/list.ft?page=${pi.startNavi - 1}">[이전]</a>
									        </c:if> 
									        <c:forEach begin="${pInfo.startNavi}" end="${pi.endNavi}" var="p">
									            <a href="/ticket/list.ft?page=${p}">${p}</a>
									        </c:forEach> 
									        <c:if test="${pi.endNavi ne pi.naviTotalCount}">
									            <a href="/ticket/list.ft?page=${pi.endNavi + 1}">[다음]</a>
									        </c:if>
									    </td>
									</tr>	
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
	
	</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>