<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<main>
       <div class="col-md-10" id="" style="display: flex; justify-content: center;">
       <div class="container mt-3" id="member-manager">
           <h3>회원 관리</h3>
           <hr>
           <div class="input-group mr-sm-2">
               <div class="form-inline">
               	<form class="form-inline" id="search" action="/admin/userlist.ft" method="GET">
                       <span class="input-group-prepend">
                           <select class="custom-select" name="type">
                               <option value="name" selected>이름</option>
                               <option value="id">아이디</option>
                               <option value="email">이메일</option>
                               <option value="userSt">활동상태</option>
                           </select>
                       </span>
                       <input class="form-control" type="search" placeholder="검색어를 입력하세요" aria-label="Search"
                       value="" name="keyword">
                       <span class="input-group-append">
                           <button class="btn btn-outline-success" type="submit">검색</button>
                       </span>
                   </form>
                 </div>
               </div>
               <br>
                   <div id="board-list">
                       <div class="container" id="board-list-container">
                           <table class="board-table">
                               <thead>
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
	                               <tr>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.realName}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userId}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userEmail}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userPhone}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userBirthDate}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userSt}</a></td>
	                                   <td><a href="javascript:void(0);" onclick="pop('${user.userId}');">${user.userDate}</a></td>
	                                   <td>
	                                   		<c:if test="${user.loginSt == 'K'}">
	                                   			Kakao
	                                   		</c:if>
	                                   		<c:if test="${user.loginSt == 'B'}">
	                                   			Normal
	                                   		</c:if>
	                                   		<c:if test="${user.loginSt == 'N'}">
	                                   			Naver
	                                   		</c:if>
	                                   		<c:if test="${user.loginSt == 'G'}">
	                                   			Google
	                                   		</c:if>
	                                   </td>
	                               </tr>
                               </c:forEach>
                               </tbody>
                               <tfoot>
						<tr align="center">
							<c:if test="${not empty keyword}">
							    <td colspan="8">
							        <c:if test="${pInfo.startNavi ne '1'}">
							            <a href="/admin/userlist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">[이전]</a>
							        </c:if>
							        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
							            <a href="/admin/userlist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
							        </c:forEach>
							        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
							            <a href="/admin/userlist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">[다음]</a>
							        </c:if>
							    </td>
							</c:if>
							<c:if test="${empty keyword}">
							    <td colspan="8">
							        <c:if test="${pInfo.startNavi ne '1'}">
							            <a href="/admin/userlist.ft?page=${pInfo.startNavi - 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">[이전]</a>
							        </c:if>
							        <c:forEach begin="${pInfo.startNavi}" end="${pInfo.endNavi}" var="p">
							            <a href="/admin/userlist.ft?page=${p}&type=${pInfo.type}&keyword=${pInfo.keyword}">${p}</a>
							        </c:forEach>
							        <c:if test="${pInfo.endNavi ne pInfo.naviTotalCount}">
							            <a href="/admin/userlist.ft?page=${pInfo.endNavi + 1}&type=${pInfo.type}&keyword=${pInfo.keyword}">[다음]</a>
							        </c:if>
							    </td>
							</c:if>
						</tr>
					</tfoot>
                           </table>
                       </div>
                   </div>
           </div>
       </div>
    </main>
    <script type="text/javascript">
    	function pop(userId)
    	{
        	window.open("/admin/userdetail.ft?userId=" + userId, "pop", "width=400,height=500,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
    	}
    </script>
</body>
</html>