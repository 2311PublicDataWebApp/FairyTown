<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 상세 조회</title>
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="order-detail">
			<h1><b>주문 상세 조회</b></h1>
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
								<td width="170px">주문번호</td>
								<td><p class="goodsOrderCode">${oList[0].goodsOrderCode }</p></td>
							</tr>
							
								<tr>
									<td><br>상품 정보</td>
									<td>
									<c:forEach items="${oList }" var="oList" varStatus="i">
									<br>
									<img src='../resources/guploadFiles/${oList.goodsFileRename }' width="300px">
									${oList.goodsName }
									<br><br>
									</c:forEach>
									</td>
								</tr>
							<tr>
								<td>총 가격</td>
<%-- 								<td>${goods.goodsPrice }원</td> --%>
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
					</div>
					</div>
					</div>
					<form name="cancelPay" action="/goods/cancelPay.ft" method="post" autocomplete="off">
						<input type="hidden" name="cancelArray" id="cancelArray" value="">
						<input type="hidden" name="goodsOrderCode" value="${oList[0].goodsOrderCode }">
						<input type="hidden" name="merchantUid" value="${oList.get(0).merchantUid }">
						<button type="button" class="payment" onclick="cancel();">주문취소</button>
					</form>
				</section>
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<!-- iamport.payment.js -->
	    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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