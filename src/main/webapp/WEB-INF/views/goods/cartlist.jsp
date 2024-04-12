<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 장바구니 목록</title>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-list">
			<h1><b>굿즈 목록</b></h1>
			<br><br><br>				
				<table class="table table-hover">
					<thead>
						<tr>
							<th></th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>상품가격</th>
							<th>상품수량</th>
							<th>상품 합계 가격</th>
						</tr>
					</thead>
					<tbody>
					<ul>
						<li>
								 <div class="allCheck">
								  	<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
								 </div>
							<form action="/goods/deleteCart.ft" method="post" name="deleteCartForm">							
							 	<input type="hidden" id="check-delete-cart" name="check-delete-cart">
                            </form>
						  	<button type="button" class="selectDelete_btn" onclick="getDeleteCart();">선택 삭제</button> 
                            <form action="/goods/order.ft" method="post" name="orderCartForm">							
								 <div class="orderBtn">
								 	<input type="hidden" id="check-order-cart" name="check-order-cart">
								 </div>
                            </form>
						  	<button type="button" class="selectOrder_btn" onclick="getOrderCart();">선택 주문</button> 
						</li>
						<li>
						<c:forEach items="${cList }" var="cart" varStatus="i">            
							<tr>
								<td>
									<div class="checkBox">
									   <input type="checkbox" name="chBox" class="chBox" value="${cart.cartNum}" data-cartNum="${cart.cartNum}" />
									</div>
								</td>
								<td><img src="../resources/guploadFiles/${cart.goodsFileRename }" width="30px"></td>
								<td>${cart.cartGoodsCode }</td>
								<td><a href="/goods/detail.ft?goodsCode=${cart.cartGoodsCode }">${cart.goodsName }</a></td>
								<td><fmt:formatNumber value="${cart.goodsPrice }" pattern="###,###,###"/>원</td>
								<td><input class="numBox" type="number" cmin="1" max="${cart.cartStock}" value="${cart.cartStock }" /></td>
								<td><fmt:formatNumber pattern="###,###,###" value="${cart.goodsPrice * cart.cartStock}" />원</td>
								<%-- <td>
									<div class="delete">
										<button type="button" class="delete_${cart.cartNum}_btn" data-cartNum="${cart.cartNum}">삭제</button>
									</div>
								</td> --%>
							</tr>
						</c:forEach>
						</li>
					</ul>
					</tbody>
				</table>
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
		</script>
		<script>
		function showInsertForm() {
			// 공지사항 글쓰기 페이지 이동
			location.href="/goods/insert.ft";
		}
		</script>
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>