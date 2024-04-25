<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 상세 조회</title>
		<style>
			#goods-detail {
				margin: auto;
				width:1200px;
			}
			.list {
			  color: lightgray;
			}
		</style>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-detail">
			<h1 style="text-align:center;"><b>굿즈 상세 정보</b></h1>
			<br><br>
			<div style="margin-left:990px;">
				<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showGoodsList();">&nbsp굿즈 목록</button>
				<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showCart();"><i class="bi bi-cart4" style="float:left;"></i>&nbsp내 장바구니</button>
			</div>
			<br><br><br>
					<br>
					<div class="thumbnail" style="float:left; margin: 0 50px 0 0;">				
						<img src='../resources/guploadFiles/${goods.goodsFileRename }' style="width:500px; height:500px;">
					</div>
					
					<table class="table" style="width:50%; float:right;">
						<tbody>
							<tr>
								<td colspan="2"><h3><a href="/goods/list.ft" class="list"><i class="bi bi-house" style="float:left;"></i> <div style="margin: 5px 0 0 0; float:left; color:gray"> &nbsp&nbsp&nbsp페어리타운 온라인 굿즈 스토어 &nbsp&nbsp&nbsp</div> <i class="bi bi-arrow-right-circle"></i></a></h3></td>
								<td></td>
							</tr>
							<tr>
								<td><h3>상품코드</h3></td>
								<td><h3>${goods.goodsCode }</h3></td>
							</tr>
							<tr>
								<td><h3>상품명</h3></td>
								<td><h3>${goods.goodsName }</h3></td>
							</tr>
							<tr>
								<td><h3>가격</h3></td>
								<td><h3>₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></h3></td>
							</tr>
							<tr>
								<td><h3>구입 수량</h3></td>
								<td>
									<c:if test="${goods.goodsStock ne 0 }">
										<input class="numBox" type="number" min="1" max="${goods.goodsStock}" value="1" />
									</c:if>
									<c:if test="${goods.goodsStock eq 0 }">
										<input class="numBox" type="number" min="0" max="${goods.goodsStock}" value="0" />
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
					<c:if test="${goods.goodsStock ne 0 }">					
						<button type="button" id="addCart_btn" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef; margin:30px 0 0 250px; padding: 10px 10px"><h3><i class="bi bi-cart4" style="float:left;"></i>&nbsp카트에 담기</button></h3>
					</c:if>
					<c:if test="${goods.goodsStock eq 0 }">
						<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef; margin:30px 0 0 270px; padding: 10px 30px"><h3>품절</button></h3>
					</c:if>
					<br><br><br><br><br><br><br><br><br>
					<div style="background-color:#ACE0F8; height:80px; display: flex; justify-content: center"><h3 style="text-align:center; padding: 20px 0 0 0; color:white;">상 세 설 명</h3></div>
					<div style="margin:auto; text-align:center;">${goods.goodsContent }</div>
		</div>
		<br><br><br>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script>
			$("#addCart_btn").click(function(){
			 var cartGoodsCode = ${goods.goodsCode };
			 var cartStock = $(".numBox").val();
			    
			 var data = {
				'cartGoodsCode' : cartGoodsCode,
			 	'cartStock' : cartStock
			   };
			 
			 $.ajax({
			  url : "/goods/addCart.ft",
			  type : "post",
			  data : data,
			  success : function(result){
				  if(result == 1) {
					     alert("카트 담기 성공");
					     $(".numBox").val("1");
					    } else {
					     alert("회원만 사용할 수 있습니다.")
					     $(".numBox").val("1");
					    }
			  },
			  error : function(){
			   alert("카트 담기 실패");
			  }
			 });
			});
		</script>
		<script type="text/javascript">
			function showCart() {
				location.href = "/goods/cartList.ft";
			}
			
			function showModifyPage() {
				var goodsCode = "${goods.goodsCode }";
				location.href = "/goods/modify.ft?goodsCode=" + goodsCode;
			}
			
			function deleteGoods() {
				if (confirm("삭제하시겠습니까?")) {
					var goodsCode = "${goods.goodsCode }";
					location.href = "/goods/delete.ft?goodsCode=" + goodsCode;
				}
			}
			
			function showGoodsList() {
				location.href = "/goods/list.ft";
			}
		</script>
		
    </body>
</html>