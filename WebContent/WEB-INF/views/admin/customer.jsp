<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="./head.jsp"%>
</head>

<body>

	<!-- initial customer data -->
	<div class="page-flag" data="customer"></div>
	<div class="initialCSId position-absolute"
		data="${customer.customerId }"></div>
	<!-- ======= Header ======= -->
	<%@include file="./header.jsp"%>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="./sidebar.jsp"%>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body pb-0">
							<h5 class="card-title">Danh sách khách hàng</h5>

							<!-- Table with stripped rows -->
							<table class="table" id="my-data-table">
								<thead>
									<tr>
										<th>Mã</th>
										<th>Họ và tên</th>
										<th>Giới tính</th>
										<th>Ngày sinh</th>
										<th>Trạng thái</th>
										<th class="text-center">Thao tác</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${cList}">
										<tr>
											<td>${c.customerId}</td>
											<td>${c.name}</td>
											<td>${c.gender? 'Nam':'Nữ'}</td>
											<td><fmt:formatDate value="${c.birthday }"
													pattern="dd/MM/yyyy" /></td>
											<td class="account-state"><c:choose>
													<c:when test="${c.getCustomerStatus() == 0}">
														<span class="badge rounded-pill bg-secondary"> Chưa
															đăng ký tập </span>
													</c:when>
													<c:when test="${c.getCustomerStatus() == 1}">
														<span class="badge rounded-pill bg-warning"> Đang
															tập </span>
													</c:when>
													<c:when test="${c.getCustomerStatus() == 2}">
														<span class="badge rounded-pill bg-success"> Đã
															đăng ký </span>
													</c:when>
												</c:choose></td>

											<td class="text-center"><a
												href="admin/customer/register/${c.customerId}.htm">
													<button class="btn btn-primary btn-sm"
														title="Đăng ký gói tập">
														<i class="fa-regular fa-file-signature"></i> <span>Đăng
															ký tập</span>
													</button>
											</a><a href="admin/customer/update/${c.customerId}.htm"><button
														class="btn btn-outline-warning btn-light btn-sm"
														title="Chỉnh sửa">
														<i class="fa-solid fa-pen-to-square"></i>
													</button> </a> <a href="admin/customer/detail/${c.customerId}.htm">
													<button class="btn btn-outline-info btn-light btn-sm"
														title="Chi tiết" data-bs-toggle="modal"
														data-bs-target="#detail" data-bs-placement="top">
														<i class="fa-solid fa-circle-exclamation"></i>
													</button>

											</a> <c:choose>
													<c:when test="${c.account == null}">
														<button
															class="btn btn-outline-success btn-create-account btn-light btn-sm"
															data=${c.customerId } title="Tạo tài khoản"
															data-bs-toggle="modal"
															data-bs-target="#modal-create-account"
															data-bs-placement="top">
															<i class="fa-solid fa-file-invoice"></i>
														</button>
													</c:when>
													<c:otherwise>
														<button disabled="disabled"
															class="btn btn-secondary btn-create-account btn-sm"
															data=${c.customerId } title="Đã có tài khoản"
															data-bs-toggle="modal"
															data-bs-target="#modal-create-account"
															data-bs-placement="top">
															<i class="fa-solid fa-file-invoice"></i>
														</button>
													</c:otherwise>
												</c:choose></td>
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

		<!-- modal  -->
		<!-- Form thêm khách hàng -->
		<div class="modal fade" id="modal-create" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">${cFormAttribute.formTitle}</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form action="${cFormAttribute.formAction}" method="post"
							class="row g-3" modelAttribute="customer">
							<div class="col-md-12">
								<label for="input-id" class="form-label ">Mã: <span
									class="employeeId text-danger customerId"></span> <form:input
										path="customerId" type="text" class="form-control"
										id="input-id" readonly="true" /> <span class="text-danger"><form:errors
											path="customerId"></form:errors></span>
								</label>
							</div>

							<div class="col-md-12">
								<label for="input-name" class="form-label">Họ và tên</label>
								<form:input path="name" type="text" class="form-control"
									id="input-name" />
								<span class="text-danger"><form:errors path="name"></form:errors></span>
							</div>
							<fieldset class="col-md-12">
								<legend class="col-form-label col-sm-2 pt-0"> Giới tính
								</legend>
								<div class="col-sm-12 d-flex gap-4">
									<div class="form-check">
										<form:radiobutton path="gender" class="form-check-input"
											name="input-gender" id="female" value="0" />
										<label class="form-check-label" for="female"> Nữ </label>
									</div>
									<div class="form-check">
										<form:radiobutton path="gender" class="form-check-input"
											name="input-gender" id="male" value="1" />
										<label class="form-check-label" for="male"> Nam </label>
									</div>
								</div>
							</fieldset>

							<div class="col-md-6">
								<label for="input-birthday" class="form-label">Ngày sinh</label>
								<form:input path="birthday" type="date" class="form-control"
									id="input-birthday" />
								<span class="text-danger"><form:errors path="birthday"></form:errors></span>
							</div>

							<div class="col-md-6">
								<label for="input-phone" class="form-label">SDT</label>
								<form:input path="phone" type="tel" class="form-control"
									id="input-phone" />
								<span class="text-danger"><form:errors path="phone"></form:errors></span>
							</div>
							<div class="col-md-12">
								<label for="input-email" class="form-label">Email</label>
								<form:input path="email" type="text" class="form-control"
									id="input-email" />
								<span class="text-danger"><form:errors path="email"></form:errors></span>
							</div>

							<div class="col-12">
								<label for="input-address" class="form-label">Địa chỉ</label>
								<form:input path="address" type="text" class="form-control"
									id="input-address" placeholder="97 Man Thiện, ..." />
								<span class="text-danger"><form:errors path="address"></form:errors></span>
							</div>

							<div class="text-end mt-3">
								<button type="submit" name="${cFormAttribute.btnAction}"
									class="btn btn-primary">Xác nhận</button>
								<button type="button" class="btn btn-secondary close-form"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>

		<!-- form đăng ký tài khoản khách hàng -->
		<div class="modal fade" id="modal-create-account" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">Đăng ký tài khoản khách hàng</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form action="/create-account.htm" method="post"
							class="row g-3">
							<div class="col-12" id="form-create-account">
								<div class="row">
									<div class="col-12" data-link="account" data-n="2">
										<label for="input-username" class="form-label">Tên tài
											khoản</label> <input type="text" name="userName" value="${userName}"
											class="form-control" id="input-username" />
									</div>

									<span class="text-danger">${error}</span>
								</div>
							</div>
							<div class="text-end mt-3">
								<button type="submit" name="${btnCreate}"
									class="btn btn-primary">Xác nhận</button>
								<button type="button" class="btn btn-secondary close-form"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>


		<!-- Form đăng ký tập -->
		<div class="modal fade" id="modal-register" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white px-3 py-2">
						<h5 class="modal-title">${formAttribute.formTitle}</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form id="register" action="${formAttribute.formAction}"
							class="row g-3" modelAttribute="${register}">
							<div class="col-md-12">
								<c:set var="size" scope="session"
									value="${register.registerDetailList.size()}" />
								<label class="form-label">Mã: <span
									class="employeeId text-danger">${register.registerId}</span>
								</label>
							</div>
							<div class="contact-registration-list">
								<div
									class="contact-registration-detail border rounded p-2 bg-light">
									<div class="col-md-12 mb-3">
										<label for="input-package" class="form-label">Gói tập</label>
										<select id="input-package" name="pack"
											class="form-select input-pack">

											<option ${register.registerDetailList== NULL ? 'selected':''}
												value="">Chọn</option>
											<c:forEach var="p" items="${pack}">
												<option
													${register.registerDetailList[size - 1].classEntity.packId == p.packID ? 'selected': ''}
													value="${p.packID}">${p.packName}</option>
											</c:forEach>
										</select>
										<c:choose>
											<c:when test="${size <= 0}">
												<c:set var="rType" value="0" />
											</c:when>
											<c:when
												test="${register.registerDetailList[size - 1].classEntity.maxPP > 1}">
												<c:set var="rType" value="1" />
											</c:when>
											<c:when
												test="${register.registerDetailList[size - 1].classEntity.maxPP == 1}">
												<c:set var="rType" value="2" />
											</c:when>

										</c:choose>


										<input type="number" value="${rType}"
											class="type  invisible position-absolute "
											name="typeRegister">
									</div>
									<div class="type-select switch-element" data-n="1"
										data-link="course-1">
										<label for="inputName" class="form-label">Hình thức</label>
										<div
											class="col-12 d-flex gap-1 justify-content-around align-items-center">
											<div class="col-5">

												<select id="input-class" name="class" disabled="disabled"
													class="form-select">
													<option
														${register.registerDetailList[size - 1].classEntity.maxPP == 1 ? 'selected': ''}
														value="">Lớp</option>
													<c:forEach var="p" items="${pack}">
														<c:forEach var="l" items="${p.classList}">
															<c:if test="${l.maxPP > 1}">
																<c:if test="${l.getClassStatus() == 1}">
																	<option
																		${register.registerDetailList[size - 1].classEntity.classId == l.classId ? 'selected': ''}
																		class="class d-none" data="${p.packID}"
																		value="${l.classId}">${l.classId}</option>
																</c:if>
															</c:if>
														</c:forEach>

													</c:forEach>
												</select>
											</div>
											<span>Hoặc</span>
											<button type="button"
												class="btn btn-primary col-5 switch-btn personal-chosen"
												data-n-switch-target="2" data-link="course-1">
												<i class="bi bi-plus-circle"></i> <span class="text-white">Cá
													Nhân</span>
											</button>
										</div>
									</div>
									<div class="row g-3 switch-element invisible position-absolute"
										data-n="2" data-link="course-1">
										<div class="col-md-6">
											<label for="input-close-register-day" class="form-label">Ngày
												bắt đầu tập</label> <input type="date"
												class="form-control date-start"
												value="${register.registerDetailList[size - 1].classEntity.dateStart}"
												name="date-start" id="input-close-register-day" />
											<div class="date-start-error text-danger"></div>
										</div>

										<div class="col-md-6">
											<label for="input-close-register-day" class="form-label">
												Thời khoá biểu </label>
											<button
												class="btn btn-tt col-12 btn-outline-primary btn-light"
												type="button" data-bs-target="#time-table"
												data-bs-toggle="modal">
												<i class="bi bi-plus-circle"></i> <span class="te">Tạo
													TKB</span>
											</button>
											<div class="schedule-error text-danger"></div>
										</div>

										<div class="text-end mt-3">
											<button type="button"
												class="btn btn-secondary personal-chosen-dismiss switch-btn"
												data-link="course-1" data-n-switch-target="1">Huỷ</button>
										</div>
									</div>
								</div>

								<!-- 2 -->
								<input class="invisible position-absolute"
									name="is-select-course-2" value="${size > 1? '1': '' }">
								<div
									class="contact-registration-detail d-none course-2 mt-2 border rounded p-2 bg-light">
									<div class="col-md-12 mb-3">
										<label for="input-package2" class="form-label">Gói tập</label>
										<select id="input-package2" name="pack2"
											class="form-select input-pack2">
											<option ${size < 2? 'selected': ''} value="">Chọn</option>
											<c:forEach var="p" items="${pack}">
												<option
													${register.registerDetailList[size - 2].classEntity.packId == p.packID ? 'selected': ''}
													value="${p.packID}">${p.packName}</option>
											</c:forEach>
											<c:choose>
												<c:when
													test="${register.registerDetailList[size - 2].classEntity.maxPP > 1}">
													<c:set var="rType2" value="1" />
												</c:when>
												<c:when
													test="${register.registerDetailList[size - 2].classEntity.maxPP == 1}">
													<c:set var="rType2" value="2" />
												</c:when>

												<c:otherwise>
													<c:set var="rType2" value="0" />
												</c:otherwise>

											</c:choose>
										</select> <input type="number" value="${rType2}"
											class="type2 invisible position-absolute"
											name="typeRegister2">
									</div>
									<div class="type-select switch-element" data-n="10"
										data-link="course-2">
										<label for="inputName2" class="form-label">Hình thức</label>
										<div
											class="col-12 d-flex gap-1 justify-content-around align-items-center">
											<div class="col-5">
												<select id="input-class2" name="class2" disabled="disabled"
													class="form-select">
													<option
														${register.registerDetailList[size - 2].classEntity.maxPP == 1 ? 'selected': ''}
														value="">Lớp</option>
													<c:forEach var="p" items="${pack}">

														<c:forEach var="l" items="${p.classList}">

															<c:if test="${l.maxPP > 1}">
																<c:if test="${l.getClassStatus() == 1}">
																	<option class="class2 d-none"
																		${register.registerDetailList[size - 2].classEntity.classId == l.classId ? 'selected': ''}
																		data="${p.packID}" value="${l.classId}">${l.classId}</option>
																</c:if>
															</c:if>
														</c:forEach>
													</c:forEach>
												</select>
											</div>
											<span>Hoặc</span>
											<button type="button"
												class="btn btn-primary col-5 switch-btn personal-chosen2"
												data-n-switch-target="20" data-link="course-2">
												<i class="bi bi-plus-circle"></i> <span class="text-white">Cá
													Nhân</span>
											</button>
										</div>
									</div>
									<div class="row g-3 switch-element invisible position-absolute"
										data-n="20" data-link="course-2">
										<div class="col-md-6">
											<label for="input-close-register-day" class="form-label">Ngày
												bắt đầu tập</label> <input type="date"
												class="form-control date-start2"
												value="${register.registerDetailList[size - 2].classEntity.dateStart}"
												name="date-start2" id="input-close-register-day2" />
											<div class="date-start-error2 text-danger"></div>
										</div>

										<div class="col-md-6">
											<label for="" class="form-label"> Thời khoá biểu </label>
											<button
												class="btn btn-tt2 col-12 btn-outline-primary btn-light"
												type="button" data-bs-target="#time-table2"
												data-bs-toggle="modal">
												<i class="bi bi-plus-circle"></i> <span class="te">Tạo
													TKB</span>
											</button>
											<div class="schedule-error2 text-danger"></div>
										</div>

										<div class="text-end mt-3">
											<button type="button"
												class="btn btn-secondary personal-chosen-dismiss2 switch-btn"
												data-link="course-2" data-n-switch-target="10">Huỷ</button>
										</div>
									</div>
									<div class="col-12 mt-3 ${size == 2? 'd-none': ''} ">
										<button type="button"
											class="btn col-12 btn-outline-danger btn-light remove-course-2">
											<i class="fa-regular fa-circle-minus"></i> <span>Loại
												bỏ</span>
										</button>
									</div>

								</div>

							</div>

							<div>
								<button type="button"
									class="btn col-12 btn-outline-primary btn-light add-course-2">
									<i class="bi bi-plus-circle"></i> <span>Thêm gói khác</span>
								</button>

							</div>
							<div class="text-end mt-3">
								<button type="submit" name="${formAttribute.btnAction}"
									class="btn btn-primary">Xác nhận</button>
								<button type="button" class="btn btn-secondary close-form"
									data-bs-dismiss="modal">Đóng</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>

		<!-- Time-table -->
		<c:forEach var="t"
			items="${register.registerDetailList[size - 1].classEntity.scheduleEntity}">
			<input type="text"
				class="T-${register.registerDetailList[size - 1].classEntity.classId} input-tt-db invisible position-absolute"
				value='T${t.day}-${t.session}'>
		</c:forEach>
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
												<button type="button" class="btn btn-primary btn-tt-confirm"
													data-bs-target="#modal-register" data-bs-toggle="modal">Xác
													nhận</button>

												<div class="search-bar-table d-flex align-items-stretch">
													<div class="">
														<button type="button"
															class="btn btn-secondary btn-tt-cancel"
															data-bs-target="#modal-register" data-bs-toggle="modal">Huỷ
															bỏ</button>
													</div>


												</div>
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
																name="T2" form="register" id="T2-0" value="0"
																class="form-check-input" /> <label for="T2-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="T3-0" value="0"
																class="form-check-input" /> <label for="T3-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="T4-0" value="0"
																class="form-check-input" /> <label for="T4-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="T5-0" value="0"
																class="form-check-input" /> <label for="T5-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="T6-0" value="0"
																class="form-check-input" /> <label for="T6-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="T7-0" value="0"
																class="form-check-input" /> <label for="T7-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="T8-0" value="0"
																class="form-check-input" /> <label for="T8-0"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Chiều</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="T2-1" value="1"
																class="form-check-input" /> <label for="T2-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="T3-1" value="1"
																class="form-check-input" /> <label for="T3-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="T4-1" value="1"
																class="form-check-input" /> <label for="T4-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="T5-1" value="1"
																class="form-check-input" /> <label for="T5-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="T6-1" value="1"
																class="form-check-input" /> <label for="T6-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="T7-1" value="1"
																class="form-check-input" /> <label for="T7-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="T8-1" value="1"
																class="form-check-input" /> <label for="T8-1"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Tối</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T2" id="T2-2" value="2"
																class="form-check-input" /> <label for="T2-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T3" id="T3-2" value="2"
																class="form-check-input" /> <label for="T3-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T4" id="T4-2" value="2"
																class="form-check-input" /> <label for="T4-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T5" id="T5-2" value="2"
																class="form-check-input" /> <label for="T5-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T6" id="T6-2" value="2"
																class="form-check-input" /> <label for="T6-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T7" id="T7-2" value="2"
																class="form-check-input" /> <label for="T7-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="T8" id="T8-2" value="2"
																class="form-check-input" /> <label for="T8-2"></label></td>
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


		<!-- Time-table -->
		<c:forEach var="t"
			items="${register.registerDetailList[size - 2].classEntity.scheduleEntity}">
			<input type="text"
				class="2-T-${register.registerDetailList[size - 2].classEntity.classId} input-tt-db invisible position-absolute"
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
													data-bs-target="#modal-register" data-bs-toggle="modal">Xác
													nhận</button>

												<div class="search-bar-table d-flex align-items-stretch">
													<div class="">
														<button type="button"
															class="btn btn-secondary btn-tt-cancel2"
															data-bs-target="#modal-register" data-bs-toggle="modal">Huỷ
															bỏ</button>
													</div>


												</div>
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
																name="2-T2" form="register" id="2-T2-0" value="0"
																class="form-check-input" /> <label for="2-T2-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T3" id="2-T3-0" value="0"
																class="form-check-input" /> <label for="2-T3-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T4" id="2-T4-0" value="0"
																class="form-check-input" /> <label for="2-T4-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T5" id="2-T5-0" value="0"
																class="form-check-input" /> <label for="2-T5-0"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T6" id="2-T6-0" value="0"
																class="form-check-input" /> <label for="2-T6-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="2-T7" id="2-T7-0" value="0"
																class="form-check-input" /> <label for="2-T7-0"></label></td>

															<td class="td-time-table"><input form="register"
																type="radio" name="2-T8" id="2-T8-0" value="0"
																class="form-check-input" /> <label for="2-T8-0"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Chiều</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T2" id="2-T2-1" value="1"
																class="form-check-input" /> <label for="2-T2-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T3" id="2-T3-1" value="1"
																class="form-check-input" /> <label for="2-T3-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T4" id="2-T4-1" value="1"
																class="form-check-input" /> <label for="2-T4-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T5" id="2-T5-1" value="1"
																class="form-check-input" /> <label for="2-T5-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T6" id="2-T6-1" value="1"
																class="form-check-input" /> <label for="2-T6-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T7" id="2-T7-1" value="1"
																class="form-check-input" /> <label for="2-T7-1"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T8" id="2-T8-1" value="1"
																class="form-check-input" /> <label for="2-T8-1"></label></td>
														</tr>

														<tr>
															<td class="align-middle bg-light">Tối</td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T2" id="2-T2-2" value="2"
																class="form-check-input" /> <label for="2-T2-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T3" id="2-T3-2" value="2"
																class="form-check-input" /> <label for="2-T3-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T4" id="2-T4-2" value="2"
																class="form-check-input" /> <label for="2-T4-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T5" id="2-T5-2" value="2"
																class="form-check-input" /> <label for="2-T5-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T6" id="2-T6-2" value="2"
																class="form-check-input" /> <label for="2-T6-2"></label></td>
															<td class="td-time-table"><input form="register"
																type="radio" name="2-T7" id="2-T7-2" value="2"
																class="form-check-input" /> <label for="2-T7-2"></label></td>
															<td class="td-time-table"><input form="register"
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

		<!-- table detail -->
		<div class="modal fade" id="modal-detail" tabindex="-1">
			<div class="modal-dialog modal-lg modal-dialog-centered"
				style="max-width: 1024px">
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
														data-bs-target="#profile-edit">Thông tin đăng ký
														tập</button>
												</li>
											</ul>
											<div class="tab-content pt-2">
												<div class="tab-pane fade show active profile-overview"
													id="profile-overview">
													<div class="row mt-4">
														<div class="col-lg-3 col-md-4 label">Họ và Tên</div>
														<div class="col-lg-9 col-md-8">${customerDetail.name}</div>
													</div>

													<div class="row">
														<div class="col-lg-3 col-md-4 label">Giới tính</div>
														<div class="col-lg-9 col-md-8">${customerDetail.gender?'Nam':'Nữ'}</div>
													</div>
													<div class="row">
														<div class="col-lg-3 col-md-4 label">Ngày Sinh</div>
														<div class="col-lg-9 col-md-8">
															<fmt:formatDate value="${customerDetail.birthday}"
																pattern="dd/MM/yyyy" />
														</div>
													</div>

													<div class="row">
														<div class="col-lg-3 col-md-4 label">Địa chỉ</div>
														<div class="col-lg-9 col-md-8">${customerDetail.address}</div>
													</div>

													<div class="row">
														<div class="col-lg-3 col-md-4 label">Số điện thoại</div>
														<div class="col-lg-9 col-md-8">${customerDetail.phone}
														</div>
													</div>

													<div class="row">
														<div class="col-lg-3 col-md-4 label">Email</div>
														<div class="col-lg-9 col-md-8">
															${customerDetail.email}</div>
													</div>
												</div>

												<div class="tab-pane fade profile-edit pt-3"
													id="profile-edit" style="min-height: 460px">
													<div class="row p-2 bg-primary-light mb-3 rounded">
														<div class="col-2">Mã</div>
														<div class="col-2">Ngày đăng ký</div>
														<div class="col-2">Trạng thái</div>
														<div class="col-2">Tài khoản đăng ký</div>
														<div class="col-2">Thành tiền</div>
													</div>

													<c:forEach var="r" items="${customerDetail.registerList}">
														<div
															class="row bg-light p-2 rounded border ${r.status == 0?'border-danger':'border-info'}  align-items-center mb-4">
															<div class="col-2 fw-bold">${r.registerId}</div>
															<div class="col-2">
																<fmt:formatDate value="${r.registerDate}"
																	pattern="dd/MM/yyyy" />
															</div>
															<div class="col-2">
																<c:if test="${r.status == 0}">
																	<span class="badge rounded-pill bg-danger">Chưa
																		thanh toán</span>
																</c:if>
																<c:if test="${r.status == 1}">
																	<span class="badge rounded-pill bg-success">Đã
																		thanh toán</span>
																</c:if>
																<c:if test="${r.status == 2}">
																	<span class="badge rounded-pill bg-secondary">Đã
																		huỷ </span>
																</c:if>

															</div>
															<div class="col-2">${r.account.username}</div>
															<div class="col-2">
																<fmt:formatNumber pattern="###,### đ" value="${r.money}"
																	type="currency" />
															</div>
															<div class="col-2 text-primary text-end"
																style="cursor: pointer">
																<button class="btn btn-outline-info btn-light btn-sm"
																	title="Chi tiết" data-bs-toggle="collapse"
																	href="#${r.registerId}" data-bs-placement="top">
																	<i class="fa-solid  fa-circle-exclamation"></i><i
																		class="fa-solid ms-1 fa-angle-down"></i>
																</button>
																<c:choose>
																	<c:when test="${r.status == 0}">
																		<a
																			href="admin/customer/register/update/${r.registerId}.htm"><button
																				class="btn btn-outline-warning btn-light btn-sm"
																				title="Chỉnh sửa">
																				<i class="fa-solid fa-pen-to-square"></i>
																			</button> </a>
																	</c:when>
																	<c:otherwise>
																		<button title="Chỉnh sửa" disabled="disabled"
																			class="btn btn-sm btn-secondary">
																			<i class="fa-solid fa-pen-to-square"></i>
																		</button>

																	</c:otherwise>
																</c:choose>

																<c:choose>
																	<c:when test="${r.status == 0}">
																		<a class="btnCheckout"
																			href="admin/contract-registration/checkout/${r.registerId}.htm">
																			<button title="Thanh toán"
																				class="btn btn-outline-success btn-sm">
																				<i class="fa-solid fa-ballot"></i>
																			</button>
																		</a>

																	</c:when>
																	<c:otherwise>
																		<button title="Thanh toán" disabled="disabled"
																			class="btn  btn-sm btn-secondary">
																			<i class="fa-solid fa-ballot"></i>
																		</button>
																	</c:otherwise>
																</c:choose>

															</div>

															<div class="collapse bg-white rounded mt-2"
																id="${r.registerId}">
																<div class="row mt-2">
																	<span class="label">Các gói đăng ký</span>
																</div>

																<div class="my-4 row justify-content-center gap-3">

																	<c:forEach var="d" items="${r.registerDetailList}">
																		<c:forEach var="t"
																			items="${d.classEntity.scheduleEntity}">
																			<input type="text"
																				class="T-${d.classEntity.classId} invisible position-absolute"
																				value='D-T${t.day}-${t.session}'>
																		</c:forEach>
																		<div
																			class="p-2 bg-white shadow mb-3 rounded d-flex flex-column col-4">
																			<div class="row">
																				<div class="col-lg-5 col-md-6 label">Gói tập</div>
																				<div class="col-lg-7 col-md-6">${d.classEntity.trainingPackEntity.packName}</div>
																			</div>
																			<div class="row mt-4">

																				<div class="col-lg-5 col-md-4 label">Ngày tập</div>
																				<div class="col-lg-7 col-md-8">
																					<fmt:formatDate value="${d.classEntity.dateStart}"
																						pattern="dd/MM/yyyy" />
																				</div>
																			</div>
																			<div class="row mt-4">
																				<div class="col-lg-5 col-md-4 label">Thời hạn</div>
																				<div class="col-lg-7 col-md-8">${d.classEntity.trainingPackEntity.packDuration}
																					tháng</div>
																			</div>
																			<div class="row mt-4">
																				<div class="col-lg-5 col-md-4 label">Hình thức</div>
																				<div class="col-lg-7 col-md-8">${d.classEntity.maxPP == 1?'Cá nhân':'Lớp' }
																				</div>
																			</div>

																			<button type="button"
																				data=".T-${d.classEntity.classId}"
																				class="btn-show-time-table-detail btn btn-outline-success btn-light btn-sm mt-4">
																				<i class="fa-regular fa-calendar-days"></i>
																			</button>
																		</div>
																	</c:forEach>
																</div>
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
		<!-- end table detail -->

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
																name="T2" form="register" id="D-T2-0" value="0"
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
    	  $(".btnCheckout").click(function(e) {
    		  if(!confirm("Xác nhận thanh toán")) {
    			  e.preventDefault();
    		  };
    	  })
    	  // wrap create c btn 
    	  $(".btn-create").wrap("<a href='admin/customer/add.htm'></a>")
    	  $(".btn-create").removeAttr("data-bs-toggle");
    	  $(".btn-create").removeAttr("data-bs-target");
    	  
    	  // show class
    	 let personalChosen = $(".personal-chosen");
    	 personalChosen.attr('disabled', true);
    	 let inputType = $(".type")
    	 let inputClass = $("#input-class");
    	 let inputPack = $(".input-pack");
    	 console.log(inputType.val())
    	 let btnAddCourseSecond = $(".add-course-2")
    	  personalChosen.click(function(){
    		  inputClass.val("").change();
    		  inputType.val(2);
    	  });
    	  
    	  $(".personal-chosen-dismiss").click(function(){
    		  inputType.val(0);
    	  });
    	  //initial
    	  let inputTypeVal = inputType.val();
    	  
    	  if(inputTypeVal == 2) {
    		  console.log(inputTypeVal); 
    		  personalChosen.click();
    		  $(".btn-tt").html('<i class="fa-solid fa-pen-to-square"></i> <span class="te">Chỉnh sửa TKB</span>') 
    	  }
    	  
    	 	function changeType1(packSelected) {
    	 		if(packSelected) {
       			inputClass.attr('disabled', false);
       		  	$('.class').addClass("d-none")
       		 	 $('.class[data="' + packSelected +'"]').removeClass("d-none")
       		  	personalChosen.attr('disabled', false);
       		  	}
       		  	else {
       			  inputClass.attr('disabled', true);
       			  personalChosen.attr('disabled', true);
       			  inputType.val(0);
       			  $(".personal-chosen-dismiss").click();
       		  }	
    	 	}
    	 changeType1(inputPack.val());
    	  inputPack.change(function(){
    		  let packSelected = this.value
    		  if(inputType.val() !== "2") {
        		  inputClass.val("").change();
        		}
    		  changeType1(packSelected);
    	  });
    	  
    	  inputClass.change(function(){
    		  let classSelected = this.value
    		  if(classSelected) {
    			  inputType.val(1);
    		  }
    		  else {  
    			  inputType.val(0);
    		  }
    	  });
    	  
    	  $("#register").submit(function(e) {
    		  if($(".type").val() == 2) {
    			  if(!$(".date-start").val()) {
    				 	$(".date-start-error").text("Nội dung này không được bỏ trống") 
    				  e.preventDefault()
    				  
    			  }
    			  else {
    				  $(".date-start-error").text("") 
    			  }
    			  let isValid = false
    			  $("#time-table :input").each(function() {
    				  if(this.id) {
    					if($("#" + this.id).prop("checked")) {
    		
    						isValid = true;
    					}
        			    
    				  }
        		  })
       
        		  
        		  if(!isValid) {
        			  $(".schedule-error").text("Vui lòng chọn ít nhất 1 ngày để lập thời khoá biểu")
        			  e.preventDefault()
        		  }
        		  else {
        			  $(".schedule-error").text("")
        		  }
    			  
    			 
    		  }
    		 
    	  })
    	  
    	  $(".btn-tt-confirm").click(function() {
    		  $(".btn-tt").html('<i class="fa-solid fa-pen-to-square"></i> <span class="te">Chỉnh sửa TKB</span>')
    	  })
    	  
    	    $(".btn-tt-confirm2").click(function() {
    		  $(".btn-tt2").html('<i class="fa-solid fa-pen-to-square"></i> <span class="te">Chỉnh sửa TKB</span>')
    	  })
    	  
    	  
    	  
    	  //////////////////////////////////// ------------- course 2 -------------/////////////////////////////////////////////////////////////////
    	  
    	  
    	 let personalChosen2 = $(".personal-chosen2");
    	 personalChosen2.attr('disabled', true);
    	 let isSelectCourse2 = $("input[name='is-select-course-2']");
    	 let inputType2 = $(".type2")
    	 let inputClass2 = $("#input-class2");
    	 let inputPack2 = $(".input-pack2");
    	 if(isSelectCourse2.val() == "1") {
    		 $(".course-2").removeClass("d-none")
             btnAddCourseSecond.addClass("d-none")
    	 }
    	 if(inputType2.val() == 2) {
   		  personalChosen2.click();
   		  $(".btn-tt2").html('<i class="fa-solid fa-pen-to-square"></i> <span class="te">Chỉnh sửa TKB</span>')
   	  }
    	  personalChosen2.click(function(){
    		  inputClass2.val("").change();
    		  inputType2.val(2);
    	  });
    	  
    	  $(".personal-chosen-dismiss2").click(function(){
    		 
    		  inputType2.val(0);
    	  });
    	  changeType2(inputPack2.val());
    	  
    	  function changeType2(packSelected) {
    		  if(packSelected) {
     			 inputClass2.attr('disabled', false);
     		  $('.class2').addClass("d-none")
     		  $('.class2[data="' + packSelected +'"]').removeClass("d-none")
     		  personalChosen2.attr('disabled', false);
     		  }
     		  else {
     			  inputClass2.attr('disabled', true);
     			  personalChosen2.attr('disabled', true);
     			  inputType2.val(0);
     			  $(".personal-chosen-dismiss2").click();
     		  }
  	 	}
    	  inputPack2.change(function(){
    		  let packSelected = this.value
    		  if(inputType2.value != "2") {
    			  inputClass2.val("").change();
        		}
    		
    		  changeType2(packSelected)
    		 
    	  });
    	  
    	  
    	  
    	  inputClass2.change(function(){
    		  let classSelected = this.value
    		  if(classSelected) {
    			  inputType2.val(1);		  
    		  }
    		  else {  
    			  inputType2.val(0);
    			    		  }
    	  });
    	  
    	  $("#register").submit(function(e) {
    		  if($(".type2").val() == 2) {
    			  
    			 
    			  if(!$(".date-start2").val()) {
    				 	$(".date-start-error2").text("Nội dung này không được bỏ trống") 
    				  e.preventDefault()
    			  }
    			  else {
    				  $(".date-start-error2").text("") 
    			  }
    				  
    			let isValid = false
    			  $("#time-table2 :input").each(function() {
    				  if(this.id) {
    					if($("#" + this.id).prop("checked"))
        			    isValid = true;
    				  }
        		  })
        		  
        		  if(!isValid) {
        			  $(".schedule-error2").text("Vui lòng chọn ít nhất 1 ngày để lập thời khoá biểu")
        			  e.preventDefault()
        		  }
        		  else {
        			  $(".schedule-error2").text("")
        		  }
    				  
    
    			 
    		  }
    		 
    	  })
    	  
    	    //////////////////////////////////// ------------- course 2 -------------/////////////////////////////////////////////////////////////////
    	  
    	  
    	  
    	  
    	  // show modal
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
    			  $("#"+this.value).prop( "checked", true );
    		  })
    		  $("#time-table-detail").modal("show");
    	  })
    	  
    	    $(".btn-tt").click(function() {
    		  $("#time-table :input").prop( "checked", false );
    		  $(".input-tt-db").each(function() {
    			  $("#"+this.value).prop( "checked", true );
    		  })
    	  })
    	  
    	  $(".btn-tt2").click(function() {
    		  $("#time-table2 :input").prop( "checked", false );
    		  $(".input-tt-db").each(function() {
    			  $("#"+this.value).prop( "checked", true );
    		  })
    	  })
    	  
    	  btnAddCourseSecond.click(function () {
          $(".course-2").removeClass("d-none")
           btnAddCourseSecond.addClass("d-none")
           isSelectCourse2.val("1")
        });
        $(".remove-course-2").click(function () {
          $(".course-2").addClass("d-none");
          btnAddCourseSecond.removeClass("d-none")
          inputType2.val(0);
          inputClass2.val("").change();
          inputPack2.val("").change();
          isSelectCourse2.val("")
        });
    	  
    	  // create account
    	  const cId = $(".customerId-flag").attr("data")
    	 if(cId !== "") {
    		 $("#modal-create-account form").attr("action", "admin/customer/"+ cId + "/create-account.htm");
    		 $(".customerId-flag").attr("data", "")
    	 }
    	  const btnCreateAccount = $(".btn-create-account");
    	  
    	 	 btnCreateAccount.click(function() {
    	 		
    	 		 $("#modal-create-account form").attr("action", "admin/customer/"+this.getAttribute("data") + "/create-account.htm");
    	 		
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
                          <div id="filter-block" class="card position-absolute end-100 top-0 collapse" style="z-index: 100; min-width: 23rem;">
                              <div class="card-header py-2 text-secondary bg-info text-black fs-6">Bộ lọc</div>
                              <div class="card-body">
                                  <form action="admin/customer.htm" class="row g-3 mt-1" id="form-filter">
                                      <div class="col-12">
                                          <label for="input-birthday" class="form-label">Ngày sinh</label>

                                          <div class="col-12 d-flex gap-1 justify-content-around align-items-stretch">
                                              <div class="input-group">
                                                  <input id="input-birthday" type="date" name="dateLeft" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                              <button type="button" class="btn btn-primary btn-sm btn-range-filter" data-bs-toggle="collapse" data-bs-target="#input-birthday-right">
                                                  Đến
                                              </button>

                                              <div class="input-group collapse" id="input-birthday-right">
                                                  <input type="date" name="dateRight" class="form-control" aria-label="input-birthday" aria-describedby="basic-addon1" />
                                              </div>
                                          </div>
                                      </div>

                                      <div class="col-md-12">
                                          <label for="gender" class="form-label">Giới tính</label>
                                          <div class="col-md-12 d-flex">
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="gender" id="filter-female" value="0" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-female">
                                                      Nữ
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="gender" id="filter-male" value="1" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-male">
                                                      Nam
                                                  </label>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-12">
                                          <label for="status" class="form-label">Trạng thái</label>
                                          <div class="col-md-12 d-flex">
         
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-0" value="1" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-0">
                                                      Đang tập
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                                  <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-1" value="0" />
                                                  <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-1">
                                                      Chưa đăng ký
                                                  </label>
                                              </div>
                                              <div class="form-check-filter">
                                              <input class="form-check-input-filter" type="checkbox" name="status" id="filter-status-2" value="2" />
                                              <label class="form-check-label py-1 px-2 rounded-1" for="filter-status-2">
                                                  Đã đăng ký
                                              </label>
                                          </div>
                                          </div>
                                      </div>
                                  </form>
                              </div>
                              <div class="card-footer py-2 text-end">
                                  <button type="submit" name="btnFilter" form="form-filter" class="btn btn-primary">
                                      Lọc
                                  </button>
                               
                              </div>
                          </div>
                      </div>
                  </div>
                `);

    	 
      });
    </script>

</body>
</html>