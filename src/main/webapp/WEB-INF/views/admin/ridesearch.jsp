<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 놀이기구</title>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

		<!-- 어드민 타이틀 영역 -->
			<div class="admTitle">
				<table class="title_tbl">
					<tr>
						<td class="titleFirst"><h2>놀이기구</h2></td>
					</tr>
					<tr>
						<td class="titleSecond"><h4>놀이기구 조회</h4></td>
					</tr>
				</table>
			</div>
		
		<!-- 컨텐츠 영역 -->
			<div class="content">
				
				<!-- 목록 테이블 -->
				<table class="table_ride_list">
					<tr>
						<td colspan="5"><input type="button" name="rideregist" onClick="showRegist();" value="등록하기"></td>
					</tr>
					
					<tr>
						<td>번호</td>
						<td>놀이기구명</td>
						<td>탑승제한</td>
						<td>운휴상태</td>
						<td>등록일</td>
					</tr>
					
					<!-- 	등록된 운영 휴무 계획이 있는 경우 -->
					<c:choose>
							<c:when test="${fn:length(rList) != 0 }">
								<c:forEach items="${rList }" var="ride" varStatus="i">
									<tr class="ride_list_tr">
										<td class="list_first_td">
											<a href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">${i.count }</a>
										</td>
										<td class="list_second_td">
											<a href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">${ride.rideName }</a>
										</td>
										<td class="list_third_td">
											<a href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">${ride.rideLimit}</a>
										</td>
										
										<td class="list_fourth_td">
											<a href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">${ride.rideStatus}</a>
										</td>

										<c:set var="rStatus" value="${ride.rideStatus }" />
										
										<c:if test="${rStatus eq 'AV' }">
											<td class="list_fifth_td"><a
												href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">정상 운영</a>
											</td>
										</c:if>
										<c:if test="${rStatus eq 'NAV'}">
											<td class="list_fifth_td"><a
												href="/admin/ridedetail.ft?rideNo=${ride.rideNo }">임시 휴무</a>
											</td>
										</c:if>
										
										<td class="list_sixth_td">
											<a href="/admin/ridedetail.ft=${ride.rideNo }">${ride.rideDate}</a>
										</td>
									</tr>
								</c:forEach>


								<!-- 페이지네이션 -->
								<tr align="center" class="pgn">
									<td colspan="5">
										<c:if test="${pInfo.startNavi ne '1' }">
											<a href="/admin/ridesearch.ft?page=${pInfo.startNavi - 1 }">[이전]</a>
										</c:if> 
										<c:forEach begin="${pInfo.startNavi }" end="${pInfo.endNavi }" var="p">
											<a href="/admin/ridesearch.ft?page=${p }">${p }</a>
										</c:forEach> 
											<c:if test="${pInfo.endNavi ne pInfo.naviTotalCount }">
												<a href="/admin/ridesearch.ft?page=${pInfo.endNavi + 1 }">[다음]</a>
											</c:if>
									</td>
								</tr>
							</c:when>
							
							<!-- 	등록된 놀이기구가 없는 경우 -->
							<c:otherwise>
									<td class="list_fifth_td" colspan="5">
										<p class="nullmsg_search">
											검색된 놀이기구가 없습니다.<br>
										</p>
										<button type="button" class="empty_reg_btn"
											onClick="showRegist();">등록하기</button>
							</c:otherwise>
						</c:choose>
										
				<tr>				
				<!-- 검색 영역 -->
					<td colspan="5">
					    <form class="search_form" action="/admin/ridesearch.ft" name="search_form" method="get">
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
									<button type="submit" class="btn" onClick="return Checkalert();">검색</button>
									<button type="reset" class="btn search_reset"  onClick="removeWord();">초기화</button>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>
		</div>
	
		<script>
		// 검색 목록 페이지 사용 JS : Checkalert(),removeWord(),showRegist()
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
				location.href = "admin/rideregist.ft";
				}
			}			 
		</script>
	  
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	
</body>
</html>