<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 내역</title>
		<style>
			#order-list {
				margin: auto;
				width:1200px;
			}
			.list {
			  color: lightgray;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="order-list">
			<h1 style="text-align:center;"><b>주문 내역</b></h1>
			<br><br><br>
					<c:if test="${totalCount eq 0 }">
						<h3 style="text-align:center;"><b>주문내역이 존재하지 않습니다</b></h3>
						<h5 style="text-align:center;"><a href="/goods/list.ft" class="list">지금 굿즈 보러 가기 &#129146;</a></h5>
					</c:if>
					<c:if test="${totalCount ne 0 }">	
					<div id="totalCount">총 ${totalCount }개</div>
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
					<br><br><br>
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
				</c:if>
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    </body>
</html>