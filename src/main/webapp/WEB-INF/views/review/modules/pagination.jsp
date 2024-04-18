<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 | 페이지네이션</title>
</head>
<body>
	<div class="row mt-3 mb-5" style="margin-top:300px;">
    <div class="col-md-12">
        <nav aria-label="Page navigation example">                    
            <ul class="pagination justify-content-center" style="font-weight: 600; ">
                <c:if test="${pi.startNavi ne '1' }">
                    <li class="page-item">
                        <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
                    <li class="page-item">
                        <a class="page-link rounded-circle mx-2" href="/review/list.ft?page=${p }" style="border: none; color: #313131;">
                            ${p }
                        </a>
                    </li>
                </c:forEach>
                <c:if test="${pi.endNavi ne pi.naviTotalCount }">
                    <li class="page-item">
                        <a class="page-link rounded-circle" href="/review/list.ft?page=${pi.endNavi + 1 }" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>