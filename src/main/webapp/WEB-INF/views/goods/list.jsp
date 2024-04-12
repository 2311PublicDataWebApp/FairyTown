<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 목록</title>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-list">
			<h1><b>굿즈 목록</b></h1>
			<br><br><br>
				<div class="d-flex col-md-6 justify-content-end">
	            	<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showInsertForm();">글쓰기</button>
				</div>		
				<table class="table table-hover">
					<thead>
						<tr>
							<th></th>
							<th>상품명</th>
							<th>상품가격</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${gList }" var="goods" varStatus="i">            
							<tr>
								<td><img src="../resources/guploadFiles/${goods.goodsFileRename }" width="30px"></td>
								<td><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></td>
								<td><fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/>원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<c:if test="${memberId ne 'admin' }">
					<div class="d-flex flex-wrap justify-content-center align-items-center pb-5">
					<div class="d-flex col-md-12 justify-content-start">
						<form class="row g-1" action="/goods/search.ft" method="get">
							<div class="col-auto">
								<select class="form-select" name="searchCondition">
									<option value="all" selected>전체</option>
									<option value="goodsCode">상품코드</option>
									<option value="goodsName">상품명</option>
									<option value="goodsContent">내용</option>
								</select>
						</div>
							<div class="col-auto">
								<div class="input-group">
									<input class="form-control" type="search" name="searchKeyword">
									<button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
								</div>
							</div>
						</form>
					</div>
					</div>
				</c:if>
				<c:if test="${memberId eq 'admin' }">
					<div class="d-flex flex-wrap justify-content-center align-items-center pb-5">
					<div class="d-flex col-md-6 justify-content-start">
						<form class="row g-1" action="/goods/search.ft" method="get">
							<div class="col-auto">
								<select class="form-select" name="searchCondition">
									<option value="all" selected>전체</option>
									<option value="goodsCode">상품코드</option>
									<option value="goodsName">상품명</option>
									<option value="goodsContent">내용</option>
								</select>
							</div>
							<div class="col-auto">
								<div class="input-group">
									<input class="form-control" type="search" name="searchKeyword">
									<button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
								</div>
							</div>
						</form>
					</div>
					                
					<div class="d-flex col-md-6 justify-content-end">
						<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showInsertForm();">글쓰기</button>
					</div>
					</div>
				</c:if>

				<div class="row mt-3 mb-5" style="margin-top:300px;">
				<div class="col-md-12">
					<nav aria-label="Page navigation example">					
						<ul class="pagination justify-content-center" style="font-weight: 600; ">
							<c:if test="${pi.startNavi ne '1' }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/goods/list.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a class="page-link rounded-circle mx-2" href="/goods/list.ft?page=${p }" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/goods/list.ft?page=${pi.endNavi + 1 }" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>
				</div>
		</div>
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script>
		function showInsertForm() {
			// 공지사항 글쓰기 페이지 이동
			location.href="/goods/insert.ft";
		}
		</script>
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>