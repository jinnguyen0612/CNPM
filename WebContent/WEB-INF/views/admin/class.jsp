<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./head.jsp"%>
</head>
<body>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->
	<div class="page-flag" data="class"></div>
	<main id="main" class="main">
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body pb-0">
							<h5
								class="card-title align-items-center d-flex justify-content-between transitioning">
								Danh sách lớp tập</h5>
							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th>Mã</th>
										<th>Gói tập</th>
										<th>Huấn luyện viên</th>
										<th>Trang thái</th>
										<th>Số người đăng ký</th>
										<th class="text-center col-2">Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="C" items="${classEntity}">
										<c:forEach var="t" items="${C.scheduleEntity}">
											<input type="text"
												class="T-${C.classId} invisible position-absolute"
												value='D-T${t.day}-${t.session}'>
										</c:forEach>
										<tr>
											<td>${C.classId}</td>
											<td>${C.trainingPackEntity.packName}</td>
											<td>${C.ptEntity.ptName}</td>
											<td><c:choose>
													<c:when test="${C.getClassStatus() == 1}">
														<span class="badge rounded-pill bg-success">Có thể
															đăng ký</span>
													</c:when>
													<c:when test="${C.getClassStatus() == 2}">
														<span class="badge rounded-pill bg-secondary">Đã đủ
															số lượng đăng ký</span>
													</c:when>
													<c:otherwise>
														<span class="badge rounded-pill bg-secondary">Hết
															hạn đăng ký</span>
													</c:otherwise>

												</c:choose></td>
											<td class="account-state">${C.getRegisterDetailEntitiesAvailable().size()}/${C.maxPP }&nbspngười</td>

											<td class="text-center"><c:choose>
													<c:when test="${C.getClassPeriod() == 0 }">
														<button class="btn btn-outline-warning btn-light btn-sm"
															onclick="window.location.href = 'admin/class/update/${C.classId}.htm'"
															title="Chỉnh sửa">
															<i class="fa-solid fa-pen-to-square"></i>
														</button>
													</c:when>
													<c:otherwise>
														<button disabled="disabled"
															class="btn btn-secondary btn-sm" title="Chỉnh sửa">
															<i class="fa-solid fa-pen-to-square"></i>
														</button>
													</c:otherwise>
												</c:choose>
												<button class="btn btn-outline-info btn-light btn-sm"
													onclick="window.location.href = 'admin/class/detail/${C.classId}.htm'"
													title="Chi tiết" data-bs-placement="top">
													<i class="fa-solid fa-circle-exclamation"></i>
												</button>
												<button data=".T-${C.classId}"
													class="btn-show-time-table-detail btn btn-outline-success btn-light btn-sm">
													<i class="fa-regular fa-calendar-days"></i>
												</button></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- End Table with stripped rows -->
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- chỉnh sửa  -->
		<!--   -->
		<div class="modal fade" id="modal-update" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Sửa lớp tập</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form method="post" id="classUpdate"
							action="admin/class/update/${classUpdate.classId}.htm"
							modelAttribute="classUpdate" class="row g-3">
							<div class="col-md-12">
								<label for="inputName" class="form-label">Mã: <form:input
										path="classId" type="text" class="form-control"
										readonly="true" />
								</label>
							</div>
							<div class="col-md-6">
								<label for="input-package" class="form-label">Gói tập</label>
								<form:select path="packId" id="input-package"
									class="form-select">
									<c:forEach var="X" items="${trainingPackEntity}">
										<form:option value="${X.packID}">${X.packName}</form:option>
									</c:forEach>
								</form:select>
								<span class="text-danger"><form:errors path="packId"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-pt" class="form-label">PT</label>
								<form:select path="PT" id="input-pt" class="form-select">
									<form:option value="${classUpdate.ptEntity.ptID}">${classUpdate.ptEntity.ptID}</form:option>
									<c:forEach var="T" items="${ptEntity}">
										<form:option value="${T.ptID}">${T.ptID}</form:option>
									</c:forEach>
								</form:select>
								<span class="text-danger"><form:errors path="PT"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-open-register-day" class="form-label">Ngày
									mở đăng ký</label>
								<form:input path="dateOpen" type="date" class="form-control"
									id="input-open-register-day" />
								<span class="text-danger"><form:errors path="dateOpen"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									đóng đăng ký</label>
								<form:input path="dateClose" type="date" class="form-control"
									id="input-close-register-day" />
								<span class="text-danger"><form:errors path="dateClose"></form:errors></span>
							</div>

							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									bắt đầu lớp</label>
								<form:input path="dateStart" type="date" class="form-control"
									id="input-close-register-day" />
								<span class="text-danger"><form:errors path="dateStart"></form:errors></span>
							</div>

							<div class="col-md-6">
								<label for="inputPhone" class="form-label">Số người đăng
									ký tối đa</label>
								<form:input path="maxPP" type="number" class="form-control" />
								<span class="text-danger"><form:errors path="maxPP"></form:errors></span>
							</div>
							<div>
								<button data=".2-T-${classUpdate.classId}"
									class="btn btn-show-time-table2 col-12 btn-outline-primary btn-light"
									type="button" data-bs-toggle="modal">
									<i class="bi bi-plus-circle"></i> <span class="te">Chỉnh
										sửa TKB</span>
								</button>
							</div>

							<div class="text-end mt-3">
								<button type="submit" name="btnUpdate" class="btn btn-primary">Xác
									nhận</button>
								<button type="button" class="btn btn-secondary close-form"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>

		<!-- modal  -->
		<!-- thêm mới lớp  -->
		<div class="modal fade" id="modal-create" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Thêm lớp tập</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form id="class" action="admin/class/insert.htm"
							method="post" class="row g-3" modelAttribute="classer">
							<div class="col-md-12">
								<label for="inputName" class="form-label">Mã: <form:input
										path="classId" type="text" class="form-control"
										readonly="true" />
								</label>
							</div>
							<div class="col-md-6">
								<label for="input-package" class="form-label">Gói tập</label>
								<form:select path="packId" id="input-package"
									class="form-select">
									<c:forEach var="X" items="${trainingPackEntity}">
										<form:option value="${X.packID}">${X.packID}</form:option>
									</c:forEach>
								</form:select>
								<span class="text-danger"><form:errors path="packId"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-pt" class="form-label">PT</label>
								<form:select path="PT" id="input-pt" class="form-select">
									<c:forEach var="T" items="${ptEntity}">
										<form:option value="${T.ptID}">${T.ptID}</form:option>
									</c:forEach>
								</form:select>
								<span class="text-danger"><form:errors path="PT"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-open-register-day" class="form-label">Ngày
									mở đăng ký</label>
								<form:input path="dateOpen" type="date" class="form-control"
									id="input-open-register-day" />
								<span class="text-danger"><form:errors path="dateOpen"></form:errors></span>
							</div>
							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									đóng đăng ký</label>
								<form:input path="dateClose" type="date" class="form-control"
									id="input-close-register-day" />
								<span class="text-danger"><form:errors path="dateClose"></form:errors></span>
							</div>

							<div class="col-md-6">
								<label for="input-close-register-day" class="form-label">Ngày
									bắt đầu lớp</label>
								<form:input path="dateStart" type="date" class="form-control"
									id="input-close-register-day" />
								<span class="text-danger"><form:errors path="dateStart"></form:errors></span>
							</div>

							<div class="col-md-6">
								<label for="inputPhone" class="form-label">Số người đăng
									ký tối đa</label>
								<form:input path="maxPP" type="number" class="form-control" />
								<span class="text-danger"><form:errors path="maxPP"></form:errors></span>
							</div>
							<div>
								<button class="btn col-12 btn-outline-primary btn-light"
									type="button" data-bs-target="#time-table"
									data-bs-toggle="modal">
									<i class="bi bi-plus-circle"></i> <span class="te">Tạo
										TKB</span>
								</button>
							</div>

							<div class="text-end mt-3">
								<button type="submit" name="btnCreate" class="btn btn-primary">Xác
									nhận</button>
								<button type="button" class="btn btn-secondary close-form"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
		<!-- detail -->
		<!-- table detail -->


		<div class="modal fade" id="modal-detail" tabindex="-1">

			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Chi tiết thông tin khách hàng</h5>
						<button type="button" class="btn-close close-form"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-0">
						<section class="section profile">
							<div class="row">
								<div class="col-xl-12 mx-auto">
									<div class="card mb-0">
										<div class="card-body pt-3">
											<!-- Bordered Tabs -->
											<ul class="nav nav-tabs nav-tabs-bordered">
												<li class="nav-item">
													<button class="nav-link active" data-bs-toggle="tab"
														data-bs-target="#profile-overview">Thông tin cơ
														bản</button>
												</li>

												<li class="nav-item">
													<button class="nav-link" data-bs-toggle="tab"
														data-bs-target="#profile-edit">Danh sách khách
														đăng ký</button>
												</li>
											</ul>
											<div class="tab-content pt-2">
												<div class="tab-pane fade show active profile-overview"
													id="profile-overview">


													<div class="row mt-4">
														<div class="col-lg-4 col-md-4 label">Mã</div>
														<div class="col-lg-8 col-md-8">${classDetail.classId }</div>

													</div>

													<div class="row">
														<div class="col-lg-4 col-md-4 label">Gói</div>
														<div class="col-lg-8 col-md-8">${classDetail.trainingPackEntity.packName }</div>

													</div>
													<div class="row">
														<div class="col-lg-4 col-md-4 label">Huấn luyện</div>
														<div class="col-lg-8 col-md-8">
															${classDetail.ptEntity.ptName}</div>

													</div>

													<div class="row">

														<div class="col-lg-4 col-md-4 label">Thời gian đăng
															ký</div>
														<div class="col-lg-8 col-md-8">
															<fmt:formatDate value="${classDetail.dateOpen }"
																pattern="dd/MM/yyyy" />
															-
															<fmt:formatDate value="${classDetail.dateClose }"
																pattern="dd/MM/yyyy" />
															(
															<c:choose>
																<c:when test="${classDetail.getClassStatus() == 1}">
																	<span class=" text-success">Có thể đăng ký</span>
																</c:when>
																<c:when test="${classDetail.getClassStatus() == 2}">
																	<span class="text-secondary">Đã đủ số lượng đăng
																		ký</span>
																</c:when>
																<c:otherwise>
																	<span class="text-secondary">Hết hạn đăng ký</span>
																</c:otherwise>
															</c:choose>
															)
														</div>
													</div>



													<div class="row">
														<div class="col-lg-4 col-md-4 label">Thời gian giảng
															dạy</div>
														<div class="col-lg-8 col-md-8">
															<fmt:formatDate value="${classDetail.dateStart}"
																pattern="dd/MM/yyyy" />
															-
															<fmt:formatDate value="${classDetail.getDateEnd()}"
																pattern="dd/MM/yyyy" />
															(
															<c:choose>
																<c:when test="${classDetail.getClassPeriod() == 1}">
																	<span class=" text-success">Đang dạy</span>
																</c:when>
																<c:when test="${classDetail.getClassStatus() == 2}">
																	<span class="text-secondary"> Kết thúc </span>
																</c:when>
																<c:otherwise>
																	<span class="text-danger">Chưa bắt đầu</span>
																</c:otherwise>
															</c:choose>
															)
														</div>
													</div>


													<div class="row">
														<div class="col-lg-4 col-md-4 label">Số người đăng
															ký</div>
														<div class="col-lg-8 col-md-8">
															${classDetail.getRegisterDetailEntitiesAvailable().size()}/${classDetail.maxPP}
															người</div>
													</div>
												</div>

												<div class="tab-pane fade profile-edit pt-3"
													id="profile-edit" style="min-height: 460px">
													<div class="row p-2 bg-primary-light mb-3 rounded">
														<div class="col-4">Mã KH</div>
														<div class="col-4">Tên khách hàng</div>
														<div class="col-4">Mã Đăng ký</div>
													</div>
													<c:forEach var="r"
														items="${classDetail.getRegisterDetailEntitiesAvailable()}"
														varStatus="loopStatus">

														<div
															class="row rounded  ${loopStatus.index % 2 == 0 ? 'bg-light' : ''} mb-2">
															<div class="col-lg-4">
																<span class="text-dark">${r.registerEntity.customer.customerId}</span>
															</div>
															<div class="col-lg-4">
																<span class="text-dark">${r.registerEntity.customer.name}</span>
															</div>
															<div class="col-lg-4">
																<span class="text-dark">${r.registerEntity.registerId}</span>
															</div>
														</div>
													</c:forEach>

												</div>
											</div>
											<!-- End Bordered Tabs -->
										</div>
									</div>
								</div>
							</div>
						</section>
						<!-- End Multi Columns Form -->
					</div>
				</div>
			</div>
		</div>
		<!-- time table -->
		<div class="modal fade" id="time-table" tabindex="-1">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<section class="section">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-0">
									<div class="card-body">
										<h5
											class="card-title align-items-center d-flex justify-content-between">
											Thời Khoá Biểu
											<div class="header-action d-flex gap-1">
												<button type="button" class="btn btn-primary"
													data-bs-target="#modal-create" data-bs-toggle="modal">
													Xác nhận</button>

												<div class="search-bar-table d-flex align-items-stretch">
													<div class="">
														<button type="button" class="btn btn-secondary btn-search"
															data-bs-target="#modal-create" data-bs-toggle="modal">
															Huỷ bỏ</button>
													</div>

													<div class="">
														<button type="button" class="btn btn-secondary btn-filter">
															Cài lại</button>
													</div>
												</div>
											</div>
										</h5>

										<!-- Table with stripped rows -->
										<from class="my-time-table">
										<div class="table-responsive">
											<table class="table table-bordered text-center">
												<thead>
													<tr class="bg-light-gray">
														<th class="text-uppercase col-1 label">Buổi</th>
														<th class="text-uppercase col-1 label">Thứ hai</th>
														<th class="text-uppercase col-1 label">Thứ ba</th>
														<th class="text-uppercase col-1 label">Thư tư</th>
														<th class="text-uppercase col-1 label">Thứ năm</th>
														<th class="text-uppercase col-1 label">Thứ sáu</th>
														<th class="text-uppercase col-1 label">Thứ bảy</th>
														<th class="text-uppercase col-1 label">Chủ nhật</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="align-middle bg-light">Sáng</td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T2" id="T2-M" value="0"
															class="form-check-input" /> <label for="T2-M"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T3" id="T3-M" value="0"
															class="form-check-input" /> <label for="T3-M"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T4" id="T4-M" value="0"
															class="form-check-input" /> <label for="T4-M"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T5" id="T5-M" value="0"
															class="form-check-input" /> <label for="T5-M"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T6" id="T6-M" value="0"
															class="form-check-input" /> <label for="T6-M"></label></td>

														<td class="td-time-table"><input type="radio"
															form="class" name="T7" id="T7-M" value="0"
															class="form-check-input" /> <label for="T7-M"></label></td>

														<td class="td-time-table"><input type="radio"
															form="class" name="T8" id="T8-M" value="0"
															class="form-check-input" /> <label for="T8-M"></label></td>
													</tr>

													<tr>
														<td class="align-middle bg-light">Chiều</td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T2" id="T2-A" value="1"
															class="form-check-input" /> <label for="T2-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T3" id="T3-A" value="1"
															class="form-check-input" /> <label for="T3-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T4" id="T4-A" value="1"
															class="form-check-input" /> <label for="T4-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T5" id="T5-A" value="1"
															class="form-check-input" /> <label for="T5-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T6" id="T6-A" value="1"
															class="form-check-input" /> <label for="T6-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T7" id="T7-A" value="1"
															class="form-check-input" /> <label for="T7-A"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T8" id="T8-A" value="1"
															class="form-check-input" /> <label for="T8-A"></label></td>
													</tr>

													<tr>
														<td class="align-middle bg-light">Tối</td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T2" id="T2-E" value="2"
															class="form-check-input" /> <label for="T2-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T3" id="T3-E" value="2"
															class="form-check-input" /> <label for="T3-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T4" id="T4-E" value="2"
															class="form-check-input" /> <label for="T4-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T5" id="T5-E" value="2"
															class="form-check-input" /> <label for="T5-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T6" id="T6-E" value="2"
															class="form-check-input" /> <label for="T6-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T7" id="T7-E" value="2"
															class="form-check-input" /> <label for="T7-E"></label></td>
														<td class="td-time-table"><input type="radio"
															form="class" name="T8" id="T8-E" value="2"
															class="form-check-input" /> <label for="T8-E"></label></td>
													</tr>
												</tbody>
											</table>
										</div>
										</from>
										<!-- End Table with stripped rows -->
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
		<!-- end time table -->

		<!-- Time-table edit -->
		<c:forEach var="t" items="${classUpdate.scheduleEntity}">
			<input type="text"
				class="2-T input-tt-db invisible position-absolute"
				value='2-T${t.day}-${t.session}'>
		</c:forEach>
		<div class="modal fade" id="time-table2" tabindex="-1">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<section class="section">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-0">
									<div class="card-body">
										<h5
											class="card-title align-items-center d-flex justify-content-between">
											Thời Khoá Biểu
											<div class="header-action d-flex gap-1">
												<button type="button"
													class="btn btn-primary btn-tt-confirm2"
													data-bs-target="#modal-update" data-bs-toggle="modal">Xác
													nhận</button>


											</div>
										</h5>

										<!-- Table with stripped rows -->
										<div class="my-time-table">
											<div class="table-responsive">
												<table class="table table-bordered text-center">
													<thead>
														<tr class="bg-light-gray">
															<th class="text-uppercase col-1 label">Buổi</th>
															<th class="text-uppercase col-1 label">Thứ hai</th>
															<th class="text-uppercase col-1 label">Thứ ba</th>
															<th class="text-uppercase col-1 label">Thư tư</th>
															<th class="text-uppercase col-1 label">Thứ năm</th>
															<th class="text-uppercase col-1 label">Thứ sáu</th>
															<th class="text-uppercase col-1 label">Thứ bảy</th>
															<th class="text-uppercase col-1 label">Chủ nhật</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td class="align-middle bg-light">Sáng</td>
															<td class="td-time-table"><input type="radio"
																name="2-T2" form="classUpdate" id="2-T2-0" value="0"
																class="form-check-input" /> <label for="2-T2-0"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T3" id="2-T3-0" value="0"
																class="form-check-input" /> <label for="2-T3-0"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T4" id="2-T4-0" value="0"
																class="form-check-input" /> <label for="2-T4-0"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T5" id="2-T5-0" value="0"
																class="form-check-input" /> <label for="2-T5-0"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T6" id="2-T6-0" value="0"
																class="form-check-input" /> <label for="2-T6-0"></label></td>

															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T7" id="2-T7-0" value="0"
																class="form-check-input" /> <label for="2-T7-0"></label></td>

															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T8" id="2-T8-0" value="0"
																class="form-check-input" /> <label for="2-T8-0"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Chiều</td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T2" id="2-T2-1" value="1"
																class="form-check-input" /> <label for="2-T2-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T3" id="2-T3-1" value="1"
																class="form-check-input" /> <label for="2-T3-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T4" id="2-T4-1" value="1"
																class="form-check-input" /> <label for="2-T4-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T5" id="2-T5-1" value="1"
																class="form-check-input" /> <label for="2-T5-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T6" id="2-T6-1" value="1"
																class="form-check-input" /> <label for="2-T6-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T7" id="2-T7-1" value="1"
																class="form-check-input" /> <label for="2-T7-1"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T8" id="2-T8-1" value="1"
																class="form-check-input" /> <label for="2-T8-1"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Tối</td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T2" id="2-T2-2" value="2"
																class="form-check-input" /> <label for="2-T2-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T3" id="2-T3-2" value="2"
																class="form-check-input" /> <label for="2-T3-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T4" id="2-T4-2" value="2"
																class="form-check-input" /> <label for="2-T4-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T5" id="2-T5-2" value="2"
																class="form-check-input" /> <label for="2-T5-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T6" id="2-T6-2" value="2"
																class="form-check-input" /> <label for="2-T6-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T7" id="2-T7-2" value="2"
																class="form-check-input" /> <label for="2-T7-2"></label></td>
															<td class="td-time-table"><input form="classUpdate"
																type="radio" name="2-T8" id="2-T8-2" value="2"
																class="form-check-input" /> <label for="2-T8-2"></label></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<!-- End Table with stripped rows -->
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>

		<!-- Time-table detail -->
		<div class="modal fade" id="time-table-detail" tabindex="-1">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<section class="section">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-0">
									<div class="card-body">
										<h5
											class="card-title align-items-center d-flex justify-content-between">
											Thời Khoá Biểu</h5>

										<!-- Table with stripped rows -->
										<div class="my-time-table">
											<div class="table-responsive">
												<table class="table table-bordered text-center">
													<thead>
														<tr class="bg-light-gray">
															<th class="text-uppercase col-1 label">Buổi</th>
															<th class="text-uppercase col-1 label">Thứ hai</th>
															<th class="text-uppercase col-1 label">Thứ ba</th>
															<th class="text-uppercase col-1 label">Thư tư</th>
															<th class="text-uppercase col-1 label">Thứ năm</th>
															<th class="text-uppercase col-1 label">Thứ sáu</th>
															<th class="text-uppercase col-1 label">Thứ bảy</th>
															<th class="text-uppercase col-1 label">Chủ nhật</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td class="align-middle bg-light">Sáng</td>
															<td class="td-time-table"><input type="radio"
																name="T2" form="classUpdate" id="D-T2-0" value="0"
																class="form-check-input" /> <label for="D-T2-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-0" value="0"
																class="form-check-input" /> <label for="D-T3-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-0" value="0"
																class="form-check-input" /> <label for="D-T4-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-0" value="0"
																class="form-check-input" /> <label for="D-T5-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-0" value="0"
																class="form-check-input" /> <label for="D-T6-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-0" value="0"
																class="form-check-input" /> <label for="D-T7-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-0" value="0"
																class="form-check-input" /> <label for="D-T8-0"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Chiều</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="D-T2-1" value="1"
																class="form-check-input" /> <label for="D-T2-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-1" value="1"
																class="form-check-input" /> <label for="D-T3-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-1" value="1"
																class="form-check-input" /> <label for="D-T4-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-1" value="1"
																class="form-check-input" /> <label for="D-T5-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-1" value="1"
																class="form-check-input" /> <label for="D-T6-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-1" value="1"
																class="form-check-input" /> <label for="D-T7-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-1" value="1"
																class="form-check-input" /> <label for="D-T8-1"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Tối</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="D-T2-2" value="2"
																class="form-check-input" /> <label for="D-T2-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="D-T3-2" value="2"
																class="form-check-input" /> <label for="D-T3-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="D-T4-2" value="2"
																class="form-check-input" /> <label for="D-T4-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="D-T5-2" value="2"
																class="form-check-input" /> <label for="D-T5-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="D-T6-2" value="2"
																class="form-check-input" /> <label for="D-T6-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="D-T7-2" value="2"
																class="form-check-input" /> <label for="D-T7-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="D-T8-2" value="2"
																class="form-check-input" /> <label for="D-T8-2"></label></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<!-- End Table with stripped rows -->
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->
	<!-- common script -->
	<%@include file="./script.jsp"%>
	<script type="text/javascript">
      $(document).ready(function () {
    	  let id = $(".modal-flag").attr("idModal")
    	  if(id) {
    	  $("#"+id).modal("show");
    	  }
    	  $(window).click(function(e) {
  		 	if(e.target.getAttribute("for")) {
  		 		if(e.target.getAttribute("for").includes("T")) {
  		 			e.preventDefault();
  		 			let el = e.target.getAttribute("for");
      		 		$("#" + el).prop("checked", !$("#" + el).prop("checked"));
  		 		}
  		 		
  		 	}
  		}); 
    	  $(".btn-show-time-table-detail").click(function() {
    		  $("#time-table-detail :input").prop( "checked", false );
    		  $(this.getAttribute("data")).each(function() {
    			  console.log(this.value)
    			  $("#"+this.value).prop( "checked", true );
    		  })
    		  $("#time-table-detail").modal("show");
    	  })
    	  
    	  $(".2-T").each(function() {
			  $("#"+this.value).prop( "checked", true );
		  })
    	  
    	  $(".btn-show-time-table2").click(function() {
    		  $("#time-table2").modal("show");
    	  })
    	  
        $(
          "#my-data-table_filter",
        ).append(`  <div class="search-bar-table d-flex align-items-stretch">
                      <div class="position-relative">
                          <button type="button" class="btn btn-primary btn-filter" data-bs-toggle="collapse" data-bs-target="#filter-block">
                              <i class="fa-regular fa-filter"></i>
                              <span class="text-white"></span>
                          </button>
                          <!-- filter table -->
                          <div id="filter-block" class="card position-absolute end-100 top-0 collapse" style="z-index: 100; min-width: 25rem;">
                              <div class="card-header py-2 text-secondary bg-info text-black fs-6">Bộ lọc</div>
                              <div class="card-body">
                                  <form class="row g-3 mt-1" action="admin/class.htm" id="form-filter">
                                    

                                      <div class="col-md-12">
                                          <label for="gender" class="form-label">Giai đoạn lớp học</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="period" id="filter-allGender" value="0"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-allGender">
                                                      Chưa bắt đầu
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="period" id="filter-female" value="1"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-female">
                                                      Đang dạy
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="period" id="filter-male" value="2"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-male">
                                                      Kết thúc
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-12">
                                          <label for="status" class="form-label">Trạng thái</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-allStatus" value="1"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-allStatus">
                                                      Có thể đăng ký
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-0" value="0"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-0">
                                                      Hết hạn đăng ký
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-1" value="2"  />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-1">
                                                     Đã đầy
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                  </form>
                              </div>
                              <div class="card-footer py-2 text-end">
                                  <button type="submit" form="form-filter" name="btnFilter" class="btn btn-primary">
                                      Lọc
                                  </button>
                                 
                              </div>
                          </div>
                      </div>
                  </div>`);

        $(".btn-filter").click(function () {
          $(".filter-block").toggleClass("show-flex");
        });
      });
    </script>
</body>
</html>