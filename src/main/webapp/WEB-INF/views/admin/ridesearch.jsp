<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
                  <tr> 
						<td colspan="5">
						<input type="button" name="rideregist" style="margin-left:90%" class="btn btn-secondary" onClick="showRegist();" value="등록하기">
						</td>
					</tr>
					<tr>
					<th style="width:80px; text-align:center;">번호</th>
				<th style="width:120px; text-align:center;">놀이기구명</th>
				<th style="width:240px; text-align:center;">탑승제한</th>
				<th style="width:80px; text-align:center;">운휴상태</th>
				<th style="width:80px; text-align:center;">등록일</th>
					</tr>
					
					<!-- 	등록된 운영 휴무 계획이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(sList) != 0 }">
								<c:forEach items="${sList }" var="ride" varStatus="i">
									<tr class="ride_list_tr">
										<td class="list_first_td" style="text-align:center;">
											<a href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${i.count }</a>
										</td>
										<td class="list_second_td" style="text-align:center;">
											<a href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${ride.rideName }</a>
										</td>
										<td class="list_third_td" style="text-align:center;">
											<a href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${ride.rideLimit}</a>
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
										
										<td class="list_sixth_td" style="text-align:center;">
											<a href="/admin/ridedetail.ft?rideId=${ride.rideId }" style="color:black;">${ride.rideDate}</a>
										</td>
									</tr>
								</c:forEach>


								<tr align="center" class="pgn">
									<td colspan="5">
										<c:if test="${pi.startNavi ne '1' }">
											<a href="/admin/ridesearch.ft?page=${pi.startNavi - 1 }" style="color:black;">[이전]</a>
										</c:if> 
										<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
											<a href="/admin/ridesearch.ft?page=${p }" style="color:black;">${p }</a>
										</c:forEach> 
											<c:if test="${pi.endNavi ne pi.naviTotalCount }">
												<a href="/admin/ridesearch.ft?page=${pi.endNavi + 1 }" style="color:black;">[다음]</a>
											</c:if>
									</td>
								</tr>
							</c:when>
							
							<c:otherwise>
									<td class="list_fifth_td" colspan="5">
										<p class="nullmsg_search">
											검색된 놀이기구가 없습니다.<br>
										</p>
										<button type="button" class="empty_reg_btn btn btn-secondary"
											onClick="showRegist();">등록하기</button>
							</c:otherwise>
						</c:choose>
										
				<tr>				
				<!-- 검색 영역 -->
					<td align="center" colspan="5">
					    <form class="search_form" action="/admin/ridesearch.ft" name="search_form" method="post">
							<input type="hidden" name="page" value="1">
							<div class="search_select">
								<select class="form-select" name="searchCondition"  id="searchcon">
									<option value="all" 			<c:if test="${searchCondition == 'all'}">selected</c:if>>전체</option>
									<option value="rideName"		<c:if test="${searchCondition == 'rideName'}">selected</c:if>>놀이기구명</option>
									<option value="rideStatus"		<c:if test="${searchCondition == 'rideStatus'}">selected</c:if>>현재 상태</option>
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
		// 검색 목록 페이지 사용 JS : Checkalert(),removeWord(),showRegist()
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
			
			
			function showRegist(){
				location.href = "/admin/rideregist.ft";
				}
						 
		</script>

	
</body>
</html>