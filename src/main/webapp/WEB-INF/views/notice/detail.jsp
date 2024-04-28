<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 상세보기 | 페어리 타운</title>
    <!-- Favicon -->
    <link href="../resources/dist/img/close.png" rel="shortcut icon" type="image/x-icon">
<!-- 부트스트랩 CDN 추가 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
#notice-detail {
	margin: 0 0 0 350px;
}

</style>
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

			<div class="pagetitle text-center">
				<h1>
					<b>공지사항</b>
				</h1>
			</div>
	<div id="notice-detail">
		<main id="main" class="main">
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
										<button type="button" class="btn"
											style="background-color: #FAFAFA; border-color: #e9ecef;"
											onclick="showModifyPage();">수정</button>
										<button type="button" class="btn"
											style="background-color: #FAFAFA; border-color: #e9ecef;"
											onclick="deleteNotice(${notice.noticeNo});">삭제</button>
										<button type="button" class="btn"
											style="background-color: #FAFAFA; border-color: #e9ecef;"
											onclick="showNoticeList();">목록</button>
									</div>
								</c:if>
								<c:if test="${userId ne 'admin' }">
									<div class="d-flex col-md-12 justify-content-end">
										<button type="button" class="btn"
											style="background-color: #FAFAFA; border-color: #e9ecef;"
											onclick="showNoticeList();">목록</button>
									</div>
								</c:if>
								<br>
								<!-- Default Table -->
							<!-- 	<table class="table table-striped"> -->
								<table class="">
									<tbody>
										<div class="titArea d-flex align-items-center justify-content-between">
										    <div class="label pr-3">
													<p class="mb-0"> ${notice.noticeType}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
		 								    </div>
										    <div class="flex-grow-1">
										        <p class="tit mb-0" style="word-wrap: break-word; font-size: 24px; font-weight: bold;">
										            ${notice.noticeSubject }
										        </p>
										    </div>
										    <div>
										        <p class="date mb-0">
										            ${notice.noticeDate }
										        </p>
										    </div>
									  </div>
									  <!-- 구분선 추가 -->
									  	<tr>
								        <tr>
										    <td colspan="2">
										        <hr style="border-top: 1px solid #ccc; width: 100%;">
										    </td>
										</tr>
										<c:if test="${notice.noticeFileRename ne null }">
											<tr>
												<td>첨부파일</td>
												<td><span><a style="color: black;"
														href='../resources/nuploadFiles/${notice.noticeFileRename }'
														download>${notice.noticeFileName }</a></span></td>
											</tr>
										</c:if>
										<tr>
											<td></td>
											<!-- escapeXml 속성을 "false"로 설정하여 HTML 태그가 escape 되지않고 그대로 출력됨  -->
											<td><c:out value="${notice.noticeContent}"
													escapeXml="false" /> <br>
													
												<!-- 상세보기 페이지의 내용 -->
												    <div class="content">
												        <!-- 동영상 플레이어 -->
												        <div id="video-container"></div>
												        
												        <!-- 다른 컨텐츠 추가 -->
												    </div>
											</td>
										</tr>
										<tr>
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
								<input type="hidden" id="refNoticeNo" name="refNoticeNo"
									value="${notice.noticeNo }">
								<table class="table table-hover" border="0">
									<tr>
										<td>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">댓글</label>
												<div class="col-sm-10">
													<input type="text" id="replyContent" name="replyContent"
														class="form-control" style="margin: 0 0 0 20px">
												</div>
											</div>
										</td>
										<td>
											<div class="d-flex col-md-12 justify-content-end">
												<button type="button" id="rSubmit" class="btn"
													style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
											</div>
										</td>
									</tr>
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



	 <script>
		 
	    
	    // ============================
	    // CKEditor 동영상 임베드 설정 영역
	    // ============================
	    	
        // URL 파라미터에서 동영상 주소 추출
        function getVideoUrl() {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('videoUrl');
        }

        // 동영상 주소를 이용하여 동영상 플레이어 생성
        function createVideoPlayer(videoUrl) {
            var videoContainer = document.getElementById("video-container");
            var embedCode = '<figure class="media">' +
                                '<iframe width="560" height="315" src="' + videoUrl + '" frameborder="0" ' +
                                'allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" ' +
                                'allowfullscreen></iframe>' +
                            '</figure>';
            videoContainer.innerHTML = embedCode;
        }

        // 페이지 로드 시 실행
        window.onload = function() {
            var videoUrl = getVideoUrl();
            if (videoUrl) {
                createVideoPlayer(videoUrl);
            } else {
                // 동영상 주소가 없는 경우 예외 처리
                console.error("동영상 주소가 없습니다.");
            }
            document.querySelectorAll( 'oembed[url]' ).forEach( element => {
                // Create the <a href="..." class="embedly-card"></a> element that Embedly uses
                // to discover the media.
                const anchor = document.createElement( 'a' );

                anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
                anchor.className = 'embedly-card';

                element.appendChild( anchor );
            } );
        };
    </script>




	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
			function showModifyPage() {
				var noticeNo = "${notice.noticeNo }";
				location.href = "/notice/modify.ft?noticeNo=" + noticeNo;
			}	
			
			function deleteNotice(noticeNo) {
				if (confirm("삭제하시겠습니까?")) {
					location.href = "/notice/delete.ft?noticeNo=" + noticeNo;
				}
			}
			
			function showNoticeList() {
				location.href = "/notice/list.ft";
			}
	
			getReplyList();
        	function getReplyList() {
        		var refNoticeNo = $("#refNoticeNo").val();
        		$.ajax({
        			url: "/notice/reply/list.ft",
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
        				var sessionId = "${userId}";
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
        			url: "/notice/reply/update.ft",
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
	        		$(obj).parent().parent().after(tr);
        		}
        		
        		//$("#replyTable tbody").append(tr);
        		//$("<td>").append("<input type='text'>");
        	}
        	
        	function removeReply(replyNo) {
        		
        		$.ajax({
        			url: "/notice/reply/delete.ft",
        			data: { "replyNo" : replyNo },
        			type: "POST",
        			success: function(result) {
        				alert("서비스 결과: " + result);
        				
        				getReplyList();
        			},
        			error: function() {
        				alert("Ajax 통신 실패! 관리자에게 문의하세요.")
        			}
        		})
        	}
        	
        	$("#rSubmit").on("click", function() {

        		var refNoticeNo = $("#refNoticeNo").val();
        		var replyContent = $("#replyContent").val();
        		$.ajax({
        			url: "/notice/reply/add.ft",
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

	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>