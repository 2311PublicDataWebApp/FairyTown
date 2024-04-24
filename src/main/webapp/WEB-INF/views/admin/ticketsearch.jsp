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
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>

			
			<!-- 어드민 타이틀 영역 -->
			<div class="content-wrapper">
		    <section class="content-header">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1>티켓 목록</h1>
		          </div>
		          	<!-- breadcrumb -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">티켓정보</a></li>
							<li class="breadcrumb-item active">티켓 목록</li>
						</ol>
					</div>
					<!-- breadcrumb -->
		        </div>
		      </div>
		    </section>
		
		<!-- 컨텐츠 영역 -->
			<!-- Main content -->
		    <section class="content">
		      <div class="container-fluid">
		        <div class="row">
		          <div class="col-12">
		            <div class="card">
					<div class="card-body">
		                <table id="example2" class="table table-bordered table-hover">
		                  <thead>
		                  <tr>
		          			 <td colspan="6">
		          			 <input type="button" style="margin-left:89%;" class="btn btn-secondary"  name="ticketregist" onClick="showRegist();" value="티켓등록"></td>
		                  </tr>
		                  <tr>
				<th style="width:80px; text-align:center;">번호</th>
						<th style="width:120px; text-align:center;">티켓명</th>
						<th style="width:240px; text-align:center;">티켓설명</th>
						<th style="width:80px; text-align:center;">어른가격</th>
						<th style="width:80px; text-align:center;">사용여부</th>
						<th style="width:80px; text-align:center;">등록일</th>
						</tr>
	                  </thead>
	                  <tbody style="text-align:center;">
							
					
					<!-- 	등록된 티켓이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(sList) != 0 }">
								<c:forEach items="${sList }" var="ticket" varStatus="i">
									<tr class="ticket_list_tr">
										<td class="list_first_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${i.count }</a>
										</td>
										<td class="list_second_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${ticket.ticketName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${ticket.ticketDetail}</a>
										</td>
										<td class="list_fourth_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${ticket.ticketAdult}</a>
										</td>
									<c:set var="tStatus" value="${ticket.ticketStatus }" />
										<c:if test="${tStatus eq 'Y' }">
											<td class="list_fifth_td"><a
												href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">사용중</a></td>
										</c:if>
										<c:if test="${tStatus ne 'Y'}">
											<td class="list_third_td"><a
												href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">사용안함</a></td>
										</c:if>
										<td class="list_sixth_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${ticket.ticketDate}</a>
										</td>
									
									</tr>
								</c:forEach>

								<tr align="center" class="pgn">
									<td colspan="6">
										<c:if test="${pi.startNavi ne '1' }">
											<a href="/admin/ticketsearch.ft?page=${pi.startNavi - 1 }" style="color:black;">[이전]</a>
										</c:if> 
										<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
											<a href="/admin/ticketsearch.ft?page=${p }" style="color:black;">${p }</a>
										</c:forEach> 
											<c:if test="${pi.endNavi ne pi.naviTotalCount }">
												<a href="/admin/ticketsearch.ft?page=${pi.endNavi + 1 }" style="color:black;">[다음]</a>
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
									<button type="submit" class="btn btn-secondary" onClick="Checkalert();">검색</button>
									<input type="button" class="btn btn-default"  onClick="removeWord();" value="초기화"/>
								</div>
									</div>
								</form>
							</div>
						</td> 
					</tr>
                  </tbody>
                  <tfoot>
                </table>
              </div>
			</div>	
		</div>
	</div>
</div>
</section>
</div>
<jsp:include page="../inc/adminfooter.jsp"></jsp:include>

	<script>
		
		// 검색 목록 페이지 사용 JS : Checkalert,removeWord(),showRegist()
			function Checkalert() {
				if (search_form.searchKeyword.value == "") {
					search_form.searchKeyword
							.focus();
					alert("검색어를 입력해주세요.");
					return false;

				}
		}
	
				function removeWord(){
				    if( search_form.searchKeyword.value != "" ) {
				    	search_form.searchKeyword.value="";
				    	document.getElementById("searchcon").value = "all";
				     }
				}
				
				
				function showRegist() {
			        location.href = "/admin/ticketregist.ft";
			    }		
	</script>
	  
	<!-- 공통 / 풋터 -->
	
</body>
</html>