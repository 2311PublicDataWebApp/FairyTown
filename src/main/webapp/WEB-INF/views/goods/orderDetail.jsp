<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 상세 정보</title>
		<style>
			#order-detail {
				margin: auto;
				width:1000px;
			}
			.list {
			  color: lightgray;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="order-detail">
			<h1 style="text-align:center;"><b>주문 상세 정보</b></h1>
			<br><br><br>        
					<div class="d-flex col-md-12 justify-content-end">
						<form name="cancelPay" action="/goods/cancelPay.ft" method="post" autocomplete="off">
							<input type="hidden" name="cancelArray" id="cancelArray" value="">
							<input type="hidden" name="goodsOrderCode" value="${oList[0].goodsOrderCode }">
							<input type="hidden" name="merchantUid" value="${oList.get(0).merchantUid }">
							<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef; margin: 0 10px 0 0" onclick="cancel();">주문취소</button>
						</form>
						<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showOrderList();">주문내역</button>
					</div>
					<br>
					<!-- Default Table -->
					<table class="table table-striped">
						<tbody>
							<tr>
								<td>주문번호</td>
								<td><p class="goodsOrderCode">${oList[0].goodsOrderCode }</p></td>
							</tr>
							
								<tr>
									<td><br>상품 정보</td>
									<td>
									<c:forEach items="${oList }" var="oList" varStatus="i">
									<br>
									<img src='../resources/guploadFiles/${oList.goodsFileRename }' width="100px" height="70px">
									&nbsp&nbsp&nbsp<a href="/goods/detail.ft?goodsCode=${oList.goodsCode }">${oList.goodsName }</a>
									<br><br>
									</c:forEach>
									</td>
								</tr>
							<tr>
								<td>총 가격</td>
								<td><fmt:formatNumber value="${oList[0].goodsSum}" pattern="###,###,###"/>원</td>
							</tr>
							<tr>
								<td>주문날짜</td>
								<td>${oList[0].goodsOrderDate }</td>
							</tr>
							<tr>
								<td>수령인</td>
								<td>${oList[0].goodsOrderName }</td>
							</tr>
							<tr>
								<td>수령인 전화번호</td>
								<td>${oList[0].goodsOrderPhone }</td>
							</tr>
							<tr>
								<td>수령인 우편번호</td>
								<td>${oList[0].goodsOrderPostcode }</td>
							</tr>
							<tr>
								<td>수령인 주소</td>
								<td>${oList[0].goodsOrderAddress }</td>
							</tr>
						</tbody>
					</table>						
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<!-- iamport.payment.js -->
	    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
		<script type="text/javascript">
			function showOrderList() {
				location.href = "/goods/orderList.ft";
			}
			function cancel() {
				var cancelGoods = "";
				<c:forEach items="${oList }" var="oList" varStatus="i">
					cancelGoods += "{goodsCode: '${oList.goodsCode }',goodsOrderCnt : '${oList.goodsOrderCnt }'}/";
		        </c:forEach>
	        	document.getElementById('cancelArray').value = cancelGoods;
				  if(confirm("주문 취소하시겠습니까?")) {	
					  
					cancelPay.submit();
				  }
			}
		</script>
		
    </body>
</html>