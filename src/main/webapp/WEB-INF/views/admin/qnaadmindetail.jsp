		<%@ page language="java" contentType="text/html; charset=UTF-8"
		    pageEncoding="UTF-8"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
		<!DOCTYPE html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <title>AdminLTE 3 | Starter</title>
			
			<!-- DataTables -->
			<link rel="stylesheet" href="../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
			<link rel="stylesheet" href="../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
			<link rel="stylesheet" href="../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
		  <!-- Google Font: Source Sans Pro -->
		  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
		  <!-- Font Awesome Icons -->
		  <!-- <link rel="stylesheet" href="../../resources/plugins/fontawesome-free/css/all.min.css"> -->
		  <link rel="stylesheet" href="../../resources/plugins/fontawesome-free/css/all.min.css">
		  <!-- Theme style -->
		  <!-- <link rel="stylesheet" href="../resources/dist/css/adminlte.min.css"> -->
		  <link rel="stylesheet" href="../../resources/dist/css/adminlte.min.css">
		  <!-- icheck bootstrap -->
		  <!-- <link rel="stylesheet" href="../resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css"> -->
		  <link rel="stylesheet" href="../../resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
		  
		</head>
		<body>
		<jsp:include page="../inc/adminheader.jsp"></jsp:include>
		<!-- Content Header -->
			<div class="content-wrapper">
		    <section class="content-header">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1>1대1문의 상세페이지</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">DataTables</li>
		            </ol>
		          </div>
		        </div>
		      </div>
		    </section>
		 <!-- Main content -->
		    <section class="content" style="margin-left: 300px;">
		      <div class="container-fluid">
		        <div class="row">
		          <!-- /.col -->
		          <div class="col-md-9">
		            <div class="card card-primary card-outline">
		              <div class="card-header">
		                <h3 class="card-title">문의 관리</h3>
		              </div>
		              <!-- /.card-header -->
		              <div class="card-body">
		                	<form action="/qna/adminModify.ft" method="post" enctype="multipart/form-data">
		                <input type="hidden" name="qnaNo" value="${qna.qnaNo }">
		                <div class="form-group">
		                  <input class="form-control" type="text" name="qnaName" value="${qna.qnaName }">
		                </div>
		                <div class="form-group">
		                  <textarea class="form-control" rows="4" cols="51" name="qnaContent">${qna.qnaContent }</textarea>
		                </div>

						     <div class="form-group">
							     <!-- 기존 상태를 보여주는 입력 필드 -->
							    <input type="text" name="qnaStatus" value="${qna.qnaStatus}" readonly>
							    
							    <!-- 상태를 수정할 수 있는 입력 필드 -->
							   <select id="qnaStatusSelect" name="updatedQnaStatus">
							        <option value="답변대기">답변대기</option>
							        <option value="답변완료">답변 완료</option>
							        <!-- 다른 상태 옵션들을 추가 -->
							    </select>
							    </div>
						    
<!-- 						    상태를 수정할 수 있는 입력 필드 -->
<!-- 						    <select name="updatedQnaStatus"> -->
<!-- 						        <option value="처리 중">처리 중</option> -->
<!-- 						        <option value="답변완료">답변 완료</option> -->
<!-- 						        다른 상태 옵션들을 추가 -->
<!-- 						    </select> -->
    					<div class="float-right">
								<input type="submit"  class="btn btn-primary" value="등록하기">
