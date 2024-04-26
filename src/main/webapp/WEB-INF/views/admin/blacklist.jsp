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
			            <h3>블랙리스트 관리</h3>
			            <hr>
			            <div class="input-group mb-3">
			                <form class="form-inline" id="search" action="/admin/blacklist.ft" method="GET">
			                    <div class="input-group-prepend">
			                        <select class="custom-select" name="type">
			                            <option value="name" selected>이름</option>
			                            <option value="id">아이디</option>
			                            <option value="email">이메일</option>
			                        </select>
			                    </div>
			                    <input class="form-control" type="search" placeholder="검색어를 입력하세요" aria-label="Search" name="keyword">
			                    <div class="input-group-append">
			                        <button class="btn btn-outline-success" type="submit">검색</button>
			                    </div>
			                </form>
			                <form action="/admin/white.ft" method="post" class="ml-2">
			                    <input type="hidden" id="check-white-users" name="check-white-users">
			                    <button type="submit" class="btn btn-dark" onclick="getWhiteUsers();">블랙 리스트 해제</button>
			                </form>
			            </div>
			            <div id="board-list">
			                <div class="container" id="board-list-container">
			                    <table class="table table-bordered table-hover">
			                        <thead class="thead-dark">
			                            <tr>
			                                <th scope="col">이름</th>
			                                <th scope="col">아이디</th>
			                                <th scope="col">이메일</th>
			                                <th scope="col">활동상태</th>
			                                <th scope="col">정지일</th>
			                                <th scope="col">정지 종료일</th>
			                                <th scope="col">선택/해제</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                            <c:forEach items="${userWithBlackList}" var="userWithBlackList" varStatus="i">
			                               <tr>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">${userWithBlackList.user.realName}</td>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">${userWithBlackList.user.userId}</td>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">${userWithBlackList.user.userEmail}</td>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">
			                                   		<c:if test="${userWithBlackList.user.userSt eq 'N'}">
			                                   			정상 활동
			                                   		</c:if>
			                                   		<c:if test="${userWithBlackList.user.userSt eq 'B'}">
			                                   			활동 정지
			                                   		</c:if>
			                                   </td>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">${userWithBlackList.blackList.regiDate}</td>
			                                   <td onclick="pop('${userWithBlackList.user.userId}');">${userWithBlackList.blackList.stopDate}</td>
			                                   <td><input type="checkbox" name="select-user" value="${userWithBlackList.user.userId}"></td>
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
													        <li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            <a class="page-link" href="/admin/blacklist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">
													            	<span aria-hidden="true">&laquo;</span>
													            </a>
													        </li>
													        </c:if>
													        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
													            <li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            	<a class="page-link" href="/admin/blacklist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
													        	</li>
													        </c:forEach>
													        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
													        	<li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            	<a class="page-link" href="/admin/blacklist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">
													            		<span aria-hidden="true">&raquo;</span>
													            	</a>
													        	</li>
													        </c:if>
													</c:if>
													<c:if test="${empty keyword}">
													        <c:if test="${pInfo.startNavi ne '1'}">
													        	<li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            	<a class="page-link" href="/admin/blacklist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">
													            		<span aria-hidden="true">&laquo;</span>
													            	</a>
													        	</li>
													        </c:if>
													        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
													        	<li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            	<a class="page-link" href="/admin/blacklist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
													        	</li>
													        </c:forEach>
													        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
													        	<li class="page-item <c:if test="${p == param.page}">active</c:if>">
													            	<a class="page-link" href="/admin/blacklist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">
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
    	function pop(userId)
    	{
        	window.open("/admin/blackdetail.ft?userId=" + userId, "pop", "width=500,height=500,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
    	}
    	
    	//블랙리스트 해제할 유저 목록
    	function getWhiteUsers(){
    		// 체크된 input 요소 선택
    		var checkedCheckboxes = document.querySelectorAll('input[name="select-user"]:checked');

    		// 체크된 input 요소의 값을 저장할 배열
    		var checkedValues = [];

    		// 각 체크된 input 요소의 값을 배열에 추가
    		checkedCheckboxes.forEach(function(checkbox) {
    		    checkedValues.push(checkbox.value);
    		});

    		// 배열에 저장된 값 확인
    		console.log(checkedValues);
    		
    		//체크 된 회원 없을 시 오류 메세지 출력
    		if(checkedValues.length == 0){
    			alert("체크된 회원이 없습니다.");
    		}
    		else{
    			document.getElementById('check-white-users').value = checkedValues.join(',');
    	    }
    	}
    </script>
</body>
</html>