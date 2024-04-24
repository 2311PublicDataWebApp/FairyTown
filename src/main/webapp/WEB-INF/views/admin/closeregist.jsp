<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 휴무일 정보</title>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../resources/plugins/fontawesome-free/css/all.min.css">
  <!-- daterange picker -->
  <link rel="stylesheet" href="../resources/plugins/daterangepicker/daterangepicker.css">
  <!-- iCheck for checkboxes and radio inputs -->
  <link rel="stylesheet" href="../resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Bootstrap Color Picker --> 
  <link rel="stylesheet" href="../resources/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="../resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- Select2 -->
  <link rel="stylesheet" href="../resources/plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <!-- Bootstrap4 Duallistbox -->
  <link rel="stylesheet" href="../resources/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
  <!-- BS Stepper -->
  <link rel="stylesheet" href="../resources/plugins/bs-stepper/css/bs-stepper.min.css">
  <!-- dropzonejs -->
  <link rel="stylesheet" href="../resources/plugins/dropzone/min/dropzone.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../resources/dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/adminheader.jsp"></jsp:include>
		<div class="content-wrapper">
			<form action="/admin/closeregist.ft" method="post" name="closeForm" onSubmit="return Checkform()">
			
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>휴무일 등록</h1>
						</div>
						<!-- breadcrumb -->
							<div class="col-sm-6">
								<ol class="breadcrumb float-sm-right">
									<li class="breadcrumb-item"><a href="#">휴무일 등록</a></li>
									<li class="breadcrumb-item active">휴무일 등록</li>
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
							<div class="col-md-6">
								<div class="card card-secondary">
									<div class="card-header">
										<h3 class="card-title">휴무일 등록</h3>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-sm-6">
												<div class="form-group">
													<label>놀이기구명 <sup style="color: red">*</sup>
													</label> 
													<select class="form-control select_ride" name="rideId">
														<option value="all">전체</option>
														<c:if test="${fn:length(close) != 0 }">
															<c:forEach items="${close }" var="close" varStatus="i">
																<option value="${close.rideId}">${close.rideName}</option>
															</c:forEach>
														</c:if>
													</select>
												</div>
												<div class="form-group">
													<label>날짜 <sup style="color: red">*</sup></label>
													<div class="input-group date" id="reservationdate"
														data-target-input="nearest">
														<input type="text"
															class="form-control datetimepicker-input"
															data-target="#reservationdate"  name="closeDate"/>
														<div class="input-group-append"
															data-target="#reservationdate"
															data-toggle="datetimepicker">
															<div class="input-group-text">
																<i class="fa fa-calendar"></i>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label>사유</label> <select class="form-control select_ride"
														name="closeReason" id="closeReason">
														<option value="all" selected>전체</option>
														<option value="regular">정기휴무</option>
														<option value="disaster">천재지변</option>
														<option value="outofOrder">기기수리</option>
														<option value="vacation">담당자부재</option>
														<option value="etc">기타</option>
													</select>
												</div>

											</div>
										</div>
										<input type="button" value="이전으로" class="btn btn-default" onClick="goBack();">
										<input type="reset" value="초기화"  class="btn btn-default"  onClick="removeWord();">
										<input type="submit" value="등록하기"  class="btn btn-secondary"  onclick="return submitAlert();">
									</div>
								</div>
							</div>	
						</div>
						</div>
					</section>
						
					</form>
				</div>
		</div>

		<!-- jQuery -->
<script src="../resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Select2 -->
<script src="../resources/plugins/select2/js/select2.full.min.js"></script>
<!-- Bootstrap4 Duallistbox -->
<script src="../resources/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
<!-- InputMask -->
<script src="../resources/plugins/moment/moment.min.js"></script>
<script src="../resources/plugins/inputmask/jquery.inputmask.min.js"></script>
<!-- date-range-picker -->
<script src="../resources/plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="../resources/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="../resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Bootstrap Switch -->
<script src="../resources/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- BS-Stepper -->
<script src="../resources/plugins/bs-stepper/js/bs-stepper.min.js"></script>
<!-- dropzonejs -->
<script src="../resources/plugins/dropzone/min/dropzone.min.js"></script>
<!-- AdminLTE App -->
<script src="../resources/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../resources/dist/js/demo.js"></script>
										<script>
									
											$(function() {
											    // 오늘 이전의 날짜 선택 불가능하도록 설정
											    var today = new Date();
											    today.setHours(0, 0, 0, 0); // 오늘 날짜의 00:00:00으로 설정
											    $('#reservationdate').datetimepicker({
											        format: "yyyy-MM-DD",
											        minDate: today // 오늘 이전의 날짜 선택 불가능하도록 설정
											    });
											});
											//등록 페이지 사용 JS : goBack(), Checkform(), submitAlert()
											function goBack() {
												history.back();
											}
											function Checkform() {

												if (closeForm.rideId.value == "all") {
													closeForm.rideId.focus();
													alert("놀이기구를 선택해주세요.");

													return false;

												}
												if (closeForm.closeDate.value == "") {
													closeForm.closeDate.focus();
													alert("날짜를 선택해주세요.");
													return false;

												}
											}

											function submitAlert() {
												if (confirm("등록하시겠습니까?")) {
													return true;
												} else {
													return false;
												}
											}
											function removeWord(){
												if(confirm("초기화하시겠습니까?")){
											    	document.getElementById("rideId").value = "all";
											    	document.getElementById("reservationdate").value = "";
											    	document.getElementById("closeReason").value = "all";
											     }
											}
											
										</script>

	

</body>
</html>