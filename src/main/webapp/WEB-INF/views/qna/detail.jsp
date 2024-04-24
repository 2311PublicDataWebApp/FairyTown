<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	</head>
	<body>
		<h1>게시글 상세 페이지</h1>
		<ul>
			<li>
				<label>번호</label>
				<span>${qna.qnaNo }</span>
			</li>
			<li>
				<label>제목</label>
				<span>${qna.qnaName }</span>
			</li>
			<li>
				<label>작성자</label>
				<span>${userId}</span>
			</li>
			<li>
				<label>내용</label>
				<span>${qna.qnaContent }</span>
			</li>
			<li>
				<label>날짜</label>
				<span>${qna.qnaDate }</span>
			</li>
			<li>
				<label>답변상태</label>
				<span>${qna.qnaStatus }</span>
			</li>
		</ul>
		<div>
			<button type="button" onclick="showQnaList();">목록으로</button>
			<button type="button" onclick="deleteQna(${qna.qnaNo});">삭제하기</button>
			<button type="button" onclick="showModifyPage();">수정하기</button>
		</div>
		
		<!-- 댓글등록 -->
		<br>
<!-- 	<form action="/reply/add.kh" method="post"> -->
			<input type="hidden" name="refQnaNo" value="${qna.qnaNo }" id="refQnaNo">
			<table width="500" border="1">
				<tr>
					<td>
						<input type="text" name="qnaReplyContent" id="qnaReplyContent" size="20">
					</td>
					<td>
<!-- 					<input type="submit" value="등록하기"> -->
						<button id="rSubmit">등록하기</button>
					</td>
			</table>
<!-- 	</form> -->
		<!-- 댓글 목록 -->
		<table width="550" border="1" id="qnaReplyTable">
			<tbody>
<%-- 			<c:forEach items="${rList }" var="reply">
	 				<tr>
	 					<td>${reply.replyWriter }</td>
	 					<td>${reply.replyContent }</td>
	 					<td>${reply.rCreateDate }</td>
	 					<td>
	 						<a href="#">수정</a>
	 						<a href="#">삭제</a>
	 					</td>
	 				</tr>
	 			</c:forEach> --%>
			</tbody>
		</table>

		<script>
		
			function showModifyPage() {
				var qnaNo = "${qna.qnaNo }";
				location.href = "/qna/modify.ft?qnaNo=" + qnaNo;
			}	
		
			function deleteQna(qnaNo) {
				if (confirm("삭제하시겠습니까?")) {
					location.href = "/qna/delete.ft?qnaNo=" + qnaNo;
				}
			}
			
			function showQnaList() {
				location.href = "/qna/list.ft";
			}
			
			
			getReplyList();
			function getReplyList() {
				var refQnaNo = $("#refQnaNo").val();
				$.ajax({
					url : "/qreply/list.ft",
					data : { "refQnaNo" : refQnaNo},
					type : "GET",
					success : function(result) {
// 						console.log(result)
						var tableBody = $("#qnaReplyTable tbody")
						tableBody.empty();
						var tr;
						var qnaReplyWriter;
						var qnaReplyContent;
						var qnaReplyDate;
						var btnArea;
// 						var sessionId = "${userId}";
						if (result.length > 0) {
							for (var i in result) {
								var qnaReplyWriterVal = result[i].qnaReplyWriter;
								var qnaReplyContentVal = result[i].qnaReplyContent;
								var qnaReplyDateVal = result[i].qnaReplyDate;
								var qnaReplyNoVal = result[i].qnaReplyNo;
								tr = $("<tr>"); //<tr></tr>
								qnaReplyWriter = $("<td>").text(qnaReplyWriterVal);
								qnaReplyContent = $("<td>").text(qnaReplyContentVal);
								qnaReplyDate = $("<td width='100'>").text(qnaReplyDateVal);
								btnArea = $("<td width='150'>")
									.append("<a href='javascript:void(0)' onclick='modifyViewReply(this, " + qnaReplyNoVal + ", \"" + qnaReplyContentVal + "\");'>수정</a> ")
									.append("<a href='javascript:void(0)' onclick='removeReply(" + qnaReplyNoVal + ");'>삭제</a>");
								tr.append(qnaReplyWriter);
								tr.append(qnaReplyContent);
								tr.append(qnaReplyDate);
								tr.append(btnArea);
								tableBody.append(tr);
							}
						}
					},
					error : function() {
						alert("서버 통신 실패!")
					}
				});
			}
			
			function modifyViewReply(obj, rNo, rContent) {
// 				console.log(obj);
				var tr = $("<tr>");
				tr.append("<td colspan = '3'><input type='text' size='50' value='" + rContent + "'></td>");
				tr.append("<td><button type='button' onclick='modifyReply(" + rNo + ", this);'>수정완료</button></td>");
				$(obj).parent().parent().after(tr);
// 				$("#replyTable tbody").append(tr);
// 				$("<td>").append("<inut type='text'>")
			}
			
			function modifyReply(qnaReplyNo, obj) {
				var inputTag  = $(obj).parent().prev().children(); // input 태그
				var qnaReplyContent = inputTag.val();
				$.ajax({
					url : "/qreply/modify.ft",
					data : { 
						"qnaReplyNo" : qnaReplyNo
						, "qnaReplyContent" : qnaReplyContent },
					type: "POST",
					success : function() {
						getReplyList();
					},
					error : function() {
						alert("서버 통신 실패!");
					}
				});
			}
			
			function removeReply(qnaReplyNo) {
				var refQnaNo = $("#refQnaNo").val();
				$.ajax({
					url : "/qreply/remove.ft",
					data : { "refQnaNo" : refQnaNo
						, "qnaReplyNo" : qnaReplyNo },
					type : "POST",
					success : function(result) {
// 						location.href = "/board/detail.kh?boardNo=" + refBoardNo;
						getReplyList();
					},
					error : function() {
						alert("서버 통신 실패!");
					} 
				});
			}
			
			$("#rSubmit").on("click", function() {
				var refQnaNo = $("#refQnaNo").val();
				var qnaReplyContent = $("#qnaReplyContent").val();
				$.ajax({
					url : "/qreply/add.ft",
					data : {"refQnaNo" : refQnaNo
						, "qnaReplyContent" : qnaReplyContent},
					type : "POST",
					success : function(result) {
// 						location.href = "/board/detail.kh?boardNo=" + refBoardNo;
						getReplyList();
						$("#qnaReplyContent").val("");
					},
					error : function() {
						alert("서버 통신 실패!");
					}
				});
			});
		</script>
	</body>
	</html>