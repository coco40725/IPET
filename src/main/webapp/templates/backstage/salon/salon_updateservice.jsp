<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.web.salonService.model.*"%>
<%@ page import="com.web.salonService.model.entities.*"%>
<%@ page import="com.web.salonService.model.services.*"%>
<%@ page import="com.web.salonService.model.dao.*"%>
<%@ page import="com.web.salonService.model.dao.impl.*"%>
<%@ page import="java.util.*"%>

<%
CategoryService catsvc = new CategoryService();
List<Category> catlist = catsvc.selectAll();
pageContext.setAttribute("catlist", catlist);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | DataTables</title>
<!-- TODO: 目前先使用 完整css，後續再換成 min.css-->
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/plugins/fontawesome-free/css/all.css">
<!-- IonIcons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/dist/css/adminlte.css">
<!-- summernote -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/backstage/plugins/summernote/summernote-bs4.min.css">
<style>
.cantSee {
	display: none !important;
}

.input-shadow {
	box-shadow: inset 0 1px 2px rgb(0 0 0/ 8%);
}

.c3 {
	margin-top: 1.25rem;
}

.choice-title {
	font-weight: 700;
	display: inline-block;
	margin-bottom: 0.5rem;
	box-sizing: border-box;
}

#second-card {
	margin-top: 28px;
}

hr {
	margin-top: 25px;
	margin-bottom: 20px;
	border: 2px solid #6c757d;
}

/* ================== 服務圖片start ==================*/
.svc_picture {
	border: 1px solid #ced4da;
	width: 100px;
	height: 100px;
	border-radius: 0.25rem;
	position: relative;
	margin-bottom: 1.25rem;
	display: block;
}

.svc_picture:hover {
	cursor: pointer;
	border: 1px solid #b1b1b1;
}

.svc_picture img {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left: -14px;
	margin-top: -13px;
}

/* ================== 寵物體型 ==================*/
#pet-size {
	border-radius: 0.25rem 0.25rem 0 0;
	background-color: #f3f5f6;
}

/* ================== 寵物品種 父元素 ==================*/
div.choose-type-price {
	border-bottom: 1px solid #ced4da;
	border-left: 1px solid #ced4da;
	border-right: 1px solid #ced4da;
	padding-right: 0.75rem;
	padding-bottom: 0.75rem;
	padding-top: 0.75rem;
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	border-radius: 0 0 0.25rem 0.25rem;
}

/* ================== 品種選項 ==================*/
div.pet-type {
	display: inline-block;
	margin-left: 0.75rem;
	height: 2rem;
}

div.pet-type input.form-control {
	width: 20px;
	display: inline-block;
}

div label.pet-label {
	font-weight: 400 !important;
	display: inline;
	position: relative;
	bottom: 0.75rem;
	left: 0.25rem;
}

/* ================== 送出價格區 ==================*/
div.add-service {
	padding: 0.375rem 1.75rem 0.375rem 0.75rem;
	border-top: none;
	border-radius: 0 0 0.25rem 0.25rem;
	position: relative;
	height: 43px;
}

#enterPrice {
	height: 30px;
	width: 200px;
	text-align: center;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding-left: 30px;
	padding-right: 5px;
}

#enterPrice:focus {
	outline: none;
	border: 1px solid #55a3e7;
	box-shadow: none;
}

#money-icon {
	position: absolute;
	left: 10px;
	top: 1px;
	color: #585858;
}

.button-style {
	height: 30px;
	width: 120px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	margin-left: 0.25rem;
}

.button-style:hover {
	border: 1px solid #9b9b9b;
}

.button-style:active {
	background-color: #cccccc;
	border: 1px solid #bdbdbd;
}

#to-right {
	margin-top: 0.5rem;
	position: absolute;
	right: 1px;
}

/* ============= 修改價格 ========= */
.button-style.short {
	width: 60px;
	background-color: #007bff;
	border: none;
	color: white;
	font-weight: 700;
}

.button-style.short:hover {
	background-color: #3295ff;
}

.button-style.short:active {
	background-color: #007bff;
}

.button-style.short.red {
	background-color: #9da2a6;
}

.button-style.short.red:hover {
	background-color: #828689;
}

