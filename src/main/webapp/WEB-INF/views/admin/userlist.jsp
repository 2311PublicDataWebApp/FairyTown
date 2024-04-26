<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<main>
	    <div class="container">
	        <div class="row justify-content-center">
	            <div class="col-md-12">
	                <div class="container mt-3" id="member-manager">
	                    <h3>회원 관리</h3>
	                    <hr>
	                    <div class="input-group mb-3">
	                        <div class="form-inline">
	                            <form class="form-inline" id="search" action="/admin/userlist.ft" method="GET">
	                                <div class="input-group">
	                                    <div class="input-group-prepend">
	                                        <select class="custom-select" name="type">
	                                            <option value="name" selected>이름</option>
	                                            <option value="id">아이디</option>
	                                            <option value="email">이메일</option>
	                                            <option value="userSt">활동상태</option>
	                                        </select>
	                                    </div>
	                                    <input class="form-control" type="search" placeholder="검색어를 입력하세요" aria-label="Search" value="" name="keyword">
	                                    <div class="input-group-append">
	                                        <button class="btn btn-outline-success" type="submit">검색</button>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	                    </div>
	                    <div id="board-list">
	                        <div class="container" id="board-list-container">
	                            <table class="table table-bordered table-hover">
	                                <thead class="thead-dark">
	                                <tr>
	                                    <th scope="col">이름</th>
	                                    <th scope="col">아이디</th>
	                                    <th scope="col">이메일</th>
	                                    <th scope="col">연락처</th>
	                                    <th scope="col">생년월일</th>
	                                    <th scope="col">활동상태</th>
	                                    <th scope="col">가입일</th>
	                                    <th scope="col">세션 상태</th>
	                                </tr>
	                                </thead>
	                                <tbody>
	                                <c:forEach items="${uList}" var="user" varStatus="i">
	                                <tr onclick="pop('${user.userId}')">
										<td>${user.realName}</td>
										<td>${user.userId}</td>
										<td>${user.userEmail}</td>
										<td>${user.userPhone}</td>
										<td>${user.userBirthDate}</td>
										<td>
											<c:if test="${user.userSt eq 'N'}">
			                                	정상
			                                </c:if>
			                                <c:if test="${user.userSt eq 'B'}">
			                                	활동 정지
			                                </c:if>
										</td>
										<td>${user.userDate}</td>
										<td>
										    <c:if test="${user.loginSt == 'K'}"> Kakao </c:if>
										    <c:if test="${user.loginSt == 'B'}"> Normal </c:if>
										    <c:if test="${user.loginSt == 'N'}"> Naver </c:if>
										    <c:if test="${user.loginSt == 'G'}"> Google </c:if>
										</td>
									</tr>
	                                </c:forEach>
	                                </tbody>
	                                <tfoot>
									    <tr>
									        <td colspan="8">
									            <nav aria-label="Page navigation">
									                <ul class="pagination justify-content-center">
									                    <c:if test="${not empty keyword}">
									                        <c:if test="${pInfo.startNavi ne '1'}">
									                            <li class="page-item">
									                                <a class="page-link" href="/admin/userlist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}" aria-label="Previous">
									                                    <span aria-hidden="true">&laquo;</span>
									                                </a>
									                            </li>
									                        </c:if>
									                        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
									                            <li class="page-item <c:if test="${p == param.page}">active</c:if>">
									                                <a class="page-link" href="/admin/userlist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
									                            </li>
									                        </c:forEach>
									                        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
									                            <li class="page-item">
									                                <a class="page-link" href="/admin/userlist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}" aria-label="Next">
									                                    <span aria-hidden="true">&raquo;</span>
									                                </a>
									                            </li>
									                        </c:if>
									                    </c:if>
									                    <c:if test="${empty keyword}">
									                        <c:if test="${pInfo.startNavi ne '1'}">
									                            <li class="page-item">
									                                <a class="page-link" href="/admin/userlist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}" aria-label="Previous">
									                                    <span aria-hidden="true">&laquo;</span>
									                                </a>
									                            </li>
									                        </c:if>
									                        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
									                            <li class="page-item <c:if test="${p == param.page}">active</c:if>">
									                                <a class="page-link" href="/admin/userlist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
									                            </li>
									                        </c:forEach>
									                        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
									                            <li class="page-item">
									                                <a class="page-link" href="/admin/userlist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}" aria-label="Next">
									                                    <span aria-hidden="true">&raquo;</span>
									                                </a>
									                            </li>
									                        </c:if>
									                    </c:if>
									                </ul>
									            </nav>
									        </td>
									    </tr>
									</tfoot>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</main>

    <script type="text/javascript">
    	//유저 정보 상세조회 창 열기
    	function pop(userId)
    	{
        	window.open("/admin/userdetail.ft?userId=" + userId, "pop", "width=500,height=800,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
    	}
    </script>
</body>
</html>