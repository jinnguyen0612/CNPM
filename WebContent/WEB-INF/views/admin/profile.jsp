<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	<div class="tab-flag" data="${tabId}"></div>
	<div class="page-flag" data="profile"></div>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Thông tin cá nhân</h1>
		</div>
		<!-- End Page Title -->

		<section class="section profile">
			<div class="row">
				<div class="col-xl-8 mx-auto">
					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">
								<li class="nav-item">
									<button class="nav-link active profile-overview "
										data-bs-toggle="tab" data-bs-target="#profile-overview">Tổng
										quát</button>
								</li>

								<li class="nav-item">
									<button class="nav-link profile-change-password"
										data-bs-toggle="tab" data-bs-target="#profile-change-password">Thay
										đổi mật khẩu</button>
								</li>
							</ul>
							<div class="tab-content pt-2">
								<div class="tab-pane fade show active profile-overview"
									id="profile-overview">
									<h5 class="card-title">Profile Details</h5>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Họ và Tên</div>
										<div class="col-lg-9 col-md-8">${admin.staff.name}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Giới tính</div>

										<div class="col-lg-9 col-md-8">${admin.staff.gender?'Nam':'Nữ'}</div>
									</div>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">Ngày Sinh</div>
										<div class="col-lg-9 col-md-8">
											<fmt:formatDate value="${admin.staff.birthday }"
												pattern="dd/MM/yyyy" />
										</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Vài trò</div>
										<div class="col-lg-9 col-md-8">
											<c:choose>
												<c:when test="${admin.policyId == '0'}">Quản lý</c:when>
												<c:when test="${admin.policyId == '2'}">Nhân viên</c:when>
											</c:choose>
										</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">CMNN/CCCD</div>
										<div class="col-lg-9 col-md-8">${admin.staff.identityCard}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Địa chỉ</div>
										<div class="col-lg-9 col-md-8">${admin.staff.address}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Số điện thoại</div>
										<div class="col-lg-9 col-md-8">${admin.staff.phone}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Email</div>
										<div class="col-lg-9 col-md-8">${admin.staff.email }</div>
									</div>
								</div>

								<div class="tab-pane fade pt-3" id="profile-change-password">
									<!-- Change Password Form -->
									<form:form action="admin/profile.htm" method="post">
										<div class="row mb-3">
											<label for="currentPassword"
												class="col-md-5 col-lg-4 col-form-label">Mật khẩu
												hiện tại</label>
											<div class="col-md-7 col-lg-8">
												<input name="password" value="${password}" type="password"
													class="form-control" id="currentPassword" /> <span
													class="text-danger"> ${message1}</span>
											</div>

										</div>

										<div class="row mb-3">
											<label for="newPassword"
												class="col-md-5 col-lg-4 col-form-label">Mật khẩu
												mới</label>
											<div class="col-md-7 col-lg-8">
												<input name="newpassword" value="${newpassword}"
													type="password" class="form-control" id="newPassword" /> <span
													class="text-danger"> ${message3}</span>
											</div>

										</div>

										<div class="row mb-3">
											<label for="renewPassword"
												class="col-md-5 col-lg-4 col-form-label">Nhập lại
												mật khẩu mới</label>
											<div class="col-md-7 col-lg-8">
												<input name="renewpassword" value="${renewpassword}"
													type="password" class="form-control" id="renewPassword" />
												<span class="text-danger"> ${message2}</span>
											</div>

										</div>

										<div class="text-center">
											<button type="submit" name="btnChangePw"
												class="btn btn-primary">Xác nhận</button>
										</div>
									</form:form>
									<!-- End Change Password Form -->
								</div>
							</div>
							<!-- End Bordered Tabs -->
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->
	<!-- common script -->
	<%@include file="./script.jsp"%>
	<script type="text/javascript">
		let tabId = $(".tab-flag").attr("data")
		$(".tab-pane").removeClass("active show")
		$(".nav-link").removeClass("active")
		$("." + tabId).addClass("active show")
		$("#" + tabId).addClass("active show")
	</script>
</body>
</html>