<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>공지사항</title>
        <style>
        	#notice-detail {
        		margin: 0 0 0 450px;
        	}
        	
        </style>
    </head>
    <body>
    	<%-- <jsp:include page="../inc/header.jsp"></jsp:include> --%>
    	
    	
    	<div id="notice-detail">
		<main id="main" class="main">
		<div class="pagetitle">
			<h1><b>공지사항</b></h1>
		</div>
		<!-- End Page Title -->
		<br>
		<section class="section">
			<div class="row">
				<div class="col-lg-9">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title"></h5>
							<c:if test="${userId eq 'admin' }">		        
			        <div class="d-flex col-md-12 justify-content-end">
			            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showModifyPage();">수정</button>
			            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="deleteNotice(${notice.noticeNo});">삭제</button>
			            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showNoticeList();">목록</button>
					</div>
		        </c:if>
		        <c:if test="${memberId ne 'admin' }">		        
			        <div class="d-flex col-md-12 justify-content-end">
			            <button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showNoticeList();">목록</button>
					</div>
		        </c:if>
		        <br>
							<!-- Default Table -->
							<table class="table table-striped">
								<tbody>
									
										<tr>
											<td width="170px">번호</td>
											<td>${notice.noticeNo }</td>
										</tr>
										<tr>
											<td>제목</td>
											<td>${notice.noticeSubject }</td>
										</tr>
										<tr>
											<td>등록일</td>
											<td>${notice.noticeDate }</td>
										</tr>
										<c:if test="${notice.noticeFileRename ne null }">
										<tr>
											<td>첨부파일</td>
											<td><span><a style="color:black;" href='../resources/nuploadFiles/${notice.noticeFileRename }' download>${notice.noticeFileName }</a></span></td>
										</tr>
										</c:if>
										<tr>
											<td>내용</td>
											<td><c:out value="${notice.noticeContent}" escapeXml="false" /></td>
											<%-- <td><textarea rows="10" cols="95" style="border:0px; background-color:transparent" readonly>${notice.noticeContent }</textarea></td> --%>
										</tr>
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="section">
			<div class="row">
				<div class="col-lg-9">
					<div class="card">
						<div class="card-body">
							<!-- Default Table -->
							<input type="hidden" id="refNoticeNo" name="refNoticeNo" value="${notice.noticeNo }">
	            			<table class="table table-hover" border="0">
				                <tr>
				                    <td>
										<div class="row mb-3">
											<label for="inputText" class="col-sm-2 col-form-label">댓글</label>
											<div class="col-sm-10">
												<input type="text" id="replyContent" name="replyContent" class="form-control" style="margin: 0 0 0 20px">
											</div>
										</div>
									</td>
				                    <td>
			<!--                         <input type="submit" value="등록하기"> -->
										<div class="d-flex col-md-12 justify-content-end">
											<button type="button" id="rSubmit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
										</div>
	                    			</td>
	            				</table>
								<table class="table table-striped" border="1" id="replyTable">
									<tbody></tbody>
								</table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	</div>
    	
