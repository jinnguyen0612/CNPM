<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header id="header" class="header fixed-top d-flex align-items-center">

	<!--  flag -->
	<div class="alert-flag" aType='${message.type}'
		aMessage="${message.message }"></div>
	<div class="modal-flag" idModal="${idModal}"></div>
	<div class="customerId-flag" data="${customerId}"></div>
	<!-- end flag  -->
	<div class="d-flex align-items-center justify-content-between">
		<a href="admin/index.htm" class="logo d-flex align-items-center">
			<img src="assets/img/logo.png" alt="" /> <span
			class="d-none d-lg-block">PTIT GYM</span>
		</a> <i class="bi bi-list toggle-sidebar-btn"></i>
	</div>
	<!-- End Logo -->

	<nav class="header-nav ms-auto">
		<ul class="d-flex align-items-center">
			<li class="nav-item d-block d-lg-none"><a
				class="nav-link nav-icon search-bar-toggle" href="#"> <i
					class="bi bi-search"></i>
			</a></li>
			<!-- End Search Icon-->



			<li class="nav-item dropdown pe-3"><a
				class="nav-link nav-profile d-flex align-items-center pe-0" href="#"
				data-bs-toggle="dropdown"> <span
					class="d-none d-md-block dropdown-toggle ps-2">${admin.staff.name}</span>
			</a> <!-- End Profile Iamge Icon -->

				<ul
					class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
					<li class="dropdown-header">
						<h6>${admin.staff.name}</h6>
					</li>
					<li>
						<hr class="dropdown-divider" />
					</li>

					<li><a class="dropdown-item d-flex align-items-center"
						href="admin/profile.htm"> <i class="bi bi-person"></i> <span>Thông
								tin của tôi</span>
					</a></li>
					<li>
						<hr class="dropdown-divider" />
					</li>

					<li><a class="dropdown-item d-flex align-items-center"
						href="admin/logout.htm"> <i class="bi bi-box-arrow-right"></i>
							<span>Đăng xuất</span>
					</a></li>
				</ul> <!-- End Profile Dropdown Items --></li>
			<!-- End Profile Nav -->
		</ul>
	</nav>
	<!-- End Icons Navigation -->
</header>