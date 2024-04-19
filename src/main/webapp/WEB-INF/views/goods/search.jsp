<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 검색 목록</title>
		<style>
			#goods-search {
				margin: 0 0 0 400px;
				width:1200px;
			}
		</style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-search">
			<h1 style="text-align:center;"><b>페어리타운 온라인 굿즈 스토어</b></h1>
			<br><br><br><br><br>				
				<c:forEach items="${sList }" var="goods" varStatus="i">
						<div class="album py-5" style="float:left; margin: 0 30px 0 30px">
						    <div class="container">
						        <div>
									<c:if test="${goods.goodsStock ne 0 }">						
										<div class="card shadow-sm" style="width: 18rem;">
										  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px;">
										  <div class="card-body">
										   <ul class="list-group list-group-flush">
											    <li class="list-group-item"> <h5 class="card-title"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></h5></li>
											    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
											</ul>
										  </div>
										</div>
									</c:if>
									<c:if test="${goods.goodsStock eq 0 }">						
										<div class="card" style="width: 18rem;">
										  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px;">
										  <div class="card-body">
										   <ul class="list-group list-group-flush">
											    <li class="list-group-item"> <h5 class="card-title"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName } - 품절</a></a></h5></li>
											    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
											</ul>
										  </div>
										</div>
									</c:if>
								</div>
							</div>
						</div>  
					</c:forEach>
					
					<div class="list-footer" style="margin: 0 0 0 35px">
						<div class="d-flex col-md-12 justify-content-start">
								<div class="col-auto">
									<select class="form-select" name="sortType" id="sortType">
										<option value="recentSort" <c:if test="${sortType eq 'recentSort' }"> selected</c:if>>최신순</option>
										<option value="oldSort" <c:if test="${sortType eq 'oldSort' }"> selected</c:if>>오래된순</option>
										<option value="highSort" <c:if test="${sortType eq 'highSort' }"> selected</c:if>>높은가격순</option>
										<option value="rowSort" <c:if test="${sortType eq 'rowSort' }"> selected</c:if>>낮은가격순</option>
										<option value="nameSort" <c:if test="${sortType eq 'nameSort' }"> selected</c:if>>이름순</option>
									</select>
								</div>
								&nbsp
								<form class="row g-1" action="/goods/search.ft" method="get">
									<div class="col-auto">
										<select class="form-select" name="searchCondition">
			                                <c:if test="${searchCondition eq 'all' }" >selected</c:if>
											<option value="all" <c:if test="${searchCondition eq 'all' }"> selected</c:if>>전체</option>
											<option value="goodsCode" <c:if test="${searchCondition eq 'goodsCode' }"> selected</c:if>>상품코드</option>
											<option value="goodsName" <c:if test="${searchCondition eq 'goodsName' }"> selected</c:if>>상품명</option>
											<option value="goodsContent" <c:if test="${searchCondition eq 'goodsContent' }"> selected</c:if>>내용</option>
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
				<div class="row mt-3 mb-5" style="margin-top:300px;">
				<div class="col-md-12">
					<nav aria-label="Page navigation example">					
						<ul id="pageul" class="pagination justify-content-center" style="font-weight: 600; ">
							<c:if test="${pi.startNavi ne '1' }">
								<li class="page-item">
									<a onclick="oneMoreAjax();" class="page-link rounded-circle" href="/goods/search.ft?page=${pi.startNavi - 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a onclick="oneMoreAjax();" class="page-link rounded-circle mx-2" href="/goods/search.ft?page=${p }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a onclick="oneMoreAjax();" class="page-link rounded-circle" href="/goods/search.ft?page=${pi.endNavi + 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Next">
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
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script>
		$("#sortType").on("change", function() {
			
			var sortType = $("#sortType option:selected").val();
			var searchCondition = $("select[name='searchCondition']").val();
			var searchKeyword = $("input[name='searchKeyword']").val();
			$.ajax({
				url: "/goods/sortSearchList.ft",
				type: "GET",
				data : {
						"sortType":sortType,
						"searchCondition": searchCondition,
						"searchKeyword": searchKeyword
						} ,
				success: function(response) {
					var tableBody = $("#tbody");
					tableBody.html("");
					var tr;
					var sortCode;
					var sortPrice;
					var sortFileRename;
					var ul = $("#pageul");
					ul.html("");
					var li;
					var a;
					var span;
					
					var result = response.sortSearchList;
					var pi = response.pi;
					var searchCondition = response.searchCondition;
					var searchKeyword = response.searchKeyword;
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
							
							tr = $("<tr>"); // <tr></tr>
							sortFileRename = $("<td>").html(goodsFileRenameVal); // <td></td>
							sortCode = $("<td>").html(goodsNameVal);
							sortPrice = $("<td>").text(goodsPriceVal);
							tr.append(sortFileRename);
    						tr.append(sortCode);
    						tr.append(sortPrice);
    						tableBody.append(tr);
						}
						
						
						if (pi.startNavi != 1) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle' href=''/goods/sortSearchList.ft?page="+pi.startNavi+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"' aria-label='Previous'>");
							span = "<span aria-hidden='true'>&laquo;</span>";
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
						for (var p = pi.startNavi; p < pi.endNavi; p++) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle mx-2' href='/goods/sortSearchList.ft?page="+p+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"' style='border: none; color: #313131;'>");
							span = p;
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
						
						if (pi.endNavi != pi.naviTotalCount) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle' href='/goods/sortSearchList.ft?page="+pi.endNavi + 1 +"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+" aria-label='Next'>");
							span = "<span aria-hidden='true'>&laquo;</span>";
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
					}
				
				},
				error: function() {
					alert("실패")
				}
			});
		});
		
		function oneMoreAjax() {
			$.ajax({
				url: "/goods/sortSearchList.ft",
				type: "GET",
				data : {
						"sortType":sortType,
						"searchCondition": searchCondition,
						"searchKeyword": searchKeyword
						} ,
				success: function(response) {
					var tableBody = $("#tbody");
					tableBody.html("");
					var tr;
					var sortCode;
					var sortPrice;
					var sortFileRename;
					var ul = $("#pageul");
					ul.html("");
					var li;
					var a;
					var span;
					
					var result = response.sortSearchList;
					var pi = response.pi;
					var searchCondition = response.searchCondition;
					var searchKeyword = response.searchKeyword;
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
							
							tr = $("<tr>"); // <tr></tr>
							sortFileRename = $("<td>").html(goodsFileRenameVal); // <td></td>
							sortCode = $("<td>").html(goodsNameVal);
							sortPrice = $("<td>").text(goodsPriceVal);
							tr.append(sortFileRename);
    						tr.append(sortCode);
    						tr.append(sortPrice);
    						tableBody.append(tr);
						}
						
						
						if (pi.startNavi != 1) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle' href='/goods/sortSearchList.ft?page="+pi.startNavi+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"' aria-label='Previous'>");
							span = "<span aria-hidden='true'>&laquo;</span>";
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
						for (var p = pi.startNavi; p < pi.endNavi; p++) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle mx-2' href='/goods/sortSearchList.ft?page="+p+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"' style='border: none; color: #313131;'>");
							span = p;
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
						
						if (pi.endNavi != pi.naviTotalCount) {
							li = $("<li class='page-item'>");
							a = $("<a onclick='oneMoreAjax();' class='page-link rounded-circle' href='/goods/sortSearchList.ft?page="+pi.endNavi + 1 +"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"' aria-label='Next'>");
							span = "<span aria-hidden='true'>&laquo;</span>";
							a.append(span);
							li.append(a);
							ul.append(li);
						}
						
					}
				
				},
				error: function() {
					alert("실패")
				}
			});
		}
		</script>
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>