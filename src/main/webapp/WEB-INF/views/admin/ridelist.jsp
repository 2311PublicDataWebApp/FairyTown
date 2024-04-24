<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 놀이기구</title>
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
            <h1>놀이기구 목록</h1>
          </div>
          	<!-- breadcrumb -->
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">놀이기구 관리</a></li>
					<li class="breadcrumb-item active">놀이기구 목록</li>
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
                  <tr> <td colspan="5">
				<input type="button" name="rideregist" class="btn btn-secondary regist_btn" 
					onClick="showRegist();" style="margin-left:90%" value="등록하기"></td>
				</tr>
			<tr>
				<th style="width:80px; text-align:center;">번호</th>
				<th style="width:120px; text-align:center;">놀이기구명</th>
				<th style="width:240px; text-align:center;">탑승제한</th>
				<th style="width:80px; text-align:center;">운휴상태</th>
				<th style="width:80px; text-align:center;">등록일</th>
			</tr>
			<c:choose>
				<c:when test="${fn:length(rList) != 0 }">
					<c:forEach items="${rList }" var="ride" varStatus="i">
						<tr class="ride_list_tr">
							<td class="list_first_td"  style="text-align:center;"><a
								href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${i.count }</a>
							</td>
							<td class="list_second_td" style="text-align:center;"><a
								href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${ride.rideName }</a>
							</td>
							<td class="list_third_td" style="text-align:center;">
							   <a href="/admin/ridedetail.ft?rideId=${ride.rideId}" style="color:black;">
							        <c:choose>
							            <c:when test="${fn:length(ride.rideLimit) > 50}">
							                ${fn:substring(ride.rideLimit, 0, 70)}...
							            </c:when>
							            <c:otherwise>
							                ${ride.rideLimit}
							            </c:otherwise>
							        </c:choose>
							    </a>
							</td>
							<c:set var="rStatus" value="${ride.rideStatus }" />
							<c:if test="${rStatus eq 'Y' }">
								<td class="list_fifth_td" style="text-align:center;"><a
									href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">정상운행</a></td>
							</c:if>
							<c:if test="${rStatus eq 'N'}">
								<td class="list_third_td" style="text-align:center;"><a
									href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">임시휴무</a></td>
							</c:if>
							<td class="list_fourth_td" style="text-align:center;"><a
								href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${ride.rideDate}</a>
							</td>
						</tr>
					</c:forEach>


					<tr align="center" class="pgn">
						<td colspan="5"><c:if test="${pi.startNavi ne '1' }">
								<a href="/admin/ridelist.ft?page=${pi.startNavi - 1 }" style="color:black;">[이전]</a>
							</c:if> <c:forEach begin="${pi.startNavi }" end="${pi.endNavi }"
								var="p">
								<a href="/admin/ridelist.ft?page=${p }" style="color:black;">${p }</a>
							</c:forEach> <c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<a href="/admin/ridelist.ft?page=${pi.endNavi + 1 }" style="color:black;">[다음]</a>
							</c:if></td>
					</tr>
				</c:when>

				<c:otherwise>
					<td class="list_fifth_td" colspan="5" style="text-align:center;">
						<p class="nullmsg_list">
							등록된 놀이기구가 없습니다.<br>
						</p>
						<button type="button" class="empty_reg_btn btn btn-secondary"
							onclick="showRegist();">등록하기</button>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="5">
					<div class="search_box"  style="text-align:center;">
						<form class="search_form" action="/admin/ridesearch.ft"
							name="search_form" method="post">
							<input type="hidden" name="page" value="1">
								<select class="form-select" name="searchCondition"
									id="searchcon">
									<option value="all">전체</option>
									<option value="rideName">놀이기구명</option>
									<option value="rideStatus">현재 상태</option>
								</select>

							<div class="search_button">
								<div class="input">
									<input type="search" name="searchKeyword"
										placeholder="검색어를 입력해주세요">
									<input type="submit" class="btn btn-secondary"  onClick="return Checkalert();" value="검색"/>
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
// 		목록 페이지 사용 JS : Checkalert(), showRegist()
		function Checkalert() {
			if (search_form.searchKeyword.value == "") {
				search_form.searchKeyword.focus();
				alert("검색어를 입력해주세요.");
				return false;
			}
		}
		
		function showRegist() {
			location.href = "/admin/rideregist.ft";
		}
		
	</script>
		<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
</body>
</html>