<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 티켓 관리</title>
<!-- DataTables -->
	<link rel="stylesheet" href="../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
<!-- Content Header -->
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
					<li class="breadcrumb-item"><a href="#">티켓 관리</a></li>
					<li class="breadcrumb-item active">티켓 목록</li>
				</ol>
			</div>
			<!-- breadcrumb -->
        </div>
      </div>
    </section>
		
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
          			 <input type="button" class="btn btn-secondary" style="margin-left:89%;" name="ticketregist" onClick="showRegist();" value="티켓등록"></td>
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
							<c:when test="${fn:length(tList) != 0 }">
								<c:forEach items="${tList }" var="ticket" varStatus="i">
									<tr class="ticket_list_tr">
										<td class="list_first_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${i.count }</a>
										</td>	
										<td class="list_second_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">${ticket.ticketName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/ticketdetail.ft?ticketNo=${ticket.ticketNo }" style="color:black;">
											<c:choose>
									            <c:when test="${fn:length(ticket.ticketDetail) > 50}">
									                ${fn:substring(ticket.ticketDetail, 0, 70)}...
									            </c:when>
									            <c:otherwise>
									                ${ticket.ticketDetail}
									            </c:otherwise>
									        </c:choose></a>
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


								<tr class="pgn">
								    <td colspan="6">
								        <c:if test="${pi.startNavi ne 1}">
								            <a href="/admin/ticketlist.ft?page=${pi.startNavi - 1}" style="color:black;">[이전]</a>
								        </c:if> 
								        <c:forEach begin="${pi.startNavi}" end="${pi.endNavi}" var="p">
								            <a href="/admin/ticketlist.ft?page=${p}" style="color:black;">${p}</a>
								        </c:forEach> 
								        <c:if test="${pi.endNavi ne pi.naviTotalCount}">
								            <a href="/admin/ticketlist.ft?page=${pi.endNavi + 1}">[다음]</a>
								        </c:if>
								    </td>
								</tr>	
							</c:when>
						
							<c:otherwise>
								<tr>
									<td class="list_fifth_td" colspan="6">
										<p class="nullmsg_list">
											등록된 티켓이 없습니다.<br>
										</p>
										<input type="button" name="ticketregist"  class="btn btn-secondary" onClick="showRegist();" value="티켓 등록">
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
											<option value="all">전체</option>
											<option value="ticketName">티켓명</option>
											<option value="ticketStatus">사용상태</option>
										</select>
									</div>	
									
									<div class="search_button">
										<div class="input">
											<input type="search" name="searchKeyword" placeholder="검색어를 입력해주세요">
											<button type="submit" class="btn btn-secondary" onClick="return Checkalert();">검색</button>
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
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
<!-- DataTables  & Plugins -->
<script src="../resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../resources/plugins/jszip/jszip.min.js"></script>
<script src="../resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<script>

//목록 페이지 사용 JS : Checkalert(),showRegist()

	function Checkalert() {
		if (search_form.searchKeyword.value == "") {
			search_form.searchKeyword
					.focus();
			alert("검색어를 입력해주세요.");
			return false;
		}
	}

	function showRegist() {
        location.href = "/admin/ticketregist.ft";
    }
	
  $(function () {
    $('#example2').DataTable({
		"paging": true,
		"lengthChange": false,
		"searching": true,
		"ordering": true,
		"info": true,
		"autoWidth": true,
		"responsive": true,
		
		language: {
		    "decimal": "",
		    "emptyTable": "테이블에 데이터가 없습니다",
		    "info": "_TOTAL_개 항목 중 _START_부터 _END_까지 표시중",
		    "infoEmpty": "0개 항목 중 0부터 0까지 표시중",
		    "infoFiltered": "(_MAX_개 항목 중 필터링됨)",
		    "infoPostFix": "",
		    "thousands": ",",
		    "lengthMenu": "_MENU_개 항목 표시",
		    "loadingRecords": "로딩 중...",
		    "processing": "처리 중...",
		    "search": "검색:",
		    "zeroRecords": "일치하는 레코드를 찾을 수 없습니다",
		    "paginate": {
		        "first": "처음",
		        "last": "마지막",
		        "next": "다음",
		        "previous": "이전"
		    },
		    "aria": {
		        "orderable": "이 열을 정렬하려면 클릭",
		        "orderableReverse": "이 열을 역순으로 정렬하려면 클릭"
		    }
	    }
    });
  });
</script>
</body>
</html>