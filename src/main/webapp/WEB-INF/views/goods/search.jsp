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
			<div class="goodscontainer">
			<h1 style="text-align:center;"><b>페어리타운 온라인 굿즈 스토어</b></h1>
			<br><br>
			<div style="margin-left:900px;"><button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showCart();"><i class="bi bi-cart4" style="float:left;"></i>&nbsp내 장바구니</button></div>
			<br><br><br>				
				<c:forEach items="${sList }" var="goods" varStatus="i">
						<div class="album py-5" onclick="detailGoods(${goods.goodsCode })" style="float:left; margin: 0 30px 0 30px">
						        <div>
									<c:if test="${goods.goodsStock ne 0 }">						
										<div class="card shadow-sm" style="width: 18rem; position: relative;">
										  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px;">
										  <div class="card-body">
										   <ul class="list-group list-group-flush">
											    <li class="list-group-item"> <h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></h5></li>
											    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
											</ul>
										  </div>
										</div>
									</c:if>
									<c:if test="${goods.goodsStock eq 0 }">						
										<div class="card" style="width: 18rem; position: relative;">
										  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px; filter: brightness(50%);">
										  <img src="../resources/guploadFiles/soldout.png" style="width:100%; position: absolute; top: 10px; left: 0;">
										  <div class="card-body">
										   <ul class="list-group list-group-flush">
											    <li class="list-group-item"> <h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></a></h5></li>
											    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
											</ul>
										  </div>
										</div>
									</c:if>
								</div>
						</div>  
					</c:forEach>
					</div>
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
											<input class="form-control" type="search" name="searchKeyword" value="${searchKeyword}">
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
									<a class="page-link rounded-circle" href="/goods/search.ft?page=${pi.startNavi - 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a class="page-link rounded-circle mx-2" href="/goods/search.ft?page=${p }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/goods/search.ft?page=${pi.endNavi + 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Next">
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
		function detailGoods(goodsCode) {
			location.href = "/goods/detail.ft?goodsCode="+goodsCode;
		}
		function showCart() {
			location.href = "/goods/cartList.ft";
		}
		$("#sortType").on("change", function() {
			var sortType = $("#sortType option:selected").val();
			var searchCondition = $("select[name='searchCondition']").val();
			var searchKeyword = $("input[name='searchKeyword']").val();
			oneMoreAjax(searchCondition, searchKeyword, 1, sortType);
		});
		
		function oneMoreAjax(searchCondition, searchKeyword, page, sortType) {
			debugger;
			$.ajax({
				url: "/goods/sortSearchList.ft",
				type: "GET",
				data : {
						"page":page,
						"sortType":sortType,
						"searchCondition": searchCondition,
						"searchKeyword": searchKeyword
						} ,
						success: function(response) {
							var goodscontainer = $(".goodscontainer");
							goodscontainer.html("");
							var cardBody;
							var album;
							var shadow;
							var ulg;
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
									var goodsFileRenameVal;
									if (result[i].goodsStock !== 0) {
										goodsFileRenameVal = "<img src='../resources/guploadFiles/"+result[i].goodsFileRename+"' class='card-img-top' alt='...' style='height:200px;'>";
										 
									} else {
										goodsFileRenameVal = "<img src='../resources/guploadFiles/"+result[i].goodsFileRename+"' class='card-img-top' alt='...' style='height:200px; filter: brightness(50%);'><img src='../resources/guploadFiles/soldout.png' style='width:100%; position: absolute; top: 10px; left: 0;'>";
									}
									var goodsNameVal = "<li class='list-group-item'><h5 class='card-title' style='white-space: nowrap; overflow: hidden; text-overflow: ellipsis;'><a href='/goods/detail.ft?goodsCode="+result[i].goodsCode+"'>"+result[i].goodsName+"</a></h5></li>";
									var goodsPriceVal = "<li class='list-group-item'><p class='card-text'>"+new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(result[i].goodsPrice)+"</p></li>";
									
									album = $("<div class='album py-5' onclick='detailGoods("+result[i].goodsCode+")' style='float:left; margin: 0 30px 0 30px'>");
									shadow = $("<div class='card shadow-sm' style='width: 18rem; position: relative;'>");
									cardBody = $("<div class='card-body'>");
									ulg = $("<ul class='list-group list-group-flush'>");
									
									ulg.append(goodsNameVal);
									ulg.append(goodsPriceVal);
									cardBody.append(ulg);
									shadow.append(goodsFileRenameVal);
									shadow.append(cardBody);
									album.append(shadow);
									goodscontainer.append(album);
								}
								
								if (pi.startNavi != 1) {
									li = $("<li class='page-item'>");
									a = $("<a onclick='oneMoreAjax(\""+searchCondition+"\",\""+searchKeyword+"\","+(pi.startNavi-1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Previous'>");
									span = "<span aria-hidden='true'>&laquo;</span>";
									a.append(span);
									li.append(a);
									ul.append(li);
								}
								
								for (var p = pi.startNavi; p <= pi.endNavi; p++) {
									li = $("<li class='page-item'>");
									a = $("<a onclick='oneMoreAjax(\""+searchCondition+"\",\""+searchKeyword+"\","+p+", \""+sortType+"\");' class='page-link rounded-circle mx-2' href='javascript:void(0);' style='border: none; color: #313131;'>");
									span = p;
									a.append(span);
									li.append(a);
									ul.append(li);
								}
								
								
								if (pi.endNavi != pi.naviTotalCount) {
									li = $("<li class='page-item'>");
									a = $("<a onclick='oneMoreAjax(\""+searchCondition+"\",\""+searchKeyword+"\","+(pi.endNavi+1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Next'>");
									span = "<span aria-hidden='true'>&raquo;</span>";
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