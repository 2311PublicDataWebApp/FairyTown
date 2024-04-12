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

			
		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
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
				
				<!-- 목록 테이블 -->
				<table class="table_ride_list">
					<tr>
						<td colspan="6"><input type="button" name="ticketregist" onClick="showRegist();" value="티켓 등록"></td>
					</tr>
					
					<tr>
						<td>번호</td>
						<td>티켓이름</td>
						<td>티켓설명</td>
						<td>어른가격</td>
						<td>사용여부</td>
						<td>등록일</td>
					</tr>
					
					<!-- 	등록된 티켓이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(sList) != 0 }">
								<c:forEach items="${sList }" var="ticket" varStatus="i">
									<tr class="ticket_list_tr">
										<td class="list_first_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${i.count }</a>
										</td>
										<td class="list_second_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${ticket.ticketName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${ticket.ticketDetail}</a>
										</td>
										<td class="list_fourth_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${ticket.ticketAdult}</a>
										</td>
										<td class="list_fifth_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${ticket.ticketStatus}</a>
										</td>
										<td class="list_sixth_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }">${ticket.ticketDate}</a>
										</td>
									
									</tr>
								</c:forEach>

								<tr align="center" class="pgn">
									<td colspan="6">
										<c:if test="${pInfo.startNavi ne '1' }">
											<a href="/admin/ticketsearch.ft?page=${pInfo.startNavi - 1 }">[이전]</a>
										</c:if> 
										<c:forEach begin="${pInfo.startNavi }" end="${pInfo.endNavi }" var="p">
											<a href="/admin/ticketsearch.ft?page=${p }">${p }</a>
										</c:forEach> 
											<c:if test="${pInfo.endNavi ne pInfo.naviTotalCount }">
												<a href="/admin/ticketsearch.ft?page=${pInfo.endNavi + 1 }">[다음]</a>
											</c:if>
									</td>
								</tr>
							</c:when>
							
							<c:otherwise>
							<tr>
									<td class="list_fifth_td" colspan="6">
										<p class="nullmsg_search">
											검색 된 티켓이 없습니다.<br>
										</p>
										<input type="button" name="ticketregist" onClick="showRegist();" value="티켓 등록">
											</td>
										</tr>
							</c:otherwise>
						</c:choose>
										
				
			<tr>
				<td colspan="6">
					<div class="search_box">
					    <form class="search_form" action="/admin/ticketsearch.ft" name="search_form" method="post">
							<div class="search_select">
								<select class="form-select" name="searchCondition"  id="searchcon">
									<option value="all" 				<c:if test="${searchCondition == 'all'}">selected</c:if>>전체</option>
									<option value="ticketName"			<c:if test="${searchCondition == 'ticketName'}">selected</c:if>>티켓명</option>
									<option value="ticketStatus"		<c:if test="${searchCondition == 'ticketStatus'}">selected</c:if>>사용상태</option>
								</select>
							</div>	
							
							<div class="search_button">
								<div class="input">
									<input type="search" name="searchKeyword" id="searchKeyword" value="${searchKeyword }">
									<button type="submit" class="btn" onClick="Checkalert();">검색</button>
									<button type="reset" class="btn search_reset"  onClick="removeWord();">초기화</button>
								</div>
							</div>
						</form>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<script>
		
		// 검색 목록 페이지 사용 JS : Checkalert,removeWord(),showRegist()
			function Checkalert() {
				if (search_form.searchKeyword.value == "") {
					search_form.searchKeyword
							.focus();
					alert("검색어를 입력해주세요.");
					return false;

				}
		
				function removeWord(){
				    if( search_form.searchKeyword.value != "" ) {
				    	search_form.searchKeyword.value="";
				    	document.getElementById("searchcon").value = "all";
				     }
				}
				
				function showRegist(){
					location.href = "redirect:/admin/ticketregist";
					}
				}		
	</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	
</body>
</html>