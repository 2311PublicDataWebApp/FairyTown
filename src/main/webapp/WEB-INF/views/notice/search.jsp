<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>공지사항 검색</title>
    	<!-- <link rel="stylesheet" href="../resources/css/main.css"> -->
    	<style>
    		#notice-search {
    			width: 1200px;
    			margin: auto;
    		}
    	</style>
    </head>
    <body>
    	
    	<div id="notice-search">
        <h1><b>공지사항 목록</b></h1>
        <br><br><br>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성날짜</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${sList }" var="notice" varStatus="i">            
                <tr>
                    <td>${notice.noticeNo }</td>
                    <td><a href="/notice/detail.ft?noticeNo=${notice.noticeNo }">
                    ${notice.noticeSubject }
                    </a></td>
                    <td>${notice.userId }</td>
                    <td>${notice.noticeDate }</td>
                </tr>
            </c:forEach>
            </tbody>
          </table>
            	<c:if test="${memberId ne 'admin' }">
		        	<div class="d-flex flex-wrap justify-content-center align-items-center pb-5">
	                    <div class="d-flex col-md-12 justify-content-start">
	                        <form class="row g-1" action="/notice/search.ft" method="get">
	                            <div class="col-auto">
	                                <select class="form-select" name="searchCondition">
	                                <c:if test="${searchCondition eq 'all' }" >selected</c:if>
								<option value="all" <c:if test="${searchCondition eq 'all' }"> selected</c:if>>전체</option>
								<option value="writer" <c:if test="${searchCondition eq 'writer' }"> selected</c:if>>작성자</option>
								<option value="title" <c:if test="${searchCondition eq 'title' }"> selected</c:if>>제목</option>
								<option value="content" <c:if test="${searchCondition eq 'content' }"> selected</c:if>>내용</option>
	                                </select>
	                            </div>
	                            <div class="col-auto">
	                                <div class="input-group">
	                                    <input class="form-control" type="search" name="searchKeyword" value="${searchKeyword }">
	                                    <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
                    </div>
		        </c:if>
		         <c:if test="${memberId eq 'admin' }">
		         	<div class="d-flex flex-wrap justify-content-center align-items-center pb-5">
	                    <div class="d-flex col-md-6 justify-content-start">
	                        <form class="row g-1" action="/notice/search.ft" method="get">
	                            <div class="col-auto">
	                                <select class="form-select" name="searchCondition">
	                                <c:if test="${searchCondition eq 'all' }" >selected</c:if>
										<option value="all" <c:if test="${searchCondition eq 'all' }"> selected</c:if>>전체</option>
										<option value="writer" <c:if test="${searchCondition eq 'writer' }"> selected</c:if>>작성자</option>
										<option value="title" <c:if test="${searchCondition eq 'title' }"> selected</c:if>>제목</option>
										<option value="content" <c:if test="${searchCondition eq 'content' }"> selected</c:if>>내용</option>
	                                </select>
	                            </div>
	                            <div class="col-auto">
	                                <div class="input-group">
	                                    <input class="form-control" type="search" name="searchKeyword" value="${searchKeyword }">
	                                    <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
		               	<div class="d-flex col-md-6 justify-content-end">
			            	<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showInsertForm();">글쓰기</button>
						</div>
                    </div>
		        </c:if>
		        
				<!-- 페이지네이션 위치 -->
				<div class="row mt-3 mb-5" style="margin-top:300px;">
							<div class="col-md-12">
								<nav aria-label="Page navigation example">					
									<ul class="pagination justify-content-center" style="font-weight: 600; ">
										<c:if test="${pi.startNavi ne '1' }">
				<%-- 							<a href="/notice/list.do?page=${pi.startNavi - 1 }">[이전]</a> --%>
											<li class="page-item">
						                       <a class="page-link rounded-circle" href="/notice/search.ft?page=${pi.startNavi - 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Previous">
						                           <span aria-hidden="true">&laquo;</span>
						                       </a>
											</li>
										</c:if>
										<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
											 <li class="page-item">
			                                     <a class="page-link rounded-circle mx-2" href="/notice/search.ft?page=${p }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="border: none; color: #313131;">
			                                         ${p }
			                                     </a>
		                                 	</li>
<%-- 											<a href="/notice/list.do?page=${p }">${p }</a> --%>
										</c:forEach>
										<c:if test="${pi.endNavi ne pi.naviTotalCount }">
											<li class="page-item">
			                                     <a class="page-link rounded-circle" href="/notice/search.ft?page=${pi.endNavi + 1 }&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" aria-label="Next">
			                                         <span aria-hidden="true">&raquo;</span>
			                                     </a>
		                                 	</li>
<%-- 											<a href="/notice/list.do?page=${pi.endNavi + 1 }">[다음]</a> --%>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>
				</div>
		<%-- <jsp:include page="../inc/footer.jsp"></jsp:include> --%>
        <script>
			function showInsertForm() {
				// 공지사항 글쓰기 페이지 이동
				location.href="/admin/notiregister";
			}
		</script>
    </body>
</html>