.button-style.short.red:active {
	background-color: #9da2a6;
}

.updatePrice {
	padding-right: none;
	height: 30px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	box-shadow: inset 0 1px 2px rgb(0 0 0/ 8%);
}

.updatePrice:focus {
	outline: none;
	border: 1px solid #55a3e7;
	box-shadow: none;
}

/* ================== table區 ==================*/
.view-type-price {
	width: 100%;
	margin-top: 0;
}

.view-type-price td, th {
	border: 1px solid #efefef;
	padding: 12.75px;
}

.view-type-price thead {
	background-color: #e7e9eb;
}

.view-type-price thead th {
	border-right: 1px solid rgb(209, 211, 212);
}

.view-type-price tbody tr:hover {
	background-color: #f3f5f6;
}

.view-type-price tbody tr td:nth-child(1) {
	width: 200px;
}

.view-type-price tbody tr td:nth-child(2) {
	width: 350px;
}

.view-type-price td:nth-child(3) {
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid rgb(233, 234, 235);
	font-size: 1.1rem;
	padding-left: 49px;
	position: relative;
}

.view-type-price td:nth-child(3)::before {
	content: "$";
	position: absolute;
	left: 10px;
}

.view-type-price th:nth-child(3) {
	padding-left: 20px;
}

.view-type-price tbody tr td:nth-child(4) {
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid rgb(233, 234, 235);
	text-align: right;
	width: 60px;
}

.fa-pen {
	padding: 0 10px;
}

.fa-pen:hover {
	cursor: pointer;
	color: #007bff;
}

.view-type-price tbody tr td:nth-child(5) {
	border-top: none;
	border-left: none;
	border-right: 1px solid rgb(233, 234, 235);
	border-bottom: 1px solid rgb(233, 234, 235);
	text-align: center;
	width: 100px;
}

.fa-trash {
	padding: 0 10px;
}

.fa-trash:hover {
	cursor: pointer;
	color: #ff0000;
}

/* ================== summernote區 ==================*/
.note-codable, .card-block {
	min-height: 170px;
	padding: 20px !important;
}

.note-editor.note-frame.card {
	box-shadow: none;
}

.note-toolbar.card-header {
	box-shadow: inset 0 1px 2px rgb(0 0 0/ 8%);
}

.note-toolbar.card-header, .note-resizebar {
	background-color: #f3f5f6;
	padding: 6px 10px 10px 10px;
}

.note-btn-group.btn-group.note-insert {
	display: none;
}

/* ================== 新增服務 按鈕 ==================*/
#before-submit {
	height: 100px;
}

.service-submit {
	height: 55px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	margin-top: 10px;
	width: 100%;
	background-color: #007bff;
	color: white;
	font-weight: 700;
}

