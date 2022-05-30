<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./head.jsp"%>
</head>
<body>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->
	<div class="page-flag" data="index"></div>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Trang chủ</h1>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">
			<form action="admin/index.htm" class="invisible position-absolute"
				method="get" id="index-filter">
				<button name="btnFilter" class="btnFilter"></button>
			</form>
			<div class="row">
				<!-- Left side columns -->
				<div class="col-lg-12">
					<div class="row">
						<!-- Sales Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card sales-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Lọc</h6>
										</li>

										<li><input type="radio" id="b-day"
											class="invisible position-absolute"
											${billFilter=="day"?'checked':''} form="index-filter"
											name="bill" value="day"> <label class="dropdown-item"
											for="b-day">Hôm nay</label></li>
										<li><input type="radio"
											class="invisible position-absolute"
											${billFilter=="month"?'checked':''} id="b-month"
											form="index-filter" name="bill" value="month"> <label
											class="dropdown-item" for="b-month">Tháng này</label></li>
										<li><input type="radio"
											class="invisible position-absolute"
											${billFilter=="year"?'checked':''} id="b-year"
											form="index-filter" name="bill" value="year"> <label
											class="dropdown-item" for="b-year">Năm này</label></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Hoá đơn <span>| <c:choose>
												<c:when test="${billFilter=='day'}">Hôm nay</c:when>
												<c:when test="${billFilter=='month'}">Tháng này</c:when>
												<c:otherwise>Năm này</c:otherwise>
											</c:choose>
										</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="fa-light fa-ballot"></i>
										</div>
										<div class="ps-3">
											<h6>${numOfBill}</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Sales Card -->

						<!-- Revenue Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card revenue-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Lọc</h6>
										</li>

										<li><input type="radio"
											class="invisible position-absolute"
											${revenueFilter=="day"?'checked':''} id="r-day"
											form="index-filter" name="revenue" value="day"> <label
											class="dropdown-item" for="r-day">Hôm nay</label></li>
										<li><input class="invisible position-absolute"
											${revenueFilter=="month"?'checked':''} type="radio"
											id="r-month" form="index-filter" name="revenue" value="month">
											<label class="dropdown-item" for="r-month">Tháng này</label></li>
										<li><input type="radio"
											class="invisible position-absolute"
											${revenueFilter=="year"?'checked':''} id="r-year"
											form="index-filter" name="revenue" value="year"> <label
											class="dropdown-item" for="r-year">Năm này</label></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Doanh thu <span>| <c:choose>
												<c:when test="${revenueFilter=='day'}">Hôm nay</c:when>
												<c:when test="${revenueFilter=='month'}">Tháng này</c:when>
												<c:otherwise>Năm này</c:otherwise>
											</c:choose></span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-currency-dollar"></i>
										</div>
										<div class="ps-3">
											<h6>
												<fmt:formatNumber pattern="###,### đ" value="${revenue}"
													type="currency" />
											</h6>

										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Revenue Card -->

						<!-- Customers Card -->
						<div class="col-xxl-4 col-xl-12">
							<div class="card info-card customers-card">
								<div class="card-body">
									<h5 class="card-title">
										Khách hàng <span>| tất cả</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6>${numOfCustomer}</h6>

										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Customers Card -->


					</div>
				</div>
				<!-- End Left side columns -->

				<!-- Right side columns -->
				<!-- End Right side columns -->
			</div>
		</section>
	</main>
	<!-- End #main -->
	<%@include file="./script.jsp"%>
	<script type="text/javascript">
		$('input[name="bill"]').change(function() {
			$('button[name="btnFilter"]').click()
		})

		$('input[name="revenue"]').change(function() {
			$('button[name="btnFilter"]').click()
		})
	</script>
</body>
</html>