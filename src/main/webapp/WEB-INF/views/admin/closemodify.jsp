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

    <form action="/admin/closemodify" method="post" name="closeForm" onsubmit="return Checkform();">

        <!-- 어드민 타이틀 영역 -->
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>휴무일 정보</h1>
                        </div>
                        <!-- breadcrumb -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="#">휴무일 정보</a></li>
                                <li class="breadcrumb-item active">휴무일 수정</li>
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
                                    <h3 class="card-title">휴무일 수정</h3>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>놀이기구명 <sup style="color: red">*</sup>
                                                </label>
                                                <span>&nbsp;&nbsp;${close.rideName }</span>
                                            </div>
                                            <div class="form-group">
                                                <label>날짜 <sup style="color: red">*</sup></label>
                                                <div class="input-group date" id="reservationdate"
                                                    data-target-input="nearest">
                                                    <input type="text"
                                                        class="form-control datetimepicker-input"
                                                        value="${close.closeDate}" data-target="#reservationdate"
                                                        name="closeDate" />
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
                                                <label>사유</label>
                                                <c:set var="cReason" value="${close.closeReason }" />
                                                <select class="form-control select_ride" name="closeReason"
                                                    id="closeReason">
                                                    <c:choose>
                                                        <c:when test="${cReason == 'all'}">
                                                            <option value="all" selected>전체</option>
                                                        </c:when>
                                                        <c:when test="${cReason == 'regular'}">
                                                            <option value="regular" selected>정기휴무</option>
                                                        </c:when>
                                                        <c:when test="${cReason == 'disaster'}">
                                                            <option value="disaster" selected>천재지변</option>
                                                        </c:when>
                                                        <c:when test="${cReason == 'outoforder'}">
                                                            <option value="outoforder" selected>기기수리</option>
                                                        </c:when>
                                                        <c:when test="${cReason == 'vacation'}">
                                                            <option value="vacation" selected>담당자부재</option>
                                                        </c:when>
                                                        <c:when test="${cReason == 'etc'}">
                                                            <option value="etc" selected>기타</option>
                                                        </c:when>
                                                    </c:choose>
                                                </select>
                                            </div>
                                            <input type="button" value="목록으로" class="btn btn-default"
                                                onClick="goMenu();"> <input type="submit"
                                                value="수정하기" class="btn btn-secondary">
                                            <input
                                                type="button" value="삭제하기" class="btn btn-default"
                                                onClick="deleteRide(${ride.rideId});">
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
    <script>
        //수정 페이지 사용 JS : goBack(), Checkform(), submitAlert()

        function goMenu(){
            location.href = "/admin/closelist.ft";
        };

        function Checkform() {

            if (closeForm.rideId.value == "all") {
                closeForm.rideId.focus();
                alert("놀이기구를 선택해주세요.");

                return false;

            }

            if (closeForm.closeReason.value == "all") {
                closeForm.closeReason.focus();
                alert("사유를 선택해주세요.");

                return false;

            }
            if (closeForm.closeDate.value == "") {
                closeForm.closeDate.focus();
                alert("날짜를 선택해주세요.");

                return false;

            }
            return confirm("수정하시겠습니까?");
        }
    </script>
    <!-- 공통 / 풋터 -->
    <jsp:include page="../inc/adminfooter.jsp"></jsp:include>
</body>
</html>