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
					<tbody id="tbody">
						<c:forEach items="${gList }" var="goods" varStatus="i">  
						<c:if test="${goods.goodsStock ne 0 }">						
							<tr>
								<td><img src="../resources/guploadFiles/${goods.goodsFileRename }" width="30px"></td>
								<td><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></td>
								<td>₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></td>
							</tr>
						</c:if>
						<c:if test="${goods.goodsStock eq 0 }">						
							<tr>
								<td><img src="../resources/guploadFiles/${goods.goodsFileRename }" width="30px"></td>
								<td>${goods.goodsName } - 품절</a></td>
								<td>₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></td>
							</tr>
						</c:if>           
						</c:forEach>
					</tbody>
				</table>
				<div class="d-flex col-md-6 justify-content-start">
<!-- 						<form class="row g-1" action="/goods/sortList.ft" method="get"> -->
							<div class="col-auto">
								<select class="form-select" name="sortType" id="sortType">
									<option value="recentSort" selected>최신순</option>
									<option value="oldSort">오래된순</option>
									<option value="highSort">높은가격순</option>
									<option value="rowSort">낮은가격순</option>
									<option value="nameSort">이름순</option>
								</select>
							</div>
<!-- 						</form> -->
					</div>
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
		<!-- jQuery -->
	    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script>
			function showInsertForm() {
				// 공지사항 글쓰기 페이지 이동
				location.href="/goods/insert.ft";
			}
			
			$("#sortType").on("change", function() {
				
				var sortType = $("#sortType option:selected").val();
				debugger;
				$.ajax({
					url: "/goods/sortList.ft",
					type: "GET",
					data : {"sortType":sortType} ,
					success: function(result) {
						var tableBody = $("#tbody");
						tableBody.html("");
						var tr;
						var sortCode;
						var sortPrice;
						var sortFileRename;
						
						
						if(result.length > 0) {
							for(var i in result) {
								var goodsFileRenameVal = "<img src='../resources/guploadFiles/"+result[i].goodsFileRename+"' width='30px'>";
								var goodsNameVal;
								if (result[i].goodsStock !== 0) {
									goodsNameVal = "<a href='/goods/detail.ft?goodsCode="+result[i].goodsCode+"'>"+result[i].goodsName+"</a>";
								} else {
									goodsNameVal = result[i].goodsName + " - 품절";
								}
								var goodsPriceVal = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(result[i].goodsPrice);
								
								tr = $("<tr>") // <tr></tr>
								sortFileRename = $("<td>").html(goodsFileRenameVal); // <td></td>
								sortCode = $("<td>").html(goodsNameVal);
								sortPrice = $("<td>").text(goodsPriceVal);
								tr.append(sortFileRename);
        						tr.append(sortCode);
        						tr.append(sortPrice);
        						tableBody.append(tr);
							}
						}
					
					},
					error: function() {
						alert("실패")
					}
				});
			});
		</script>
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>