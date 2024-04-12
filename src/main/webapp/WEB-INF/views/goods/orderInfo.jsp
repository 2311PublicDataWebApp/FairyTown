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
							<th>상품이미지</th>
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
							<form action="/goods/deleteCart.ft" method="post">							
								 <div class="delBtn">
								 	<input type="hidden" id="check-delete-cart" name="check-delete-cart">
								  	<button type="submit" class="selectDelete_btn" onclick="getDeleteCart();">선택 삭제</button> 
								 </div>
                            </form>
                            <form action="/goods/order.ft" method="post">							
								 <div class="orderBtn">
								 	<input type="hidden" id="check-order-cart" name="check-order-cart">
								  	<button type="submit" class="selectOrder_btn" onclick="getOrderCart();">선택 주문</button> 
								 </div>
                            </form>
						</li>
						<li>
			
						<c:set var="sum" value="0" />${cList }
						<c:forEach items="${cList }" var="cart" varStatus="i">
							<tr>
								<td><img src="../resources/guploadFiles/${cart.goodsFileRename }" width="30px"></td>
								<td><a href="/goods/detail.ft?goodsCode=${cart.cartGoodsCode }">${cart.goodsName }</a></td>
								<td><fmt:formatNumber value="${cart.goodsPrice }" pattern="###,###,###"/>원</td>
								<td><input class="numBox" type="number" cmin="1" max="${cart.cartStock}" value="${cart.cartStock }" /></td>
								<td><fmt:formatNumber pattern="###,###,###" value="${cart.goodsPrice * cart.cartStock}" />원</td>
								
							</tr>
						<c:set var="sum" value="${sum + (cart.goodsPrice * cart.cartStock)}" />
						</c:forEach>
						</li>
					</ul>
					</tbody>
				</table>
					<div class="listResult">
					 <div class="sum">
					  총 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum}" />원
					 </div>
					 <div class="orderOpne">
					  주문 정보 입력
					 </div>
					 <div class="orderInfo">
					 <form role="form" method="post" autocomplete="off">
					  <c:forEach items="${cList }" var="cart" varStatus="i">            
						<input type="hidden" value="${cart.cartGoodsCode }" name="cartGoodsCode">
						<input type="hidden" value="${cart.cartUserId }" name="cartUserId">
						<input type="hidden" value="${cart.cartStock }" name="cartStock">
						<input type="hidden" value="${cart.goodsName }" name="goodsName">
						<input type="hidden" value="${cart.goodsPrice }" name="goodsPrice">
						<input type="hidden" value="${cart.goodsFileRename }" name="goodsFileRename">
					  </c:forEach>
					  <input type="hidden" name="amount" value="${sum}" />
					    
					  <div class="inputArea">
					   <label for="">수령인</label>
					   <input type="text" name="goodsOrderName" id="goodsOrderName" required="required" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="orderPhon">수령인 연락처</label>
					   <input type="text" name="goodsOrderPhone" id="goodsOrderPhone" required="required" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="userAddr1">우편번호</label>
					   <input type="text" name="goodsOrderPostcode" id="goodsOrderPostcode" required="required" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="userAddr2">1차 주소</label>
					   <input type="text" name="goodsOrderAddress" id="goodsOrderAddress" required="required" />
					  </div>
					  
					  
					    <input type="text" id="goodsOrderPostcode" placeholder="우편번호">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="roadAddress" placeholder="도로명주소">
						<input type="text" id="jibunAddress" placeholder="지번주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="detailAddress" placeholder="상세주소">
						<input type="text" id="extraAddress" placeholder="참고항목">
					  <div class="inputArea">
					   <button type="submit" class="order_btn">주문</button>
					   <button type="button" class="cancel_btn">취소</button> 
					  </div>
					  
					 </form> 
					</div>
					</div>
				
		</div>
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수
		
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('goodsOrderPostcode').value = data.zonecode;
		                document.getElementById("roadAddress").value = roadAddr;
		                document.getElementById("jibunAddress").value = data.jibunAddress;
		                
		                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		                if(roadAddr !== ''){
		                    document.getElementById("extraAddress").value = extraRoadAddr;
		                } else {
		                    document.getElementById("extraAddress").value = '';
		                }
		
		                var guideTextBox = document.getElementById("guide");
		                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
		                if(data.autoRoadAddress) {
		                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                    guideTextBox.style.display = 'block';
		
		                } else if(data.autoJibunAddress) {
		                    var expJibunAddr = data.autoJibunAddress;
		                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
		                    guideTextBox.style.display = 'block';
		                } else {
		                    guideTextBox.innerHTML = '';
		                    guideTextBox.style.display = 'none';
		                }
		            }
		        }).open();
		    }
		</script>
		<script>
			$(".cancel_btn").click(function(){
				location.href="/goods/cartList.ft";
			});      
		</script>
		<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>