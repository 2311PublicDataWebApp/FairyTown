<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>캘린더</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../resources/dist/css/calendar.css">
	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">날짜 선택</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10">
					<div class="elegant-calencar d-md-flex">
						<div class="wrap-header d-flex align-items-center img" style="background-image: url(../../resources/dist/img/calenderBg.png);">
						<p id="reset">Today</p>
					<div id="header" class="p-0">
					<div class="head-info">
						<div class="head-month"></div>
						<div class="head-day"></div>
					</div>
					</div>
					</div>
					<div class="calendar-wrap">
					<div class="w-100 button-wrap">
						<div class="pre-button d-flex align-items-center justify-content-center"><i class="fa fa-chevron-left"></i></div>
						<div class="next-button d-flex align-items-center justify-content-center"><i class="fa fa-chevron-right"></i></div>
					</div>
					<table id="calendar">
					<thead>
						<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
						</tr>
					</thead>
					<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					</tbody>
					</table>
					</div>
				</div>
				</div>
			</div>
		</div>
	</section>
	<script src="../resources/dist/js/jquery.min.js"></script>
	<script src="../resources/dist/js/popper.js"></script>
	<script src="../resources/dist/js/bootstrap.min.js"></script>
	<script src="../resources/dist/js/calendar.js"></script>
	</body>
</html>