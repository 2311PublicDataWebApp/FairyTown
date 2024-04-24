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
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
			
	<div class="content-wrapper">
	<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>놀이기구 상세정보</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">놀이기구 정보</a></li>
              <li class="breadcrumb-item"><a href="#">놀이기구 상세정보</a></li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
		 <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <!-- Default box -->
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">놀이기구 상세정보</h3>
              </div>
              <div class="card-body">
				<input type="hidden" name="rideId" value="${ride.rideId }">
			
				<table class="table_ride">
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">놀이기구명 : </td>
						<td>&nbsp;&nbsp;${ride.rideName }</td>
					</tr>
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">설명 : </td>
						<td><pre>${ride.rideDescription}</pre></td>
					</tr>
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">탑승인원 : </td>
						<td>&nbsp;&nbsp;${ride.rideCount }</td>
					</tr>
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">탑승제한 : </td>
						<td>&nbsp;&nbsp;<pre>${ride.rideLimit }</pre></td>
					</tr>
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">운휴정보 : </td>
						<c:set var="rStatus" value="${ride.rideStatus }" />
						<c:if test="${rStatus eq 'N'}">
									<td>&nbsp;&nbsp;임시휴무</td>
						</c:if>
						<c:if test="${rStatus ne 'N'}">
								<td>&nbsp;&nbsp;정상운행(10:00 ~ 22:00)</td>
						</c:if>
					</tr>
				
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">이미지 : </td>
						<td>&nbsp;&nbsp;
						    <c:forEach var="rImg" items="${rImg}">
						        <img src="../resources/nuploadFiles/${rImg.rideImgRename}" style="width:100px; height:100px;" alt="이미지">
						    </c:forEach><br>
						</td>
									
					</tr>
				
					<tr class="padding-bottom:10px;">
						<td style="width : 120px; text-align:right;">X좌표 : </td>
						<td>&nbsp;&nbsp;${ride.rideX }</td>
					</tr>
					<tr class="height:3rem;">
						<td style="width : 120px; text-align:right;">Y좌표 : </td>
						<td>&nbsp;&nbsp;${ride.rideY }</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="button" value="목록으로"  class="btn btn-default"  onClick="goMenu();"> 
							<input type="button" value="수정하기"  class="btn btn-secondary" onClick="showModify(${ride.rideId});"> 
							<input type="button" value="삭제하기"  class="btn btn-default" onClick="deleteClose(${ride.rideId});">
						</td>
					</tr>
				</table>
			</div>
            <!-- /.card -->
          </div>
        </div>
      </div>
      </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<!-- 		</form>  -->
	
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
			// 상세 페이지 사용 JS : goBack(),showModify()
				function goBack(){
				history.back();
			}
				function goMenu(){
					location.href = "/admin/ridelist.ft";
				}
				function deleteClose(rideId){
					if(confirm("삭제하시겠습니까?")){
						location.href = "/admin/ridedelete.ft?rideId="+rideId;
						alert("정상적으로 삭제되었습니다.");
					}else{
						alert("삭제를 취소하셨습니다.");
					}
				}
				function showModify(rideId) {
					location.href = "/admin/ridemodify.ft?rideId="+rideId;
				}
			</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
</body>
</html>