<%-- 		<jsp:include page="../inc/footer.jsp"></jsp:include>--%>	
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script type="text/javascript">
			function showModifyPage() {
				var noticeNo = "${notice.noticeNo }";
				location.href = "/notice/modify?noticeNo=" + noticeNo;
			}
			
			function deleteNotice(noticeNo) {
				if (confirm("삭제하시겠습니까?")) {
					location.href = "/notice/delete?noticeNo=" + noticeNo;
				}
			}
			
			function showNoticeList() {
				location.href = "/notice/list";
			}
			
			
			
			
			
			
			getReplyList();
        	function getReplyList() {
        		var refNoticeNo = $("#refNoticeNo").val();
        		$.ajax({
        			url: "/notice/reply/list",
        			data: {"refNoticeNo": refNoticeNo},
        			type: "GET",
        			success: function(result) {
        				var tableBody = $("#replyTable tbody");
        				//tableBody.empty();
        				tableBody.html("");
        				var tr;
        				var replyWriter;
        				var replyContent;
        				var rCreateDate;
        				var btnArea;
        				var sessionId = "${memberId}";
        				if(result.length > 0) {
        					for(var i in result) {
        						var replyWriterVal = result[i].replyWriter;
        						var replyContentVal = result[i].replyContent;
        						var rCreateDateVal = result[i].rCreateDate;
        						var replyNoVal = result[i].replyNo;
        						tr = $("<tr>") // <tr></tr>
        						replyWriter = $("<td width='140px'>").text(replyWriterVal); // <td></td>
        						replyContent = $("<td>").text(replyContentVal);
        						rCreateDate = $("<td width='150px'>").text(rCreateDateVal);
        						btnArea = $("<td width='90'>")
        						.append("<a href='javascript:void(0)' onclick='modifyViewReply(this, "+replyNoVal+", \""+ replyContentVal +"\");'>수정</a> ")
        						.append("<a href='javascript:void(0)' onclick='removeReply(" + replyNoVal + ");'>삭제</a>");
        						tr.append(replyWriter);
        						tr.append(replyContent);
        						tr.append(rCreateDate);
        						if(sessionId == replyWriterVal) {
        							tr.append(btnArea);
        						}
        						tableBody.append(tr);
        					}
        				}
        			},
        			error: function() {
        				alert("Ajax 통신 실패! 관리자에게 문의해주세요!");
        			}
        		})
        	}
        	
        	function modifyReply(replyNo, obj) {
        		var inputTag = $(obj).parent().prev().prev();
        		var replyContent = inputTag.val();
        		$.ajax({
        			url: "/notice/reply/update",
        			data: { "replyNo" : replyNo,
        					"replyContent" : replyContent },
        			type: "POST",
        			success: function(data) {
        				alert("서비스 결과: " + data);				
        				getReplyList();
        			},
        			error: function() {
        				alert("Ajax 통신 실패! 관리자에게 문의하십시오.")
        			}
        		})
        	}
        	
        	function modifyViewReply(obj, rNo, rContent) {
        		//console.log(obj);
        		var nextTr = $(obj).parent().parent().next();
        		
        		if (nextTr.attr("id") != "replyTr") {
        			
	        		var tr = $("<tr id='replyTr'>");
	        		tr.append("<td colspan='2'><input type='text' id='replyContent' name='replyContent' class='form-control' style='margin: 0 0 0 125px;' value='"+rContent+"'><br><div class='d-flex col-md-10 justify-content-end'><button type='button' class='btn ' style='background-color: #FAFAFA; border-color: #e9ecef; margin:0 100px 0 0' onclick='modifyReply("+rNo+", this);'>수정완료</button></div></td>")
// 	        		tr.append("<td><br><br><button type='button' id='rSubmit' class='btn' style='background-color: #FAFAFA; border-color: #e9ecef;' onclick='modifyReply("+rNo+", this);'>수정완료</button></td>")
	        		$(obj).parent().parent().after(tr);
        		}
        		
        		
       		
        			
        		
        		
        		//$("#replyTable tbody").append(tr);
        		//$("<td>").append("<input type='text'>");
        	}
        	
        	function removeReply(replyNo) {
        		
        		$.ajax({
        			url: "/notice/reply/delete",
        			data: { "replyNo" : replyNo },
        			type: "POST",
        			success: function(result) {
        				alert("서비스 결과: " + result);
        				
        				getReplyList();
        			},
        			error: function() {
        				alert("Ajax 통신 실패! 관리자에게 문의하세요~")
        			}
        		})
        	}
        	
        	$("#rSubmit").on("click", function() {

        		var refNoticeNo = $("#refNoticeNo").val();
        		var replyContent = $("#replyContent").val();
        		$.ajax({
        			url: "/notice/reply/add",
        			data: { "refNoticeNo" : refNoticeNo, "replyContent" : replyContent },
        			type: "POST",
        			success: function(result) {
        				alert("서비스 결과: " + result);
        				getReplyList();
        				$("#replyContent").val("");
        			},
        			error: function() {
        				alert("Ajax 통신 실패! 관리자에게 문의바랍니다.")
        			}
        		});
        	});
        	
		</script>
		
		
    </body>
</html>