.service-submit:active {
	transform: scale(0.995);
}
</style>
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!--  Navbar -->
		<div id="Mynavbar"></div>
		<!-- /.navbar -->

		<!-- 左邊選單區 Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo -->
			<a href="../../index.html" class="brand-link"> <!--  TODO: {LOGO} 修改LOGO!    -->
				<img src="${pageContext.request.contextPath}/static/backstage/img/AdminLTELogo.png" alt="AdminLTE Logo"
				class="brand-image img-circle"> <span
				class="brand-text font-weight-light">IPET</span>
			</a>

			<!-- Left Sidebar -->
			<div class="sidebar">

				<!-- Sidebar user panel (optional) -->
				<div class="user-panel mt-3 pb-3 mb-3 d-flex">
					<div class="image">
						<img src="${pageContext.request.contextPath}/static/backstage/img/Employee1.jpg"
							class="img-circle elevation-2" alt="User Image">
					</div>
					<div class="info">
						<a href="#" class="d-block">IPET 寵物員工1 </a>
					</div>
				</div>

				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
						<li class="nav-header"><b>最新消息</b></li>
						<li class="nav-item">
							<!--  TODO: {最新消息管理-消息管理} 請修改消息管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {最新消息管理-消息管理} 可以修改消息管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-bullhorn"></i>
								<p>
									消息管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {最新消息管理-消息管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {最新消息管理-消息管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>員工專區</b></li>
						<li class="nav-item">
							<!--  TODO: {員工專區-員工管理} 請修改員工管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {員工專區-員工管理} 可以修改員工管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-user-tie"></i>
								<p>
									員工管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {員工專區-員工管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {員工專區-員工管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {員工專區-權限管理} 請修改權限管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {員工專區-權限管理} 可以修改權限管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-user-lock"></i>
								<p>
									權限管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {員工專區-權限管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {員工專區-權限管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>購物商城專區</b></li>
						<li class="nav-item">
							<!--  TODO: {購物商城專區-商品管理} 請修改商品管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {購物商城專區-商品管理} 可以修改商品管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-box"></i>
								<p>
									商品管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {購物商城專區-商品管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {購物商城專區-商品管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {購物商城專區-訂單管理} 請修改訂單管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {購物商城專區-訂單管理} 可以修改訂單管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-regular fa-clipboard-list"></i>
								<p>
									訂單管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {購物商城專區-訂單管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {購物商城專區-訂單管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>寵物住宿專區</b></li>
						<li class="nav-item">
							<!--  TODO: {寵物住宿專區-住宿預約管理} 請修改住宿預約管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物住宿專區-住宿預約管理} 可以修改住宿預約管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-regular fa-clipboard-list"></i>
								<p>
									住宿預約管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物住宿專區-住宿預約管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物住宿專區-住宿預約管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物住宿專區-房間管理} 請修改房間管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物住宿專區-房間管理} 可以修改房間管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-regular fa-bed"></i>
								<p>
									房間管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物住宿專區-房間管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物住宿專區-房間管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物住宿專區-房務管理} 請修改房務管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物住宿專區-房務管理} 可以修改房務管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-broom"></i>
								<p>
									房務管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物住宿專區-房務管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物住宿專區-房務管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物住宿專區-優惠管理} 請修改優惠管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物住宿專區-優惠管理} 可以修改優惠管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-receipt"></i>
								<p>
									住宿優惠管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物住宿專區-優惠管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物住宿專區-優惠管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>寵物美容專區</b></li>
						<li class="nav-item menu-open">
							<!--  TODO: {寵物美容專區-美容預約管理} 請修改美容預約管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物美容專區-美容預約管理} 可以修改美容預約管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-regular fa-clipboard-list"></i>
								<p>
									美容預約管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物美容專區-美容預約管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物美容專區-美容預約管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="salon_reserve_all.html"
									class="nav-link active"> <i class="far fa-circle nav-icon"></i>
										<p>預約總覽</p>
								</a></li>
								<li class="nav-item"><a href="salon_reserve_payed.html"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>已付訂金的預約</p>
								</a></li>
								<li class="nav-item"><a href="salon_reserve_cancelled.html"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>已取消的預約</p>
								</a></li>
								<li class="nav-item"><a href="salon_reserve_finished.html"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>已完成的預約</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物美容專區-班表管理} 請修改班表管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物美容專區-班表管理} 可以修改班表管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-calendar-alt"></i>
								<p>
									班表管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物美容專區-班表管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物美容專區-班表管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物美容專區-服務項目管理} 請修改服務項目管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物美容專區-服務項目管理} 可以修改服務項目管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-dog"></i>
								<p>
									服務項目管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物美容專區-服務項目管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物美容專區-服務項目管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-item">
							<!--  TODO: {寵物美容專區-優惠管理} 請修改優惠管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {寵物美容專區-優惠管理} 可以修改優惠管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-receipt"></i>
								<p>
									美容優惠管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {寵物美容專區-優惠管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {寵物美容專區-優惠管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>會員專區</b></li>
						<li class="nav-item">
							<!--  TODO: {會員專區-會員資料管理} 請修改會員資料管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {會員專區-會員資料管理} 可以修改會員資料管理的icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-solid fa-users"></i>
								<p>
									會員資料管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {會員專區-會員資料管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {會員專區-會員資料管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
						</li>
						<li class="nav-header"><b>客服專區</b></li>
						<li class="nav-item">
							<!--  TODO: {客服專區-客服管理} 請修改客服管理的 href  --> <a href="#"
							class="nav-link"> <!--  TODO: {客服專區-客服管理} 可以修改客服管理的 icon，參考網站: font awesome  -->
								<i class="nav-icon fas fa-sharp fa-solid fa-headset"></i>
								<p>
									客服管理 <i class="fas fa-angle-left right"></i>
									<!--      TODO: {客服專區-客服管理} 請評估是否有要顯示未讀訊息數量，暫時顯示 999         -->
									<span class="badge badge-info right">999</span>
								</p>
						</a> <!--    TODO: {客服專區-客服管理} 請評估是否要有子項目，需要的話請於按照  <li class="nav-item">... </li> 進行新增  -->
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目1</p>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link"> <i
										class="far fa-circle nav-icon"></i>
										<p>項目2</p>
								</a></li>
							</ul>
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
						<div class="col-sm-6">
							<!-- <h3 style="margin-top: .6rem;">新增美容服務</h3> -->
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active"><a href="#">美容服務管理</a></li>
								<li class="breadcrumb-item active">修改美容服務</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>

			<!-- Main content -->
			<section class="content">


				<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/static/backstage/salon/svc.servlet" name="form1">
				<div class="card card-secondary">
					<!-- card-body -->
						<div class="card-body">

							<input type="hidden" value="${param.svcId}" name="svcId">

							<label for="svc_category_id">服務類型</label>
							<select id="svc_category_id" class="form-control custom-select" name="catId">
								<c:forEach var="catVO" items="${catlist}">
									<option value="${param.catId}"
										${(param.catId == catVO.catId) ? 'selected' : ''}>${catVO.catName}</option>
								</c:forEach>
							</select>
								<label for="svc_name" class="c3">服務名稱</label>
								<c:if test="${not empty errorMsgs}">
									<span style="color: red;">${message.value}</span>
								</c:if>
								<input type="text" id="svc_name" class="form-control input-shadow" value="${param.svcName}" name="svcName">
								
								<span class="choice-title c3">服務圖片</span>
								<label class="svc_picture input-shadow">
								<input type="file" id="add-img" accept="image/*" style="display: none;" value="${param.svcImg}" name="svcImg">
								<img src="${pageContext.request.contextPath}/static/backstage/img/image.png" alt="">
								</label>

							<label for="svc_img">服務描述</label>
							<div>
								<textarea id="summernote" name="svcContent">
              					${param.svcContent}
              					</textarea>
							</div>

							<label for="pet_type" class="c3">寵物品種</label>
							<input type="hidden" value="${param.typeId}" name="typeId">
							<input type="text" readonly id="pet_type" class="form-control input-shadow" value="${param.typeNameAndSize}">
							
							<label for="svc_price" class="c3">服務單價</label>
							<input type="text" id="svc_price" class="form-control input-shadow" value="${param.svcPrice}" name="svcPrice">
							
							<input type="radio" id="svc_status1" value="0" ${(param.svcStatus == 0) ? 'checked' : ''} name="svcStatus">
							<label for="svc_status1" class="c3">上架</label>

							<input type="radio" id="svc_status2" value="1" ${(param.svcStatus == 1) ? 'checked' : ''} name="svcStatus">
							<label for="svc_status2" class="c3">未上架</label>
						</div>
						<!-- /.card-body -->
				</div>
				<!-- /.card -->

				<input type="hidden" name="action" value="update">

				<div id="before-submit">
					<input type="submit" class="service-submit" value="確認修改" id="submit">
				</div>
				
				</form>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<!-- Main Footer -->
		<div id="Myfooter"></div>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script src="${pageContext.request.contextPath}/static/backstage/dist/js/adminlte.js"></script>

	<!-- DataTables  & Plugins -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/jszip/jszip.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/pdfmake/pdfmake.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/pdfmake/vfs_fonts.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	<!-- Summernote -->
	<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
	<!-- Navbar script-->
	<script>
		$(function() {
			$("#Mynavbar").load("../../navbar_pages.html");
		})
	</script>

	<!-- Footer script-->
	<script>
		$(function() {
			$("#Myfooter").load("../../footer.html");
		})
	</script>
	<!-- Page specific script -->
	<script>
		$(function() {
			$("#example1").DataTable(
					{
						"responsive" : true,
						"lengthChange" : false,
						"autoWidth" : false,
						"buttons" : [ "copy", "csv", "excel", "pdf", "print",
								"colvis" ]
					}).buttons().container().appendTo(
					'#example1_wrapper .col-md-6:eq(0)');
			$('#example2').DataTable({
				"paging" : true,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : true,
				"info" : true,
				"autoWidth" : false,
				"responsive" : true,
			});

			/*===================== 點擊 card-header 開關 ==========================*/

			$(".card-header").click(function() {
				$(this).next().slideToggle();
				const i = $(this).find("i");
				if (i.hasClass("fa-minus")) {
					i.removeClass("fa-minus").addClass("fa-plus");
				} else if (i.hasClass("fa-plus")) {
					i.removeClass("fa-plus").addClass("fa-minus");
				}
			});

			/*===================== 點擊 鉛筆 更改價格 ==========================*/
			let priceValue;

			$(document)
					.on(
							"click",
							".fa-pen",
							function() {
								//變換成圖示+輸入框
								const td4 = $(this).parent();
								const ok = $("<button>").text("修改").addClass(
										"button-style short ok")
								const cancel = $("<button>")
										.text("取消")
										.addClass(
												"button-style short red cancel");
								priceValue = td4.prev().text();
								const updatePrice = `<input type="number" value="${priceValue}" min="0" max="999999999" class="updatePrice">`;
								td4.prev().html(updatePrice);
								td4.next().html(cancel);
								td4.html(ok);
							});

			// 確定修改
			$(document)
					.on(
							"click",
							".ok",
							function() {
								const ok = $(this).parent();
								const uppriceNum = ok.prev().children().val();
								if (uppriceNum === "0"
										|| uppriceNum.match(/[-]/)) {
									alert("服務價格不可小於或等於0！");
									return;
								}
								const faPen = `<i class="nav-icon fas fa-solid fa-pen"></i>`;
								const faTrash = `<i class="nav-icon fas fa-solid fa-trash"></i>`;
								ok.prev().html(uppriceNum);
								ok.next().html(faTrash);
								ok.html(faPen);
							});

			//取消修改
			$(document)
					.on(
							"click",
							".cancel",
							function() {
								const cancel = $(this).parent();
								const faPen = `<i class="nav-icon fas fa-solid fa-pen"></i>`;
								const faTrash = `<i class="nav-icon fas fa-solid fa-trash"></i>`;
								const pricesubling = cancel.prev().prev();
								pricesubling.html(priceValue);
								cancel.prev().html(faPen);
								cancel.html(faTrash);
							});

			/*===================== 點擊 垃圾桶 刪除價格 ==========================*/
			$(document).on("click", ".fa-trash", function() {
				$(this).parentsUntil("tbody").remove();
			});

			/*===================== Summernote ==========================*/
			$("#summernote").summernote();

			/*===================== 點擊 大中小標籤 換犬種 ==========================*/
			$("#pet-size").change(function() {
				if ($("#pet-size :selected").text() === "大型犬") {
					$("#showBigDog").removeClass("cantSee");
					$("#showMediumDog").addClass("cantSee");
					$("#showSmallDog").addClass("cantSee");
				} else if ($("#pet-size :selected").text() === "中型犬") {
					$("#showBigDog").addClass("cantSee");
					$("#showMediumDog").removeClass("cantSee");
					$("#showSmallDog").addClass("cantSee");
				} else if ($("#pet-size :selected").text() === "小型犬") {
					$("#showBigDog").addClass("cantSee");
					$("#showMediumDog").addClass("cantSee");
					$("#showSmallDog").removeClass("cantSee");
				}
			});

			/*===================== 點擊  ==========================*/
			$("#addService").click(function() {
				// 		  alert($("#svc_category_id").val());
				// 		  alert($("#svc_name").val());
				// 		  alert($("#add-img").files[0]);
				// 		  alert($("#summernote").val());
				// 		  alert($("#enterPrice").val());
				// 		  alert($(".aType").val());
				const aTypeLength = $(".aType").length;
				for (let i = 0; i < aTypeLength; i++) {
					const aTypeNum = $(".aType").eq(i);
					if (aTypeNum.prop("checked")) {
						alert(aTypeNum.val());
					}
				}
			});

		});
	</script>
</body>
</html>