<!-- 		                  <button type="submit" value="submit" class="btn btn-primary">완료</button> -->
		                </div>
		              </form>
						</div>

		                <br>
		                
		                	<br>
						<!--댓글 -->
						<!-- 댓글 목록 -->
								<table width="1000" border="0" id="qnaReplyTable" style="margin-left: 35px;">
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
						<!-- 댓글등록 -->
								<br>
						<!-- 	<form action="/reply/add.kh" method="post"> -->
									<input type="hidden" name="refQnaNo" value="${qna.qnaNo }" id="refQnaNo">
									<table width="500" border="0">
										<tr>
											<td>
												<input type="text" name="qnaReplyContent" id="qnaReplyContent" size="110" style=" margin-left: 20px;">
											</td>
											<td>
						<!-- 					<input type="submit" value="등록하기"> -->
												<button id="rSubmit" style="margin-left: 20px; height: 43px; width:100px; border-radius: 10px; background-color: #007BFF; border: none;
				  color: #fff;													">답변</button>
											</td>
									</table>
						<!-- 	</form> -->
						<br>
								
		                </div>
		              </div>
		              <!-- /.card-body -->
		              <div class="card-footer">
		                
		                <button type="reset" class="btn btn-default" onclick="showQnaList();"><i class="fas fa-times"></i> 취소</button>
		                <button class="btn btn-default" type="button" onclick="deleteQna(${qna.qnaNo});">삭제</button>
		              </div>
		              </div>
		              <!-- /.card-footer -->
		            </div>
		            <!-- /.card -->
		          </div>
		          <!-- /.col -->
		        </div>
		        <!-- /.row -->
		      </div><!-- /.container-fluid -->
		    </section>
		    <!-- /.content -->
		            <!-- /.card-body -->
		            <div class="card-footer p-0">
		              <div class="mailbox-controls">
		                <!-- Check all button -->
		                <!-- <button type="button" class="btn btn-default btn-sm checkbox-toggle">
		                  <i class="far fa-square"></i>
		                </button>
		                <div class="btn-group">
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="far fa-trash-alt"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-reply"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-share"></i>
		                  </button>
		                </div> -->
		                <!-- /.btn-group -->
		                  </div>
		                  <!-- /.btn-group -->
		                </div>
		                <!-- /.float-right -->
		              </div>
		            </div>
		          </div>
		          <!-- /.card -->
		        </div>
		        <!-- /.col -->
		      </div>
		      <!-- /.row -->
		    </section>
		    <!-- /.content -->
		  </div>
		  <!-- /.content-wrapper -->
		  <footer class="main-footer">
		    <div class="float-right d-none d-sm-block">
		      <b>Version</b> 3.2.0
		    </div>
		    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
		  </footer>
		
		  <!-- Control Sidebar -->
		  <aside class="control-sidebar control-sidebar-dark">
		    <!-- Control sidebar content goes here -->
		  </aside>
		  <!-- /.control-sidebar -->
		</div>
		<!-- ./wrapper -->
		
		<!-- jQuery -->
		<script src="../../resources/plugins/jquery/jquery.min.js"></script>
		<!-- Bootstrap 4 -->
		<script src="../../resourcesplugins/bootstrap/js/bootstrap.bundle.min.js"></script>
		<!-- AdminLTE App -->
		<script src="../../resources/dist/js/adminlte.min.js"></script>
		<!-- AdminLTE for demo purposes -->
		<script src="../../resources/dist/js/demo.js"></script>
		<!-- Page specific script -->
		<!-- DataTables  & Plugins -->
<script src="../resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../resources/plugins/jszip/jszip.min.js"></script>
<script src="../resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
		<script>
		  $(function () {
		    //Enable check and uncheck all functionality
		    $('.checkbox-toggle').click(function () {
		      var clicks = $(this).data('clicks')
		      if (clicks) {
		        //Uncheck all checkboxes
		        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', false)
		        $('.checkbox-toggle .far.fa-check-square').removeClass('fa-check-square').addClass('fa-square')
		      } else {
		        //Check all checkboxes
		        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', true)
		        $('.checkbox-toggle .far.fa-square').removeClass('fa-square').addClass('fa-check-square')
		      }
		      $(this).data('clicks', !clicks)
		    })
		
		    //Handle starring for font awesome
		    $('.mailbox-star').click(function (e) {
		      e.preventDefault()
		      //detect type
		      var $this = $(this).find('a > i')
		      var fa    = $this.hasClass('fa')
		
		      //Switch states
		      if (fa) {
		        $this.toggleClass('fa-star')
		        $this.toggleClass('fa-star-o')
		      }
		    })
		  })
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
// 						var qnaReplyWriter;
						var qnaReplyContent;
