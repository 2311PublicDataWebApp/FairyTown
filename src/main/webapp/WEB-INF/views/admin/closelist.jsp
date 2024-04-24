<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 휴무일 정보</title>
	<link rel="stylesheet" href="../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
	<style>
	a{font-color:black;}
	</style>
</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<!-- Content Header -->
	<div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>휴무일 목록</h1>
          </div>
          	<!-- breadcrumb -->
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">운휴정보</a></li>
					<li class="breadcrumb-item active">휴무일 목록</li>
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
          			 <td colspan="5">
          			 <input type="button" style="margin-left:89%;"class="btn btn-secondary"  name="closeregist" onClick="showRegist();" value="휴무등록"></td>
                  </tr>
                  <tr style="text-align:center;">
						<th>번호</th>
						<th>놀이기구명</th>
						<th>휴무일시</th>
						<th>사유</th>
						<th>현재상태</th>
					</tr>
                  </thead>
                  <tbody style="text-align:center;">
                 		<!-- 	등록된 운영 휴무 계획이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(cList) != 0 }">
								<c:forEach items="${cList }" var="close" varStatus="i">
									<tr class="close_list_tr">
										<td class="list_first_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">${i.count }</a>
										</td>
										<td class="list_second_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }"  style="color:black;">${close.rideName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }"  style="color:black;">${close.closeDate}</a>
										</td>
										
										<td class="list_fourth_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }"  style="color:black;">
											<c:choose>
										        <c:when test="${close.closeReason == 'all'}">전체</c:when>
										        <c:when test="${close.closeReason == 'regular'}">정기휴무</c:when>
										        <c:when test="${close.closeReason == 'disaster'}">천재지변</c:when>
										        <c:when test="${close.closeReason == 'outoforder'}">기기수리</c:when>
										        <c:when test="${close.closeReason == 'vacation'}">담당자부재</c:when>
										        <c:when test="${close.closeReason == 'etc'}">기타</c:when>
										    </c:choose></a>
										</td>

										<c:set var="rStatus" value="${close.rideStatus }" />
										<c:if test="${rStatus eq 'Y' }">
											<td class="list_fifth_td"><a
												href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">정상운행</a>
											</td>
										</c:if>
										<c:if test="${rStatus eq 'N'}">
											<td class="list_third_td"><a
												href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">임시휴무</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>


								<tr align="center" class="pgn">
									<td colspan="5">
										<c:if test="${pi.startNavi ne '1' }">
											<a href="/admin/closelist.ft?page=${pi.startNavi - 1 }" style="color:black;">[이전]</a>
										</c:if> 
										<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
											<a href="/admin/closelist.ft?page=${p }" style="color:black;">${p }</a>
										</c:forEach> 
											<c:if test="${pi.endNavi ne pi.naviTotalCount }">
												<a href="/admin/closelist.ft?page=${pi.endNavi + 1 }" style="color:black;">[다음]</a>
											</c:if>
									</td>
								</tr>
							</c:when>
							
							<c:otherwise>
							<tr>
									<td class="list_fifth_td" colspan="5">
										<p class="nullmsg_list">
											등록된 휴무 일정이 없습니다.<br>
										</p>
										<button type="button" class="empty_reg_btn btn btn-secondary"
											onClick="showRegist();">휴무 일정 등록하기</button>
										</td>
									</tr>
							</c:otherwise>
						</c:choose>
						
					<tr>
					<td colspan="5">
						<div class="search_box">
						    <form class="search_form" action="/admin/closesearch.ft" name="search_form" method="post">
									<div class="search_select">
										<select class="form-select" name="searchCondition"  id="searchcon">
											<option value="all">전체</option>
											<option value="rideName">놀이기구명</option>
											<option value="closeDate">휴무일시</option>
											<option value="closeReason">사유</option>
											<option value="rideStatus">운휴상태</option>
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

	function showRegist(){
		location.href = "/admin/closeregist.ft";
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