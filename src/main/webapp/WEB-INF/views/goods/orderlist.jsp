<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 내역</title>
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="order-detail">
			<h1><b>주문 내역</b></h1>
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
									<td>주문 날짜</td>
									<td>주문 번호</td>
									<td>주문 상태</td>
								</tr>
							<c:forEach items="${oList }" var="oList" varStatus="i">
								<tr>
									<td><p class="goodsOrderDate">${oList.goodsOrderDate }</p></td>
									<td><p class="goodsOrderCode"><a href="/goods/orderDetail.ft?goodsOrderCode=${oList.goodsOrderCode }">${oList.goodsOrderCode }</p></td>
									<td width="170px">결제완료</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12">
					<nav aria-label="Page navigation example">					
						<ul class="pagination justify-content-center" style="font-weight: 600; ">
							<c:if test="${pi.startNavi ne '1' }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/goods/orderList.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a class="page-link rounded-circle mx-2" href="/goods/orderList.ft?page=${p }" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/goods/orderList.ft?page=${pi.endNavi + 1 }" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>						
					</div>
					</div>
					</div>
					</div>
				</section>
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		
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