// 						var qnaReplyDate;
						var btnArea;
// 						var sessionId = "${userId}";
						if (result.length > 0) {
							for (var i in result) {
// 								var qnaReplyWriterVal = result[i].qnaReplyWriter;
								var qnaReplyContentVal = result[i].qnaReplyContent;
// 								var qnaReplyDateVal = result[i].qnaReplyDate;
								var qnaReplyNoVal = result[i].qnaReplyNo;
								tr = $("<tr>"); //<tr></tr>
// 								qnaReplyWriter = $("<td>").text(qnaReplyWriterVal);
								qnaReplyContent = $("<td>").text(qnaReplyContentVal);
// 								qnaReplyDate = $("<td width='100'>").text(qnaReplyDateVal);
								btnArea = $("<td width='150'>")
									.append("<a href='javascript:void(0)' onclick='modifyViewReply(this, " + qnaReplyNoVal + ", \"" + qnaReplyContentVal + "\");'>수정</a> ")
									.append("<a href='javascript:void(0)' onclick='removeReply(" + qnaReplyNoVal + ");'>삭제</a>");
// 								tr.append(qnaReplyWriter);
								tr.append(qnaReplyContent);
// 								tr.append(qnaReplyDate);
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
			
			function showQnaList() {
				location.href = "/qna/adminList.ft";
			}
			
			
			// 페이지가 로드될 때 실행될 함수
			window.onload = function() {
			    // 입력 필드 요소 가져오기
			    var inputField = document.querySelector('.form-group input[name="qnaStatus"]');
			    
			    // 입력 필드가 포커스를 얻었을 때 발생하는 이벤트 리스너 추가
			    inputField.addEventListener('focus', function(event) {
			        // 입력 필드의 값이 비어있으면 "답변완료"로 설정
			        if (event.target.value === '') {
			            event.target.value = '답변완료';
			        }
			    });
			};
			
			// 셀렉트 박스의 onchange 이벤트 핸들러
		    document.getElementById('qnaStatusSelect').addEventListener('change', function() {
		        // 선택된 옵션의 값을 읽어와서 hidden 입력 필드에 설정
		        var selectedStatus = this.value;
		        document.querySelector('input[name="qnaStatus"]').value = selectedStatus;
		    });
			
		    $(function () {
		        $('#example2').DataTable({
		    		"paging": true,
		    		"lengthChange": false,
		    		"searching": true,
		    		"ordering": true,
		    		"info": true,
		    		"autoWidth": true,
		    		"responsive": true,
		    		
		    		language: {
		    		    "decimal": "",
		    		    "emptyTable": "테이블에 데이터가 없습니다",
		    		    "info": "_TOTAL_개 항목 중 _START_부터 _END_까지 표시중",
		    		    "infoEmpty": "0개 항목 중 0부터 0까지 표시중",
		    		    "infoFiltered": "(_MAX_개 항목 중 필터링됨)",
		    		    "infoPostFix": "",
		    		    "thousands": ",",
		    		    "lengthMenu": "_MENU_개 항목 표시",
		    		    "loadingRecords": "로딩 중...",
		    		    "processing": "처리 중...",
		    		    "search": "검색:",
		    		    "zeroRecords": "일치하는 레코드를 찾을 수 없습니다",
		    		    "paginate": {
		    		        "first": "처음",
		    		        "last": "마지막",
		    		        "next": "다음",
		    		        "previous": "이전"
		    		    },
		    		    "aria": {
		    		        "orderable": "이 열을 정렬하려면 클릭",
		    		        "orderableReverse": "이 열을 역순으로 정렬하려면 클릭"
		    		    }
		    	    }
		        });
		      });
		    
		    function deleteQna(qnaNo) {
				if (confirm("삭제하시겠습니까?")) {
					location.href = "/qna/delete.ft?qnaNo=" + qnaNo;
				}
			}
		</script>
		</body>
		</html>