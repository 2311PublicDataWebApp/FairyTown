<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성날짜</th>
					<th>답변상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${qList }" var="qna">
					<tr>
						<td>${qna.qnaNo }</td>
						<td><a href="/qna/detail.ft?qnaNo=${qna.qnaNo }">${qna.qnaName }</a></td>
						<td>${qna.qnaWriter }</td>
						<td>${qna.qnaDate }</td>
						<td>${qna.qnaStatus }</td>
					</tr>
				</c:forEach>
			</tbody>
					<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showInsertForm();">글쓰기</button>
			<tfoot>
				<tr align = "center">
					<td colspan = "5">
						<c:if test="${pInfo.startNavi != 1 }">
							<a href="/qna/list.ft?page=${pInfo.startNavi - 1 }">이전</a>
						</c:if>
						<c:forEach begin="${pInfo.startNavi }" end="${pInfo.endNavi }" var="p">
							<a href="/qna/list.ft?page=${p }">${p }</a>
						</c:forEach>
						<c:if test="${pInfo.endNavi != pInfo.naviTotalCount }">
							<a href="/qna/list.ft?page=${pInfo.endNavi + 1 }">다음</a>
						</c:if>
					</td>
				</tr>
			</tfoot>
		</table>
		<script>
		function showInsertForm() {
			// 공지사항 글쓰기 페이지 이동
			location.href="/qna/insert.ft";
		}
		</script>
	</body>
</html>