<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 상세 조회</title>
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-detail">
			<h1><b>굿즈 상세 조회</b></h1>
			<br><br><br>
				<section class="section">
					<div class="row">
					<div class="col-lg-9">
					<div class="card">
					<div class="card-body">
					<h5 class="card-title"></h5>
						<c:if test="${memberId ne 'admin' }">		        
							<div class="d-flex col-md-12 justify-content-end">
								<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showModifyPage();">수정</button>
								<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="deleteGoods();">삭제</button>
								<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showGoodsList();">목록</button>
							</div>
						</c:if>
						<c:if test="${memberId ne 'admin' }">		        
							<div class="d-flex col-md-12 justify-content-end">
								<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showGoodsList();">목록</button>
							</div>
						</c:if>
					<br>
					<!-- Default Table -->
					<table class="table table-striped">
						<tbody>
							<tr>
								<td width="170px">상품코드</td>
								<td><p class="goodsCode">${goods.goodsCode }</p></td>
							</tr>
							<tr>
								<td>상품명</td>
								<td>${goods.goodsName }</td>
							</tr>
							<tr>
								<td>가격</td>
<%-- 								<td>${goods.goodsPrice }원</td> --%>
								<td>₩<fmt:formatNumber value="${goods.goodsPrice }" pattern="###,###,###"/></td>
							</tr>
							<c:if test="${goods.goodsFileRename ne null }">
								<tr>
									<td>첨부파일</td>
									<td><img src='../resources/guploadFiles/${goods.goodsFileRename }'></td>
								</tr>
							</c:if>
							<tr>
								<td>내용</td>
								<td>${goods.goodsContent }</td>
							</tr>
						</tbody>
					</table>
							<p class="cartStock">
							<span>구입 수량</span>
							<input class="numBox" type="number" min="1" max="${goods.goodsStock}" value="1" />  
							</p>						
					</div>
					</div>
					</div>
					</div>
					<p class="addToCart">
 						<button type="button" class="addCart_btn">카트에 담기</button>
					</p>
				</section>
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script>
			$(".addCart_btn").click(function(){
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