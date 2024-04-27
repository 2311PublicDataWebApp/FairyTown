
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 장바구니 목록</title>
		<style>
			#cart-list {
				margin: auto;
				width:1200px;
			}
			ul{
			   list-style:none;
			}
			.list {
			  color: gray;
			}
		</style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="cart-list">
			<h1 style="text-align:center;"><b>장바구니</b></h1>
			<br><br><br><br><br><br><br><br>				
					<ul>
						<li>
							 <div class="allCheck" style="float:left; margin: 0 0 0 -25px;">
							  	<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">&nbsp모두 선택</label> 
							 </div>
							<form action="/goods/deleteCart.ft" method="post" name="deleteCartForm">							
							 	<input type="hidden" id="check-delete-cart" name="check-delete-cart">
                            </form>
                            <button type="button" id="selectDelete_btn" class="btn" style="float:left; background-color: #FAFAFA; border-color: #e9ecef; margin: 0 0 0 25px;" onclick="getDeleteCart();">선택 삭제</button>
                            <form action="/goods/orderInfo.ft" method="post" name="orderCartForm">							
								 <div class="orderBtn">
								 	<input type="hidden" id="check-order-cart" name="check-order-cart">
								 </div>
                            </form>
                            <button type="button" id="selectOrder_btn" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef; margin: 0 0 0 25px;" onclick="getOrderCart();">선택 주문</button> 
						</li>
					</ul>
					<br><br><br>
					<c:if test="${totalCount eq 0 }">
						<h3 style="text-align:center;"><b>장바구니가 비어있습니다</b></h3>
						<h5 style="text-align:center;"><a href="/goods/list.ft" class="list">지금 굿즈 보러 가기 &#129146;</a></h5>
					</c:if>
					<c:if test="${totalCount ne 0 }">	
					<div id="totalCount">총 ${totalCount }개</div>
					<table class="table table-hover">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>상품가격</th>
							<th>상품수량</th>
							<th>상품 합계 가격</th>
						</tr>
					</thead>
					<tbody>
						
						<div id="mainTbody">
						<c:forEach items="${cList }" var="cart" varStatus="i">            
							<tr>
								<td style="padding: 30px 0">
									<div class="checkBox">
										<c:if test="${cart.goodsStock ne 0 }">
										   <input type="checkbox" name="chBox" class="chBox" value="${cart.cartNum}" data-cartNum="${cart.cartNum}" />
										</c:if>
									</div>
								</td>
								<td style="position:relative;">
									<c:if test="${cart.goodsStock ne 0 }">
										<img src="../resources/guploadFiles/${cart.goodsFileRename }" width="100px" height="70px">
									</c:if>
									<c:if test="${cart.goodsStock eq 0 }">
										<img src="../resources/guploadFiles/${cart.goodsFileRename }" width="100px" height="70px" style="filter: brightness(50%);">
										<img src="../resources/guploadFiles/soldout.png" style="width:35%; position: absolute; top: 10px; left: 10px;">
									</c:if>
								</td>
								<td style="padding: 30px 0">${cart.cartGoodsCode }</td>
								<td style="padding: 30px 0"><a href="/goods/detail.ft?goodsCode=${cart.cartGoodsCode }">${cart.goodsName }</a></td>
								<td style="padding: 30px 0">₩<fmt:formatNumber value="${cart.goodsPrice }" pattern="###,###,###"/></td>
								<td style="padding: 30px 0">
									<input type="hidden" value="${cart.goodsPrice}">
									<c:if test="${cart.goodsStock eq 0 }">
										<input id="numBox${i.count}" name="numBox${i.count}" class="numBox${i.count}" type="number" min="0" max="${cart.goodsStock}" value="0"/>
									</c:if>
									<c:if test="${cart.goodsStock ne 0 }">
										<input id="numBox${i.count}" name="numBox${i.count}" class="numBox${i.count}" type="number" min="1" max="${cart.goodsStock}" value="${cart.cartStock }"/>
									</c:if>
									<input type="hidden" value="${cart.cartNum}" name="cartNum${i.count}" id="cartNum${i.count}" class="cartNum${i.count}">
								</td>
								<td style="padding: 30px 0">₩<fmt:formatNumber pattern="###,###,###" value="${cart.goodsPrice * cart.cartStock}" /></td>
							</tr>
						</c:forEach>
						</div>
					</tbody>
				</table>
				</c:if>
		</div>
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script>
			$("#allCheck").click(function(){
				 var chk = $("#allCheck").prop("checked");
				 if(chk) {
				  $(".chBox").prop("checked", true);
				 } else {
				  $(".chBox").prop("checked", false);
				 }
			});
			$(".chBox").click(function(){
				$("#allCheck").prop("checked", false);
			});
			
			function getDeleteCart(){
	    		// 체크된 input 요소 선택
	    		var checkedCheckboxes = document.querySelectorAll('input[name="chBox"]:checked');

	    		// 체크된 input 요소의 값을 저장할 배열
	    		var checkedValues = [];

	    		// 각 체크된 input 요소의 값을 배열에 추가
	    		checkedCheckboxes.forEach(function(checkbox) {
	    		    checkedValues.push(checkbox.value);
	    		});

	    		// 배열에 저장된 값 확인
	    		console.log(checkedValues);
	    		
	    		//체크 된 상품 없을 시 오류 메세지 출력
	    		if(checkedValues.length == 0){
	    			alert("체크된 상품이 없습니다.");
	    		}
	    		else{
	    			document.getElementById('check-delete-cart').value = checkedValues.join(',');
	    			deleteCartForm.submit();
	    	    }
	    	}
			
			function getOrderCart(){
	    		// 체크된 input 요소 선택
	    		var checkedCheckboxes = document.querySelectorAll('input[name="chBox"]:checked');

	    		// 체크된 input 요소의 값을 저장할 배열
	    		var checkedValues = [];

	    		// 각 체크된 input 요소의 값을 배열에 추가
	    		checkedCheckboxes.forEach(function(checkbox) {
	    		    checkedValues.push(checkbox.value);
	    		});

	    		// 배열에 저장된 값 확인
	    		console.log(checkedValues);
	    		
	    		//체크 된 상품 없을 시 오류 메세지 출력
	    		if(checkedValues.length == 0){
	    			alert("체크된 상품이 없습니다.");
	    		}
	    		else{
	    			document.getElementById('check-order-cart').value = checkedValues.join(',');
	    			orderCartForm.submit();
	    	    }
	    	}

			function showInsertForm() {
				// 글쓰기 페이지 이동
				location.href="/goods/insert.ft";
			}
			
			<c:forEach items="${cList}" var="cart" varStatus="i">
				$("#numBox${i.count}").on("change", function() {
					var changeCount = "";
					var cartNum;
					var numBox;
					cartNum = $("#cartNum${i.count}").val();
	        		numBox = $("#numBox${i.count}").val();
					changeCount += "{cartNum: "+ cartNum +", cartStock : "+numBox+"}/";
	        		var price = parseInt(this.previousElementSibling.value);
	     			var totalTd = this.parentElement.nextElementSibling;
					$.ajax({
	        			url: "/goods/cartCnt.ft",
	        			data: { "changeCount" : changeCount},
	        			type: "POST",
	        			success: function(result) {
	        				totalTd.innerHTML = '';
	        				totalTd.innerHTML = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(price * numBox);
	        			},
	        			error: function() {
	        				alert("Ajax 통신 실패! 관리자에게 문의바랍니다.")
	        			}
	        		});
				});
			</c:forEach>

		</script>
	</body>
</html>
