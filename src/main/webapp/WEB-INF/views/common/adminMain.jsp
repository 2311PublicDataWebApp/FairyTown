<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대쉬보드</title>

</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">대쉬보드</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item">관리메뉴</li>
              <li class="breadcrumb-item active">대쉬보드</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
    
    <!-- Main content -->
   	<section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-primary">
              <div class="inner">
                <h3>${totalUser }<sup style="font-size: 20px">명</sup></h3>

                <p>전체 회원</p>
              </div>
              <div class="icon">
                <i class="ion ion-person-add"></i>
              </div>
              <a href="/admin/userlist.ft" class="small-box-footer">상세화면 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3>53<sup style="font-size: 20px">개</sup></h3>

                <p>미답변 QNA</p>
              </div>
              <div class="icon">
                <i class="ion ion-stats-bars"></i>
              </div>
              <a href="/qna/adminList.ft" class="small-box-footer">상세화면 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3>65</h3>

                <p>당일 티켓발매</p>
              </div>
              <div class="icon">
                <i class="ion ion-pie-graph"></i>
              </div>
              <a href="/admin/ticketing/list.ft" class="small-box-footer">상세화면 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3><fmt:formatNumber value="${lastNumber }" pattern="###,###"/><sup style="font-size: 20px">원</sup></h3>

                <p>당일 매출액</p>
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a href="/admin/orderList.ft" class="small-box-footer">상세화면 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
          <!-- ./col -->
        </div>
        
        
        <div class="row">
          <div class="col-lg-6">
            <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">가입자 현황</h3>
                  <a href="/admin/userlist.ft">상세화면</a>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex">
                  <p class="d-flex flex-column">
                    <span class="text-bold text-lg">${totalSumU } 명</span>
                    <span>1주일간 가입 상황</span>
                  </p>
                  <p class="ml-auto d-flex flex-column text-right">
                  <span class="text-muted">전날대비</span>
					<c:choose>
					    <c:when test="${difference > 0}">
					        <span class="text-success">
					            <i class="fas fa-arrow-up"></i> ${difference} 명
					        </span> 
					    </c:when>
					    <c:otherwise>
					        <span class="text-danger">
					            <i class="fas fa-arrow-down"></i> ${difference} 명
					        </span>
					    </c:otherwise>
					</c:choose>
                  </p>
                </div>
                <!-- /.d-flex -->

                <div class="position-relative mb-4">
                  <canvas id="users-chart" height="200"></canvas>
                </div>

                <div class="d-flex flex-row justify-content-end">
                  <span class="mr-2">
                    <i class="fas fa-square text-primary"></i> 최근 7일
                  </span>
                </div>
              </div>
            </div>
            <!-- /.card -->
            <!-- /.card -->
          </div>
          
          <div class="col-lg-6">
            <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">상품매출현황</h3>
                  <a href="/admin/goodsList.ft">상세화면</a>
                </div>
              </div>
              <div class="card-body">
                <div class="d-flex">
                  <p class="d-flex flex-column">
                    <span class="text-bold text-lg"><fmt:formatNumber value="${totalSum }" pattern="###,### 원"/></span>                   
                    <span>7일 매출액</span>
                  </p>
                  <p class="ml-auto d-flex flex-column text-right">
                    <span class="text-muted">전날대비</span>
                    <span class="text-success">
                      <i class="fas fa-arrow-up"></i> 335%
                    </span>
                  </p>
                </div>
                <!-- /.d-flex -->
                <div class="position-relative mb-4">
                  <canvas id="sales-chart" height="200"></canvas>
                </div>
                <div class="d-flex flex-row justify-content-end">
                  <span class="mr-2">
                    <i class="fas fa-square text-success"></i> 최근 7일
                  </span>
                </div>
              </div>
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col-md-6 -->

<!--           <div class="col-12"> -->
<!--             interactive chart -->
<!--             <div class="card card-primary card-outline"> -->
<!--               <div class="card-header"> -->
<!--                 <h3 class="card-title"> -->
<!--                   <i class="far fa-chart-bar"></i> -->
<!--                   Interactive Area Chart -->
<!--                 </h3> -->

<!--                 <div class="card-tools"> -->
<!--                   Real time -->
<!--                   <div class="btn-group" id="realtime" data-toggle="btn-toggle"> -->
<!--                     <button type="button" class="btn btn-default btn-sm active" data-toggle="on">On</button> -->
<!--                     <button type="button" class="btn btn-default btn-sm" data-toggle="off">Off</button> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--               <div class="card-body"> -->
<!--                 <div id="interactive" style="height: 200px;"></div> -->
<!--               </div> -->
<!--               /.card-body -->
<!--             </div> -->
<!--             /.card -->
<!--           </div>       -->
      </div>
    </section>
    </div>
	<script>
	    var totalUser = ${totalUser};
	    var listUser = ${listUser};
	    var sumList = ${sumList};
	</script>
	<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
	<script src="../../../resources/plugins/chart.js/Chart.min.js"></script>
	<script src="../../../resources/dist/js/pages/dashboard3.js"></script>
	<!-- FLOT CHARTS -->
	<script src="../../../resources/plugins/flot/jquery.flot.js"></script>
</body>
</html>