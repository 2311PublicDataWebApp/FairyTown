<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 휴무일 정보</title>
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
		          			 <td colspan="5"><input type="button" class="btn btn-secondary"  name="closeregist" onClick="showRegist();" value="휴무등록"></td>
		                  </tr>
		                  <tr>
								<th>번호</th>
								<th>놀이기구명</th>
								<th>휴무일시</th>
								<th>사유</th>
								<th>현재상태</th>
							</tr>
		                  </thead>
		                  <tbody>
							
					<!-- 	등록된 운영 휴무 계획이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(cList) != 0 }">
								<c:forEach items="${cList }" var="close" varStatus="i">
									<tr class="close_list_tr">
										<td class="list_first_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">${i.count }</a>
										</td>
										<td class="list_second_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">${close.rideName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/closedetail.ft?rideId=${close.rideId }" style="color:black;">${close.closeDate}</a>
										</td>
										
										<td class="list_fourth_td">
											<a href="/adminclosedetail.ft?rideId=${close.rideId }" style="color:black;">
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
											<td class="list_fifth_td"><a
												href="/adminclosedetail.ft?rideId=${close.rideId }" style="color:black;">임시휴무</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>


								<tr align="center" class="pgn">
									<td colspan="5">
										<c:if test="${pi.startNavi ne '1' }">
											<a href="/admin/closesearch.ft?page=${pi.startNavi - 1 }">[이전]</a>
										</c:if> 
										<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
											<a href="/admin/closesearch.ft?page=${p }">${p }</a>
										</c:forEach> 
											<c:if test="${pi.endNavi ne pi.naviTotalCount }">
												<a href="/admin/closesearch.ft?page=${pi.endNavi + 1 }">[다음]</a>
											</c:if>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
									<td class="list_fifth_td" colspan="5">
										<p class="nullmsg_search">
											검색된 휴무 일정이 없습니다.<br>
										</p>
										<button type="button" class="empty_reg_btn btn btn-secondary"
											onclick="showRegist();">휴무 일정 등록하기</button>
							</c:otherwise>
						</c:choose>
										
				
				<!-- 검색 영역 -->
			<tr>
				<td colspan="5">
					<div class="search_box">
					    <form class="search_form" action="/admin/closesearch.ft" name="search_form" method="post">
							<div class="search_select">
								<select class="form-select" name="searchCondition"  id="searchcon">
									<option value="all" 			<c:if test="${searchCondition == 'all'}">selected</c:if>>전체</option>
									<option value="rideName"		<c:if test="${searchCondition == 'rideName'}">selected</c:if>>놀이기구명</option>
									<option value="closeDate"		<c:if test="${searchCondition == 'closeDate'}">selected</c:if>>휴무일시</option>
									<option value="closeReason"		<c:if test="${searchCondition == 'closeReason'}">selected</c:if>>사유</option>
									<option value="rideStatus"		<c:if test="${searchCondition == 'rideStatus'}">selected</c:if>>현재 상태</option>
								</select>
							</div>	
							
							<div class="search_button">
								<div class="input">
									<input type="search" name="searchKeyword" id="searchKeyword" value="${searchKeyword }">
									<button type="submit" class="btn btn-secondary" onClick="return Checkalert();">검색</button>
									<button type="button" class="btn search_reset btn-secondary"  onClick="removeWord();">초기화</button>
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
				
				function showRegist(){
					location.href = "/admin/closeregist.ft";
					}
						
	</script>
	  
	<!-- 공통 / 풋터 -->
	
</body>
</html>