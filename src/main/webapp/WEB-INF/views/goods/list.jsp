<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 목록</title>
		<style>
			#goods-list {
				margin: 0 0 0 400px;
				width:1200px;
			}
		</style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-list">
			<h1 style="margin: 0 0 0 300px;"><b>페어리타운 온라인 굿즈 스토어</b></h1>
			<br><br>
			<div style="margin-left:900px;"><button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showCart();"><i class="bi bi-cart4" style="float:left;"></i>&nbsp내 장바구니</button></div>
			<br><br><br>
				    <div class="goodscontainer">
					<c:forEach items="${gList }" var="goods" varStatus="i">
						<div class="album py-5" onclick="detailGoods(${goods.goodsCode })" style="float:left; margin: 0 30px 0 30px">
							<c:if test="${goods.goodsStock ne 0 }">						
								<div class="card shadow-sm" style="width: 18rem; position: relative;">
								  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px;">
								  
								  <div class="card-body">
								   <ul class="list-group list-group-flush">
									    <li class="list-group-item"><h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></h5></li>
									    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
									</ul>
								  </div>
								</div>
							</c:if>
							<c:if test="${goods.goodsStock eq 0 }">						
								<div class="card shadow-sm" style="width: 18rem; position: relative;">
								  <img src="../resources/guploadFiles/${goods.goodsFileRename }" class="card-img-top" alt="..." style="height:200px; filter: brightness(50%);">
								  <img src="../resources/guploadFiles/soldout.png" style="width:100%; position: absolute; top: 10px; left: 0;">
								  <div class="card-body">
								   <ul class="list-group list-group-flush">
									    <li class="list-group-item"><h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="/goods/detail.ft?goodsCode=${goods.goodsCode }">${goods.goodsName }</a></h5></li>
									    <li class="list-group-item"><p class="card-text">₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></p></li>
									</ul>
								  </div>
								</div>
							</c:if>
						</div>  
					</c:forEach>
					</div>

					<div class="list-footer" style="margin: 0 0 0 35px">
						<div class="d-flex col-md-12 justify-content-start">
								<div class="col-auto">
									<select class="form-select" name="sortType" id="sortType">
										<option value="recentSort" selected>최신순</option>
										<option value="oldSort">오래된순</option>
										<option value="highSort">높은가격순</option>
										<option value="rowSort">낮은가격순</option>
										<option value="nameSort">이름순</option>
									</select>
								</div>
								&nbsp
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

				
				<div class="row mt-3 mb-5" style="margin-top:300px;">
				<div class="col-md-12">
					<nav aria-label="Page navigation example">					
						<ul id="pageul" class="pagination justify-content-center" style="font-weight: 600; ">
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
			function detailGoods(goodsCode) {
				location.href = "/goods/detail.ft?goodsCode="+goodsCode;
			}
			function showCart() {
				location.href = "/goods/cartList.ft";
			}
			$("#sortType").on("change", function() {
				var sortType = $("#sortType option:selected").val();
				oneMoreAjax(1, sortType);
			});
			function oneMoreAjax(page, sortType) {
				$.ajax({
					url: "/goods/sortList.ft",
					type: "GET",
					data : {
								"page":page,
								"sortType":sortType
							},
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
						
						var result = response.sortList;
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
								a = $("<a onclick='oneMoreAjax("+(pi.startNavi-1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Previous'>");
								span = "<span aria-hidden='true'>&laquo;</span>";
								a.append(span);
								li.append(a);
								ul.append(li);
							}
							
							for (var p = pi.startNavi; p <= pi.endNavi; p++) {
								li = $("<li class='page-item'>");
								a = $("<a onclick='oneMoreAjax("+p+", \""+sortType+"\");' class='page-link rounded-circle mx-2' href='javascript:void(0);' style='border: none; color: #313131;'>");
								span = p;
								a.append(span);
								li.append(a);
								ul.append(li);
							}
							
							
							if (pi.endNavi != pi.naviTotalCount) {
								li = $("<li class='page-item'>");
								a = $("<a onclick='oneMoreAjax("+(pi.endNavi+1)+", \""+sortType+"\");' class='page-link rounded-circle' href='javascript:void(0);' aria-label='Next'>");
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
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>