<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>관리자 페이지</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Theme style -->
  <link rel="stylesheet" href="../resources/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="../../resources/dist/css/adminlte.min.css">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/" class="nav-link">홈페이지</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="fas fa-search"></i>
        </a>
        <div class="navbar-search-block">
          <form class="form-inline">
            <div class="input-group input-group-sm">
              <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                  <i class="fas fa-search"></i>
                </button>
                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </li>
     
      <!-- Notifications Dropdown Menu -->
<!--       <li class="nav-item dropdown"> -->
<!--         <a class="nav-link" data-toggle="dropdown" href="#"> -->
<!--           <i class="far fa-bell"></i> -->
<!--           <span class="badge badge-warning navbar-badge">15</span> -->
<!--         </a> -->
<!--         <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right"> -->
<!--           <span class="dropdown-header">15 Notifications</span> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="#" class="dropdown-item"> -->
<!--             <i class="fas fa-envelope mr-2"></i> 4 new messages -->
<!--             <span class="float-right text-muted text-sm">3 mins</span> -->
<!--           </a> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="#" class="dropdown-item"> -->
<!--             <i class="fas fa-users mr-2"></i> 8 friend requests -->
<!--             <span class="float-right text-muted text-sm">12 hours</span> -->
<!--           </a> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="#" class="dropdown-item"> -->
<!--             <i class="fas fa-file mr-2"></i> 3 new reports -->
<!--             <span class="float-right text-muted text-sm">2 days</span> -->
<!--           </a> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a> -->
<!--         </div> -->
<!--       </li> -->
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/admin.ft" class="brand-link">
      <img src="../../resources/dist/img/AdminMainLogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">FAIRYTOWN 관리</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
		<li class="nav-header">관리메뉴</li>               
          <li class="nav-item menu-open">
            <a href="/admin.ft" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                대쉬보드
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin.ft" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>대쉬보드</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/adminTableSample.ft" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>관리자 테이블 양식</p>
                </a>
              </li>
            </ul>
          </li>
          
			<li class="nav-header">회원관리</li>
			<li class="nav-item">
	            <a href="/admin/userlist.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-users"></i>
	              <p>회원관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/blacklist.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-user-slash"></i>
	              <p>블랙리스트 관리</p>
	            </a>
			</li>
          <li class="nav-header">전시관리</li>
			<li class="nav-item">
	            <a href="#" class="nav-link">
	              <i class="nav-icon fa-solid fa-newspaper"></i>
	              <p>배너 관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/review/list.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-face-smile"></i>
	              <p>리뷰 관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/goodsList.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-store"></i>
	              <p>굿즈샵 상품 관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/ridelist.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-landmark-flag"></i>
	              <p>놀이기구 관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/closelist.ft" class="nav-link">
	              <i class="nav-icon far fa-calendar-alt"></i>
	              <p>운휴관리</p>
	            </a>
			</li>
			<li class="nav-item">
	            <a href="/admin/ticketlist.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-ticket"></i>
	              <p>티켓 관리</p>
	            </a>
			</li>															          
          <li class="nav-header">주문관리</li>
          	<li class="nav-item">
	            <a href="/admin/booking/list.ft" class="nav-link">
	              <i class="nav-icon far fa-calendar-alt"></i>
	              <p>놀이기구 예약관리</p>
	            </a>
			</li>
          	<li class="nav-item">
	            <a href="/admin/ticketing/list.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-cash-register"></i>
	              <p>티켓 결제관리</p>
	            </a>
			</li>
          	<li class="nav-item">
	            <a href="/admin/orderList.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-cart-flatbed"></i>
	              <p>굿즈샵 주문관리</p>
	            </a>
			</li>						
          <li class="nav-header">고객센터</li>
          	<li class="nav-item">
	            <a href="/admin/notice/list.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-bell"></i>
	              <p>공지사항 관리</p>
	            </a>
			</li>
          	<li class="nav-item">
	            <a href="/qna/adminList.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-message"></i>
	              <p>1:1문의 관리</p>
	            </a>
			</li>
          	<li class="nav-item">
	            <a href="/admin/chatList.ft" class="nav-link">
	              <i class="nav-icon fa-solid fa-comments"></i>
	              <p>채팅 상담 관리</p>
	            </a>
			</li>			          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

</div>
<!-- ./wrapper -->
<script>
document.addEventListener('DOMContentLoaded', function() {

    var currentPageUrl = window.location.pathname;
    var navLinks = document.querySelectorAll('.nav-link');
    // 모든 네비게이션 항목을 반복하면서 active 클래스를 적용합니다.
    navLinks.forEach(function(link) {
        // 현재 항목의 href 속성값을 가져옵니다.
        var linkUrl = link.getAttribute('href');

        // 현재 페이지와 항목의 href가 일치하는 경우에 active 클래스를 추가합니다.
        if (linkUrl === currentPageUrl) {
            link.classList.add('active');

            // 부모 요소의 상위 nav-item이 있는 경우에도 active 클래스를 추가합니다.
            var parentNav = link.closest('.nav-item');
            if (parentNav) {
                parentNav.classList.add('active');
                parentNav.classList.add('menu-open');
            }
        } else {
            // 현재 페이지와 일치하지 않는 항목의 active 클래스를 삭제합니다.
            link.classList.remove('active');
        }
    });
});

</script>
<!-- jQuery -->
<script src="../../resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../resources/dist/js/adminlte.min.js"></script>
<script src="../resources/plugins/select2/js/select2.full.min.js"></script>

</body>
</html>
