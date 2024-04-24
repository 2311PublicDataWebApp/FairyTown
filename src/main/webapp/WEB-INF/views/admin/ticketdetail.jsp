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
            <h1>티켓 상세정보</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">티켓정보</a></li>
              <li class="breadcrumb-item"><a href="#">티켓 상세정보</a></li>
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
                <h3 class="card-title">티켓 상세정보</h3>
              </div>
              <div class="card-body">
				<table class="table_close">
					<tr style="">
						<td style="width:120px;text-align:right;">티켓명<sup style="color:red">*</sup> : </td>
						<td>
							<span>&nbsp;&nbsp;${ticket.ticketName }</span>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">티켓설명 : </td>
						<td><span>&nbsp;&nbsp;<pre style="width:800px; overflow-y:scroll;">${ticket.ticketDetail }</pre></span>
					</tr>
					<tr>
						<td style="text-align:right;">제휴카드 : </td>
						<td>
							<span>&nbsp;&nbsp;${ticket.ticketCard }</span>
						</td>
					</tr>
					
					<tr>
						<td style="text-align:right;">어른 가격 <sup style="color:red">*</sup> : </td>
						<td>
							<span>&nbsp;&nbsp;${ticket.ticketAdult}</span>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">청소년 가격 : </td>
						<td>
							<span>&nbsp;&nbsp;${ticket.ticketTeen}</span>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">어린이 가격 : </td>
						<td>
							<span>&nbsp;&nbsp;${ticket.ticketChild}</span>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">사용상태 : </td>
							<c:set var="tStatus" value="${ticket.ticketStatus }" />
							<c:if test="${tStatus eq 'Y' }">
								<td>&nbsp;&nbsp;사용중</td>
							</c:if>
							<c:if test="${tStatus eq 'N'}">
								<td>&nbsp;&nbsp;사용안함</td>
							</c:if>
					</tr>
					<tr>
						<td style="text-align:right;">이미지 : </td>
						<td>
								&nbsp;&nbsp;<img src="../resources/nuploadFiles/${ticket.ticketImgRename }" alt="이미지"><br>
						</td>
					</tr>
					
					
					<tr>
						<td colspan="6">
							<input type="button" value="목록으로"  class="btn btn-default"  onClick="goMenu();"> 
							<input type="button" value="수정하기"  class="btn btn-secondary" onClick="showModify(${ticket.ticketNo});"> 
							<input type="button" value="삭제하기"  class="btn btn-default" onClick="deleteClose(${ticket.ticketNo});"> 
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
	//상세 페이지 사용 JS : showModify(), goBack()
		function deleteClose(ticketNo){
				if(confirm("삭제하시겠습니까?")){
					location.href = "/admin/ticketdelete.ft?ticketNo="+ticketNo;
					alert("정상적으로 삭제되었습니다.");
				}else{
					alert("삭제를 취소하셨습니다.");
				}
			}
		function goBack() {
			history.back();
		}
		function goMenu(){
			location.href = "/admin/ticketlist.ft";
		}
	
		function showModify(ticketNo) {
		    location.href = "/admin/ticketmodify.ft?ticketNo=" + ticketNo;
		}
		
	
	</script>
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
</body>
</html>