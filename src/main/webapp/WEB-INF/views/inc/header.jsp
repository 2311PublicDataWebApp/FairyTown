<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <script src="../assets/js/color-modes.js"></script>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/headers/">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
        <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUITE/fonts/static/woff2/SUITE.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <!-- Option 1: Include in HTML -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <style>
        	.body {
        		position: releative;
        	}
            .container {
/*                 position: fixed; 
/*                 top: 0; */
            }
            .body{
                padding-top: 8.751rem;
            }
            body {
            font-family: 'SUITE', sans-serif;
/*             font-weight: bold; */
            }
/*             @font-face { */
/*                 font-family: 'SUITE-Regular'; */
/*                 src: */
/*                     url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') */
/*                     format('woff2'); */
/*                 font-weight: 600; */
/*                 font-style: normal; */
/*             } */

/*             body { */
/*                 font-family: 'SUITE-Regular'; */
/*             } */

            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }

            .b-example-divider {
                width: 100%;
                height: 3rem;
                background-color: rgba(0, 0, 0, .1);
                border: solid rgba(0, 0, 0, .15);
                border-width: 1px 0;
                box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
            }

            .b-example-vr {
                flex-shrink: 0;
                width: 1.5rem;
                height: 100vh;
            }

            .bi {
                vertical-align: -.125em;
                fill: currentColor;
            }

            .nav-scroller {
                position: relative;
                z-index: 2;
                height: 2.75rem;
                overflow-y: hidden;
            }

            .nav-scroller .nav {
                display: flex;
                flex-wrap: nowrap;
                padding-bottom: 1rem;
                margin-top: -1px;
                overflow-x: auto;
                text-align: center;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
            }

            .btn-bd-primary {
                --bd-violet-bg: #712cf9;
                --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

                --bs-btn-font-weight: 600;
                --bs-btn-color: var(--bs-white);
                --bs-btn-bg: var(--bd-violet-bg);
                --bs-btn-border-color: var(--bd-violet-bg);
                --bs-btn-hover-color: var(--bs-white);
                --bs-btn-hover-bg: #6528e0;
                --bs-btn-hover-border-color: #6528e0;
                --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
                --bs-btn-active-color: var(--bs-btn-hover-color);
                --bs-btn-active-bg: #5a23c8;
                --bs-btn-active-border-color: #5a23c8;
            }

            .bd-mode-toggle {
                z-index: 1500;
            }

            .bd-mode-toggle .dropdown-menu .active .bi {
                display: block !important;
            }
            .nav {
		    --bs-nav-link-padding-x: 1rem;
		    --bs-nav-link-padding-y: 0.5rem;
		    --bs-nav-link-font-weight: ;
		    --bs-nav-link-color: var(--bs-link-color);
		    --bs-nav-link-hover-color: #99CCFF;
		    --bs-nav-link-disabled-color: var(--bs-secondary-color);
		    display: flex;
		    flex-wrap: wrap;
		    padding-left: 0;
		    margin-bottom: 0;
		    list-style: none;
			}
			
			.dropdown{
			  position : relative;
			  display : inline-block;
			}
			
			.dropbtn_icon{
			  font-family : 'Material Icons';
			}
			.dropbtn{
			  border : 1px solid rgb(37, 37, 37);
			  border-radius : 4px;
			  background-color: #f5f5f5;
			  font-weight: 400;
			  color : rgb(37, 37, 37);
			  padding : 12px;
			  width :200px;
			  text-align: left;
			  cursor : pointer;
			  font-size : 12px;
			}
			.dropdown-content{
			  display : none;
			  position : absolute;
			  z-index : 1; /*다른 요소들보다 앞에 배치*/
			  font-weight: 700;
			  background-color: #f9f9f9;
			  min-width : 200px;
			}
			
			.dropdown-content a{
			  display : block;
			  text-decoration : none;
			  color : rgb(37, 37, 37);
			  font-size: 15px;
			  padding : 12px 20px;
			}
			
			.dropdown-content a:hover{
			  background-color : #ececec
			}
			
			.dropdown:hover .dropdown-content {
			  display: block;
			}
			[class*="btn-"] {
				position: relative;
				display: inline-block;
				width: 100%;
				color: #fff;
				font-size: 16px;
				line-height: 45px;
				margin-right:3em;
				max-width: 100px;
				text-decoration: none;
				text-transform: uppercase;
				vertical-align: middle;
			}
			/**
			 * ===========================
			 * @class : btn-2
			 * ===========================
			 */
			.btn-2 {
				color: #white;
 				background-color: #ACE0F8;
/* 				border: 1px solid ; */
				box-shadow: 0 2px 0 #e8e8e8, 2px 4px 6px ;
				font-weight: bold;
				letter-spacing: 1px;
				-webkit-transition: all .15s linear;
				transition: all .15s linear;
			}
			.btn-2:hover {
				background: #FAC0CF;;
				border: 1px solid #fff;
				box-shadow: 1px 1px 2px #fff;
				color: ;
				text-shadow: -1px -1px 0 #c2211c;
			}
			/* 헤더 */
			body {
			  padding: 16px;
			}
			
			a {
			  text-decoration: none;
			}
			
			.underline {
			  line-height: 1.2;
			  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, "Apple Color Emoji", Arial, sans-serif, "Segoe UI Emoji", "Segoe UI Symbol";
			  font-size: 20px;
			  font-weight: 700;
			  background-image: linear-gradient(transparent calc(100% - 3px), #000 3px);
			  background-repeat: no-repeat;
			  background-size: 0% 100%;
			  transition: background-size 0.8s;
			  color: #000;
			  cursor: pointer;
			}
			@media (min-width: 1000px) {
			  .underline {
			    font-size: 5em;
			  }
			}
			.underline.yellow {
			  background-image: linear-gradient(transparent 60%, #F8CD07 40%);
			}
			.underline:hover {
			  background-size: 100% 100%;
			}
					
        	</style>
        <link href="../resources/css/headerandFooter" rel="stylesheet">
    </head>

<main>
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
        <symbol id="check2" viewBox="0 0 16 16">
            <path
                d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
        </symbol>
        <symbol id="circle-half" viewBox="0 0 16 16">
            <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z" />
        </symbol>
        <symbol id="moon-stars-fill" viewBox="0 0 16 16">
            <path
                d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
            <path
                d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z" />
        </symbol>
        <symbol id="sun-fill" viewBox="0 0 16 16">
            <path
                d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
        </symbol>
    </svg>
	    <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle" >
	   		<div class="dropup-center dropup">
<!-- 				  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" src="../resources/dist/img/close.png" style="width: 200px; height: 150px; margin-top: -200px; margin-right: 20px;"> -->
				    <img class="dropdown-toggle"  data-bs-toggle="dropdown" aria-expanded="false"  src="../resources/dist/img/close.png" style="width: 200px; height: 150px; margin-top: -200px; margin-right: 20px;"></img>
<!-- 				  </button> -->
				
				  <ul class="dropdown-menu" style="width: 200px; height: 430px; border: 0px; background-image: url('../resources/dist/img/backcloud.jpg');">
				    <img src="../resources/dist/img/opening.png" style="width: 280px; height: 210px; margin-top: -110px; margin-right: 20px; position: absolute;" />
				    <li><a class="dropdown-item"  href="#" style="height: 100px; margin-top: 40px; width: 90%; margin-left: 10px; background-color: #FDC3D2; border-radius: 15px; margin-bottom: 10px; ">Action</a></li>
				    <li><a class="dropdown-item" href="#" style="height: 100px; width: 90%; margin-left: 10px; background-color: #FDC3D2; border-radius: 15px; margin-bottom: 10px;">Action two</a></li>
				    <li><a class="dropdown-item" href="#" style="height: 100px; width: 90%; margin-left: 10px; background-color: #FDC3D2; border-radius: 15px; margin-bottom: 10px;">Action three</a></li>
				    <img src="../resources/dist/img/clouds.png" style="width: 550px; height: 430px; margin-top: -70px; margin-left: -180px; position: absolute;" />
				  </ul>
				</div>
			</div>
<!--     	<div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle" > -->
<!-- <!--     	<img src="../resources/dist/img/star8.png" style="width: 200px; height: 200px; margin-top: -400px; margin-left: 50px;"></img> --> -->
<!--     	<img src="../resources/dist/img/close.png" style="width: 200px; height: 150px; margin-top: -200px; margin-right: 20px;"></img> -->
<!--     	</div> -->

<!--     <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle"> -->
<!--         <button class="btn btn-bd-primary py-2 dropdown-toggle d-flex align-items-center" id="bd-theme" type="button" -->
<!--             aria-expanded="false" data-bs-toggle="dropdown" aria-label="Toggle theme (auto)"> -->
<!--             <svg class="bi my-1 theme-icon-active" width="1em" height="1em"> -->
<!--                 <use href="#circle-half"></use> -->
<!--             </svg> -->
<!--             <span class="visually-hidden" id="bd-theme-text">Toggle theme</span> -->
<!--         </button> -->
<!--         <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text"> -->
<!--             <li> -->
<!--                 <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" -->
<!--                     aria-pressed="false"> -->
<!--                     <svg class="bi me-2 opacity-50" width="1em" height="1em"> -->
<!--                         <use href="#sun-fill"></use> -->
<!--                     </svg> -->
<!--                     Light -->
<!--                     <svg class="bi ms-auto d-none" width="1em" height="1em"> -->
<!--                         <use href="#check2"></use> -->
<!--                     </svg> -->
<!--                 </button> -->
<!--             </li> -->
<!--             <li> -->
<!--                 <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" -->
<!--                     aria-pressed="false"> -->
<!--                     <svg class="bi me-2 opacity-50" width="1em" height="1em"> -->
<!--                         <use href="#moon-stars-fill"></use> -->
<!--                     </svg> -->
<!--                     Dark -->
<!--                     <svg class="bi ms-auto d-none" width="1em" height="1em"> -->
<!--                         <use href="#check2"></use> -->
<!--                     </svg> -->
<!--                 </button> -->
<!--             </li> -->
<!--             <li> -->
<!--                 <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto" -->
<!--                     aria-pressed="true"> -->
<!--                     <svg class="bi me-2 opacity-50" width="1em" height="1em"> -->
<!--                         <use href="#circle-half"></use> -->
<!--                     </svg> -->
<!--                     Auto -->
<!--                     <svg class="bi ms-auto d-none" width="1em" height="1em"> -->
<!--                         <use href="#check2"></use> -->
<!--                     </svg> -->
<!--                 </button> -->
<!--             </li> -->
<!--         </ul> -->
<!--     </div> -->


    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
        <symbol id="bootstrap" viewBox="0 0 118 94">
            <title>Bootstrap</title>
            <path fill-rule="evenodd" clip-rule="evenodd"
                d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z">
            </path>
        </symbol>
        <symbol id="home" viewBox="0 0 16 16">
            <path
                d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
        </symbol>
        <symbol id="speedometer2" viewBox="0 0 16 16">
            <path
                d="M8 4a.5.5 0 0 1 .5.5V6a.5.5 0 0 1-1 0V4.5A.5.5 0 0 1 8 4zM3.732 5.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 10a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 10zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 9.31a.91.91 0 1 0 1.302 1.258l3.434-4.297a.389.389 0 0 0-.029-.518z" />
            <path fill-rule="evenodd"
                d="M0 10a8 8 0 1 1 15.547 2.661c-.442 1.253-1.845 1.602-2.932 1.25C11.309 13.488 9.475 13 8 13c-1.474 0-3.31.488-4.615.911-1.087.352-2.49.003-2.932-1.25A7.988 7.988 0 0 1 0 10zm8-7a7 7 0 0 0-6.603 9.329c.203.575.923.876 1.68.63C4.397 12.533 6.358 12 8 12s3.604.532 4.923.96c.757.245 1.477-.056 1.68-.631A7 7 0 0 0 8 3z" />
        </symbol>
        <symbol id="table" viewBox="0 0 16 16">
            <path
                d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z" />
        </symbol>
        <symbol id="people-circle" viewBox="0 0 16 16">
            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
            <path fill-rule="evenodd"
                d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
        </symbol>
        <symbol id="grid" viewBox="0 0 16 16">
            <path
                d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z" />
        </symbol>
    </svg>
    <main>

    </main>
    <div class="navsquare" style="width: 2000px; height: 100px; background-color: white; position: fixed; top: 0; margin-left: -20px; font-size: 20px;  z-index:5;"> 
    <div class="container" style=" margin-top: 20px;">
        <header
            class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
            <div class="col-md-3 mb-2 mb-md-0">
                <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
                   <img src="../resources/dist/img/mainLogo.png" style="width: 180px; position: absolute; margin-top: -100px; margin-left: -80px;"/>
                </a>
            </div>

            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0" style="margin-right: 100px;">
                <li><a href="/ride/list.ft" class="yellow underline" style="margin-right: 40px; color: #C96AAC; font-size: 20px;" >즐길거리</a></li>
                <li><a href="/goods/list.ft" class="yellow underline" style="margin-right: 40px; color: #BA83BD; font-size: 20px;" >굿즈샵</a></li>
                <li><a href="/ticket/list.ft" class="yellow underline" style="margin-right: 40px; color: #A996CE; font-size: 20px;" >예매하기</a></li>
                <li><a href="/review/list.ft" class="yellow underline" style="margin-right: 40px; color: #93ADDE; font-size: 20px;" >리뷰</a></li>
<!--                 <li><a href="#" class="nav-link px-2" style="margin-right: 40px; color: #5DCCFA;">고객센터</a></li> -->
				<li class="dropdown">
				      <button class="nav-link px-2" style="margin-top: -9px;"> 
				        <span class="yellow underline" style="margin-right: 40px;  color: #5DCCFA; font-size: 20px;">고객센터</span>
				      </button>
				      <div class="dropdown-content">
				        <a href="/notice/list.ft" style="color: #497BC2;">공지사항</a>
				        <a href="/faq.ft" style="color: #5DCCFA;">자주 묻는 질문</a>
				        <a href="/qna/list.ft" style="color: #497BC2;">1대1 문의</a>
				      </div>
				    </li>
                
            </ul>

<!--             <div class="col-md-3 text-end"> -->
<!--                 <button type="button" onclick = "location.href = '#'" class="btn btn-outline-primary me-2" style="background-color: #ACE0F8; color: #3C94D4; border: 0;">로그인</button> -->
<!--                 <button type="button" onclick = "location.href = '#'" class="btn btn-primary" style="background-color: #FAC0CF; color: #F38686; border: 0;">회원가입</button> -->
<!--             </div> -->
				<!-- Start of Button 2 -->
				<c:if test = "${user.userId eq null }">
					<a href="/user/login.ft" class="btn-2" style="border-radius: 10px; text-align: center; margin-right: -20px; margin-top: -15px; ">로그인</a>
					<a href="/user/register.ft" class="btn-2" style="border-radius: 10px; text-align: center; margin-top: -15px; margin-right: -20px;">회원가입</a>
				</c:if>
				<c:if test = "${user.userId ne null }">
					<a href="/user/logout.ft" class="btn-2" style="border-radius: 10px; text-align: center; margin-top: -15px; margin-right: -20px;">로그아웃</a>
				</c:if>
<!-- 					background-color: #FAC0CF; -->
					<!-- End of Button 2 -->
        </header>
    </div>
    </div>
        <br><br><br><br><br><br><br><br><br><br>
    <!-- <div class="b-example-divider"></div> -->
</main>
    <script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
