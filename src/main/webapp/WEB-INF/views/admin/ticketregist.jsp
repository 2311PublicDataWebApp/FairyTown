<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 티켓 관리</title>
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="../resources/plugins/fontawesome-free/css/all.min.css">
<!-- daterange picker -->
<link rel="stylesheet"
	href="../resources/plugins/daterangepicker/daterangepicker.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet"
	href="../resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet"
	href="../resources/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="../resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- Select2 -->
<link rel="stylesheet"
	href="../resources/plugins/select2/css/select2.min.css">
<link rel="stylesheet"
	href="../resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- Bootstrap4 Duallistbox -->
<link rel="stylesheet"
	href="../resources/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
<!-- BS Stepper -->
<link rel="stylesheet"
	href="../resources/plugins/bs-stepper/css/bs-stepper.min.css">
<!-- dropzonejs -->
<link rel="stylesheet"
	href="../resources/plugins/dropzone/min/dropzone.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../resources/dist/css/adminlte.min.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>

	<div class="content-wrapper">
		<form action="/admin/ticketregist.ft" method="post" name="ticketForm"
			enctype="multipart/form-data" onSubmit="return Checkform()">

			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>티켓 등록</h1>
						</div>
						<!-- breadcrumb -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">티켓정보</a></li>
								<li class="breadcrumb-item active">티켓 등록</li>
							</ol>
						</div>
						<!-- breadcrumb -->
					</div>
				</div>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- left column -->
						<div class="col-md-10">
							<div class="card card-secondary">
								<div class="card-header">
									<h3 class="card-title">티켓 등록</h3>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-sm-10">
											<div class="form-group">

												<table class="table_close">
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">티켓명 <sup
																	style="color: red">*</sup>
																</label>
																<div class="col-sm-12">
																	<input type="text" class="form-control"
																		name="ticketName" value="${ticket.ticketName }"
																		id="inputEmail3" placeholder="티켓명을 입력해주세요">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">티켓설명</label>
																<div class="col-sm-12">
																	<textarea class="form-control" rows="10"
																		placeholder="티켓 설명을 입력해주세요" name="ticketDetail">${ticket.ticketDetail }</textarea>
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">제휴카드</label>
																<div class="col-sm-9">
																	<input type="text" class="form-control"
																		name="ticketCard" 
																		placeholder="제휴카드를 입력해주세요">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">어른가격 <sup
																	style="color: red">*</sup>
																</label>
																<div class="col-sm-7">
																	<input type="number" class="form-control" value="10000"
																		name="ticketAdult" oninput="this.value = Math.max(0, this.value)">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">청소년 가격</label>
																<div class="col-sm-7">
																	<input type="number" class="form-control"
																		name="ticketTeen" value="10000" oninput="this.value = Math.max(0, this.value)">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">어린이 가격 </label>
																<div class="col-sm-7">
																	<input type="number" class="form-control"
																		name="ticketChild"  value="10000" oninput="this.value = Math.max(0, this.value)">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-10 col-form-label">사용상태</label>
																<div class="form-check">
																	<input class="form-check-input" type="checkbox"
																		id="using" value="Y" name="ticketStatus"
																		onClick='checkOnlyOne(this)'
																		<c:if test="${ticket.ticketStatus eq 'Y'}">checked</c:if>>
																	<label class="form-check-label" for="using">사용함&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
																	<input type="checkbox" class="form-check-input"
																		id="discard" value="N" name="ticketStatus"
																		onClick='checkOnlyOne(this)'
																		<c:if test="${ticket.ticketStatus eq 'N'}">checked</c:if>>
																	<label class="form-check-label" for="discard">사용안함</label>
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<th>이미지</th>

														<td><input type="file" name="reloadFile"></td>
													</tr>
													<tr>
														<td colspan="5"><br> <input type="button"
															value="목록으로" class="btn btn-default" onClick="goMenu();">
															<input type="submit" value="등록하기"
															class="btn btn-secondary" onclick="return submitAlert();">
														</td>
													</tr>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

		</form>
	</div>
	<script src="../resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="../resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Select2 -->
	<script src="../resources/plugins/select2/js/select2.full.min.js"></script>
	<!-- Bootstrap4 Duallistbox -->
	<script
		src="../resources/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
	<!-- InputMask -->
	<script src="../resources/plugins/moment/moment.min.js"></script>
	<script src="../resources/plugins/inputmask/jquery.inputmask.min.js"></script>
	<!-- date-range-picker -->
	<script src="../resources/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap color picker -->
	<script
		src="../resources/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="../resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Bootstrap Switch -->
	<script
		src="../resources/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
	<!-- BS-Stepper -->
	<script src="../resources/plugins/bs-stepper/js/bs-stepper.min.js"></script>
	<!-- dropzonejs -->
	<script src="../resources/plugins/dropzone/min/dropzone.min.js"></script>
	<!-- AdminLTE App -->
	<script src="../resources/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="../resources/dist/js/demo.js"></script>
	<script>
		//등록 페이지 사용 JS : goBack(), Checkform(), submitAlert(),checkOnlyOne()
		
		function checkOnlyOne(element) {
  
		  const checkboxes 
		      = document.getElementsByName("ticketStatus");
		  
			  checkboxes.forEach((cb) => {
			    cb.checked = false;
			  })
			  
			  element.checked = true;
		}
	
		function goMenu(){
			location.href = "/admin/ticketlist.ft";
		};
		function goBack() {
			history.back();
		}

		function Checkform() {

				if (ticketForm.ticketName.value == "") {
					ticketForm.ticketName.focus();
					alert("티켓 이름을 입력해주세요.");
					return false;
				}

				if (ticketForm.ticketAdult.value == "") {
					ticketForm.ticketAdult.focus();
					alert("어른 가격을 등록해주세요.");
					return false;
				}
		}
		
		function submitAlert(){
			if(confirm("등록하시겠습니까?")){
				return true;
			} else{
				return false;
			}
		}

		
		</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
</body>
</html>