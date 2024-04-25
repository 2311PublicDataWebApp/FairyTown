		<%@ page language="java" contentType="text/html; charset=UTF-8"
		    pageEncoding="UTF-8"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
		<!DOCTYPE html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <title>AdminLTE 3 | Starter</title>
		
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
		        <a href="../../index3.html" class="nav-link">Home</a>
		      </li>
		      <li class="nav-item d-none d-sm-inline-block">
		        <a href="#" class="nav-link">Contact</a>
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
		
		      <!-- Messages Dropdown Menu -->
		      <li class="nav-item dropdown">
		        <a class="nav-link" data-toggle="dropdown" href="#">
		          <i class="far fa-comments"></i>
		          <span class="badge badge-danger navbar-badge">3</span>
		        </a>
		        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
		          <a href="#" class="dropdown-item">
		            <!-- Message Start -->
		            <div class="media">
		              <img src="../../dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
		              <div class="media-body">
		                <h3 class="dropdown-item-title">
		                  Brad Diesel
		                  <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
		                </h3>
		                <p class="text-sm">Call me whenever you can...</p>
		                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
		              </div>
		            </div>
		            <!-- Message End -->
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item">
		            <!-- Message Start -->
		            <div class="media">
		              <img src="../../dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
		              <div class="media-body">
		                <h3 class="dropdown-item-title">
		                  John Pierce
		                  <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
		                </h3>
		                <p class="text-sm">I got your message bro</p>
		                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
		              </div>
		            </div>
		            <!-- Message End -->
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item">
		            <!-- Message Start -->
		            <div class="media">
		              <img src="../../dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
		              <div class="media-body">
		                <h3 class="dropdown-item-title">
		                  Nora Silvester
		                  <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
		                </h3>
		                <p class="text-sm">The subject goes here</p>
		                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
		              </div>
		            </div>
		            <!-- Message End -->
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
		        </div>
		      </li>
		      <!-- Notifications Dropdown Menu -->
		      <li class="nav-item dropdown">
		        <a class="nav-link" data-toggle="dropdown" href="#">
		          <i class="far fa-bell"></i>
		          <span class="badge badge-warning navbar-badge">15</span>
		        </a>
		        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
		          <span class="dropdown-item dropdown-header">15 Notifications</span>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item">
		            <i class="fas fa-envelope mr-2"></i> 4 new messages
		            <span class="float-right text-muted text-sm">3 mins</span>
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item">
		            <i class="fas fa-users mr-2"></i> 8 friend requests
		            <span class="float-right text-muted text-sm">12 hours</span>
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item">
		            <i class="fas fa-file mr-2"></i> 3 new reports
		            <span class="float-right text-muted text-sm">2 days</span>
		          </a>
		          <div class="dropdown-divider"></div>
		          <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
		        </div>
		      </li>
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
		    <a href="../../index3.html" class="brand-link">
		      <img src="../../dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
		      <span class="brand-text font-weight-light">AdminLTE 3</span>
		    </a>
		
		    <!-- Sidebar -->
		    <div class="sidebar">
		      <!-- Sidebar user (optional) -->
		      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
		        <div class="image">
		          <img src="../../dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
		        </div>
		        <div class="info">
		          <a href="#" class="d-block">Alexander Pierce</a>
		        </div>
		      </div>
		
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
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-tachometer-alt"></i>
		              <p>
		                Dashboard
		                <i class="right fas fa-angle-left"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../../index.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Dashboard v1</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../../index2.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Dashboard v2</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../../index3.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Dashboard v3</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="../widgets.html" class="nav-link">
		              <i class="nav-icon fas fa-th"></i>
		              <p>
		                Widgets
		                <span class="right badge badge-danger">New</span>
		              </p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-copy"></i>
		              <p>
		                Layout Options
		                <i class="fas fa-angle-left right"></i>
		                <span class="badge badge-info right">6</span>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../layout/top-nav.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Top Navigation</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/top-nav-sidebar.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Top Navigation + Sidebar</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/boxed.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Boxed</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/fixed-sidebar.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Fixed Sidebar</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/fixed-sidebar-custom.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Fixed Sidebar <small>+ Custom Area</small></p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/fixed-topnav.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Fixed Navbar</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/fixed-footer.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Fixed Footer</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../layout/collapsed-sidebar.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Collapsed Sidebar</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-chart-pie"></i>
		              <p>
		                Charts
		                <i class="right fas fa-angle-left"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../charts/chartjs.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>ChartJS</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../charts/flot.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Flot</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../charts/inline.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Inline</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../charts/uplot.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>uPlot</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-tree"></i>
		              <p>
		                UI Elements
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../UI/general.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>General</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/icons.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Icons</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/buttons.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Buttons</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/sliders.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Sliders</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/modals.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Modals & Alerts</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/navbar.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Navbar & Tabs</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/timeline.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Timeline</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../UI/ribbons.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Ribbons</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-edit"></i>
		              <p>
		                Forms
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../forms/general.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>General Elements</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../forms/advanced.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Advanced Elements</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../forms/editors.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Editors</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../forms/validation.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Validation</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-table"></i>
		              <p>
		                Tables
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../tables/simple.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Simple Tables</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../tables/data.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>DataTables</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../tables/jsgrid.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>jsGrid</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-header">EXAMPLES</li>
		          <li class="nav-item">
		            <a href="../calendar.html" class="nav-link">
		              <i class="nav-icon far fa-calendar-alt"></i>
		              <p>
		                Calendar
		                <span class="badge badge-info right">2</span>
		              </p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="../gallery.html" class="nav-link">
		              <i class="nav-icon far fa-image"></i>
		              <p>
		                Gallery
		              </p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="../kanban.html" class="nav-link">
		              <i class="nav-icon fas fa-columns"></i>
		              <p>
		                Kanban Board
		              </p>
		            </a>
		          </li>
		          <li class="nav-item menu-open">
		            <a href="#" class="nav-link active">
		              <i class="nav-icon far fa-envelope"></i>
		              <p>
		                Mailbox
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../mailbox/mailbox.html" class="nav-link active">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Inbox</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../mailbox/compose.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Compose</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../mailbox/read-mail.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Read</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-book"></i>
		              <p>
		                Pages
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../examples/invoice.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Invoice</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/profile.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Profile</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/e-commerce.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>E-commerce</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/projects.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Projects</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/project-add.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Project Add</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/project-edit.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Project Edit</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/project-detail.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Project Detail</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/contacts.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Contacts</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/faq.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>FAQ</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/contact-us.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Contact us</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon far fa-plus-square"></i>
		              <p>
		                Extras
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>
		                    Login & Register v1
		                    <i class="fas fa-angle-left right"></i>
		                  </p>
		                </a>
		                <ul class="nav nav-treeview">
		                  <li class="nav-item">
		                    <a href="../examples/login.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Login v1</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/register.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Register v1</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/forgot-password.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Forgot Password v1</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/recover-password.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Recover Password v1</p>
		                    </a>
		                  </li>
		                </ul>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>
		                    Login & Register v2
		                    <i class="fas fa-angle-left right"></i>
		                  </p>
		                </a>
		                <ul class="nav nav-treeview">
		                  <li class="nav-item">
		                    <a href="../examples/login-v2.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Login v2</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/register-v2.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Register v2</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/forgot-password-v2.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Forgot Password v2</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="../examples/recover-password-v2.html" class="nav-link">
		                      <i class="far fa-circle nav-icon"></i>
		                      <p>Recover Password v2</p>
		                    </a>
		                  </li>
		                </ul>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/lockscreen.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Lockscreen</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/legacy-user-menu.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Legacy User Menu</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/language-menu.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Language Menu</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/404.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Error 404</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/500.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Error 500</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/pace.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Pace</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../examples/blank.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Blank Page</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../../starter.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Starter Page</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-search"></i>
		              <p>
		                Search
		                <i class="fas fa-angle-left right"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="../search/simple.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Simple Search</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="../search/enhanced.html" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Enhanced</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-header">MISCELLANEOUS</li>
		          <li class="nav-item">
		            <a href="../../iframe.html" class="nav-link">
		              <i class="nav-icon fas fa-ellipsis-h"></i>
		              <p>Tabbed IFrame Plugin</p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="https://adminlte.io/docs/3.1/" class="nav-link">
		              <i class="nav-icon fas fa-file"></i>
		              <p>Documentation</p>
		            </a>
		          </li>
		          <li class="nav-header">MULTI LEVEL EXAMPLE</li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="fas fa-circle nav-icon"></i>
		              <p>Level 1</p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon fas fa-circle"></i>
		              <p>
		                Level 1
		                <i class="right fas fa-angle-left"></i>
		              </p>
		            </a>
		            <ul class="nav nav-treeview">
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Level 2</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>
		                    Level 2
		                    <i class="right fas fa-angle-left"></i>
		                  </p>
		                </a>
		                <ul class="nav nav-treeview">
		                  <li class="nav-item">
		                    <a href="#" class="nav-link">
		                      <i class="far fa-dot-circle nav-icon"></i>
		                      <p>Level 3</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="#" class="nav-link">
		                      <i class="far fa-dot-circle nav-icon"></i>
		                      <p>Level 3</p>
		                    </a>
		                  </li>
		                  <li class="nav-item">
		                    <a href="#" class="nav-link">
		                      <i class="far fa-dot-circle nav-icon"></i>
		                      <p>Level 3</p>
		                    </a>
		                  </li>
		                </ul>
		              </li>
		              <li class="nav-item">
		                <a href="#" class="nav-link">
		                  <i class="far fa-circle nav-icon"></i>
		                  <p>Level 2</p>
		                </a>
		              </li>
		            </ul>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="fas fa-circle nav-icon"></i>
		              <p>Level 1</p>
		            </a>
		          </li>
		          <li class="nav-header">LABELS</li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon far fa-circle text-danger"></i>
		              <p class="text">Important</p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon far fa-circle text-warning"></i>
		              <p>Warning</p>
		            </a>
		          </li>
		          <li class="nav-item">
		            <a href="#" class="nav-link">
		              <i class="nav-icon far fa-circle text-info"></i>
		              <p>Informational</p>
		            </a>
		          </li>
		        </ul>
		      </nav>
		      <!-- /.sidebar-menu -->
		    </div>
		    <!-- /.sidebar -->
		  </aside>
		
		  <!-- Content Wrapper. Contains page content -->
		  <div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header">
		      <div class="container-fluid">
		        <div class="row mb-2">
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		
		 <!-- Main content -->
		    <section class="content" style="margin-left: 300px;">
		      <div class="container-fluid">
		        <div class="row">
		          <!-- /.col -->
		          <div class="col-md-9">
		            <div class="card card-primary card-outline">
		              <div class="card-header">
		                <h3 class="card-title">Compose New Message</h3>
		              </div>
		              <!-- /.card-header -->
		              <div class="card-body">
		                <div class="form-group">
		                  <input class="form-control" placeholder="To:">
		                </div>
		                <div class="form-group">
		                  <input class="form-control" placeholder="Subject:">
		                </div>
						<!--댓글 -->
						<!-- 댓글 목록 -->
								<table width="1000" border="0" id="qnaReplyTable">
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
												<input type="text" name="qnaReplyContent" id="qnaReplyContent" size="110">
											</td>
											<td>
						<!-- 					<input type="submit" value="등록하기"> -->
												<button id="rSubmit" style="margin-left: 20px; height: 43px; width:100px; border-radius: 10px; background-color: #007BFF; border: none;
				  color: #fff;													">등록하기</button>
											</td>
									</table>
						<!-- 	</form> -->
						<br>
								
		                </div>
		              </div>
		              <!-- /.card-body -->
		              <div class="card-footer">
		                <div class="float-right">
		                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> Send</button>
		                </div>
		                <button type="reset" class="btn btn-default"><i class="fas fa-times"></i> Discard</button>
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
		</script>
		</body>
		</html>