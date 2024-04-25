<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[ADMIN] 놀이기구</title>
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
<link rel="stylesheet" type="text/css" href="../resources/css/admin.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>

	<form action="/admin/rideregist.ft" method="post" name="rideForm"
		enctype="multipart/form-data" onSubmit="return Checkform()">
		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>놀이기구 등록</h1>
						</div>
						<!-- breadcrumb -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">놀이기구 정보</a></li>
								<li class="breadcrumb-item active">놀이기구 등록</li>
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
						<div class="col-md-12">
							<div class="card card-secondary">
								<div class="card-header">
									<h3 class="card-title">놀이기구 등록</h3>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-sm-12">
											<div class="form-group">
												<table class="table_ride">
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">놀이기구명 <sup
																	style="color: red">*</sup>
																</label>
																<div class="col-sm-10">
																	<input type="text" class="form-control" name="rideName"
																		placeholder="놀이기구명을 입력해주세요">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">설명</label>
																<div class="col-sm-12">
																	<textarea class="form-control" rows="10"
																		placeholder="설명을 입력해주세요" name="rideDescription"></textarea>
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">탑승인원 : </label>
																<div class="col-sm-8">
																	<input type="number" class="form-control"
																		name="rideCount" style="width: 80px;" value="0"
																		oninput="this.value = Math.max(0, this.value)">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">탑승제한 <sup
																	style="color: red">*</sup></label>
																<div class="col-sm-12">
																	<textarea class="form-control" rows="10"
																		placeholder="탑승제한을 입력해주세요" name="rideLimit"></textarea>
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-10 col-form-label">현재상태</label>
																<div class="form-check">
																	<input class="form-check-input" type="checkbox"
																		id="Available" value="Y" name="rideStatus"
																		onClick='checkOnlyOne(this)' checked> <label
																		class="form-check-label" for="Available">정상운행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
																	<input type="checkbox" class="form-check-input"
																		id="NotAvailable" value="N" name="rideStatus"
																		onClick='checkOnlyOne(this)'> <label
																		class="form-check-label" for="NotAvailable">임시휴무</label>
																</div>
															</div>
														</td>
													</tr>

													<tr id="fileInputs">
														<th>첫번째 이미지 :</th>
														<td><input type="file" name="uploadFile">
															<button type="button" class="btn btn-secondary"
																onclick="addFileInput();">파일 추가</button></td>
													</tr>


													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">X좌표 : </label>
																<div class="col-sm-12">
																	<input type="text" class="form-control" name="rideX"
																		placeholder="소수점 포함 12자까지 입력 가능합니다.">
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<div class="form-group row">
																<label class="col-sm-4 col-form-label">Y좌표 : </label>
																<div class="col-sm-12">
																	<input type="text" class="form-control" name="rideY"
																		placeholder="소수점 포함 12자까지 입력 가능합니다.">
																</div>
															</div>
														</td>
													</tr>

												</table>

												<input type="button" value="목록으로" class="btn btn-default"
													onClick="goMenu();"> <input type="submit"
													value="등록하기" class="btn btn-secondary"
													onclick="return submitAlert();">
											</div>


										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</section>
		</div>
	</form>
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
			// 상세 페이지 사용 JS : goBack(),submitAlert(), Checkform()

var maxFileInputs = 5; // 최대 파일 입력란 개수
var fileInputCount = 1; // 현재 파일 입력란 개수

function addFileInput() {
    if (fileInputCount < maxFileInputs) {
        var fileInputsDiv = document.getElementById("fileInputs");
        var newFileInput = document.createElement("input");
        newFileInput.type = "file";
        newFileInput.name = "uploadFile"; // 이 이름은 서버에서 파일을 처리할 때 사용됩니다.
        var newRow = document.createElement("tr");
        var newTd1 = document.createElement("th");
        var newTd2 = document.createElement("th");

        var textContent = "";
        switch (fileInputCount) {
            case 1:
                textContent = "첫번째 이미지 :";
                break;
            case 2:
                textContent = "두번째 이미지 :";
                break;
            case 3:
                textContent = "세번째 이미지 :";
                break;
            case 4:
                textContent = "썸네일이미지(264x363) :";
                break;
            case 5:
                textContent = "썸네일이미지(264x180) :";
                break;
        }

        newTd1.textContent = textContent;
        newTd2.appendChild(newFileInput);
        newRow.appendChild(newTd1);
        newRow.appendChild(newTd2);
        fileInputsDiv.parentNode.insertBefore(newRow, fileInputsDiv.nextSibling);
        fileInputCount++;
    } else {
        alert("최대 " + maxFileInputs + "개까지만 추가할 수 있습니다.");
    }
}
		
		function checkOnlyOne(element) {
			  
			  const checkboxes 
			      = document.getElementsByName("rideStatus");
			  
				  checkboxes.forEach((cb) => {
				    cb.checked = false;
				  })
				  
				  element.checked = true;
			}
		
		function goMenu(){
			location.href = "/admin/ridelist.ft";
		};
		
			function Checkform() {

				if (rideForm.rideName.value == "") {
					rideForm.rideName.focus();
					alert("놀이기구 이름을 입력해주세요.");
					return false;
				} 
				if (rideForm.rideLimit.value == "") {
					rideForm.rideLimit.focus();
					alert("탑승 제한을 등록해주세요.");
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